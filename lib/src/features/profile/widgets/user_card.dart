import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';

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

                // Avatar overlapping the cover and content sections
                Transform.translate(
                  offset: showCover && user.cover != null
                      ? const Offset(0, -46) // Move avatar up to overlap
                      : Offset.zero,
                  child: Center(child: _buildAvatar(context, theme)),
                ),

                // Content section - positioned below the overlapping avatar
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    top: showCover && user.cover != null ? 0.0 : 12.0,
                    bottom: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // User info (name and status) - centered below avatar
                      _buildUserInfo(context, theme, l10n),

                      const SizedBox(height: 16), // More space before stats
                      // User stats (always show exactly 3 counts) - at bottom
                      _buildUserStats(context, theme, l10n),

                      // Profile title if not empty
                      if (user.title != null && user.title!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _buildProfileTitle(context, theme),
                      ],
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

  /// Builds the cover image section with 3:1 aspect ratio
  Widget _buildCoverSection(BuildContext context, ColorScheme colorScheme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate height for 3:1 aspect ratio
        final imageHeight = constraints.maxWidth / 3;

        return Container(
          height: imageHeight,
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
      },
    );
  }

  /// Builds the avatar with online status indicator
  Widget _buildAvatar(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.surface, width: 3.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          CachedAvatar(
            imageUrl: user.avatar?.x92 ?? user.avatar?.x42,
            size: 92.0, // Avatar size set to 92px
            fallbackIcon: Icons.person,
          ),

          // Online status indicator
          if (user.isOnline == true)
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.surface, width: 2.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the user information section (name, status)
  Widget _buildUserInfo(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display name - more prominent and centered
        Text(
          user.showName ?? user.name ?? '',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        // Online status text - centered
        _buildOnlineStatus(context, theme, l10n),
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
        textAlign: TextAlign.center,
      );
    }

    return Text(
      l10n.offline,
      style: theme.textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Builds the user statistics section (always shows entries, followers, and rank)
  Widget _buildUserStats(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final counts = user.counts;

    // Always show exactly 3 stats: entries, followers, and rank
    final statsToShow = <_StatInfo>[
      _StatInfo(
        count: (counts?.entries ?? 0).toString(),
        label: l10n.entries,
        onTap: () => _navigateToEntries(context),
      ),
      _StatInfo(
        count: (counts?.followers ?? 0).toString(),
        label: l10n.followers,
        onTap: () => _navigateToFollowers(context),
      ),
      _StatInfo(
        count: (user.rank ?? 0).toString(),
        label: 'Rank', // TODO: Add to localization files
        onTap: null, // Rank is not clickable
      ),
    ];

    return Row(
      children: statsToShow.map((stat) {
        return Expanded(
          child: _buildStatItem(
            context,
            theme,
            l10n,
            stat.count,
            stat.label,
            stat.onTap,
          ),
        );
      }).toList(),
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
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Text(
                count,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the profile title section
  Widget _buildProfileTitle(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Text(
      user.title!,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Navigation methods
  void _navigateToEntries(BuildContext context) {
    if (user.name != null && user.name!.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(user.name!)}/entries');
    }
  }

  void _navigateToFollowers(BuildContext context) {
    if (user.name != null && user.name!.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(user.name!)}/followers');
    }
  }

  /// Gets the semantic label for accessibility
  String _getSemanticLabel(AppLocalizations l10n) {
    final name = user.showName ?? user.name ?? 'Unknown User';
    final status = user.isOnline == true ? l10n.online : l10n.offline;
    final counts = user.counts;

    final parts = <String>[];
    parts.add('${counts?.entries ?? 0} ${l10n.entries}');
    parts.add('${counts?.followers ?? 0} ${l10n.followers}');
    parts.add('${user.rank ?? 0} Rank');

    final stats = ', ${parts.join(', ')}';
    final title = user.title != null && user.title!.isNotEmpty
        ? ', ${user.title}'
        : '';

    return '$name, $status$stats$title';
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

/// Helper class to hold stat information
class _StatInfo {
  final String count;
  final String label;
  final VoidCallback? onTap;

  const _StatInfo({required this.count, required this.label, this.onTap});
}
