import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';

/// A widget that displays a single chat conversation item in the chat list.
///
/// Shows the partner's avatar, name, last message preview, timestamp,
/// and unread message count badge.
class ChatListItem extends StatelessWidget {
  /// The chat data to display
  final MwChat chat;

  /// Callback when the item is tapped
  final VoidCallback? onTap;

  const ChatListItem({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final partner = chat.partner;
    final lastMessage = chat.lastMessage;
    final unreadCount = chat.unreadCount ?? 0;

    if (partner == null) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: _getSemanticLabel(l10n, partner, lastMessage, unreadCount),
      button: true,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        leading: _buildAvatar(theme, partner),
        title: _buildTitle(theme, partner),
        subtitle: _buildSubtitle(theme, lastMessage),
        trailing: _buildTrailing(theme, lastMessage, unreadCount),
        onTap: onTap ?? () => _navigateToChat(context, partner),
      ),
    );
  }

  /// Builds the partner's avatar
  Widget _buildAvatar(ThemeData theme, MwUser partner) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          child: _buildAvatarContent(partner),
        ),
        // Online status indicator
        if (partner.isOnline == true)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the avatar content (image or initials)
  Widget _buildAvatarContent(MwUser partner) {
    final avatar = partner.avatar;
    final showName = partner.showName ?? partner.name ?? '';

    if (avatar?.x92 != null && avatar!.x92!.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatar.x92!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildInitials(showName),
          errorWidget: (context, url, error) => _buildInitials(showName),
        ),
      );
    } else {
      return _buildInitials(showName);
    }
  }

  /// Builds initials when no avatar is available
  Widget _buildInitials(String name) {
    final initials = name.isNotEmpty
        ? name
              .split(' ')
              .map((word) => word.isNotEmpty ? word[0] : '')
              .join('')
              .toUpperCase()
        : '?';

    return Text(
      initials.length > 2 ? initials.substring(0, 2) : initials,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  /// Builds the title (partner's name)
  Widget _buildTitle(ThemeData theme, MwUser partner) {
    final displayName = partner.showName ?? partner.name ?? 'Unknown';

    return Text(
      displayName,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the subtitle (last message preview)
  Widget _buildSubtitle(ThemeData theme, MwMessage? lastMessage) {
    if (lastMessage == null) {
      return Text(
        'No messages yet',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          fontStyle: FontStyle.italic,
        ),
      );
    }

    final content = lastMessage.editContent ?? lastMessage.content ?? '';
    final plainText = _stripHtmlTags(content);
    final preview = plainText.length > 50
        ? '${plainText.substring(0, 50)}...'
        : plainText;

    return Text(
      preview,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds the trailing widget (timestamp and unread badge)
  Widget _buildTrailing(
    ThemeData theme,
    MwMessage? lastMessage,
    int unreadCount,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Timestamp
        Text(
          _formatTimestamp(lastMessage?.createdAt),
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        // Unread badge
        if (unreadCount > 0)
          Badge(
            label: Text(
              unreadCount > 99 ? '99+' : unreadCount.toString(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
          ),
      ],
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
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  /// Gets the semantic label for accessibility
  String _getSemanticLabel(
    AppLocalizations l10n,
    MwUser partner,
    MwMessage? lastMessage,
    int unreadCount,
  ) {
    final displayName = partner.showName ?? partner.name ?? 'Unknown';
    final lastMessageText = lastMessage?.content ?? 'No messages yet';
    final unreadText = unreadCount > 0 ? 'Unread messages: $unreadCount' : '';

    return '$displayName. $lastMessageText. $unreadText';
  }

  /// Navigates to the chat screen
  void _navigateToChat(BuildContext context, MwUser partner) {
    final username = partner.name;
    if (username != null && username.isNotEmpty) {
      context.push('/chats/$username');
    }
  }

  /// Strips HTML tags from content to create plain text preview
  String _stripHtmlTags(String html) {
    if (html.isEmpty) return '';

    // Simple HTML tag removal using regex
    // This handles most common cases for message content
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
        .replaceAll(RegExp(r'&nbsp;'), ' ') // Replace non-breaking spaces
        .replaceAll(RegExp(r'&amp;'), '&') // Replace HTML entities
        .replaceAll(RegExp(r'&lt;'), '<')
        .replaceAll(RegExp(r'&gt;'), '>')
        .replaceAll(RegExp(r'&quot;'), '"')
        .replaceAll(RegExp(r'&#39;'), "'")
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        ) // Replace multiple whitespace with single space
        .trim();
  }
}
