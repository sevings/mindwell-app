import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/profile/providers/profile_provider.dart';

/// A dialog for reporting/complaining about a user.
/// 
/// This dialog allows users to submit a complaint about another user's behavior,
/// with an optional text field for additional details.
class ComplainDialog extends ConsumerStatefulWidget {
  /// The username of the user being reported
  final String username;
  
  /// Callback when complaint is submitted successfully
  final VoidCallback? onComplaintSubmitted;

  const ComplainDialog({
    super.key,
    required this.username,
    this.onComplaintSubmitted,
  });

  @override
  ConsumerState<ComplainDialog> createState() => _ComplainDialogState();
}

class _ComplainDialogState extends ConsumerState<ComplainDialog> {
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
              'Report ${widget.username} for inappropriate behavior.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Additional details (optional)',
                hintText: 'Please describe the issue...',
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
          child: Text('Cancel'),
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
              : Text(l10n?.complain ?? 'Submit Complaint'),
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
      // Import the profile provider - we'll need to add this import
      final profileNotifier = ref.read(profileProvider(widget.username).notifier);
      
      final content = _contentController.text.trim().isEmpty 
          ? null 
          : _contentController.text.trim();

      await profileNotifier.complain(content: content);

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit complaint. Please try again.'),
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

