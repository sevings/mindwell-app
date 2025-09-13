import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../loaders/skeleton_loader.dart';

/// A reliable widget for displaying network images with proper loading and error states.
/// 
/// This widget uses cached_network_image for efficient image loading and caching,
/// provides skeleton loading placeholders, and handles error states gracefully.
/// 
/// ## Usage Examples:
/// 
/// ```dart
/// // Basic usage
/// CachedImage(imageUrl: 'https://example.com/image.jpg')
/// 
/// // With custom dimensions and border radius
/// CachedImage(
///   imageUrl: 'https://example.com/image.jpg',
///   width: 200,
///   height: 150,
///   borderRadius: 12.0,
/// )
/// 
/// // Avatar with fallback
/// CachedAvatar(
///   imageUrl: user.avatarUrl,
///   size: 50.0,
///   fallbackText: user.initials,
/// )
/// 
/// // Post image with aspect ratio
/// CachedPostImage(
///   imageUrl: post.imageUrl,
///   width: double.infinity,
///   aspectRatio: 16 / 9,
///   onTap: () => _openImageFullScreen(post.imageUrl),
/// )
/// ```
class CachedImage extends StatelessWidget {
  /// The URL of the image to display
  final String imageUrl;
  
  /// Optional width for the image
  final double? width;
  
  /// Optional height for the image
  final double? height;
  
  /// How the image should be fitted within its bounds
  final BoxFit fit;
  
  /// Border radius for the image
  final double borderRadius;
  
  /// Placeholder widget to show while loading
  final Widget? placeholder;
  
  /// Error widget to show when image fails to load
  final Widget? errorWidget;
  
  /// Whether to show a skeleton loader as placeholder
  final bool useSkeletonLoader;
  
  /// Color of the skeleton loader
  final Color? skeletonColor;
  
  /// Whether to show a retry button on error
  final bool showRetryOnError;
  
  /// Callback when retry is tapped
  final VoidCallback? onRetry;
  
  /// Whether the image should be cached
  final bool cacheImage;
  
  /// Maximum width for the cached image
  final int? memCacheWidth;
  
  /// Maximum height for the cached image
  final int? memCacheHeight;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.placeholder,
    this.errorWidget,
    this.useSkeletonLoader = true,
    this.skeletonColor,
    this.showRetryOnError = true,
    this.onRetry,
    this.cacheImage = true,
    this.memCacheWidth,
    this.memCacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          memCacheWidth: memCacheWidth,
          memCacheHeight: memCacheHeight,
          placeholder: (context, url) => _buildPlaceholder(context),
          errorWidget: (context, url, error) => _buildErrorWidget(context, error),
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 100),
        ),
      ),
    );
  }

  /// Builds the placeholder widget shown while loading
  Widget _buildPlaceholder(BuildContext context) {
    if (placeholder != null) {
      return placeholder!;
    }
    
    if (useSkeletonLoader) {
      return SkeletonLoader(
        baseColor: skeletonColor,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );
    }
    
    return Container(
      width: width ?? double.infinity,
      height: height ?? 200.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  /// Builds the error widget shown when image fails to load
  Widget _buildErrorWidget(BuildContext context, dynamic error) {
    if (errorWidget != null) {
      return errorWidget!;
    }
    
    final theme = Theme.of(context);
    
    return Container(
      width: width ?? double.infinity,
      height: height ?? 200.0,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: (height != null && height! < 100) ? 24.0 : 48.0,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          if (height == null || height! > 80) ...[
            const SizedBox(height: 8.0),
            Text(
              'Failed to load image',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (showRetryOnError && onRetry != null) ...[
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Retry',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// A specialized CachedImage for user avatars
class CachedAvatar extends StatelessWidget {
  /// The URL of the avatar image
  final String? imageUrl;
  
  /// The size of the avatar
  final double size;
  
  /// The border radius of the avatar
  final double borderRadius;
  
  /// The background color when no image is available
  final Color? backgroundColor;
  
  /// The text to display when no image is available
  final String? fallbackText;
  
  /// The text style for the fallback text
  final TextStyle? fallbackTextStyle;
  
  /// The icon to display when no image is available
  final IconData? fallbackIcon;

  const CachedAvatar({
    super.key,
    this.imageUrl,
    this.size = 40.0,
    this.borderRadius = 20.0,
    this.backgroundColor,
    this.fallbackText,
    this.fallbackTextStyle,
    this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildFallbackAvatar(context, theme);
    }
    
    return CachedImage(
      imageUrl: imageUrl!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      borderRadius: borderRadius,
      useSkeletonLoader: true,
      placeholder: SkeletonLoader(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      errorWidget: _buildFallbackAvatar(context, theme),
    );
  }

  Widget _buildFallbackAvatar(BuildContext context, ThemeData theme) {
    final bgColor = backgroundColor ?? theme.colorScheme.primaryContainer;
    final textColor = theme.colorScheme.onPrimaryContainer;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: fallbackIcon != null
            ? Icon(
                fallbackIcon,
                size: size * 0.5,
                color: textColor,
              )
            : fallbackText != null
                ? Text(
                    fallbackText!,
                    style: (fallbackTextStyle ?? theme.textTheme.titleMedium)?.copyWith(
                      color: textColor,
                      fontSize: size * 0.4,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: size * 0.5,
                    color: textColor,
                  ),
      ),
    );
  }
}

/// A specialized CachedImage for post/entry images with aspect ratio
class CachedPostImage extends StatelessWidget {
  /// The URL of the image
  final String imageUrl;
  
  /// The width of the image
  final double? width;
  
  /// The aspect ratio of the image (width/height)
  final double aspectRatio;
  
  /// Border radius for the image
  final double borderRadius;
  
  /// Whether to show a skeleton loader
  final bool useSkeletonLoader;
  
  /// Callback when image is tapped
  final VoidCallback? onTap;

  const CachedPostImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.aspectRatio = 16 / 9,
    this.borderRadius = 8.0,
    this.useSkeletonLoader = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedImage(
      imageUrl: imageUrl,
      width: width,
      height: width != null ? width! / aspectRatio : null,
      fit: BoxFit.cover,
      borderRadius: borderRadius,
      useSkeletonLoader: useSkeletonLoader,
    );
    
    if (onTap != null) {
      imageWidget = GestureDetector(
        onTap: onTap,
        child: imageWidget,
      );
    }
    
    return imageWidget;
  }
}
