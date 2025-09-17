import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// A widget that displays a user's avatar with fallback options
class UserAvatar extends StatelessWidget {
  /// The avatar data to display
  final MwAvatar? avatar;

  /// The radius of the avatar
  final double radius;

  /// Whether to show online status indicator
  final bool showOnlineStatus;

  /// Whether the user is online (for status indicator)
  final bool isOnline;

  /// Custom fallback widget
  final Widget? fallback;

  const UserAvatar({
    super.key,
    this.avatar,
    this.radius = 16,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine which avatar size to use based on radius
    String? avatarUrl;
    if (avatar != null) {
      if (radius <= 21) {
        avatarUrl = avatar!.x42;
      } else if (radius <= 46) {
        avatarUrl = avatar!.x92;
      } else {
        avatarUrl = avatar!.x124;
      }
    }

    Widget avatarWidget;

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      avatarWidget = CircleAvatar(
        radius: radius,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: avatarUrl,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildFallbackAvatar(theme),
            errorWidget: (context, url, error) => _buildFallbackAvatar(theme),
          ),
        ),
      );
    } else {
      avatarWidget = _buildFallbackAvatar(theme);
    }

    // Add online status indicator if requested
    if (showOnlineStatus && isOnline) {
      return Stack(
        children: [
          avatarWidget,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.4,
              height: radius * 0.4,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.surface, width: 1),
              ),
            ),
          ),
        ],
      );
    }

    return avatarWidget;
  }

  /// Builds a fallback avatar when no image is available
  Widget _buildFallbackAvatar(ThemeData theme) {
    if (fallback != null) {
      return fallback!;
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: radius * 0.8,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }
}
