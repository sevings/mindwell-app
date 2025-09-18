import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';

/// A dialog for reporting/complaining about a comment.
///
/// This dialog allows users to submit a complaint about a comment's content,
/// with an optional text field for additional details.
class CommentComplainDialog extends ConsumerStatefulWidget {
  /// The comment being reported
  final MwComment comment;

  /// Callback when complaint is submitted successfully
  final VoidCallback? onComplaintSubmitted;

  const CommentComplainDialog({
    super.key,
    required this.comment,
    this.onComplaintSubmitted,
  });

  @override
  ConsumerState<CommentComplainDialog> createState() =>
      _CommentComplainDialogState();
}

class _CommentComplainDialogState extends ConsumerState<CommentComplainDialog> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.report_outlined, color: Colors.red, size: 24),
          const SizedBox(width: 8),
          Text(
            l10n?.complain ?? 'Complain',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.reportCommentTitle ??
                  'Report this comment for inappropriate content.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText:
                    l10n?.additionalDetails ?? 'Additional details (optional)',
                hintText: l10n?.describeIssue ?? 'Please describe the issue...',
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              maxLength: 500,
              enabled: !_isSubmitting,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: Text(l10n?.goBack ?? 'Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitComplaint,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: _isSubmitting
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(l10n?.submitComplaint ?? 'Submit Complaint'),
        ),
      ],
    );
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final commentsApi = ref.read(commentsApiProvider);

      // Submit the complaint using the comments API
      await commentsApi.commentsIdComplainPost(
        id: widget.comment.id!,
        content: _contentController.text.trim().isEmpty
            ? null
            : _contentController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.complaintSubmitted ??
                  'Complaint submitted successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );

        widget.onComplaintSubmitted?.call();
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n?.failedToSubmitComplaint ??
                  'Failed to submit complaint. Please try again.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
