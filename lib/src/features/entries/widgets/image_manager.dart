import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/images/cached_image.dart';
import '../../../../l10n/app_localizations.dart';

/// Widget for managing images in the entry editor.
/// 
/// This widget displays attached images in a grid layout and provides
/// functionality to add new images and remove existing ones.
class ImageManager extends ConsumerStatefulWidget {
  /// List of image IDs currently attached to the entry
  final List<int> imageIds;
  
  /// Callback when an image is removed
  final void Function(int imageId) onRemoveImage;
  
  /// Callback when new images are added
  final void Function(List<File> files) onAddImages;
  
  /// Whether images are currently being uploaded
  final bool isUploading;
  
  /// Upload progress (0.0 to 1.0)
  final double uploadProgress;

  const ImageManager({
    super.key,
    required this.imageIds,
    required this.onRemoveImage,
    required this.onAddImages,
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
                        value: widget.uploadProgress > 0 ? widget.uploadProgress : null,
                      ),
                    )
                  : const Icon(Icons.add_photo_alternate),
              tooltip: l10n?.addImages ?? 'Add Images',
            ),
          ],
        ),
        
        // Images grid
        if (widget.imageIds.isNotEmpty) ...[
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: widget.imageIds.length,
      itemBuilder: (context, index) {
        final imageId = widget.imageIds[index];
        return _buildImageItem(imageId);
      },
    );
  }

  Widget _buildImageItem(int imageId) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedImage(
            imageUrl: '/api/v1/images/$imageId/thumbnail',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            borderRadius: 8,
            errorWidget: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.broken_image),
            ),
          ),
        ),
        
        // Remove button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => widget.onRemoveImage(imageId),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
