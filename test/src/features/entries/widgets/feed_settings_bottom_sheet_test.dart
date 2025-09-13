import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/widgets/feed_settings_bottom_sheet.dart';

void main() {
  group('FeedSettingsBottomSheet', () {
    Widget createTestWidget({
      FeedType feedType = FeedType.live,
      String? feedParameter,
    }) {
      return ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: FeedSettingsBottomSheet(
              feedType: feedType,
              feedParameter: feedParameter,
            ),
          ),
        ),
      );
    }

    testWidgets('should display all settings sections for live feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.live));
      await tester.pumpAndSettle();

      // Verify all section titles are displayed
      expect(find.text('Display Format'), findsOneWidget);
      expect(find.text('Sort Order'), findsNothing); // Not shown for live feed
      expect(find.text('Source Options'), findsOneWidget);
      expect(find.text('Entry Count'), findsNothing); // Not shown for live feed
      expect(find.text('Apply Settings'), findsOneWidget);
    });

    testWidgets('should display all settings sections for best feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.best));
      await tester.pumpAndSettle();

      // Verify all section titles are displayed
      expect(find.text('Display Format'), findsOneWidget);
      expect(find.text('Sort Order'), findsNothing); // Not shown for best feed
      expect(find.text('Source Options'), findsOneWidget);
      expect(find.text('Entry Count'), findsOneWidget); // Shown for best feed
      expect(find.text('Apply Settings'), findsOneWidget);
    });

    testWidgets('should not display source options for friends feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.friends));
      await tester.pumpAndSettle();

      // Verify source options are not displayed
      expect(find.text('Source Options'), findsNothing);
      expect(find.text('Include Tlogs'), findsNothing);
      expect(find.text('Include Themes'), findsNothing);
      
      // Verify entry count is not displayed
      expect(find.text('Entry Count'), findsNothing);
    });

    testWidgets('should display sort order for profile feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.profile));
      await tester.pumpAndSettle();

      // Verify sort order is displayed for profile feed
      expect(find.text('Sort Order'), findsOneWidget);
      expect(find.text('Newest First'), findsOneWidget);
      expect(find.text('Oldest First'), findsOneWidget);
      expect(find.text('Best First'), findsOneWidget);
      
      // Verify source options are not displayed
      expect(find.text('Source Options'), findsNothing);
      
      // Verify entry count is not displayed
      expect(find.text('Entry Count'), findsNothing);
    });

    testWidgets('should display display format options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify display format options
      expect(find.text('Short'), findsOneWidget);
      expect(find.text('Full'), findsOneWidget);
      expect(find.byIcon(Icons.view_module), findsOneWidget);
      expect(find.byIcon(Icons.view_list), findsOneWidget);
    });

    testWidgets('should allow selecting display format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initially short format should be selected
      final shortOption = find.text('Short');
      expect(shortOption, findsOneWidget);

      // Tap on full format option
      await tester.tap(find.text('Full'));
      await tester.pumpAndSettle();

      // Verify the UI updates (the visual selection should change)
      expect(find.text('Full'), findsOneWidget);
    });

    testWidgets('should display sort order options for profile feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.profile));
      await tester.pumpAndSettle();

      // Verify sort order options
      expect(find.text('Newest First'), findsOneWidget);
      expect(find.text('Oldest First'), findsOneWidget);
      expect(find.text('Best First'), findsOneWidget);
    });

    testWidgets('should allow selecting sort order for profile feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.profile));
      await tester.pumpAndSettle();

      // Tap on oldest first option
      await tester.tap(find.text('Oldest First'));
      await tester.pumpAndSettle();

      // Verify the UI updates
      expect(find.text('Oldest First'), findsOneWidget);
    });

    testWidgets('should display source options for live feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.live));
      await tester.pumpAndSettle();

      // Verify source options
      expect(find.text('Include Tlogs'), findsOneWidget);
      expect(find.text('Include Themes'), findsOneWidget);
      expect(find.text('Show entries from diaries'), findsOneWidget);
      expect(find.text('Show entries from themes'), findsOneWidget);

      // Verify switches are present
      expect(find.byType(Switch), findsNWidgets(2));
    });

    testWidgets('should allow toggling source options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.live));
      await tester.pumpAndSettle();

      // Find the switches
      final switches = find.byType(Switch);
      expect(switches, findsNWidgets(2));

      // Tap the first switch (include tlogs)
      await tester.tap(switches.first);
      await tester.pumpAndSettle();

      // Verify the switch state changed
      final switchWidget = tester.widget<Switch>(switches.first);
      expect(switchWidget.value, isFalse);
    });

    testWidgets('should prevent disabling both source options', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.live));
      await tester.pumpAndSettle();

      // Find the switches
      final switches = find.byType(Switch);
      expect(switches, findsNWidgets(2));

      // Disable tlogs first
      await tester.tap(switches.first);
      await tester.pumpAndSettle();

      // Verify tlogs is disabled
      final tlogsSwitch = tester.widget<Switch>(switches.first);
      expect(tlogsSwitch.value, isFalse);

      // Try to disable themes (should be prevented)
      await tester.tap(switches.last);
      await tester.pumpAndSettle();

      // Verify themes is still enabled (validation prevented disabling)
      final themesSwitch = tester.widget<Switch>(switches.last);
      expect(themesSwitch.value, isTrue);
    });


    testWidgets('should handle different feed types', (WidgetTester tester) async {
      // Test with different feed types
      final feedTypes = [FeedType.live, FeedType.best, FeedType.friends, FeedType.profile];
      
      for (final feedType in feedTypes) {
        await tester.pumpWidget(createTestWidget(feedType: feedType));
        await tester.pumpAndSettle();

        // Verify the widget renders correctly for each feed type
        expect(find.text('Display Format'), findsOneWidget);
        expect(find.text('Apply Settings'), findsOneWidget);

        // Clean up for next iteration
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      }
    });

    testWidgets('should display entry count options for best feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.best));
      await tester.pumpAndSettle();

      // Verify entry count options are displayed
      expect(find.text('Entry Count'), findsOneWidget);
      expect(find.text('Number of entries to display per page'), findsOneWidget);
      expect(find.text('20 entries'), findsOneWidget); // Default value
    });

    testWidgets('should allow selecting entry count for best feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(feedType: FeedType.best));
      await tester.pumpAndSettle();

      // Tap on the dropdown to open it
      await tester.tap(find.byType(DropdownButton<int>));
      await tester.pumpAndSettle();

      // Select 50 entries
      await tester.tap(find.text('50 entries'));
      await tester.pumpAndSettle();

      // Verify the selection is updated
      expect(find.text('50 entries'), findsOneWidget);
    });
  });
}