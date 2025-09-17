import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

/// A widget that renders HTML content safely
class HtmlContent extends StatelessWidget {
  /// The HTML content to render
  final String html;

  /// Custom text style
  final TextStyle? textStyle;

  /// Whether to shrink wrap the content
  final bool shrinkWrap;

  const HtmlContent({
    super.key,
    required this.html,
    this.textStyle,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Html(
      data: html,
      shrinkWrap: shrinkWrap,
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
          builder: (context) {
            // Handle images - for now, just show a placeholder
            // In a real implementation, you might want to handle image loading
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
                    Icons.image,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '[Image]',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
