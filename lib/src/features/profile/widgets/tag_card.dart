import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';

/// A widget that displays the tags used by the user.
/// 
/// This widget showcases the user's tag usage in a visually appealing format.
/// It displays tags in a cloud or list format, and tapping on a tag navigates
/// to the entry feed filtered by that tag.
class TagCard extends StatelessWidget {
  /// The list of tags with their usage counts
  final List<MwTagListDataInner> tags;

  const TagCard({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    // Handle case where localizations are not available
    if (l10n == null) {
      return const SizedBox.shrink();
    }

    // Don't show the card if there are no tags
    if (tags.isEmpty) {
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
                  Icons.tag_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.tags,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Show total tag count (only valid tags)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${tags.where((tag) => tag.tag != null && tag.tag!.isNotEmpty).length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Tag cloud/list
            _buildTagCloud(context, theme),
          ],
        ),
      ),
    );
  }

  /// Builds the tag cloud or list
  Widget _buildTagCloud(BuildContext context, ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tagData) => _buildTagChip(context, theme, tagData)).toList(),
    );
  }

  /// Builds an individual tag chip
  Widget _buildTagChip(BuildContext context, ThemeData theme, MwTagListDataInner tagData) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return const SizedBox.shrink();
    
    final tag = tagData.tag ?? '';
    final count = tagData.count ?? 0;

    // Don't show tags with empty names
    if (tag.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      label: '$tag (${l10n.used} $count ${count == 1 ? l10n.time : l10n.times})',
      button: true,
      child: InkWell(
        onTap: () => _navigateToTagFeed(context, tag),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tag name
              Text(
                '#$tag',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              // Tag count (if greater than 1)
              if (count > 1) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$count',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the entry feed filtered by the selected tag
  void _navigateToTagFeed(BuildContext context, String tag) {
    // Use the existing tag route from the router
    context.go('/tags/${Uri.encodeComponent(tag)}');
  }
}
