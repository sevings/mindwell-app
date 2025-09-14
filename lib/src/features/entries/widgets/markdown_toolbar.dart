import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// A custom toolbar for the entry editor that provides only markdown-supported formatting options.
/// 
/// This toolbar includes:
/// - Headings (H3, H4, H5, H6)
/// - Text formatting (bold, italic, strikethrough, code)
/// - Lists (ordered and unordered)
/// - Blockquote
/// - Link
class MarkdownToolbar extends StatelessWidget {
  /// The Quill controller for the editor
  final QuillController controller;

  const MarkdownToolbar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            // Heading buttons
            _buildHeadingButton('H3', Attribute.h3),
            _buildHeadingButton('H4', Attribute.h4),
            _buildHeadingButton('H5', Attribute.h5),
            _buildHeadingButton('H6', Attribute.h6),
            
            const VerticalDivider(width: 8),
            
            // Text formatting buttons
            _buildFormatButton(
              icon: Icons.format_bold,
              tooltip: 'Bold',
              attribute: Attribute.bold,
            ),
            _buildFormatButton(
              icon: Icons.format_italic,
              tooltip: 'Italic',
              attribute: Attribute.italic,
            ),
            _buildFormatButton(
              icon: Icons.format_strikethrough,
              tooltip: 'Strikethrough',
              attribute: Attribute.strikeThrough,
            ),
            _buildFormatButton(
              icon: Icons.code,
              tooltip: 'Code',
              attribute: Attribute.codeBlock,
            ),
            
            const VerticalDivider(width: 8),
            
            // List buttons
            _buildFormatButton(
              icon: Icons.format_list_bulleted,
              tooltip: 'Bullet List',
              attribute: Attribute.ul,
            ),
            _buildFormatButton(
              icon: Icons.format_list_numbered,
              tooltip: 'Numbered List',
              attribute: Attribute.ol,
            ),
            
            const VerticalDivider(width: 8),
            
            // Blockquote button
            _buildFormatButton(
              icon: Icons.format_quote,
              tooltip: 'Quote',
              attribute: Attribute.blockQuote,
            ),
            
            const VerticalDivider(width: 8),
            
            // Link button
            _buildLinkButton(),
          ],
        ),
      ),
    );
  }

  /// Build a heading button
  Widget _buildHeadingButton(String label, Attribute attribute) {
    return _buildToolbarButton(
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      tooltip: 'Heading $label',
      onPressed: () => _toggleAttribute(attribute),
      isActive: _isAttributeActive(attribute),
    );
  }

  /// Build a format button with an icon
  Widget _buildFormatButton({
    required IconData icon,
    required String tooltip,
    required Attribute attribute,
  }) {
    return _buildToolbarButton(
      child: Icon(icon, size: 18),
      tooltip: tooltip,
      onPressed: () => _toggleAttribute(attribute),
      isActive: _isAttributeActive(attribute),
    );
  }

  /// Build a link button with special handling
  Widget _buildLinkButton() {
    return Builder(
      builder: (context) => _buildToolbarButton(
        child: const Icon(Icons.link, size: 18),
        tooltip: 'Link',
        onPressed: () => _showLinkDialog(context),
        isActive: _isAttributeActive(Attribute.link),
      ),
    );
  }

  /// Build a generic toolbar button
  Widget _buildToolbarButton({
    required Widget child,
    required String tooltip,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return Builder(
      builder: (context) => Tooltip(
        message: tooltip,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: Material(
            color: isActive 
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: isActive 
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Toggle an attribute on the current selection
  void _toggleAttribute(Attribute attribute) {
    final selection = controller.selection;
    if (selection.isValid) {
      controller.formatText(
        selection.baseOffset,
        selection.extentOffset - selection.baseOffset,
        attribute,
      );
    }
  }

  /// Check if an attribute is active on the current selection
  bool _isAttributeActive(Attribute attribute) {
    final selection = controller.selection;
    if (!selection.isValid) return false;
    
    final style = controller.getSelectionStyle();
    return style.attributes.containsKey(attribute.key);
  }

  /// Show a dialog to insert/edit a link
  void _showLinkDialog(BuildContext context) {
    final selection = controller.selection;
    
    if (!selection.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select text to create a link'),
        ),
      );
      return;
    }

    final selectedText = controller.getPlainText().substring(
      selection.baseOffset,
      selection.extentOffset,
    );

    showDialog(
      context: context,
      builder: (context) => _LinkDialog(
        initialText: selectedText,
        onLink: (url) {
          if (url.isNotEmpty) {
            controller.formatText(
              selection.baseOffset,
              selection.extentOffset - selection.baseOffset,
              LinkAttribute(url),
            );
          }
        },
      ),
    );
  }
}

/// Dialog for entering link URL
class _LinkDialog extends StatefulWidget {
  final String initialText;
  final Function(String) onLink;

  const _LinkDialog({
    required this.initialText,
    required this.onLink,
  });

  @override
  State<_LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<_LinkDialog> {
  late final TextEditingController _urlController;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Insert Link'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Link Text',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: 'URL',
              border: OutlineInputBorder(),
              hintText: 'https://example.com',
            ),
            keyboardType: TextInputType.url,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final url = _urlController.text.trim();
            if (url.isNotEmpty) {
              widget.onLink(url);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Insert'),
        ),
      ],
    );
  }
}
