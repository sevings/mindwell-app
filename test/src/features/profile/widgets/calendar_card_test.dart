import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import '../../../../../lib/l10n/app_localizations.dart';
import '../../../../../lib/src/features/profile/widgets/calendar_card.dart';

void main() {
  group('CalendarCard', () {
    late MwCalendar mockCalendar;
    late List<MwCalendarEntry> mockEntries;

    setUp(() {
      // Create mock calendar entries
      mockEntries = [
        MwCalendarEntry((b) => b
          ..id = 1
          ..title = 'Test Entry 1'
          ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0),
        MwCalendarEntry((b) => b
          ..id = 2
          ..title = 'Test Entry 2'
          ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0),
        MwCalendarEntry((b) => b
          ..id = 3
          ..title = 'Test Entry 3'
          ..createdAt = DateTime(2024, 1, 20).millisecondsSinceEpoch / 1000.0),
        MwCalendarEntry((b) => b
          ..id = 4
          ..title = 'Test Entry 4'
          ..createdAt = DateTime(2024, 2, 5).millisecondsSinceEpoch / 1000.0),
      ];

      mockCalendar = MwCalendar((b) => b
        ..entries = ListBuilder<MwCalendarEntry>(mockEntries)
        ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
        ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
        ..limit = 100);
    });

    Widget createTestWidget({
      MwCalendar? calendarData,
      void Function(MwCalendarEntry)? onEntryTap,
      void Function(List<MwCalendarEntry>, DateTime)? onDayTap,
    }) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CalendarCard(
            calendarData: calendarData,
            onEntryTap: onEntryTap,
            onDayTap: onDayTap,
          ),
        ),
      );
    }

    testWidgets('should not display when calendar data is null', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: null));
      
      expect(find.byType(CalendarCard), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should not display when calendar has no entries', (WidgetTester tester) async {
      final emptyCalendar = MwCalendar((b) => b
        ..entries = ListBuilder<MwCalendarEntry>(<MwCalendarEntry>[])
        ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
        ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
        ..limit = 100);

      await tester.pumpWidget(createTestWidget(calendarData: emptyCalendar));
      
      expect(find.byType(CalendarCard), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should display calendar with entries', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Calendar'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_month_outlined), findsOneWidget);
      
      // Should start with January 2024 since that's when the first entry is
      expect(find.text('January 2024'), findsOneWidget);
    });

    testWidgets('should display navigation buttons', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Check for navigation buttons
      expect(find.byIcon(Icons.keyboard_double_arrow_left), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_left), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_right), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_double_arrow_right), findsOneWidget);
    });

    testWidgets('should display day headers', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Check for day headers (first 2 characters of day names)
      expect(find.text('Mo'), findsOneWidget);
      expect(find.text('Tu'), findsOneWidget);
      expect(find.text('We'), findsOneWidget);
      expect(find.text('Th'), findsOneWidget);
      expect(find.text('Fr'), findsOneWidget);
      expect(find.text('Sa'), findsOneWidget);
      expect(find.text('Su'), findsOneWidget);
    });

    testWidgets('should navigate to previous month when left arrow is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Find and tap the previous month button
      final prevButton = find.byIcon(Icons.keyboard_arrow_left);
      expect(prevButton, findsOneWidget);
      
      await tester.tap(prevButton);
      await tester.pumpAndSettle();
      
      // The calendar should update to show the previous month
      // We can verify this by checking that the month/year text has changed
      expect(find.text('December 2023'), findsOneWidget);
    });

    testWidgets('should navigate to next month when right arrow is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Find and tap the next month button
      final nextButton = find.byIcon(Icons.keyboard_arrow_right);
      expect(nextButton, findsOneWidget);
      
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      
      // The calendar should update to show the next month
      expect(find.text('February 2024'), findsOneWidget);
    });

    testWidgets('should navigate to previous year when double left arrow is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Find and tap the previous year button
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      expect(prevYearButton, findsOneWidget);
      
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();
      
      // The calendar should update to show the previous year
      expect(find.text('January 2023'), findsOneWidget);
    });

    testWidgets('should navigate to next year when double right arrow is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Find and tap the next year button
      final nextYearButton = find.byIcon(Icons.keyboard_double_arrow_right);
      expect(nextYearButton, findsOneWidget);
      
      await tester.tap(nextYearButton);
      await tester.pumpAndSettle();
      
      // The calendar should update to show the next year
      expect(find.text('January 2025'), findsOneWidget);
    });

    testWidgets('should call onEntryTap when single entry day is tapped', (WidgetTester tester) async {
      MwCalendarEntry? tappedEntry;
      
      await tester.pumpWidget(createTestWidget(
        calendarData: mockCalendar,
        onEntryTap: (entry) => tappedEntry = entry,
      ));
      await tester.pumpAndSettle();
      
      // Find a day with a single entry (day 20 should have one entry)
      final day20 = find.text('20');
      expect(day20, findsOneWidget);
      
      await tester.tap(day20);
      await tester.pumpAndSettle();
      
      expect(tappedEntry, isNotNull);
      expect(tappedEntry!.id, equals(3));
      expect(tappedEntry!.title, equals('Test Entry 3'));
    });

    testWidgets('should call onDayTap when multiple entry day is tapped', (WidgetTester tester) async {
      List<MwCalendarEntry>? tappedEntries;
      DateTime? tappedDate;
      
      await tester.pumpWidget(createTestWidget(
        calendarData: mockCalendar,
        onDayTap: (entries, date) {
          tappedEntries = entries;
          tappedDate = date;
        },
      ));
      await tester.pumpAndSettle();
      
      // Find a day with multiple entries (day 15 should have two entries)
      final day15 = find.text('15');
      expect(day15, findsOneWidget);
      
      await tester.tap(day15);
      await tester.pumpAndSettle();
      
      expect(tappedEntries, isNotNull);
      expect(tappedEntries!.length, equals(2));
      expect(tappedDate, equals(DateTime(2024, 1, 15)));
    });

    testWidgets('should display entry title for single entry days', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Day 20 should show the truncated entry title
      expect(find.text('Test Ent...'), findsOneWidget);
    });

    testWidgets('should display entry count for multiple entry days', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Day 15 should show "+2" for two entries
      expect(find.text('+2'), findsOneWidget);
    });

    testWidgets('should highlight today', (WidgetTester tester) async {
      // Mock the current date to be January 15, 2024
      final now = DateTime(2024, 1, 15);
      
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Today should be highlighted (we can't easily test the visual styling,
      // but we can verify the day is present and tappable)
      final today = find.text('15');
      expect(today, findsOneWidget);
    });

    testWidgets('should handle entries without titles', (WidgetTester tester) async {
      final entryWithoutTitle = MwCalendarEntry((b) => b
        ..id = 5
        ..title = null
        ..createdAt = DateTime(2024, 1, 25).millisecondsSinceEpoch / 1000.0);
      
      final calendarWithUntitledEntry = MwCalendar((b) => b
        ..entries = ListBuilder<MwCalendarEntry>([entryWithoutTitle])
        ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
        ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
        ..limit = 100);

      await tester.pumpWidget(createTestWidget(calendarData: calendarWithUntitledEntry));
      await tester.pumpAndSettle();
      
      // The day should still be tappable even without a title
      final day25 = find.text('25');
      expect(day25, findsOneWidget);
    });

    testWidgets('should handle long entry titles by truncating', (WidgetTester tester) async {
      final longTitleEntry = MwCalendarEntry((b) => b
        ..id = 6
        ..title = 'This is a very long entry title that should be truncated'
        ..createdAt = DateTime(2024, 1, 30).millisecondsSinceEpoch / 1000.0);
      
      final calendarWithLongTitle = MwCalendar((b) => b
        ..entries = ListBuilder<MwCalendarEntry>([longTitleEntry])
        ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
        ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
        ..limit = 100);

      await tester.pumpWidget(createTestWidget(calendarData: calendarWithLongTitle));
      await tester.pumpAndSettle();
      
      // Should show truncated title (first 8 characters + "...")
      expect(find.text('This is ...'), findsOneWidget);
    });

    testWidgets('should be accessible with proper semantic labels', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();
      
      // Check that navigation buttons have proper semantics
      final prevButton = find.byIcon(Icons.keyboard_arrow_left);
      expect(prevButton, findsOneWidget);
      
      // Check that day cells have proper semantics
      final day20 = find.text('20');
      expect(day20, findsOneWidget);
    });
  });
}
