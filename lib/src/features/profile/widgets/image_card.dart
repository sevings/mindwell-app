import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../src/core/widgets/images/cached_image.dart';
import 'package:mindwell/src/features/entries/screens/image_gallery_screen.dart';

/// A widget that displays a grid of the user's most recent images.
/// 
/// This widget showcases the user's uploaded images in a 3x3 grid format.
/// It displays the last 9 images, and includes a "View All Images" button
/// if the user has more than 9 images. Tapping an image opens it in a
/// fullscreen viewer.
class ImageCard extends StatelessWidget {
  /// The list of images to display
  final List<MwImage> images;

  /// Callback when the "View All Images" button is tapped
  final VoidCallback? onViewAllImages;

  const ImageCard({
    super.key,
    required this.images,
    this.onViewAllImages,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Don't show the card if there are no images
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.lastImages,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (images.length > 9)
                  TextButton(
                    onPressed: onViewAllImages,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.viewAllImages,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Image grid
            _buildImageGrid(context, theme),
          ],
        ),
      ),
    );
  }

  /// Builds the 3x3 grid of images
  Widget _buildImageGrid(BuildContext context, ThemeData theme) {
    // Show only the last 9 images
    final imagesToShow = images.take(9).toList();
    final hasMoreImages = images.length > 9;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the number of rows needed (always 3 for 3x3 grid)
        final crossAxisCount = 3;
        final itemCount = imagesToShow.length + (hasMoreImages ? 1 : 0);
        final rowCount = 3; // Always 3 rows for consistent layout
        
        return SizedBox(
          height: rowCount * 100.0 + (rowCount - 1) * 8.0, // 100px per item + 8px spacing
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // Show "View All" button in the last position if there are more images
              if (hasMoreImages && index == imagesToShow.length) {
                return _buildViewAllButton(context, theme);
              }

              final image = imagesToShow[index];
              return _buildImageItem(context, theme, image, index);
            },
          ),
        );
      },
    );
  }

  /// Builds an individual image item
  Widget _buildImageItem(BuildContext context, ThemeData theme, MwImage image, int index) {
    final l10n = AppLocalizations.of(context)!;
    final imageUrl = _getImageUrl(image);

    return Semantics(
      label: '${l10n.imageNumber} ${index + 1}',
      button: true,
      child: InkWell(
        onTap: () => _openImageGallery(context, images, index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7), // Slightly smaller to account for border
            child: imageUrl != null
                ? CachedImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    useSkeletonLoader: true,
                    errorWidget: _buildImageErrorWidget(context, theme),
                  )
                : _buildImageErrorWidget(context, theme),
          ),
        ),
      ),
    );
  }

  /// Gets the best available image URL from the MwImage object
  String? _getImageUrl(MwImage image) {
    return image.medium?.url ?? 
           image.small?.url ?? 
           image.thumbnail?.url;
  }

  /// Builds the error widget shown when images fail to load
  Widget _buildImageErrorWidget(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 24,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 4),
          Text(
            'Error',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds the "View All" button for the grid
  Widget _buildViewAllButton(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: l10n.viewAllImages,
      button: true,
      child: InkWell(
        onTap: onViewAllImages,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.more_horiz,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.viewAll,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Opens the image gallery with the specified images and initial index
  void _openImageGallery(BuildContext context, List<MwImage> images, int initialIndex) {
    final l10n = AppLocalizations.of(context)!;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ImageGalleryScreen(
          images: images,
          initialIndex: initialIndex,
          title: l10n.imageGallery,
        ),
        fullscreenDialog: true,
      ),
    );
  }
}
