import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/images/cached_image.dart';
import '../../../../l10n/app_localizations.dart';
import '../models/attached_image.dart';

/// Widget for managing images in the entry editor.
///
/// This widget displays attached images in a grid layout and provides
/// functionality to add new images and remove existing ones.
class ImageManager extends ConsumerStatefulWidget {
  /// List of attached images with their processing status
  final List<AttachedImage> images;

  /// Callback when an image is removed
  final void Function(int imageId) onRemoveImage;

  /// Callback when new images are added
  final void Function(List<File> files) onAddImages;

  /// Callback when images are reordered
  final void Function(int oldIndex, int newIndex) onReorderImages;

  /// Callback when image is opened in fullscreen
  final void Function(AttachedImage image) onOpenImage;

  /// Callback when image is inserted into content
  final void Function(AttachedImage image) onInsertImage;

  /// Whether images are currently being uploaded
  final bool isUploading;

  /// Upload progress (0.0 to 1.0)
  final double uploadProgress;

  const ImageManager({
    super.key,
    required this.images,
    required this.onRemoveImage,
    required this.onAddImages,
    required this.onReorderImages,
    required this.onOpenImage,
    required this.onInsertImage,
    this.isUploading = false,
    this.uploadProgress = 0.0,
  });

  @override
  ConsumerState<ImageManager> createState() => _ImageManagerState();
}

class _ImageManagerState extends ConsumerState<ImageManager> {
  final ImagePicker _imagePicker = ImagePicker();

  /// Show image source selection dialog
  Future<void> _showImageSourceDialog() async {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n?.camera ?? 'Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImages(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n?.gallery ?? 'Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImages(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Pick images from the specified source
  Future<void> _pickImages(ImageSource source) async {
    try {
      final List<XFile> pickedFiles;

      if (source == ImageSource.camera) {
        // Pick single image from camera
        final XFile? pickedFile = await _imagePicker.pickImage(
          source: source,
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
        pickedFiles = pickedFile != null ? [pickedFile] : [];
      } else {
        // Pick multiple images from gallery
        pickedFiles = await _imagePicker.pickMultiImage(
          imageQuality: 85,
          maxWidth: 1920,
          maxHeight: 1920,
        );
      }

      if (pickedFiles.isNotEmpty) {
        final files = pickedFiles.map((xFile) => File(xFile.path)).toList();
        widget.onAddImages(files);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick images: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with add button
        Row(
          children: [
            Text(
              l10n?.images ?? 'Images',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: widget.isUploading ? null : _showImageSourceDialog,
              icon: widget.isUploading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value: widget.uploadProgress > 0
                            ? widget.uploadProgress
                            : null,
                      ),
                    )
                  : const Icon(Icons.add_photo_alternate),
              tooltip: l10n?.addImages ?? 'Add Images',
            ),
          ],
        ),

        // Images grid
        if (widget.images.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildImagesGrid(),
        ],

        // Upload progress indicator
        if (widget.isUploading && widget.uploadProgress > 0) ...[
          const SizedBox(height: 8),
          LinearProgressIndicator(value: widget.uploadProgress),
          const SizedBox(height: 4),
          Text(
            '${(widget.uploadProgress * 100).toInt()}%',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildImagesGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 32; // Account for horizontal padding
    final itemSize = (availableWidth - 32) / 5; // 5 columns with spacing

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (int i = 0; i < widget.images.length; i++)
          SizedBox(
            width: itemSize,
            height: itemSize,
            child: ReorderableDragStartListener(
              key: ValueKey(widget.images[i].id),
              index: i,
              child: _buildImageItem(widget.images[i], i),
            ),
          ),
      ],
    );
  }

  Widget _buildImageItem(AttachedImage attachedImage, int index) {
    final theme = Theme.of(context);

    return GestureDetector(
      key: ValueKey(attachedImage.id),
      onTap: () => _showImageMenu(attachedImage),
      child: Stack(
        children: [
          // Image container with better styling
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImageContent(attachedImage, theme),
            ),
          ),

          // Processing indicator
          if (attachedImage.isProcessing)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),

          // Failed indicator
          if (attachedImage.isFailed)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.error, color: Colors.white, size: 24),
                ),
              ),
            ),

          // Remove button
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => widget.onRemoveImage(attachedImage.id),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),

          // Status indicator in bottom left
          if (attachedImage.isProcessing || attachedImage.isFailed)
            Positioned(
              bottom: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: attachedImage.isProcessing
                      ? Colors.orange
                      : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  attachedImage.isProcessing ? 'Processing' : 'Failed',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageContent(AttachedImage attachedImage, ThemeData theme) {
    // Try to get the best available image URL
    String? imageUrl;

    if (attachedImage.isReady) {
      // For ready images, prefer thumbnail, fallback to small
      imageUrl = attachedImage.thumbnailUrl ?? attachedImage.smallUrl;
    } else {
      // For processing/failed images, try to get any available URL
      imageUrl =
          attachedImage.thumbnailUrl ??
          attachedImage.smallUrl ??
          attachedImage.mediumUrl;
    }

    // Fallback to API endpoint if no URL is available
    imageUrl ??= '/api/v1/images/${attachedImage.id}/thumbnail';

    return CachedImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      borderRadius: 8,
      placeholder: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image,
              color: theme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              'Failed to load',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show popup menu for image actions
  void _showImageMenu(AttachedImage attachedImage) {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedImage(
                        imageUrl:
                            attachedImage.thumbnailUrl ??
                            attachedImage.smallUrl ??
                            '/api/v1/images/${attachedImage.id}/thumbnail',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Image ${attachedImage.id}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: attachedImage.when(
                                  processing:
                                      (
                                        id,
                                        image,
                                        isUploading,
                                        uploadProgress,
                                      ) => Colors.orange,
                                  ready: (id, image) => Colors.green,
                                  failed: (id, image, errorMessage) =>
                                      Colors.red,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              attachedImage.when(
                                processing:
                                    (id, image, isUploading, uploadProgress) =>
                                        'Processing...',
                                ready: (id, image) => 'Ready',
                                failed: (id, image, errorMessage) => 'Failed',
                              ),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: attachedImage.when(
                                      processing:
                                          (
                                            id,
                                            image,
                                            isUploading,
                                            uploadProgress,
                                          ) => Colors.orange,
                                      ready: (id, image) => Colors.green,
                                      failed: (id, image, errorMessage) =>
                                          Colors.red,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Open'),
              onTap: () {
                Navigator.pop(context);
                widget.onOpenImage(attachedImage);
              },
            ),

            if (attachedImage.isReady)
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Insert'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onInsertImage(attachedImage);
                },
              ),

            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(
                l10n?.delete ?? 'Delete',
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onRemoveImage(attachedImage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
