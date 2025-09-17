import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../models/chat_messages_state.dart';

/// A widget that displays a single message in a chat conversation.
///
/// Shows the message content with different styling for sent vs received messages,
/// message status indicators, and handles message interactions.
class MessageBubble extends StatelessWidget {
  /// The message to display
  final MwMessage message;

  /// Whether this message was sent by the current user
  final bool isFromCurrentUser;

  /// The status of the message (sending, sent, failed, etc.)
  final MessageStatus? messageStatus;

  /// Callback when the message is long-pressed
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isFromCurrentUser,
    this.messageStatus,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = message.editContent ?? message.content ?? '';

    return Semantics(
      label: _getSemanticLabel(content, messageStatus),
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          margin: EdgeInsets.only(
            left: isFromCurrentUser ? 50 : 16,
            right: isFromCurrentUser ? 16 : 50,
            top: 4,
            bottom: 4,
          ),
          child: Row(
            mainAxisAlignment: isFromCurrentUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isFromCurrentUser) ...[
                _buildAvatar(theme),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: isFromCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _buildMessageContent(theme, content),
                    const SizedBox(height: 4),
                    _buildMessageFooter(theme),
                  ],
                ),
              ),
              if (isFromCurrentUser) ...[
                const SizedBox(width: 8),
                _buildStatusIndicator(theme),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the message content bubble
  Widget _buildMessageContent(ThemeData theme, String content) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isFromCurrentUser
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(isFromCurrentUser ? 18 : 4),
          bottomRight: Radius.circular(isFromCurrentUser ? 4 : 18),
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
          color: isFromCurrentUser
              ? colorScheme.onPrimary
              : colorScheme.onSurface,
        ),
      ),
    );
  }

  /// Builds the message footer with timestamp
  Widget _buildMessageFooter(ThemeData theme) {
    final timestamp = _formatTimestamp(message.createdAt);

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
    if (!isFromCurrentUser) return const SizedBox.shrink();

    final status = messageStatus ?? MessageStatus.sent;
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

    return Icon(icon, size: 16, color: color);
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

  /// Gets the semantic label for accessibility
  String _getSemanticLabel(String content, MessageStatus? status) {
    final statusText = status != null ? 'Status: ${status.name}' : '';
    return '$content. $statusText';
  }
}
