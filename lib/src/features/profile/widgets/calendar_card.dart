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

  /// The profile data to get registration date
  final MwProfile? profile;

  /// Callback when an entry is tapped
  final void Function(MwCalendarEntry entry)? onEntryTap;

  /// Callback when a day with multiple entries is tapped
  final void Function(List<MwCalendarEntry> entries, DateTime date)? onDayTap;

  const CalendarCard({
    super.key,
    this.calendarData,
    this.profile,
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
    // Always start with current month
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
        // Navigation buttons - positioned on the left
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Previous year button
            IconButton(
              onPressed: () => _navigateToPreviousYear(),
              icon: const Icon(Icons.keyboard_double_arrow_left),
              iconSize: 16,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
            
            // Previous month button
            IconButton(
              onPressed: () => _navigateToPreviousMonth(),
              icon: const Icon(Icons.keyboard_arrow_left),
              iconSize: 16,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          ],
        ),
        
        // Current month/year display - centered
        Expanded(
          child: Text(
            _getMonthYearText(l10n),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        // Next navigation buttons - positioned on the right
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Next month button
            IconButton(
              onPressed: () => _navigateToNextMonth(),
              icon: const Icon(Icons.keyboard_arrow_right),
              iconSize: 16,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
            
            // Next year button
            IconButton(
              onPressed: () => _navigateToNextYear(),
              icon: const Icon(Icons.keyboard_double_arrow_right),
              iconSize: 16,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          ],
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
      child: GestureDetector(
        onTap: hasEntries ? () => _handleDayTap(date, entries) : null,
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
    final currentYear = DateTime.now().year;
    
    // Only show year if it's not the current year
    if (_currentDate.year == currentYear) {
      return monthName;
    } else {
      return '$monthName ${_currentDate.year}';
    }
  }

  /// Handles day tap events
  void _handleDayTap(DateTime date, List<MwCalendarEntry> entries) {
    if (entries.isEmpty) return;
    
    if (entries.length == 1) {
      // Single entry - navigate to entry detail
      final entry = entries.first;
      if (widget.onEntryTap != null) {
        widget.onEntryTap!(entry);
      }
    } else {
      // Multiple entries - call onDayTap callback if provided, otherwise show popup
      if (widget.onDayTap != null) {
        widget.onDayTap!(entries, date);
      } else {
        _showEntriesPopup(context, entries, date);
      }
    }
  }

  /// Shows a popup with the list of entries for a specific day
  void _showEntriesPopup(BuildContext context, List<MwCalendarEntry> entries, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${date.day} ${_getMonthName(date.month, l10n)} ${date.year}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: 300,
          height: entries.length > 5 ? 300 : null,
          child: ListView.builder(
            shrinkWrap: entries.length <= 5,
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                title: Text(
                  entry.title ?? l10n.untitledEntry,
                  style: theme.textTheme.bodyMedium,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onEntryTap?.call(entry);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  /// Gets the profile registration date
  DateTime? _getRegistrationDate() {
    if (widget.profile?.createdAt != null) {
      return DateTime.fromMillisecondsSinceEpoch(
        (widget.profile!.createdAt! * 1000).toInt(),
      );
    }
    return null;
  }

  /// Checks if a date is before the registration date
  bool _isBeforeRegistration(DateTime date) {
    final registrationDate = _getRegistrationDate();
    if (registrationDate == null) return false;
    
    final registrationMonth = DateTime(registrationDate.year, registrationDate.month, 1);
    final targetMonth = DateTime(date.year, date.month, 1);
    
    return targetMonth.isBefore(registrationMonth);
  }

  /// Navigation methods
  void _navigateToPreviousMonth() {
    final newDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    if (!_isBeforeRegistration(newDate)) {
      setState(() {
        _currentDate = newDate;
      });
    }
  }

  void _navigateToNextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  void _navigateToPreviousYear() {
    final newDate = DateTime(_currentDate.year - 1, _currentDate.month, 1);
    if (!_isBeforeRegistration(newDate)) {
      setState(() {
        _currentDate = newDate;
      });
    } else {
      // If we can't go one year back, navigate to the registration date
      final registrationDate = _getRegistrationDate();
      if (registrationDate != null) {
        setState(() {
          _currentDate = DateTime(registrationDate.year, registrationDate.month, 1);
        });
      }
    }
  }

  void _navigateToNextYear() {
    setState(() {
      _currentDate = DateTime(_currentDate.year + 1, _currentDate.month, 1);
    });
  }
}
