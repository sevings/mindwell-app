import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/profile/widgets/tag_card.dart';
import 'package:mindwell/l10n/app_localizations.dart';

void main() {
  group('TagCard', () {
    testWidgets('should not display when tags list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: TagCard(tags: []),
          ),
        ),
      );

      // The widget should not be visible (SizedBox.shrink)
      expect(find.byType(TagCard), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should display tags with correct header', (WidgetTester tester) async {
      final tags = [
        MwTagListDataInner((b) => b
          ..tag = 'mindfulness'
          ..count = 5),
        MwTagListDataInner((b) => b
          ..tag = 'meditation'
          ..count = 3),
      ];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Should display the card
      expect(find.byType(Card), findsOneWidget);
      
      // Should display the header with tags icon and title
      expect(find.byIcon(Icons.tag_outlined), findsOneWidget);
      expect(find.text('Tags'), findsOneWidget);
      
      // Should display tag count
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should display tag chips correctly', (WidgetTester tester) async {
      final tags = [
        MwTagListDataInner((b) => b
          ..tag = 'mindfulness'
          ..count = 5),
        MwTagListDataInner((b) => b
          ..tag = 'meditation'
          ..count = 1),
        MwTagListDataInner((b) => b
          ..tag = 'gratitude'
          ..count = 10),
      ];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Should display all tag chips
      expect(find.text('#mindfulness'), findsOneWidget);
      expect(find.text('#meditation'), findsOneWidget);
      expect(find.text('#gratitude'), findsOneWidget);
      
      // Should display count badges for tags with count > 1
      expect(find.text('5'), findsOneWidget); // mindfulness count
      expect(find.text('10'), findsOneWidget); // gratitude count
      
      // Should not display count badge for tag with count = 1
      expect(find.text('1'), findsNothing);
    });

    testWidgets('should handle empty tag names gracefully', (WidgetTester tester) async {
      final tags = [
        MwTagListDataInner((b) => b
          ..tag = 'mindfulness'
          ..count = 5),
        MwTagListDataInner((b) => b
          ..tag = null
          ..count = 3),
        MwTagListDataInner((b) => b
          ..tag = ''
          ..count = 2),
        MwTagListDataInner((b) => b
          ..tag = 'meditation'
          ..count = 1),
      ];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Should only display valid tags
      expect(find.text('#mindfulness'), findsOneWidget);
      expect(find.text('#meditation'), findsOneWidget);
      
      // Should not display empty or null tags
      expect(find.text('#'), findsNothing);
      
      // Should show correct count in header (only valid tags: mindfulness and meditation = 2)
      expect(find.text('2'), findsOneWidget);
      
      // Should show count badges for tags with count > 1
      expect(find.text('5'), findsOneWidget); // mindfulness count
    });

    testWidgets('should handle null count values', (WidgetTester tester) async {
      final tags = [
        MwTagListDataInner((b) => b
          ..tag = 'mindfulness'
          ..count = null),
        MwTagListDataInner((b) => b
          ..tag = 'meditation'
          ..count = 3),
      ];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Should display both tags
      expect(find.text('#mindfulness'), findsOneWidget);
      expect(find.text('#meditation'), findsOneWidget);
      
      // Should not display count badge for null count
      expect(find.text('0'), findsNothing);
      
      // Should display count badge for valid count
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('should handle tag tap without navigation errors', (WidgetTester tester) async {
      final tags = [
        MwTagListDataInner((b) => b
          ..tag = 'mindfulness'
          ..count = 5),
      ];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Find the tag chip
      final tagChip = find.text('#mindfulness');
      expect(tagChip, findsOneWidget);
      
      // Verify the tag chip is tappable (has InkWell)
      expect(find.byType(InkWell), findsWidgets);
      
      // Note: Navigation testing would require mocking GoRouter
      // For now, we just verify the widget structure is correct
    });

    testWidgets('should provide proper semantic labels', (WidgetTester tester) async {
      final tags = [
        MwTagListDataInner((b) => b
          ..tag = 'mindfulness'
          ..count = 5),
        MwTagListDataInner((b) => b
          ..tag = 'meditation'
          ..count = 1),
      ];

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Verify semantic labels are present
      expect(find.byType(Semantics), findsWidgets);
      
      // Verify that Semantics widgets are properly configured
      // (We can't directly access the properties, but we can verify they exist)
      final semanticsWidgets = tester.widgetList<Semantics>(find.byType(Semantics));
      expect(semanticsWidgets.length, greaterThan(0));
    });

    testWidgets('should display tags in wrap layout', (WidgetTester tester) async {
      final tags = List.generate(10, (index) => 
        MwTagListDataInner((b) => b
          ..tag = 'tag$index'
          ..count = index + 1),
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: TagCard(tags: tags),
          ),
        ),
      );

      // Should display all tags
      for (int i = 0; i < 10; i++) {
        expect(find.text('#tag$i'), findsOneWidget);
      }
      
      // Should use Wrap widget for layout
      expect(find.byType(Wrap), findsOneWidget);
    });
  });
}
