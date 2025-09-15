import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';

/// A widget that displays a calendar view of the user's activity.
/// 
/// This widget shows a month-by-month calendar with navigation controls.
/// It displays entry titles on days with single entries, or entry counts
/// on days with multiple entries. Tapping on a day shows entry details.
class CalendarCard extends StatefulWidget {
  /// The calendar data containing entries
  final MwCalendar? calendarData;

  /// Callback when an entry is tapped
  final void Function(MwCalendarEntry entry)? onEntryTap;

  /// Callback when a day with multiple entries is tapped
  final void Function(List<MwCalendarEntry> entries, DateTime date)? onDayTap;

  const CalendarCard({
    super.key,
    this.calendarData,
    this.onEntryTap,
    this.onDayTap,
  });

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  late DateTime _currentDate;
  late Map<DateTime, List<MwCalendarEntry>> _entriesByDate;

  @override
  void initState() {
    super.initState();
    // Start with the first month that has entries, or current month if no entries
    _currentDate = _getInitialDate();
    _entriesByDate = _groupEntriesByDate();
  }

  @override
  void didUpdateWidget(CalendarCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.calendarData != widget.calendarData) {
      _entriesByDate = _groupEntriesByDate();
    }
  }

  /// Gets the initial date to display in the calendar
  DateTime _getInitialDate() {
    if (widget.calendarData?.entries?.isNotEmpty == true) {
      // Find the earliest entry date
      DateTime? earliestDate;
      for (final entry in widget.calendarData!.entries!) {
        if (entry.createdAt != null) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            (entry.createdAt! * 1000).toInt(),
          );
          if (earliestDate == null || date.isBefore(earliestDate)) {
            earliestDate = date;
          }
        }
      }
      if (earliestDate != null) {
        return DateTime(earliestDate.year, earliestDate.month, 1);
      }
    }
    
    // Fallback to current month
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  /// Groups calendar entries by date for easy lookup
  Map<DateTime, List<MwCalendarEntry>> _groupEntriesByDate() {
    final Map<DateTime, List<MwCalendarEntry>> grouped = {};
    
    if (widget.calendarData?.entries != null) {
      for (final entry in widget.calendarData!.entries!) {
        if (entry.createdAt != null) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            (entry.createdAt! * 1000).toInt(),
          );
          final dateKey = DateTime(date.year, date.month, date.day);
          
          grouped.putIfAbsent(dateKey, () => []).add(entry);
        }
      }
    }
    
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Don't show the card if there are no entries
    if (widget.calendarData?.entries?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with navigation
            _buildHeader(context, theme, l10n),
            const SizedBox(height: 16),
            
            // Calendar grid
            _buildCalendarGrid(context, theme),
          ],
        ),
      ),
    );
  }

  /// Builds the header with month/year and navigation buttons
  Widget _buildHeader(BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month_outlined,
          color: theme.colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            l10n.calendar,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        
        // Navigation buttons - use Wrap to handle overflow gracefully
        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // If space is very limited, show only month navigation
              if (constraints.maxWidth < 200) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Previous month button
                    IconButton(
                      onPressed: () => _navigateToPreviousMonth(),
                      icon: const Icon(Icons.keyboard_arrow_left),
                      iconSize: 14,
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                    ),
                    
                    // Current month/year display
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(
                          _getMonthYearText(l10n),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    
                    // Next month button
                    IconButton(
                      onPressed: () => _navigateToNextMonth(),
                      icon: const Icon(Icons.keyboard_arrow_right),
                      iconSize: 14,
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                    ),
                  ],
                );
              }
              
              // If space is limited, show month navigation only
              if (constraints.maxWidth < 280) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Previous month button
                    IconButton(
                      onPressed: () => _navigateToPreviousMonth(),
                      icon: const Icon(Icons.keyboard_arrow_left),
                      iconSize: 14,
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(
                        minWidth: 26,
                        minHeight: 26,
                      ),
                    ),
                    
                    // Current month/year display
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          _getMonthYearText(l10n),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    
                    // Next month button
                    IconButton(
                      onPressed: () => _navigateToNextMonth(),
                      icon: const Icon(Icons.keyboard_arrow_right),
                      iconSize: 14,
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(
                        minWidth: 26,
                        minHeight: 26,
                      ),
                    ),
                  ],
                );
              }
              
              // Full navigation for larger screens
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Previous year button
                  IconButton(
                    onPressed: () => _navigateToPreviousYear(),
                    icon: const Icon(Icons.keyboard_double_arrow_left),
                    iconSize: 14,
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                  ),
                  
                  // Previous month button
                  IconButton(
                    onPressed: () => _navigateToPreviousMonth(),
                    icon: const Icon(Icons.keyboard_arrow_left),
                    iconSize: 14,
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                  ),
                  
                  // Current month/year display
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        _getMonthYearText(l10n),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  
                  // Next month button
                  IconButton(
                    onPressed: () => _navigateToNextMonth(),
                    icon: const Icon(Icons.keyboard_arrow_right),
                    iconSize: 14,
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                  ),
                  
                  // Next year button
                  IconButton(
                    onPressed: () => _navigateToNextYear(),
                    icon: const Icon(Icons.keyboard_double_arrow_right),
                    iconSize: 14,
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the calendar grid
  Widget _buildCalendarGrid(BuildContext context, ThemeData theme) {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    // Calculate the number of weeks needed
    final totalCells = firstDayOfWeek - 1 + daysInMonth;
    final weeksNeeded = (totalCells / 7).ceil();

    return Column(
      children: [
        // Day headers (Mon, Tue, Wed, etc.)
        _buildDayHeaders(context, theme),
        const SizedBox(height: 8),
        
        // Calendar grid
        ...List.generate(weeksNeeded, (weekIndex) {
          return _buildWeekRow(context, theme, weekIndex, firstDayOfMonth, firstDayOfWeek, daysInMonth);
        }),
      ],
    );
  }

  /// Builds the day headers row
  Widget _buildDayHeaders(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    final dayNames = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];

    return Row(
      children: dayNames.map((dayName) {
        return Expanded(
          child: Center(
            child: Text(
              dayName.substring(0, 2), // Show first 2 characters
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds a week row in the calendar
  Widget _buildWeekRow(
    BuildContext context,
    ThemeData theme,
    int weekIndex,
    DateTime firstDayOfMonth,
    int firstDayOfWeek,
    int daysInMonth,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: List.generate(7, (dayIndex) {
          final cellIndex = weekIndex * 7 + dayIndex;
          final dayNumber = cellIndex - firstDayOfWeek + 2;
          
          if (dayNumber < 1 || dayNumber > daysInMonth) {
            // Empty cell for days outside the current month
            return const Expanded(child: SizedBox(height: 32));
          }
          
          final date = DateTime(_currentDate.year, _currentDate.month, dayNumber);
          final entries = _entriesByDate[date] ?? [];
          
          return Expanded(
            child: _buildDayCell(context, theme, date, entries),
          );
        }),
      ),
    );
  }

  /// Builds an individual day cell
  Widget _buildDayCell(
    BuildContext context,
    ThemeData theme,
    DateTime date,
    List<MwCalendarEntry> entries,
  ) {
    final isToday = _isToday(date);
    final hasEntries = entries.isNotEmpty;
    
    return Semantics(
      label: _getDaySemanticLabel(date, entries),
      button: true,
      child: InkWell(
        onTap: () => _handleDayTap(date, entries),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _getDayBackgroundColor(theme, isToday, hasEntries),
            border: isToday
                ? Border.all(
                    color: theme.colorScheme.primary,
                    width: 1,
                  )
                : null,
          ),
          child: Center(
            child: hasEntries
                ? _buildDayWithEntries(context, theme, date, entries)
                : Text(
                    date.day.toString(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _getDayTextColor(theme, isToday, hasEntries),
                      fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  /// Builds the content for a day that has entries
  Widget _buildDayWithEntries(
    BuildContext context,
    ThemeData theme,
    DateTime date,
    List<MwCalendarEntry> entries,
  ) {
    if (entries.length == 1) {
      // Single entry - show the beginning of the title
      final entry = entries.first;
      final title = entry.title ?? '';
      final displayTitle = title.length > 8 ? '${title.substring(0, 8)}...' : title;
      
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
          if (displayTitle.isNotEmpty)
            Text(
              displayTitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      );
    } else {
      // Multiple entries - show count
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
          Text(
            '+${entries.length}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontSize: 8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
  }

  /// Gets the background color for a day cell
  Color _getDayBackgroundColor(ThemeData theme, bool isToday, bool hasEntries) {
    if (hasEntries) {
      return theme.colorScheme.primary;
    } else if (isToday) {
      return theme.colorScheme.primaryContainer;
    } else {
      return Colors.transparent;
    }
  }

  /// Gets the text color for a day cell
  Color _getDayTextColor(ThemeData theme, bool isToday, bool hasEntries) {
    if (hasEntries) {
      return theme.colorScheme.onPrimary;
    } else if (isToday) {
      return theme.colorScheme.onPrimaryContainer;
    } else {
      return theme.colorScheme.onSurface;
    }
  }

  /// Checks if a date is today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  /// Gets the semantic label for a day
  String _getDaySemanticLabel(DateTime date, List<MwCalendarEntry> entries) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = '${date.day} ${_getMonthName(date.month, l10n)} ${date.year}';
    
    if (entries.isEmpty) {
      return '$dateStr, ${l10n.noEntries}';
    } else if (entries.length == 1) {
      return '$dateStr, ${l10n.oneEntry}: ${entries.first.title ?? l10n.untitledEntry}';
    } else {
      return '$dateStr, ${entries.length} ${l10n.entries}';
    }
  }

  /// Gets the month name in the current locale
  String _getMonthName(int month, AppLocalizations l10n) {
    switch (month) {
      case 1: return l10n.january;
      case 2: return l10n.february;
      case 3: return l10n.march;
      case 4: return l10n.april;
      case 5: return l10n.may;
      case 6: return l10n.june;
      case 7: return l10n.july;
      case 8: return l10n.august;
      case 9: return l10n.september;
      case 10: return l10n.october;
      case 11: return l10n.november;
      case 12: return l10n.december;
      default: return '';
    }
  }

  /// Gets the month/year text for the header
  String _getMonthYearText(AppLocalizations l10n) {
    final monthName = _getMonthName(_currentDate.month, l10n);
    return '$monthName ${_currentDate.year}';
  }

  /// Handles day tap events
  void _handleDayTap(DateTime date, List<MwCalendarEntry> entries) {
    if (entries.isEmpty) return;
    
    if (entries.length == 1) {
      // Single entry - navigate to entry detail
      widget.onEntryTap?.call(entries.first);
    } else {
      // Multiple entries - show popup with entry list
      widget.onDayTap?.call(entries, date);
    }
  }

  /// Navigation methods
  void _navigateToPreviousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }

  void _navigateToNextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  void _navigateToPreviousYear() {
    setState(() {
      _currentDate = DateTime(_currentDate.year - 1, _currentDate.month, 1);
    });
  }

  void _navigateToNextYear() {
    setState(() {
      _currentDate = DateTime(_currentDate.year + 1, _currentDate.month, 1);
    });
  }
}
