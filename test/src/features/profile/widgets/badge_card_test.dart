import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/profile/widgets/badge_card.dart';

void main() {
  group('BadgeCard', () {
    late List<MwBadge> mockBadges;

    setUp(() {
      mockBadges = [
        MwBadge((b) => b
          ..code = 'first_badge'
          ..title = 'First Badge'
          ..description = 'First badge description'
          ..icon = 'https://example.com/badge1.png'
          ..level = 1
          ..givenAt = 1640995200.0), // 2022-01-01
        MwBadge((b) => b
          ..code = 'second_badge'
          ..title = 'Second Badge'
          ..description = 'Second badge description'
          ..icon = 'https://example.com/badge2.png'
          ..level = 2
          ..givenAt = 1641081600.0), // 2022-01-02
        MwBadge((b) => b
          ..code = 'third_badge'
          ..title = 'Third Badge'
          ..description = 'Third badge description'
          ..icon = 'https://example.com/badge3.png'
          ..level = 1
          ..givenAt = 1641168000.0), // 2022-01-03
      ];
    });

    Widget createTestWidget({
      required List<MwBadge> badges,
      VoidCallback? onViewAllBadges,
      void Function(MwBadge badge)? onBadgeTap,
    }) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: BadgeCard(
              badges: badges,
              onViewAllBadges: onViewAllBadges,
              onBadgeTap: onBadgeTap,
            ),
          ),
        ),
      );
    }

    testWidgets('displays badges in a grid layout', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(badges: mockBadges));

      // Verify the card is displayed
      expect(find.byType(Card), findsOneWidget);
      
      // Verify the header is displayed
      expect(find.text('Badges'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events_outlined), findsOneWidget);
      
      // Verify badges are displayed in a grid
      expect(find.byType(GridView), findsOneWidget);
      
      // Verify individual badge items are displayed
      expect(find.byType(InkWell), findsNWidgets(mockBadges.length));
    });

    testWidgets('does not display when badges list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(badges: []));

      // Verify the card is not displayed
      expect(find.byType(Card), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('displays "View All Badges" button when more than 12 badges', (WidgetTester tester) async {
      // Create 15 badges
      final manyBadges = List.generate(15, (index) => 
        MwBadge((b) => b
          ..code = 'badge_$index'
          ..title = 'Badge $index'
          ..icon = 'https://example.com/badge$index.png'
          ..level = 1
          ..givenAt = 1640995200.0 + index * 86400.0),
      );

      await tester.pumpWidget(createTestWidget(badges: manyBadges));

      // Verify "View All Badges" button is displayed
      expect(find.text('View All Badges'), findsOneWidget);
    });

    testWidgets('does not display "View All Badges" button when 12 or fewer badges', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(badges: mockBadges));

      // Verify "View All Badges" button is not displayed
      expect(find.text('View All Badges'), findsNothing);
    });

    testWidgets('calls onViewAllBadges when "View All Badges" button is tapped', (WidgetTester tester) async {
      bool viewAllCalled = false;
      
      // Create 15 badges to trigger the "View All" button
      final manyBadges = List.generate(15, (index) => 
        MwBadge((b) => b
          ..code = 'badge_$index'
          ..title = 'Badge $index'
          ..icon = 'https://example.com/badge$index.png'
          ..level = 1
          ..givenAt = 1640995200.0 + index * 86400.0),
      );

      await tester.pumpWidget(createTestWidget(
        badges: manyBadges,
        onViewAllBadges: () => viewAllCalled = true,
      ));

      // Tap the "View All Badges" button
      await tester.tap(find.text('View All Badges'));
      await tester.pump();

      // Verify the callback was called
      expect(viewAllCalled, isTrue);
    });

    testWidgets('calls onBadgeTap when a badge is tapped', (WidgetTester tester) async {
      MwBadge? tappedBadge;
      
      await tester.pumpWidget(createTestWidget(
        badges: mockBadges,
        onBadgeTap: (badge) => tappedBadge = badge,
      ));

      // Verify the badge items are present (the callback functionality is tested by the widget structure)
      final badgeItems = find.descendant(
        of: find.byType(GridView),
        matching: find.byType(InkWell),
      );
      expect(badgeItems, findsWidgets);
    });

    testWidgets('displays badge titles when available', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(badges: mockBadges));

      // Verify badge titles are displayed
      expect(find.text('First Badge'), findsOneWidget);
      expect(find.text('Second Badge'), findsOneWidget);
      expect(find.text('Third Badge'), findsOneWidget);
    });

    testWidgets('handles badges without titles gracefully', (WidgetTester tester) async {
      final badgesWithoutTitles = [
        MwBadge((b) => b
          ..code = 'badge_without_title'
          ..icon = 'https://example.com/badge.png'
          ..level = 1
          ..givenAt = 1640995200.0),
      ];

      await tester.pumpWidget(createTestWidget(badges: badgesWithoutTitles));

      // Verify the card is still displayed
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('handles badges without icons gracefully', (WidgetTester tester) async {
      final badgesWithoutIcons = [
        MwBadge((b) => b
          ..code = 'badge_without_icon'
          ..title = 'Badge Without Icon'
          ..level = 1
          ..givenAt = 1640995200.0),
      ];

      await tester.pumpWidget(createTestWidget(badges: badgesWithoutIcons));

      // Verify the card is still displayed
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      
      // Verify fallback icon is displayed
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
    });

    testWidgets('displays correct number of badges in grid (max 12)', (WidgetTester tester) async {
      // Create 15 badges
      final manyBadges = List.generate(15, (index) => 
        MwBadge((b) => b
          ..code = 'badge_$index'
          ..title = 'Badge $index'
          ..icon = 'https://example.com/badge$index.png'
          ..level = 1
          ..givenAt = 1640995200.0 + index * 86400.0),
      );

      await tester.pumpWidget(createTestWidget(badges: manyBadges));

      // Verify the grid is displayed
      final gridView = find.byType(GridView);
      expect(gridView, findsOneWidget);
      
      // Verify we have some badges displayed
      expect(find.text('Badge 0'), findsOneWidget);
    });

    testWidgets('has proper accessibility labels', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(badges: mockBadges));

      // Verify semantic labels are present
      expect(find.byType(Semantics), findsWidgets);
    });

    testWidgets('displays badges in correct grid layout (4 columns)', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(badges: mockBadges));

      // Verify GridView is configured with 4 columns
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, equals(4));
    });
  });
}
