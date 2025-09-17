import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';

/// A widget that displays a single notification item.
///
/// This widget shows:
/// - An icon based on the notification type
/// - The notification text/content
/// - Timestamp
/// - Read/unread indicator
/// - Tap handling to mark as read and navigate to relevant content
class NotificationItem extends StatelessWidget {
  /// The notification to display
  final MwNotification notification;

  /// Callback when the notification is tapped
  final VoidCallback? onTap;

  const NotificationItem({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    final isRead = notification.read == true;
    final notificationType = notification.type;
    final createdAt = notification.createdAt;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap?.call();
          _handleNotificationTap(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: MindwellSpacing.md,
            vertical: MindwellSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isRead
                ? Colors.transparent
                : colorScheme.primaryContainer.withValues(alpha: 0.1),
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getNotificationIconColor(
                    notificationType,
                    colorScheme,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getNotificationIcon(notificationType),
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: MindwellSpacing.sm),

              // Notification content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notification text
                    Text(
                      _getNotificationText(notification, l10n),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: isRead
                            ? FontWeight.normal
                            : FontWeight.w600,
                        color: isRead
                            ? colorScheme.onSurface.withValues(alpha: 0.7)
                            : colorScheme.onSurface,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: MindwellSpacing.xs),

                    // Timestamp
                    if (createdAt != null)
                      Text(
                        _formatTimestamp(createdAt, l10n),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                  ],
                ),
              ),

              // Unread indicator
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handle notification tap by navigating to relevant content.
  void _handleNotificationTap(BuildContext context) {
    final notification = this.notification;
    final type = notification.type;

    // Navigate based on notification type
    switch (type) {
      case MwNotificationTypeEnum.comment:
        // Navigate to entry detail if comment is available
        if (notification.entry?.id != null) {
          context.go('/entries/${notification.entry!.id}');
        }
        break;
      case MwNotificationTypeEnum.follower:
      case MwNotificationTypeEnum.request:
      case MwNotificationTypeEnum.accept:
        // Navigate to user profile if user is available
        if (notification.user?.name != null) {
          context.go('/users/${notification.user!.name}');
        }
        break;
      case MwNotificationTypeEnum.entryMoved:
        // Navigate to entry detail if entry is available
        if (notification.entry?.id != null) {
          context.go('/entries/${notification.entry!.id}');
        }
        break;
      case MwNotificationTypeEnum.badge:
        // Navigate to user profile to show badges
        if (notification.user?.name != null) {
          context.go('/users/${notification.user!.name}');
        }
        break;
      case MwNotificationTypeEnum.wishCreated:
      case MwNotificationTypeEnum.wishReceived:
        // Navigate to user profile if user is available
        if (notification.user?.name != null) {
          context.go('/users/${notification.user!.name}');
        }
        break;
      case MwNotificationTypeEnum.invite:
      case MwNotificationTypeEnum.invited:
      case MwNotificationTypeEnum.welcome:
      case MwNotificationTypeEnum.admSent:
      case MwNotificationTypeEnum.admReceived:
      case MwNotificationTypeEnum.info:
      default:
        // For general notifications, do nothing or show a dialog
        break;
    }
  }

  /// Get the appropriate icon for the notification type.
  IconData _getNotificationIcon(MwNotificationTypeEnum? type) {
    switch (type) {
      case MwNotificationTypeEnum.comment:
        return Icons.comment;
      case MwNotificationTypeEnum.follower:
        return Icons.person_add;
      case MwNotificationTypeEnum.request:
        return Icons.person_add_alt_1;
      case MwNotificationTypeEnum.accept:
        return Icons.check_circle;
      case MwNotificationTypeEnum.invite:
        return Icons.mail;
      case MwNotificationTypeEnum.invited:
        return Icons.mail_outline;
      case MwNotificationTypeEnum.welcome:
        return Icons.waving_hand;
      case MwNotificationTypeEnum.badge:
        return Icons.emoji_events;
      case MwNotificationTypeEnum.admSent:
        return Icons.admin_panel_settings;
      case MwNotificationTypeEnum.admReceived:
        return Icons.admin_panel_settings_outlined;
      case MwNotificationTypeEnum.wishCreated:
        return Icons.star;
      case MwNotificationTypeEnum.wishReceived:
        return Icons.star_outline;
      case MwNotificationTypeEnum.entryMoved:
        return Icons.move_to_inbox;
      case MwNotificationTypeEnum.info:
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  /// Get the appropriate color for the notification icon.
  Color _getNotificationIconColor(
    MwNotificationTypeEnum? type,
    ColorScheme colorScheme,
  ) {
    switch (type) {
      case MwNotificationTypeEnum.comment:
        return Colors.blue;
      case MwNotificationTypeEnum.follower:
      case MwNotificationTypeEnum.request:
      case MwNotificationTypeEnum.accept:
        return Colors.green;
      case MwNotificationTypeEnum.invite:
      case MwNotificationTypeEnum.invited:
        return Colors.orange;
      case MwNotificationTypeEnum.welcome:
        return Colors.purple;
      case MwNotificationTypeEnum.badge:
        return Colors.amber;
      case MwNotificationTypeEnum.admSent:
      case MwNotificationTypeEnum.admReceived:
        return Colors.red;
      case MwNotificationTypeEnum.wishCreated:
      case MwNotificationTypeEnum.wishReceived:
        return Colors.pink;
      case MwNotificationTypeEnum.entryMoved:
        return Colors.teal;
      case MwNotificationTypeEnum.info:
        return Colors.cyan;
      default:
        return colorScheme.primary;
    }
  }

  /// Get the notification text based on type and content.
  String _getNotificationText(
    MwNotification notification,
    AppLocalizations? l10n,
  ) {
    final type = notification.type;
    final user = notification.user;
    final entry = notification.entry;
    final badge = notification.badge;
    final info = notification.info;

    final userName = user?.name ?? user?.showName ?? 'Unknown User';

    switch (type) {
      case MwNotificationTypeEnum.comment:
        if (entry != null) {
          return l10n?.notificationCommentText(userName) ??
              '$userName commented on your entry';
        }
        return l10n?.notificationCommentGeneralText(userName) ??
            '$userName commented on your content';

      case MwNotificationTypeEnum.follower:
        return l10n?.notificationFollowerText(userName) ??
            '$userName started following you';

      case MwNotificationTypeEnum.request:
        return l10n?.notificationRequestText(userName) ??
            '$userName sent you a follow request';

      case MwNotificationTypeEnum.accept:
        return l10n?.notificationAcceptText(userName) ??
            '$userName accepted your follow request';

      case MwNotificationTypeEnum.invite:
        return l10n?.notificationInviteText(userName) ??
            '$userName invited you to join';

      case MwNotificationTypeEnum.invited:
        return l10n?.notificationInvitedText(userName) ??
            'You were invited by $userName';

      case MwNotificationTypeEnum.welcome:
        return l10n?.notificationWelcomeText ?? 'Welcome to Mindwell!';

      case MwNotificationTypeEnum.badge:
        if (badge != null) {
          return l10n?.notificationBadgeText(badge.title ?? 'Badge') ??
              'You earned a new badge: ${badge.title}';
        }
        return l10n?.notificationBadgeGeneralText ?? 'You earned a new badge!';

      case MwNotificationTypeEnum.admSent:
        return l10n?.notificationAdmSentText(userName) ??
            'You sent a message to $userName';

      case MwNotificationTypeEnum.admReceived:
        return l10n?.notificationAdmReceivedText(userName) ??
            'You received a message from $userName';

      case MwNotificationTypeEnum.wishCreated:
        return l10n?.notificationWishCreatedText(userName) ??
            '$userName created a wish';

      case MwNotificationTypeEnum.wishReceived:
        return l10n?.notificationWishReceivedText(userName) ??
            'You received a wish from $userName';

      case MwNotificationTypeEnum.entryMoved:
        return l10n?.notificationEntryMovedText ?? 'Your entry was moved';

      case MwNotificationTypeEnum.info:
        if (info != null) {
          return info.content ??
              (l10n?.notificationInfoText ?? 'New information available');
        }
        return l10n?.notificationInfoText ?? 'New information available';

      default:
        return l10n?.notificationDefaultText ?? 'New notification';
    }
  }

  /// Format the timestamp for display.
  String _formatTimestamp(double timestamp, AppLocalizations? l10n) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      (timestamp * 1000).round(),
    );
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, y').format(dateTime);
    } else if (difference.inHours > 0) {
      return l10n?.timeHoursAgo(difference.inHours) ??
          '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return l10n?.timeMinutesAgo(difference.inMinutes) ??
          '${difference.inMinutes}m ago';
    } else {
      return l10n?.timeJustNow ?? 'Just now';
    }
  }
}
