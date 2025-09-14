import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/app_localizations.dart';

/// Widget for managing tags in the entry editor.
/// 
/// This widget displays tags as chips and provides functionality
/// to add new tags and remove existing ones.
class TagManager extends StatefulWidget {
  /// List of tags currently attached to the entry
  final List<String> tags;
  
  /// Callback when a tag is removed
  final void Function(String tag) onRemoveTag;
  
  /// Callback when a new tag is added
  final void Function(String tag) onAddTag;
  
  /// Maximum number of tags allowed
  final int maxTags;

  const TagManager({
    super.key,
    required this.tags,
    required this.onRemoveTag,
    required this.onAddTag,
    this.maxTags = 10,
  });

  @override
  State<TagManager> createState() => _TagManagerState();
}

class _TagManagerState extends State<TagManager> {
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();

  @override
  void dispose() {
    _tagController.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }

  /// Add a new tag
  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isEmpty) return;
    
    // Validate tag format (alphanumeric, hyphens, underscores only)
    if (!_isValidTag(tag)) {
      _showInvalidTagMessage();
      return;
    }
    
    // Check if tag already exists
    if (widget.tags.contains(tag)) {
      _showDuplicateTagMessage();
      return;
    }
    
    // Check tag limit
    if (widget.tags.length >= widget.maxTags) {
      _showTagLimitMessage();
      return;
    }
    
    widget.onAddTag(tag);
    _tagController.clear();
  }

  /// Validate tag format
  bool _isValidTag(String tag) {
    // Tag should be 1-50 characters, alphanumeric, hyphens, underscores only
    final regex = RegExp(r'^[a-zA-Z0-9_-]{1,50}$');
    return regex.hasMatch(tag);
  }

  /// Show invalid tag format message
  void _showInvalidTagMessage() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.invalidTagFormat ?? 'Invalid tag format. Use letters, numbers, hyphens, and underscores only.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  /// Show duplicate tag message
  void _showDuplicateTagMessage() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.duplicateTag ?? 'This tag already exists.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  /// Show tag limit message
  void _showTagLimitMessage() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.tagLimitReached ?? 'Maximum number of tags reached.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          l10n?.tags ?? 'Tags',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Tag input field
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagController,
                focusNode: _tagFocusNode,
                decoration: InputDecoration(
                  hintText: l10n?.addTag ?? 'Add tag...',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  isDense: true,
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _addTag(),
                inputFormatters: [
                  // Allow only alphanumeric, hyphens, and underscores
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]')),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _addTag,
              icon: const Icon(Icons.add),
              tooltip: l10n?.addTag ?? 'Add Tag',
            ),
          ],
        ),
        
        // Tags display
        if (widget.tags.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: widget.tags.map((tag) => _buildTagChip(tag)).toList(),
          ),
        ],
        
        // Tag count indicator
        if (widget.tags.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            '${widget.tags.length}/${widget.maxTags}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTagChip(String tag) {
    final theme = Theme.of(context);
    
    return Chip(
      label: Text(
        tag,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
      deleteIcon: Icon(
        Icons.close,
        size: 18,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      onDeleted: () => widget.onRemoveTag(tag),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
