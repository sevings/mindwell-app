import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../src/core/widgets/images/cached_image.dart';

/// A widget that displays a grid of the user's most recently earned badges.
/// 
/// This widget showcases the user's achievements in a visually appealing grid format.
/// It displays the last 12 badges in a 2-4 row grid, and includes a "View All" button
/// if the user has more than 12 badges.
class BadgeCard extends StatelessWidget {
  /// The list of badges to display
  final List<MwBadge> badges;

  /// Callback when the "View All Badges" button is tapped
  final VoidCallback? onViewAllBadges;

  /// Callback when a badge is tapped
  final void Function(MwBadge badge)? onBadgeTap;

  const BadgeCard({
    super.key,
    required this.badges,
    this.onViewAllBadges,
    this.onBadgeTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Don't show the card if there are no badges
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.badges,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (badges.length > 12)
                  TextButton(
                    onPressed: onViewAllBadges,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.viewAllBadges,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Badge grid
            _buildBadgeGrid(context, theme),
          ],
        ),
      ),
    );
  }

  /// Builds the grid of badges
  Widget _buildBadgeGrid(BuildContext context, ThemeData theme) {
    // Show only the last 12 badges
    final badgesToShow = badges.take(12).toList();
    final hasMoreBadges = badges.length > 12;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the number of rows needed
        final crossAxisCount = 4;
        final itemCount = badgesToShow.length + (hasMoreBadges ? 1 : 0);
        final rowCount = (itemCount / crossAxisCount).ceil();
        
        return SizedBox(
          height: rowCount * 80.0 + (rowCount - 1) * 8.0, // 80px per item + 8px spacing
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // Show "View All" button in the last position if there are more badges
              if (hasMoreBadges && index == badgesToShow.length) {
                return _buildViewAllButton(context, theme);
              }

              final badge = badgesToShow[index];
              return _buildBadgeItem(context, theme, badge);
            },
          ),
        );
      },
    );
  }

  /// Builds an individual badge item
  Widget _buildBadgeItem(BuildContext context, ThemeData theme, MwBadge badge) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: '${l10n.badgeEarned}: ${badge.title ?? badge.code ?? 'Unknown badge'}',
      button: true,
      child: InkWell(
        onTap: () => onBadgeTap?.call(badge),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Badge icon
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildBadgeIcon(context, theme, badge),
                ),
              ),
              
              // Badge title (if space allows)
              if (badge.title != null && badge.title!.isNotEmpty)
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      badge.title!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the badge icon
  Widget _buildBadgeIcon(BuildContext context, ThemeData theme, MwBadge badge) {
    // If badge has an icon URL, use CachedImage
    if (badge.icon != null && badge.icon!.isNotEmpty) {
      return CachedImage(
        imageUrl: badge.icon!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
        borderRadius: 4,
        useSkeletonLoader: true,
        errorWidget: _buildFallbackIcon(context, theme, badge),
      );
    }

    // Fallback to a default icon
    return _buildFallbackIcon(context, theme, badge);
  }

  /// Builds a fallback icon when badge icon is not available
  Widget _buildFallbackIcon(BuildContext context, ThemeData theme, MwBadge badge) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.emoji_events,
        color: theme.colorScheme.onPrimaryContainer,
        size: 24,
      ),
    );
  }

  /// Builds the "View All" button for the grid
  Widget _buildViewAllButton(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: l10n.viewAllBadges,
      button: true,
      child: InkWell(
        onTap: onViewAllBadges,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.more_horiz,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.viewAllBadges,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
