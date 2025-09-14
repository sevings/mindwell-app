import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';

/// Widget that displays navigation to adjacent entries (previous and next).
/// 
/// This widget shows clickable titles and arrows for the previous and next entries,
/// allowing users to navigate directly to adjacent entries without going back to the feed.
class AdjacentEntryNavigation extends StatelessWidget {
  /// The adjacent entries data containing previous and next entry information
  final MwAdjacentEntries? adjacentEntries;
  
  /// Callback when user taps on the previous entry
  final VoidCallback? onPreviousTap;
  
  /// Callback when user taps on the next entry
  final VoidCallback? onNextTap;

  const AdjacentEntryNavigation({
    super.key,
    required this.adjacentEntries,
    this.onPreviousTap,
    this.onNextTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Don't show navigation if no adjacent entries
    if (adjacentEntries == null) {
      return const SizedBox.shrink();
    }
    
    final older = adjacentEntries!.older;
    final newer = adjacentEntries!.newer;
    
    // Don't show navigation if no adjacent entries are available
    if (older == null && newer == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Previous entry (older)
          if (older != null) _buildEntryNavigation(
            context,
            entry: older,
            isPrevious: true,
            onTap: onPreviousTap,
          ),
          
          // Divider between entries if both exist
          if (older != null && newer != null)
            Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          
          // Next entry (newer)
          if (newer != null) _buildEntryNavigation(
            context,
            entry: newer,
            isPrevious: false,
            onTap: onNextTap,
          ),
        ],
      ),
    );
  }

  Widget _buildEntryNavigation(
    BuildContext context, {
    required MwCalendarEntry entry,
    required bool isPrevious,
    VoidCallback? onTap,
  }) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    final title = entry.title?.isNotEmpty == true 
        ? entry.title! 
        : l10n?.untitled ?? 'Untitled';
    
    final timestamp = entry.createdAt != null 
        ? _formatTimestamp(entry.createdAt!)
        : null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Navigation arrow
              Icon(
                isPrevious ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              
              // Entry information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Navigation label
                    Text(
                      isPrevious 
                          ? (l10n?.previousEntry ?? 'Previous Entry')
                          : (l10n?.nextEntry ?? 'Next Entry'),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Entry title
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Timestamp
                    if (timestamp != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        timestamp,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Arrow indicator at the end
              Icon(
                isPrevious ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(double timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).round());
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
