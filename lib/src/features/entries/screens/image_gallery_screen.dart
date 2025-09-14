import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';


/// A fullscreen image gallery that allows users to view entry images with zoom and swipe capabilities.
/// 
/// This screen provides a swipeable gallery of images with pinch-to-zoom functionality
/// using the photo_view package. Users can navigate between images by swiping left/right
/// and zoom in/out using pinch gestures.
class ImageGalleryScreen extends StatefulWidget {
  /// The list of images to display in the gallery
  final List<MwImage> images;
  
  /// The initial index to display when the gallery opens
  final int initialIndex;
  
  /// Optional title to display in the app bar
  final String? title;

  const ImageGalleryScreen({
    super.key,
    required this.images,
    this.initialIndex = 0,
    this.title,
  });

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showControls ? AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.7),
        foregroundColor: Colors.white,
        title: Text(
          widget.title ?? 'Image Gallery',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (widget.images.length > 1)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ) : null,
      body: GestureDetector(
        onTap: _toggleControls,
        child: PhotoViewGallery.builder(
          pageController: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          builder: (context, index) {
            final image = widget.images[index];
            final imageUrl = _getImageUrl(image);
            
            if (imageUrl == null) {
              return PhotoViewGalleryPageOptions.customChild(
                child: _buildErrorWidget(theme),
                childSize: Size.infinite,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            }
            
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3,
              initialScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(
                tag: 'image_${image.id ?? index}',
              ),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          loadingBuilder: (context, event) => _buildLoadingWidget(theme),
        ),
      ),
    );
  }

  /// Gets the best available image URL from the MwImage object
  String? _getImageUrl(MwImage image) {
    return image.large?.url ?? 
           image.medium?.url ?? 
           image.small?.url ?? 
           image.thumbnail?.url;
  }

  /// Toggles the visibility of the app bar controls
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  /// Builds the loading widget shown while images are loading
  Widget _buildLoadingWidget(ThemeData theme) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.0,
        ),
      ),
    );
  }

  /// Builds the error widget shown when images fail to load
  Widget _buildErrorWidget(ThemeData theme) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.broken_image_outlined,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load image',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A specialized image gallery screen for entry images
class EntryImageGalleryScreen extends StatelessWidget {
  /// The entry containing the images
  final MwEntry entry;
  
  /// The initial index to display
  final int initialIndex;

  const EntryImageGalleryScreen({
    super.key,
    required this.entry,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final images = entry.images?.toList() ?? <MwImage>[];
    
    if (images.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Images'),
        ),
        body: const Center(
          child: Text('This entry has no images to display.'),
        ),
      );
    }
    
    return ImageGalleryScreen(
      images: images,
      initialIndex: initialIndex,
      title: entry.title,
    );
  }
}
