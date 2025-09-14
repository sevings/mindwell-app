import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/widgets/adjacent_entry_navigation.dart';

void main() {
  group('AdjacentEntryNavigation', () {
    testWidgets('should not display when adjacentEntries is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: null,
            ),
          ),
        ),
      );

      expect(find.byType(AdjacentEntryNavigation), findsOneWidget);
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('should not display when both older and newer are null', (tester) async {
      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = null
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
            ),
          ),
        ),
      );

      expect(find.byType(AdjacentEntryNavigation), findsOneWidget);
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('should display only previous entry when older is provided', (tester) async {
      final olderEntry = MwCalendarEntry((b) => b
        ..id = 1
        ..title = 'Previous Entry Title'
        ..createdAt = 1640995200.0); // Jan 1, 2022

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = olderEntry.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Previous Entry'), findsOneWidget);
      expect(find.text('Previous Entry Title'), findsOneWidget);
      expect(find.text('Next Entry'), findsNothing);
      expect(find.byIcon(Icons.arrow_back_ios), findsNWidgets(2)); // One at start, one at end
    });

    testWidgets('should display only next entry when newer is provided', (tester) async {
      final newerEntry = MwCalendarEntry((b) => b
        ..id = 2
        ..title = 'Next Entry Title'
        ..createdAt = 1640995200.0); // Jan 1, 2022

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = null
        ..newer = newerEntry.toBuilder());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onNextTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Next Entry'), findsOneWidget);
      expect(find.text('Next Entry Title'), findsOneWidget);
      expect(find.text('Previous Entry'), findsNothing);
      expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(2)); // One at start, one at end
    });

    testWidgets('should display both entries when both are provided', (tester) async {
      final olderEntry = MwCalendarEntry((b) => b
        ..id = 1
        ..title = 'Previous Entry Title'
        ..createdAt = 1640995200.0); // Jan 1, 2022

      final newerEntry = MwCalendarEntry((b) => b
        ..id = 2
        ..title = 'Next Entry Title'
        ..createdAt = 1640995200.0); // Jan 1, 2022

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = olderEntry.toBuilder()
        ..newer = newerEntry.toBuilder());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
              onNextTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Previous Entry'), findsOneWidget);
      expect(find.text('Previous Entry Title'), findsOneWidget);
      expect(find.text('Next Entry'), findsOneWidget);
      expect(find.text('Next Entry Title'), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget); // Divider between entries
    });

    testWidgets('should handle entries without titles', (tester) async {
      final entryWithoutTitle = MwCalendarEntry((b) => b
        ..id = 1
        ..title = null
        ..createdAt = 1640995200.0);

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = entryWithoutTitle.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Untitled'), findsOneWidget);
    });

    testWidgets('should handle entries with empty titles', (tester) async {
      final entryWithEmptyTitle = MwCalendarEntry((b) => b
        ..id = 1
        ..title = ''
        ..createdAt = 1640995200.0);

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = entryWithEmptyTitle.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Untitled'), findsOneWidget);
    });

    testWidgets('should display timestamp correctly', (tester) async {
      final entry = MwCalendarEntry((b) => b
        ..id = 1
        ..title = 'Test Entry'
        ..createdAt = 1640995200.0); // Jan 1, 2022

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = entry.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
            ),
          ),
        ),
      );

      // Should display relative time (e.g., "365d ago" for Jan 1, 2022)
      expect(find.textContaining('d ago'), findsOneWidget);
    });

    testWidgets('should handle entries without timestamps', (tester) async {
      final entryWithoutTimestamp = MwCalendarEntry((b) => b
        ..id = 1
        ..title = 'Test Entry'
        ..createdAt = null);

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = entryWithoutTimestamp.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Previous Entry'), findsOneWidget);
      expect(find.text('Test Entry'), findsOneWidget);
      // Should not display timestamp
      expect(find.textContaining('ago'), findsNothing);
    });

    testWidgets('should call onPreviousTap when previous entry is tapped', (tester) async {
      bool previousTapped = false;
      final olderEntry = MwCalendarEntry((b) => b
        ..id = 1
        ..title = 'Previous Entry Title'
        ..createdAt = 1640995200.0);

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = olderEntry.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {
                previousTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Previous Entry Title'));
      await tester.pump();

      expect(previousTapped, isTrue);
    });

    testWidgets('should call onNextTap when next entry is tapped', (tester) async {
      bool nextTapped = false;
      final newerEntry = MwCalendarEntry((b) => b
        ..id = 2
        ..title = 'Next Entry Title'
        ..createdAt = 1640995200.0);

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = null
        ..newer = newerEntry.toBuilder());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onNextTap: () {
                nextTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Next Entry Title'));
      await tester.pump();

      expect(nextTapped, isTrue);
    });

    testWidgets('should handle long entry titles with ellipsis', (tester) async {
      final entryWithLongTitle = MwCalendarEntry((b) => b
        ..id = 1
        ..title = 'This is a very long entry title that should be truncated with ellipsis to fit in the available space'
        ..createdAt = 1640995200.0);

      final adjacentEntries = MwAdjacentEntries((b) => b
        ..older = entryWithLongTitle.toBuilder()
        ..newer = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdjacentEntryNavigation(
              adjacentEntries: adjacentEntries,
              onPreviousTap: () {},
            ),
          ),
        ),
      );

      // Should find the text widget but it should be truncated
      expect(find.textContaining('This is a very long entry title'), findsOneWidget);
    });
  });
}
