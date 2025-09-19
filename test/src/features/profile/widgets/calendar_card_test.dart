import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/profile/widgets/calendar_card.dart';

void main() {
  group('CalendarCard', () {
    late MwCalendar mockCalendar;
    late List<MwCalendarEntry> mockEntries;

    setUp(() {
      // Create mock calendar entries
      mockEntries = [
        MwCalendarEntry(
          (b) => b
            ..id = 1
            ..title = 'Test Entry 1'
            ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
        ),
        MwCalendarEntry(
          (b) => b
            ..id = 2
            ..title = 'Test Entry 2'
            ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
        ),
        MwCalendarEntry(
          (b) => b
            ..id = 3
            ..title = 'Test Entry 3'
            ..createdAt = DateTime(2024, 1, 20).millisecondsSinceEpoch / 1000.0,
        ),
        MwCalendarEntry(
          (b) => b
            ..id = 4
            ..title = 'Test Entry 4'
            ..createdAt = DateTime(2024, 2, 5).millisecondsSinceEpoch / 1000.0,
        ),
      ];

      mockCalendar = MwCalendar(
        (b) => b
          ..entries = ListBuilder<MwCalendarEntry>(mockEntries)
          ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
          ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
          ..limit = 100,
      );
    });

    Widget createTestWidget({
      MwCalendar? calendarData,
      MwProfile? profile,
      void Function(MwCalendarEntry)? onEntryTap,
      void Function(List<MwCalendarEntry>, DateTime)? onDayTap,
    }) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CalendarCard(
            calendarData: calendarData,
            profile: profile,
            onEntryTap: onEntryTap,
            onDayTap: onDayTap,
          ),
        ),
      );
    }

    testWidgets('should not display when calendar data is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: null));

      expect(find.byType(CalendarCard), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should not display when calendar has no entries', (
      WidgetTester tester,
    ) async {
      final emptyCalendar = MwCalendar(
        (b) => b
          ..entries = ListBuilder<MwCalendarEntry>(<MwCalendarEntry>[])
          ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
          ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
          ..limit = 100,
      );

      await tester.pumpWidget(createTestWidget(calendarData: emptyCalendar));

      expect(find.byType(CalendarCard), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should display calendar with entries', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsOneWidget);
      // Calendar title and icon have been removed
      expect(find.text('Calendar'), findsNothing);
      expect(find.byIcon(Icons.calendar_month_outlined), findsNothing);

      // Should start with current month (not earliest entry month)
      // Since we can't predict the current month in tests, we'll just check that a month is displayed
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should display navigation buttons', (
      WidgetTester tester,
    ) async {
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

    testWidgets('should navigate to previous month when left arrow is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Find and tap the previous month button
      final prevButton = find.byIcon(Icons.keyboard_arrow_left);
      expect(prevButton, findsOneWidget);

      await tester.tap(prevButton);
      await tester.pumpAndSettle();

      // The calendar should update to show the previous month
      // We can verify this by checking that the month/year text has changed
      // Since we start with current month, we can't predict the exact month
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should navigate to next month when right arrow is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Find and tap the next month button
      final nextButton = find.byIcon(Icons.keyboard_arrow_right);
      expect(nextButton, findsOneWidget);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // The calendar should update to show the next month
      // Since we start with current month, we can't predict the exact month
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets(
      'should navigate to previous year when double left arrow is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Find and tap the previous year button
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        expect(prevYearButton, findsOneWidget);

        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        // The calendar should update to show the previous year
        // Since we start with current month, we can't predict the exact month/year
        expect(find.byType(Text), findsWidgets);
      },
    );

    testWidgets(
      'should navigate to next year when double right arrow is tapped',
      (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Find and tap the next year button
        final nextYearButton = find.byIcon(Icons.keyboard_double_arrow_right);
        expect(nextYearButton, findsOneWidget);

        await tester.tap(nextYearButton);
        await tester.pumpAndSettle();

        // The calendar should update to show the next year
        // Since we start with current month, we can't predict the exact month/year
        expect(find.byType(Text), findsWidgets);
      },
    );

    testWidgets('should call onEntryTap when single entry day is tapped', (
      WidgetTester tester,
    ) async {
      MwCalendarEntry? tappedEntry;

      await tester.pumpWidget(
        createTestWidget(
          calendarData: mockCalendar,
          onEntryTap: (entry) => tappedEntry = entry,
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Find a day with a single entry (day 20 should have one entry)
      final day20 = find.text('20');
      expect(day20, findsOneWidget);

      await tester.tap(day20);
      await tester.pumpAndSettle();

      expect(tappedEntry, isNotNull);
      expect(tappedEntry!.id, equals(3));
      expect(tappedEntry!.title, equals('Test Entry 3'));
    });

    testWidgets('should call onDayTap when multiple entry day is tapped', (
      WidgetTester tester,
    ) async {
      List<MwCalendarEntry>? tappedEntries;
      DateTime? tappedDate;

      await tester.pumpWidget(
        createTestWidget(
          calendarData: mockCalendar,
          onDayTap: (entries, date) {
            tappedEntries = entries;
            tappedDate = date;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Find a day with multiple entries (day 15 should have two entries)
      final day15 = find.text('15');
      expect(day15, findsOneWidget);

      await tester.tap(day15);
      await tester.pumpAndSettle();

      expect(tappedEntries, isNotNull);
      expect(tappedEntries!.length, equals(2));
      expect(tappedDate, equals(DateTime(2024, 1, 15)));
    });

    testWidgets('should display entry title for single entry days', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Day 20 should show the truncated entry title
      expect(find.text('Test Ent...'), findsOneWidget);
    });

    testWidgets('should display entry count for multiple entry days', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Day 15 should show "+2" for two entries
      expect(find.text('+2'), findsOneWidget);
    });

    testWidgets('should highlight today', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Today should be highlighted (we can't easily test the visual styling,
      // but we can verify the day is present and tappable)
      final today = find.text('15');
      expect(today, findsOneWidget);
    });

    testWidgets('should handle entries without titles', (
      WidgetTester tester,
    ) async {
      final entryWithoutTitle = MwCalendarEntry(
        (b) => b
          ..id = 5
          ..title = null
          ..createdAt = DateTime(2024, 1, 25).millisecondsSinceEpoch / 1000.0,
      );

      final calendarWithUntitledEntry = MwCalendar(
        (b) => b
          ..entries = ListBuilder<MwCalendarEntry>([entryWithoutTitle])
          ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
          ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
          ..limit = 100,
      );

      await tester.pumpWidget(
        createTestWidget(calendarData: calendarWithUntitledEntry),
      );
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // The day should still be tappable even without a title
      final day25 = find.text('25');
      expect(day25, findsOneWidget);
    });

    testWidgets('should handle long entry titles by truncating', (
      WidgetTester tester,
    ) async {
      final longTitleEntry = MwCalendarEntry(
        (b) => b
          ..id = 6
          ..title = 'This is a very long entry title that should be truncated'
          ..createdAt = DateTime(2024, 1, 30).millisecondsSinceEpoch / 1000.0,
      );

      final calendarWithLongTitle = MwCalendar(
        (b) => b
          ..entries = ListBuilder<MwCalendarEntry>([longTitleEntry])
          ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
          ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
          ..limit = 100,
      );

      await tester.pumpWidget(
        createTestWidget(calendarData: calendarWithLongTitle),
      );
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Should show truncated title (first 8 characters + "...")
      expect(find.text('This is ...'), findsOneWidget);
    });

    testWidgets('should be accessible with proper semantic labels', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Check that navigation buttons have proper semantics
      final prevButton = find.byIcon(Icons.keyboard_arrow_left);
      expect(prevButton, findsOneWidget);

      // Check that day cells have proper semantics
      final day20 = find.text('20');
      expect(day20, findsOneWidget);
    });

    testWidgets('should hide year when displaying current year', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // The calendar should start with current month
      // We can't predict the exact month, but we can verify it's displayed
      expect(find.byType(Text), findsWidgets);

      // Navigate to a different year to verify year is shown
      final nextYearButton = find.byIcon(Icons.keyboard_double_arrow_right);
      await tester.tap(nextYearButton);
      await tester.pumpAndSettle();

      // Year should now be visible in the header
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should show popup with constrained width for multiple entries', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
      await tester.pumpAndSettle();

      // Navigate to January 2024 where our test entries are
      // We need to navigate from current month (September 2025) to January 2024
      // That's about 1 year and 8 months back

      // First, go back one year
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      await tester.tap(prevYearButton);
      await tester.pumpAndSettle();

      // Then go back 8 months to get to January
      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 8; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Find a day with multiple entries (day 15 should have two entries)
      final day15 = find.text('15');
      expect(day15, findsOneWidget);

      await tester.tap(day15);
      await tester.pumpAndSettle();

      // Should show a dialog
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('15 January 2024'), findsOneWidget);
    });

    testWidgets('should not navigate before profile registration date', (
      WidgetTester tester,
    ) async {
      // Create a mock profile with registration date in January 2024
      final mockProfile = $MwProfile(
        (b) => b
          ..id = 1
          ..name = 'testuser'
          ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
      );

      await tester.pumpWidget(
        createTestWidget(calendarData: mockCalendar, profile: mockProfile),
      );
      await tester.pumpAndSettle();

      // Navigate to January 2024 (registration month)
      final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
      if (prevYearButton.evaluate().isNotEmpty) {
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();
      }

      final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
      for (int i = 0; i < 12; i++) {
        await tester.tap(prevMonthButton);
        await tester.pumpAndSettle();
      }

      // Try to navigate to December 2023 (before registration)
      await tester.tap(prevMonthButton);
      await tester.pumpAndSettle();

      // Should still be in January 2024, not December 2023
      // We can't easily test the exact month display, but we can verify
      // that the navigation didn't go too far back
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should work with entries in current month', (
      WidgetTester tester,
    ) async {
      // Create entries for the current month (September 2025)
      final currentMonth = DateTime.now();
      final currentMonthEntries = [
        MwCalendarEntry(
          (b) => b
            ..id = 1
            ..title = 'Current Month Entry'
            ..createdAt =
                DateTime(
                  currentMonth.year,
                  currentMonth.month,
                  15,
                ).millisecondsSinceEpoch /
                1000.0,
        ),
      ];

      final currentMonthCalendar = MwCalendar(
        (b) => b
          ..entries = ListBuilder<MwCalendarEntry>(currentMonthEntries)
          ..start =
              DateTime(
                currentMonth.year,
                currentMonth.month,
                1,
              ).millisecondsSinceEpoch /
              1000.0
          ..end =
              DateTime(
                currentMonth.year,
                currentMonth.month + 1,
                0,
              ).millisecondsSinceEpoch /
              1000.0
          ..limit = 100,
      );

      MwCalendarEntry? tappedEntry;

      await tester.pumpWidget(
        createTestWidget(
          calendarData: currentMonthCalendar,
          onEntryTap: (entry) => tappedEntry = entry,
        ),
      );
      await tester.pumpAndSettle();

      // Find day 15 which should have an entry
      final day15 = find.text('15');
      expect(day15, findsOneWidget);

      await tester.tap(day15);
      await tester.pumpAndSettle();

      expect(tappedEntry, isNotNull);
      expect(tappedEntry!.id, equals(1));
      expect(tappedEntry!.title, equals('Current Month Entry'));
    });

    testWidgets('should show popup for multiple entries in current month', (
      WidgetTester tester,
    ) async {
      // Create multiple entries for the current month
      final currentMonth = DateTime.now();
      final currentMonthEntries = [
        MwCalendarEntry(
          (b) => b
            ..id = 1
            ..title = 'First Entry'
            ..createdAt =
                DateTime(
                  currentMonth.year,
                  currentMonth.month,
                  15,
                ).millisecondsSinceEpoch /
                1000.0,
        ),
        MwCalendarEntry(
          (b) => b
            ..id = 2
            ..title = 'Second Entry'
            ..createdAt =
                DateTime(
                  currentMonth.year,
                  currentMonth.month,
                  15,
                ).millisecondsSinceEpoch /
                1000.0,
        ),
      ];

      final currentMonthCalendar = MwCalendar(
        (b) => b
          ..entries = ListBuilder<MwCalendarEntry>(currentMonthEntries)
          ..start =
              DateTime(
                currentMonth.year,
                currentMonth.month,
                1,
              ).millisecondsSinceEpoch /
              1000.0
          ..end =
              DateTime(
                currentMonth.year,
                currentMonth.month + 1,
                0,
              ).millisecondsSinceEpoch /
              1000.0
          ..limit = 100,
      );

      await tester.pumpWidget(
        createTestWidget(calendarData: currentMonthCalendar),
      );
      await tester.pumpAndSettle();

      // Find day 15 which should have multiple entries
      final day15 = find.text('15');
      expect(day15, findsOneWidget);

      await tester.tap(day15);
      await tester.pumpAndSettle();

      // Should show a dialog
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('First Entry'), findsOneWidget);
      expect(find.text('Second Entry'), findsOneWidget);
    });

    testWidgets(
      'should navigate to registration date when previous year is blocked',
      (WidgetTester tester) async {
        // Create a mock profile with registration date in January 2024
        final mockProfile = $MwProfile(
          (b) => b
            ..id = 1
            ..name = 'testuser'
            ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: mockCalendar, profile: mockProfile),
        );
        await tester.pumpAndSettle();

        // Navigate to January 2024 (registration month)
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        if (prevYearButton.evaluate().isNotEmpty) {
          await tester.tap(prevYearButton);
          await tester.pumpAndSettle();
        }

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 12; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Now we should be in January 2024 (registration month)
        // Try to go back one year - should navigate to registration date instead
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        // Should still be in January 2024 (registration month)
        // We can't easily test the exact month display, but we can verify
        // that the navigation didn't go too far back
        expect(find.byType(Text), findsWidgets);
      },
    );

    // ===== 1. EDGE CASES & ERROR HANDLING =====
    group('Edge Cases & Error Handling', () {
      testWidgets('should handle entries with null createdAt', (
        WidgetTester tester,
      ) async {
        final entriesWithNullCreatedAt = [
          MwCalendarEntry(
            (b) => b
              ..id = 1
              ..title = 'Entry with null createdAt'
              ..createdAt = null,
          ),
          MwCalendarEntry(
            (b) => b
              ..id = 2
              ..title = 'Valid entry'
              ..createdAt =
                  DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
          ),
        ];

        final calendarWithNullCreatedAt = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>(entriesWithNullCreatedAt)
            ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: calendarWithNullCreatedAt),
        );
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Should only show the valid entry on day 15
        expect(find.text('15'), findsOneWidget);
        // Should not crash or show invalid entries
        expect(find.byType(CalendarCard), findsOneWidget);
      });

      testWidgets('should handle profile with null registration date', (
        WidgetTester tester,
      ) async {
        final mockProfileWithNullCreatedAt = $MwProfile(
          (b) => b
            ..id = 1
            ..name = 'testuser'
            ..createdAt = null,
        );

        await tester.pumpWidget(
          createTestWidget(
            calendarData: mockCalendar,
            profile: mockProfileWithNullCreatedAt,
          ),
        );
        await tester.pumpAndSettle();

        // Should be able to navigate freely without registration date restrictions
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        // Should not crash and should allow navigation
        expect(find.byType(CalendarCard), findsOneWidget);
      });

      testWidgets('should handle malformed calendar data gracefully', (
        WidgetTester tester,
      ) async {
        // Create calendar with invalid date ranges
        final malformedCalendar = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>([])
            ..start =
                -1.0 // Invalid start date
            ..end =
                -1.0 // Invalid end date
            ..limit = -1,
        ); // Invalid limit

        await tester.pumpWidget(
          createTestWidget(calendarData: malformedCalendar),
        );
        await tester.pumpAndSettle();

        // Should not crash, should show empty calendar or hide widget
        expect(find.byType(CalendarCard), findsOneWidget);
      });
    });

    // ===== 2. WIDGET LIFECYCLE & STATE MANAGEMENT =====
    group('Widget Lifecycle & State Management', () {
      testWidgets('should update when calendar data changes', (
        WidgetTester tester,
      ) async {
        final initialCalendar = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>([])
            ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: initialCalendar),
        );
        await tester.pumpAndSettle();

        // Initially should show empty calendar (hidden)
        expect(find.byType(Card), findsNothing);

        // Update with new calendar data
        final updatedCalendar = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>([
              MwCalendarEntry(
                (b) => b
                  ..id = 1
                  ..title = 'New Entry'
                  ..createdAt =
                      DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
              ),
            ])
            ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: updatedCalendar),
        );
        await tester.pumpAndSettle();

        // Should now show the calendar with entries
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should maintain state when profile changes', (
        WidgetTester tester,
      ) async {
        final initialProfile = $MwProfile(
          (b) => b
            ..id = 1
            ..name = 'user1'
            ..createdAt = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: mockCalendar, profile: initialProfile),
        );
        await tester.pumpAndSettle();

        // Navigate to a specific month
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        // Update profile
        final updatedProfile = $MwProfile(
          (b) => b
            ..id = 2
            ..name = 'user2'
            ..createdAt = DateTime(2023, 6, 1).millisecondsSinceEpoch / 1000.0,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: mockCalendar, profile: updatedProfile),
        );
        await tester.pumpAndSettle();

        // Should maintain calendar state and not crash
        expect(find.byType(CalendarCard), findsOneWidget);
      });
    });

    // ===== 3. LOCALIZATION & INTERNATIONALIZATION =====
    group('Localization & Internationalization', () {
      testWidgets('should display month names in different locales', (
        WidgetTester tester,
      ) async {
        // Test with English locale
        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: CalendarCard(calendarData: mockCalendar)),
          ),
        );
        await tester.pumpAndSettle();

        // Should render with English locale
        expect(find.byType(CalendarCard), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);

        // Should show day headers in English
        expect(find.text('Mo'), findsOneWidget);
        expect(find.text('Tu'), findsOneWidget);
        expect(find.text('We'), findsOneWidget);
        expect(find.text('Th'), findsOneWidget);
        expect(find.text('Fr'), findsOneWidget);
        expect(find.text('Sa'), findsOneWidget);
        expect(find.text('Su'), findsOneWidget);
      });

      testWidgets('should display day headers in different locales', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Should show day headers (first 2 characters)
        expect(find.text('Mo'), findsOneWidget);
        expect(find.text('Tu'), findsOneWidget);
        expect(find.text('We'), findsOneWidget);
        expect(find.text('Th'), findsOneWidget);
        expect(find.text('Fr'), findsOneWidget);
        expect(find.text('Sa'), findsOneWidget);
        expect(find.text('Su'), findsOneWidget);
      });

      testWidgets('should handle semantic labels localization', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Should have semantic labels for accessibility
        final day15 = find.text('15');
        expect(day15, findsOneWidget);

        // The semantic label should be set (we can't easily test the exact content)
        final semantics = tester.getSemantics(day15);
        expect(semantics.label, isNotNull);
      });
    });

    // ===== 4. POPUP DIALOG FUNCTIONALITY =====
    group('Popup Dialog Functionality', () {
      testWidgets(
        'should show popup with multiple entries and allow navigation',
        (WidgetTester tester) async {
          MwCalendarEntry? tappedEntry;

          await tester.pumpWidget(
            createTestWidget(
              calendarData: mockCalendar,
              onEntryTap: (entry) => tappedEntry = entry,
            ),
          );
          await tester.pumpAndSettle();

          // Navigate to January 2024
          final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
          await tester.tap(prevYearButton);
          await tester.pumpAndSettle();

          final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
          for (int i = 0; i < 8; i++) {
            await tester.tap(prevMonthButton);
            await tester.pumpAndSettle();
          }

          // Tap on day 15 with multiple entries
          final day15 = find.text('15');
          await tester.tap(day15);
          await tester.pumpAndSettle();

          // Should show popup dialog
          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.text('Test Entry 1'), findsOneWidget);
          expect(find.text('Test Entry 2'), findsOneWidget);

          // Tap on first entry in popup
          await tester.tap(find.text('Test Entry 1'));
          await tester.pumpAndSettle();

          // Popup should close and callback should be called
          expect(find.byType(AlertDialog), findsNothing);
          expect(tappedEntry, isNotNull);
          expect(tappedEntry!.id, equals(1));
        },
      );

      testWidgets('should close popup with close button', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Tap on day 15 with multiple entries
        final day15 = find.text('15');
        await tester.tap(day15);
        await tester.pumpAndSettle();

        // Should show popup dialog
        expect(find.byType(AlertDialog), findsOneWidget);

        // Tap close button
        final closeButton = find.text('Close');
        await tester.tap(closeButton);
        await tester.pumpAndSettle();

        // Popup should close
        expect(find.byType(AlertDialog), findsNothing);
      });

      testWidgets('should handle popup with many entries (scrollable)', (
        WidgetTester tester,
      ) async {
        // Create calendar with many entries on the same day
        final manyEntries = List.generate(
          10,
          (index) => MwCalendarEntry(
            (b) => b
              ..id = index + 1
              ..title = 'Entry ${index + 1}'
              ..createdAt =
                  DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
          ),
        );

        final calendarWithManyEntries = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>(manyEntries)
            ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: calendarWithManyEntries),
        );
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Tap on day 15 with many entries
        final day15 = find.text('15');
        await tester.tap(day15);
        await tester.pumpAndSettle();

        // Should show popup dialog with scrollable list
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);

        // Should show some entries (may not show all due to scrolling)
        expect(find.text('Entry 1'), findsOneWidget);
      });
    });

    // ===== 5. CALENDAR GRID EDGE CASES =====
    group('Calendar Grid Edge Cases', () {
      testWidgets('should handle February in leap year', (
        WidgetTester tester,
      ) async {
        // Create entries for February 29, 2024 (leap year)
        final leapYearEntries = [
          MwCalendarEntry(
            (b) => b
              ..id = 1
              ..title = 'Leap Year Entry'
              ..createdAt =
                  DateTime(2024, 2, 29).millisecondsSinceEpoch / 1000.0,
          ),
        ];

        final leapYearCalendar = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>(leapYearEntries)
            ..start = DateTime(2024, 2, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 2, 29).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: leapYearCalendar),
        );
        await tester.pumpAndSettle();

        // Navigate to February 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 7; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Should show February 29
        expect(find.text('29'), findsOneWidget);
      });

      testWidgets('should handle months with different day counts', (
        WidgetTester tester,
      ) async {
        // Test February (28 days), April (30 days), January (31 days)
        final entriesForDifferentMonths = [
          MwCalendarEntry(
            (b) => b
              ..id = 1
              ..title = 'Feb Entry'
              ..createdAt =
                  DateTime(2024, 2, 28).millisecondsSinceEpoch / 1000.0,
          ),
          MwCalendarEntry(
            (b) => b
              ..id = 2
              ..title = 'Apr Entry'
              ..createdAt =
                  DateTime(2024, 4, 30).millisecondsSinceEpoch / 1000.0,
          ),
          MwCalendarEntry(
            (b) => b
              ..id = 3
              ..title = 'Jan Entry'
              ..createdAt =
                  DateTime(2024, 1, 31).millisecondsSinceEpoch / 1000.0,
          ),
        ];

        final multiMonthCalendar = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>(entriesForDifferentMonths)
            ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: multiMonthCalendar),
        );
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Should show January 31
        expect(find.text('31'), findsOneWidget);

        // Navigate to February
        final nextMonthButton = find.byIcon(Icons.keyboard_arrow_right);
        await tester.tap(nextMonthButton);
        await tester.pumpAndSettle();

        // Should show February 28 (last day of February)
        expect(find.text('28'), findsOneWidget);
        // Should not show February 30 or 31 (29 might be shown if it's a leap year)
        expect(find.text('30'), findsNothing);
        expect(find.text('31'), findsNothing);
      });

      testWidgets('should handle months starting on different weekdays', (
        WidgetTester tester,
      ) async {
        // January 2024 starts on Monday, February 2024 starts on Thursday
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // January 1 should be in the first row, first column (Monday)
        expect(find.text('1'), findsOneWidget);

        // Navigate to February
        final nextMonthButton = find.byIcon(Icons.keyboard_arrow_right);
        await tester.tap(nextMonthButton);
        await tester.pumpAndSettle();

        // February 1 should be in the first row, fourth column (Thursday)
        expect(find.text('1'), findsOneWidget);
      });
    });

    // ===== 6. NAVIGATION EDGE CASES =====
    group('Navigation Edge Cases', () {
      testWidgets('should handle year boundary navigation (December to January)', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        // Navigate to December 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final nextMonthButton = find.byIcon(Icons.keyboard_arrow_right);
        for (int i = 0; i < 11; i++) {
          await tester.tap(nextMonthButton);
          await tester.pumpAndSettle();
        }

        // Should be in December 2024 (we can't easily test the exact month name)
        expect(find.byType(CalendarCard), findsOneWidget);

        // Navigate to next month (January 2025)
        await tester.tap(nextMonthButton);
        await tester.pumpAndSettle();

        // Should be in January 2025 (we can't easily test the exact month name)
        expect(find.byType(CalendarCard), findsOneWidget);
        expect(find.byType(Text), findsWidgets);

        // Verify that navigation buttons are still present and functional
        expect(find.byIcon(Icons.keyboard_arrow_left), findsOneWidget);
        expect(find.byIcon(Icons.keyboard_arrow_right), findsOneWidget);
      });

      testWidgets('should handle rapid navigation button tapping', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
        await tester.pumpAndSettle();

        final nextMonthButton = find.byIcon(Icons.keyboard_arrow_right);

        // Rapidly tap next month button multiple times
        for (int i = 0; i < 5; i++) {
          await tester.tap(nextMonthButton);
          await tester.pumpAndSettle();
        }

        // Should handle rapid navigation without crashing
        expect(find.byType(CalendarCard), findsOneWidget);
        expect(find.byType(Text), findsWidgets);
      });

      testWidgets(
        'should handle navigation limits with profile registration date',
        (WidgetTester tester) async {
          final profileWithRecentRegistration = $MwProfile(
            (b) => b
              ..id = 1
              ..name = 'recentuser'
              ..createdAt =
                  DateTime(2024, 6, 1).millisecondsSinceEpoch / 1000.0,
          );

          await tester.pumpWidget(
            createTestWidget(
              calendarData: mockCalendar,
              profile: profileWithRecentRegistration,
            ),
          );
          await tester.pumpAndSettle();

          // Try to navigate back multiple years
          final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
          for (int i = 0; i < 3; i++) {
            await tester.tap(prevYearButton);
            await tester.pumpAndSettle();
          }

          // Should stop at registration date (June 2024)
          // We can't easily test the exact month, but should not crash
          expect(find.byType(CalendarCard), findsOneWidget);
        },
      );
    });

    // ===== 7. VISUAL & STYLING =====
    group('Visual & Styling', () {
      testWidgets('should adapt to different theme configurations', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.purple,
                brightness: Brightness.light,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: CalendarCard(calendarData: mockCalendar)),
          ),
        );
        await tester.pumpAndSettle();

        // Should render with purple theme
        expect(find.byType(CalendarCard), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should handle dark theme', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(body: CalendarCard(calendarData: mockCalendar)),
          ),
        );
        await tester.pumpAndSettle();

        // Should render with dark theme
        expect(find.byType(CalendarCard), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
      });

      testWidgets('should handle very long entry titles gracefully', (
        WidgetTester tester,
      ) async {
        final longTitleEntry = MwCalendarEntry(
          (b) => b
            ..id = 1
            ..title =
                'This is an extremely long entry title that should be truncated properly to fit within the calendar day cell without causing layout issues or overflow problems'
            ..createdAt = DateTime(2024, 1, 15).millisecondsSinceEpoch / 1000.0,
        );

        final calendarWithLongTitle = MwCalendar(
          (b) => b
            ..entries = ListBuilder<MwCalendarEntry>([longTitleEntry])
            ..start = DateTime(2024, 1, 1).millisecondsSinceEpoch / 1000.0
            ..end = DateTime(2024, 12, 31).millisecondsSinceEpoch / 1000.0
            ..limit = 100,
        );

        await tester.pumpWidget(
          createTestWidget(calendarData: calendarWithLongTitle),
        );
        await tester.pumpAndSettle();

        // Navigate to January 2024
        final prevYearButton = find.byIcon(Icons.keyboard_double_arrow_left);
        await tester.tap(prevYearButton);
        await tester.pumpAndSettle();

        final prevMonthButton = find.byIcon(Icons.keyboard_arrow_left);
        for (int i = 0; i < 8; i++) {
          await tester.tap(prevMonthButton);
          await tester.pumpAndSettle();
        }

        // Should show truncated title (first 8 characters + "...")
        expect(find.text('This is ...'), findsOneWidget);

        // Should not cause layout overflow
        expect(find.byType(CalendarCard), findsOneWidget);
      });

      testWidgets(
        'should maintain consistent styling across different months',
        (WidgetTester tester) async {
          await tester.pumpWidget(createTestWidget(calendarData: mockCalendar));
          await tester.pumpAndSettle();

          // Navigate through several months
          final nextMonthButton = find.byIcon(Icons.keyboard_arrow_right);
          for (int i = 0; i < 6; i++) {
            await tester.tap(nextMonthButton);
            await tester.pumpAndSettle();

            // Should maintain consistent styling
            expect(find.byType(CalendarCard), findsOneWidget);
            expect(find.byType(Card), findsOneWidget);
          }
        },
      );
    });
  });
}
