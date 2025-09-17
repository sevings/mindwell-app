import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message_action.dart';
import '../providers/chat_messages_provider.dart';

/// Dialog for displaying message actions (edit, delete, report)
class MessageActionsDialog extends ConsumerWidget {
  final int messageId;
  final String messageContent;
  final bool isFromCurrentUser;
  final String chatUsername;

  const MessageActionsDialog({
    super.key,
    required this.messageId,
    required this.messageContent,
    required this.isFromCurrentUser,
    required this.chatUsername,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text('Message Actions', style: theme.textTheme.titleMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isFromCurrentUser) ...[
            _buildActionTile(
              context,
              ref,
              icon: Icons.edit,
              title: 'Edit',
              subtitle: 'Edit this message',
              onTap: () => _handleEdit(context, ref),
            ),
            const Divider(),
            _buildActionTile(
              context,
              ref,
              icon: Icons.delete,
              title: 'Delete',
              subtitle: 'Delete this message',
              onTap: () => _handleDelete(context, ref),
              isDestructive: true,
            ),
            const Divider(),
          ],
          _buildActionTile(
            context,
            ref,
            icon: Icons.report,
            title: 'Report',
            subtitle: 'Report this message',
            onTap: () => _handleReport(context, ref),
            isDestructive: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: colorScheme.onSurface)),
        ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? colorScheme.error : colorScheme.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDestructive ? colorScheme.error : colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      onTap: onTap,
    );
  }

  void _handleEdit(BuildContext context, WidgetRef ref) {
    Navigator.of(context).pop();

    // Show edit dialog
    showDialog(
      context: context,
      builder: (context) => _EditMessageDialog(
        messageId: messageId,
        currentContent: messageContent,
        chatUsername: chatUsername,
      ),
    );
  }

  void _handleDelete(BuildContext context, WidgetRef ref) {
    Navigator.of(context).pop();

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text(
          'Are you sure you want to delete this message? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _performAction(
                context,
                ref,
                MessageAction.delete(messageId: messageId),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _handleReport(BuildContext context, WidgetRef ref) {
    Navigator.of(context).pop();

    // Show report dialog
    showDialog(
      context: context,
      builder: (context) => _ReportMessageDialog(
        messageId: messageId,
        chatUsername: chatUsername,
      ),
    );
  }

  Future<void> _performAction(
    BuildContext context,
    WidgetRef ref,
    MessageAction action,
  ) async {
    final notifier = ref.read(chatMessagesProvider(chatUsername).notifier);

    try {
      final result = await notifier.performMessageAction(action);

      if (context.mounted) {
        result.when(
          success: (message) {
            if (message != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            }
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

/// Dialog for editing a message
class _EditMessageDialog extends ConsumerStatefulWidget {
  final int messageId;
  final String currentContent;
  final String chatUsername;

  const _EditMessageDialog({
    required this.messageId,
    required this.currentContent,
    required this.chatUsername,
  });

  @override
  ConsumerState<_EditMessageDialog> createState() => _EditMessageDialogState();
}

class _EditMessageDialogState extends ConsumerState<_EditMessageDialog> {
  late TextEditingController _controller;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: const Text('Edit Message'),
      content: TextField(
        controller: _controller,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: 'Enter your message...',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          child: _isSubmitting
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                  ),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final notifier = ref.read(
        chatMessagesProvider(widget.chatUsername).notifier,
      );
      final action = MessageAction.edit(
        messageId: widget.messageId,
        currentContent: _controller.text.trim(),
      );

      final result = await notifier.performMessageAction(action);

      if (mounted) {
        Navigator.of(context).pop();

        result.when(
          success: (message) {
            if (message != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            }
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
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

/// Dialog for reporting a message
class _ReportMessageDialog extends ConsumerStatefulWidget {
  final int messageId;
  final String chatUsername;

  const _ReportMessageDialog({
    required this.messageId,
    required this.chatUsername,
  });

  @override
  ConsumerState<_ReportMessageDialog> createState() =>
      _ReportMessageDialogState();
}

class _ReportMessageDialogState extends ConsumerState<_ReportMessageDialog> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: const Text('Report Message'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Please provide a reason for reporting this message:'),
          const SizedBox(height: 16),
          TextField(
            controller: _reasonController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter reason...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          child: _isSubmitting
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.error,
                    ),
                  ),
                )
              : Text('Report', style: TextStyle(color: colorScheme.error)),
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      final notifier = ref.read(
        chatMessagesProvider(widget.chatUsername).notifier,
      );
      final action = MessageAction.report(
        messageId: widget.messageId,
        reason: _reasonController.text.trim().isNotEmpty
            ? _reasonController.text.trim()
            : null,
      );

      final result = await notifier.performMessageAction(action);

      if (mounted) {
        Navigator.of(context).pop();

        result.when(
          success: (message) {
            if (message != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            }
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
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
