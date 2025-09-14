import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';

/// A widget that displays a list of the user's most recent entries.
/// 
/// This widget shows the last 10 entry titles and dates from the calendar data.
/// It is only displayed if the user has at least one entry.
/// Tapping an entry navigates to the entry detail screen.
class LastEntriesCard extends StatelessWidget {
  /// The calendar data containing the user's entries
  final MwCalendar? calendarData;

  /// Callback when the "View All Entries" button is tapped
  final VoidCallback? onViewAllEntries;

  const LastEntriesCard({
    super.key,
    required this.calendarData,
    this.onViewAllEntries,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Don't show the card if there are no entries
    if (calendarData?.entries == null || calendarData!.entries!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get the last 10 entries, sorted by creation date (newest first)
    final entries = _getLastEntries(calendarData!.entries!.toList());

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
                  Icons.article_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.lastEntries,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (calendarData!.entries!.length > 10)
                  TextButton(
                    onPressed: onViewAllEntries,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.viewAllEntries,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Entries list
            _buildEntriesList(context, theme, entries),
          ],
        ),
      ),
    );
  }

  /// Gets the last 10 entries sorted by creation date (newest first)
  List<MwCalendarEntry> _getLastEntries(List<MwCalendarEntry> allEntries) {
    // Sort by creation date (newest first)
    allEntries.sort((a, b) {
      final aDate = a.createdAt ?? 0;
      final bDate = b.createdAt ?? 0;
      return bDate.compareTo(aDate);
    });
    
    // Return the first 10 entries
    return allEntries.take(10).toList();
  }

  /// Builds the list of entries
  Widget _buildEntriesList(
    BuildContext context,
    ThemeData theme,
    List<MwCalendarEntry> entries,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: entries.length * 80.0, // Fixed height based on item count
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: entries.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 0.5,
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return _buildEntryItem(context, theme, entry, l10n);
        },
      ),
    );
  }

  /// Builds an individual entry item
  Widget _buildEntryItem(
    BuildContext context,
    ThemeData theme,
    MwCalendarEntry entry,
    AppLocalizations l10n,
  ) {
    final title = (entry.title?.isNotEmpty == true) 
        ? entry.title! 
        : l10n.untitled;
    
    final date = entry.createdAt != null
        ? DateTime.fromMillisecondsSinceEpoch((entry.createdAt! * 1000).toInt())
        : null;
    
    final formattedDate = date != null
        ? DateFormat('MMM dd, yyyy').format(date)
        : '';

    return Semantics(
      label: '${l10n.entryTitle}: $title',
      button: true,
      child: InkWell(
        onTap: () => _navigateToEntry(context, entry),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              // Entry icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.article_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              
              // Entry content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Entry title
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (formattedDate.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      // Entry date
                      Text(
                        formattedDate,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Navigation arrow
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the entry detail screen
  void _navigateToEntry(BuildContext context, MwCalendarEntry entry) {
    if (entry.id != null) {
      context.go('/entries/${entry.id}');
    }
  }
}
