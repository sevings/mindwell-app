import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';

/// A widget that provides a form for users to add new comments to an entry.
/// 
/// This widget includes:
/// - A text field for entering comment content
/// - A submit button that's enabled only when content is provided
/// - Loading state during comment submission
/// - Error handling and display
/// - Proper validation and user feedback
class AddCommentForm extends StatefulWidget {
  /// The ID of the entry to comment on
  final int entryId;
  
  /// Callback when a comment is successfully posted
  final void Function(MwComment comment)? onCommentPosted;
  
  /// Alternative callback that takes just the content string
  final void Function(String content)? onCommentSubmitted;
  
  /// Callback when there's an error posting the comment
  final void Function(String error)? onError;
  
  /// Whether the form is currently submitting
  final bool isSubmitting;
  
  /// The error message to display (if any)
  final String? errorMessage;
  
  /// Custom padding for the form
  final EdgeInsetsGeometry? padding;
  
  /// Whether to show the form in a compact mode
  final bool compact;
  
  /// Placeholder text for the comment field
  final String? placeholder;
  
  /// Maximum number of lines for the text field
  final int? maxLines;
  
  /// Whether to auto-focus the text field
  final bool autofocus;

  const AddCommentForm({
    super.key,
    required this.entryId,
    this.onCommentPosted,
    this.onCommentSubmitted,
    this.onError,
    this.isSubmitting = false,
    this.errorMessage,
    this.padding,
    this.compact = false,
    this.placeholder,
    this.maxLines,
    this.autofocus = false,
  });

  @override
  State<AddCommentForm> createState() => _AddCommentFormState();
}

class _AddCommentFormState extends State<AddCommentForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  
  bool _hasContent = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasContent = _textController.text.trim().isNotEmpty;
    if (hasContent != _hasContent) {
      setState(() {
        _hasContent = hasContent;
      });
    }
  }

  void _submitComment() {
    if (!_formKey.currentState!.validate()) return;
    
    final content = _textController.text.trim();
    if (content.isEmpty) return;
    
    // Call the appropriate callback
    if (widget.onCommentSubmitted != null) {
      widget.onCommentSubmitted!(content);
    } else {
      // Create a mock comment for the callback
      // In a real implementation, this would be handled by a provider
      final comment = MwComment((b) => b
        ..content = content
        ..entryId = widget.entryId
        ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000.0
      );
      
      widget.onCommentPosted?.call(comment);
    }
    
    // Clear the form after successful submission
    _textController.clear();
    _focusNode.unfocus();
  }

  void _clearForm() {
    _textController.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, l10n),
            const SizedBox(height: 12),
            _buildTextField(context, l10n),
            if (widget.errorMessage != null) ...[
              const SizedBox(height: 8),
              _buildErrorMessage(context),
            ],
            const SizedBox(height: 12),
            _buildActions(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations? l10n) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          Icons.comment_outlined,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          l10n?.addComment ?? 'Add comment',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, AppLocalizations? l10n) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: _textController,
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines ?? (widget.compact ? 3 : 5),
      minLines: widget.compact ? 2 : 3,
      enabled: !widget.isSubmitting,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        hintText: widget.placeholder ?? (l10n?.commentHint ?? 'Write your comment...'),
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        counterText: '', // Hide character counter
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Comment cannot be empty';
        }
        if (value.trim().length > 500) {
          return 'Comment is too long (max 500 characters)';
        }
        return null;
      },
      onFieldSubmitted: (_) {
        if (_hasContent && !widget.isSubmitting) {
          _submitComment();
        }
      },
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, AppLocalizations? l10n) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_hasContent && !widget.isSubmitting) ...[
          TextButton(
            onPressed: _clearForm,
            child: Text(
              'Cancel',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        ElevatedButton(
          onPressed: _hasContent && !widget.isSubmitting ? _submitComment : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
            disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: widget.isSubmitting
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(
                  l10n?.addComment ?? 'Add comment',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ],
    );
  }
}
