import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../models/chat_messages_state.dart';
import '../models/message_action.dart';
import '../providers/chat_messages_provider.dart';
import 'message_actions_dialog.dart';

/// A widget that displays a single message in a chat conversation.
///
/// Shows the message content with different styling for sent vs received messages,
/// message status indicators, and handles message interactions.
class MessageBubble extends ConsumerStatefulWidget {
  /// The message to display
  final MwMessage message;

  /// Whether this message was sent by the current user
  final bool isFromCurrentUser;

  /// The status of the message (sending, sent, failed, etc.)
  final MessageStatus? messageStatus;

  /// The chat username for message actions
  final String chatUsername;

  /// Callback when the message is long-pressed
  final VoidCallback? onLongPress;

  /// Whether this is a new message that should be animated
  final bool isNewMessage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isFromCurrentUser,
    this.messageStatus,
    required this.chatUsername,
    this.onLongPress,
    this.isNewMessage = false,
  });

  @override
  ConsumerState<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends ConsumerState<MessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: widget.isFromCurrentUser
              ? const Offset(0.3, 0.0)
              : const Offset(-0.3, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    // Start animation if this is a new message
    if (widget.isNewMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward();
      });
    } else {
      // For existing messages, set to final state immediately
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = widget.message.editContent ?? widget.message.content ?? '';

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Semantics(
                label: _getSemanticLabel(content, widget.messageStatus),
                child: GestureDetector(
                  onLongPress:
                      widget.onLongPress ?? () => _showMessageActions(context),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: widget.isFromCurrentUser ? 50 : 16,
                      right: widget.isFromCurrentUser ? 16 : 50,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: widget.isFromCurrentUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!widget.isFromCurrentUser) ...[
                          _buildAvatar(theme),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Column(
                            crossAxisAlignment: widget.isFromCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              _buildMessageContent(theme, content),
                              const SizedBox(height: 4),
                              _buildMessageFooter(theme),
                            ],
                          ),
                        ),
                        if (widget.isFromCurrentUser) ...[
                          const SizedBox(width: 8),
                          _buildStatusIndicator(theme),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the message content bubble
  Widget _buildMessageContent(ThemeData theme, String content) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.isFromCurrentUser
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(widget.isFromCurrentUser ? 18 : 4),
          bottomRight: Radius.circular(widget.isFromCurrentUser ? 4 : 18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        content,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: widget.isFromCurrentUser
              ? colorScheme.onPrimary
              : colorScheme.onSurface,
        ),
      ),
    );
  }

  /// Builds the message footer with timestamp
  Widget _buildMessageFooter(ThemeData theme) {
    final timestamp = _formatTimestamp(widget.message.createdAt);

    return Text(
      timestamp,
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        fontSize: 11,
      ),
    );
  }

  /// Builds the status indicator for sent messages
  Widget _buildStatusIndicator(ThemeData theme) {
    if (!widget.isFromCurrentUser) return const SizedBox.shrink();

    final status = widget.messageStatus ?? MessageStatus.sent;
    final colorScheme = theme.colorScheme;

    IconData icon;
    Color color;

    switch (status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        color = colorScheme.onSurface.withValues(alpha: 0.6);
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        color = colorScheme.onSurface.withValues(alpha: 0.6);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = colorScheme.onSurface.withValues(alpha: 0.6);
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = colorScheme.primary;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = colorScheme.error;
        break;
    }

    if (status == MessageStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => _retryMessage(context),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.refresh,
                size: 12,
                color: colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      );
    }

    return Icon(icon, size: 16, color: color);
  }

  /// Retry sending a failed message
  void _retryMessage(BuildContext context) {
    // Get the provider reference from the context
    final container = ProviderScope.containerOf(context);
    final notifier = container.read(
      chatMessagesProvider(widget.chatUsername).notifier,
    );
    final action = MessageAction.retry(
      messageId: widget.message.id ?? 0,
      content: widget.message.content ?? '',
    );

    notifier.performMessageAction(action).then((result) {
      if (context.mounted) {
        result.when(
          success: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message ?? 'Message retry initiated'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
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
    });
  }

  /// Builds the avatar for received messages
  Widget _buildAvatar(ThemeData theme) {
    // For now, we'll use a simple circle avatar
    // In a real implementation, you might want to fetch the user's avatar
    return CircleAvatar(
      radius: 16,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: 16,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }

  /// Formats the timestamp for display
  String _formatTimestamp(double? timestamp) {
    if (timestamp == null) return '';

    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      (timestamp * 1000).toInt(),
    );
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inHours > 0) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inMinutes > 0) {
      return '${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
    } else {
      return 'now';
    }
  }

  /// Shows message actions dialog
  void _showMessageActions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MessageActionsDialog(
        messageId: widget.message.id ?? 0,
        messageContent: widget.message.content ?? '',
        isFromCurrentUser: widget.isFromCurrentUser,
        chatUsername: widget.chatUsername,
      ),
    );
  }

  /// Gets the semantic label for accessibility
  String _getSemanticLabel(String content, MessageStatus? status) {
    final statusText = status != null ? 'Status: ${status.name}' : '';
    return '$content. $statusText';
  }
}
