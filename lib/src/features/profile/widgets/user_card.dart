import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../src/core/widgets/images/cached_image.dart';

/// A reusable widget to display a user's information in a compact card format.
/// 
/// This widget displays the user's cover image, avatar, name, online status,
/// and key statistics (entries, followers, etc.) in a card layout suitable for
/// use in user lists and grids.
/// 
/// ## Usage Examples:
/// 
/// ```dart
/// // Basic usage with MwFriend data
/// UserCard(
///   user: friendUser,
///   onTap: () => context.go('/users/${user.name}'),
/// )
/// 
/// // With custom tap handlers for specific elements
/// UserCard(
///   user: friendUser,
///   onTap: () => context.go('/users/${user.name}'),
///   onEntriesTap: () => context.go('/users/${user.name}/entries'),
///   onFollowersTap: () => context.go('/users/${user.name}/followers'),
/// )
/// ```
class UserCard extends StatelessWidget {
  /// The user data to display
  final MwFriend user;
  
  /// Callback when the entire card is tapped
  final VoidCallback? onTap;
  
  /// Callback when the entries count is tapped
  final VoidCallback? onEntriesTap;
  
  /// Callback when the followers count is tapped
  final VoidCallback? onFollowersTap;
  
  /// Whether to show the cover image
  final bool showCover;
  
  /// The height of the card
  final double? cardHeight;
  
  /// The border radius of the card
  final double borderRadius;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.onEntriesTap,
    this.onFollowersTap,
    this.showCover = true,
    this.cardHeight,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    
    // Handle case where localizations are not available
    if (l10n == null) {
      return _buildErrorCard(context, 'Localization not available');
    }

    return Semantics(
      label: _getSemanticLabel(l10n),
      button: true,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover image section
                if (showCover && user.cover != null) 
                  _buildCoverSection(context, colorScheme),
                
                // Content section
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar and basic info
                      _buildAvatarAndInfo(context, theme, l10n),
                      
                      const SizedBox(height: 8),
                      
                      // User stats
                      _buildUserStats(context, theme, l10n),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the cover image section
  Widget _buildCoverSection(BuildContext context, ColorScheme colorScheme) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        child: CachedImage(
          imageUrl: user.cover?.x318 ?? user.cover?.x1920 ?? '',
          fit: BoxFit.cover,
          useSkeletonLoader: true,
          errorWidget: Container(
            color: colorScheme.surfaceContainerHighest,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 24,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the avatar and user information section
  Widget _buildAvatarAndInfo(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        // Avatar with online status indicator
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surface,
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4.0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: CachedAvatar(
                imageUrl: user.avatar?.x92 ?? user.avatar?.x42,
                size: 48.0,
                fallbackIcon: Icons.person,
              ),
            ),
            
            // Online status indicator
            if (user.isOnline == true)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
        
        const SizedBox(width: 12),
        
        // User info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display name
              Text(
                user.showName ?? user.name ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 2),
              
              // Username
              Text(
                '@${user.name ?? ''}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 2),
              
              // Online status text
              _buildOnlineStatus(context, theme, l10n),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the online status text
  Widget _buildOnlineStatus(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final colorScheme = theme.colorScheme;

    if (user.isOnline == true) {
      return Text(
        l10n.online,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Text(
      l10n.offline,
      style: theme.textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Builds the user statistics section
  Widget _buildUserStats(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final counts = user.counts;

    // Only show stats if we have count data
    if (counts == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        // Entries count
        if (counts.entries != null && counts.entries! > 0)
          _buildStatItem(
            context,
            theme,
            l10n,
            counts.entries.toString(),
            l10n.entries,
            onEntriesTap,
          ),
        
        // Followers count
        if (counts.followers != null && counts.followers! > 0) ...[
          if (counts.entries != null && counts.entries! > 0)
            const SizedBox(width: 16),
          _buildStatItem(
            context,
            theme,
            l10n,
            counts.followers.toString(),
            _getFollowersLabel(l10n, counts.followers!),
            onFollowersTap,
          ),
        ],
        
        // Rank indicator (if available)
        if (user.rank != null) ...[
          if ((counts.entries != null && counts.entries! > 0) ||
              (counts.followers != null && counts.followers! > 0))
            const SizedBox(width: 16),
          _buildRankIndicator(context, theme, user.rank!),
        ],
      ],
    );
  }

  /// Builds a single statistic item
  Widget _buildStatItem(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    String count,
    String label,
    VoidCallback? onTap,
  ) {
    final colorScheme = theme.colorScheme;

    return Semantics(
      label: '$count $label',
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the rank indicator
  Widget _buildRankIndicator(BuildContext context, ThemeData theme, num rank) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 12,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 2),
          Text(
            rank.toString(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Gets the appropriate followers label based on count
  String _getFollowersLabel(AppLocalizations l10n, int count) {
    // For now, we'll use a simple approach
    // In a real app, you might want to add proper pluralization
    return count == 1 ? 'follower' : 'followers';
  }

  /// Gets the semantic label for accessibility
  String _getSemanticLabel(AppLocalizations l10n) {
    final name = user.showName ?? user.name ?? 'Unknown User';
    final username = user.name != null ? '@${user.name}' : '';
    final status = user.isOnline == true ? l10n.online : l10n.offline;
    final counts = user.counts;
    
    String stats = '';
    if (counts != null) {
      final parts = <String>[];
      if (counts.entries != null && counts.entries! > 0) {
        parts.add('${counts.entries} ${l10n.entries}');
      }
      if (counts.followers != null && counts.followers! > 0) {
        parts.add('${counts.followers} ${_getFollowersLabel(l10n, counts.followers!)}');
      }
      if (parts.isNotEmpty) {
        stats = ', ${parts.join(', ')}';
      }
    }
    
    return '$name $username, $status$stats';
  }

  /// Builds an error card when localization is not available
  Widget _buildErrorCard(BuildContext context, String message) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        height: cardHeight,
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
