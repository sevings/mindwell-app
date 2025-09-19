import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'images/cached_image.dart';

/// A widget that renders HTML content safely
class HtmlContent extends StatelessWidget {
  /// The HTML content to render
  final String html;

  /// Custom text style
  final TextStyle? textStyle;

  /// Whether to shrink wrap the content
  final bool shrinkWrap;

  /// Callback when a link is tapped
  final void Function(String url)? onLinkTap;

  const HtmlContent({
    super.key,
    required this.html,
    this.textStyle,
    this.shrinkWrap = false,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Html(
      data: html,
      shrinkWrap: shrinkWrap,
      onLinkTap: (url, attributes, element) {
        if (url != null) {
          if (onLinkTap != null) {
            onLinkTap!(url);
          } else {
            _launchUrl(url);
          }
        }
      },
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(
            textStyle?.fontSize ?? theme.textTheme.bodyMedium?.fontSize ?? 14,
          ),
          color: textStyle?.color ?? theme.colorScheme.onSurface,
          fontFamily:
              textStyle?.fontFamily ?? theme.textTheme.bodyMedium?.fontFamily,
          fontWeight:
              textStyle?.fontWeight ?? theme.textTheme.bodyMedium?.fontWeight,
          lineHeight: LineHeight(
            textStyle?.height ?? theme.textTheme.bodyMedium?.height ?? 1.4,
          ),
        ),
        "p": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
        "br": Style(height: Height(0)),
        "strong": Style(fontWeight: FontWeight.bold),
        "b": Style(fontWeight: FontWeight.bold),
        "em": Style(fontStyle: FontStyle.italic),
        "i": Style(fontStyle: FontStyle.italic),
        "u": Style(textDecoration: TextDecoration.underline),
        "a": Style(
          color: theme.colorScheme.primary,
          textDecoration: TextDecoration.underline,
        ),
        "blockquote": Style(
          margin: Margins.symmetric(horizontal: 16, vertical: 8),
          padding: HtmlPaddings.only(left: 16),
          border: Border(
            left: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 4,
            ),
          ),
        ),
        "code": Style(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
          fontFamily: 'monospace',
        ),
        "pre": Style(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          padding: HtmlPaddings.all(12),
          margin: Margins.symmetric(vertical: 8),
        ),
        "ul": Style(margin: Margins.only(left: 16), padding: HtmlPaddings.zero),
        "ol": Style(margin: Margins.only(left: 16), padding: HtmlPaddings.zero),
        "li": Style(margin: Margins.only(bottom: 4)),
      },
      extensions: [
        TagExtension(
          tagsToExtend: {"img"},
          builder: (extensionContext) {
            final imgElement = extensionContext.element;
            final src = imgElement?.attributes['src'];

            if (src == null || src.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Invalid image',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Builder(
                  builder: (buildContext) => GestureDetector(
                    onTap: () => _showFullscreenImage(buildContext, src),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(buildContext).size.height * 0.8,
                      ),
                      child: CachedImage(
                        imageUrl: src,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        borderRadius: 8.0,
                        useSkeletonLoader: true,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Shows an image in fullscreen
  void _showFullscreenImage(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullscreenImageViewer(imageUrl: imageUrl),
        fullscreenDialog: true,
      ),
    );
  }

  /// Launches a URL in the default browser
  Future<void> _launchUrl(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle URL launch error silently
      debugPrint('Failed to launch URL: $urlString, error: $e');
    }
  }
}

/// A fullscreen image viewer widget
class FullscreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullscreenImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: CachedImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            useSkeletonLoader: true,
            errorWidget: Container(
              color: Colors.black,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
