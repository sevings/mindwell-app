import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/widgets/entry_widget_base.dart';

void main() {
  group('EntryWidgetBase', () {
    late MwEntry testEntry;
    late EntryDisplayConfig testConfig;

    setUp(() {
      testEntry = MwEntry(
        (b) => b
          ..id = 1
          ..title = 'Test Entry'
          ..content = 'Test content'
          ..author = $MwUser(
            (b) => b
              ..id = 1
              ..name = 'testuser'
              ..showName = 'Test User',
          )
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000.0
          ..rating = MwRating(
            (b) => b
              ..isVotable = true
              ..upCount = 5
              ..downCount = 2
              ..vote = 1, // User has upvoted
          ).toBuilder()
          ..favoriteCount = 3
          ..isFavorited = true
          ..commentCount = 7
          ..rights = MwEntryRights(
            (b) => b
              ..vote = true
              ..edit = false
              ..delete = false
              ..pin = false
              ..comment = true
              ..complain = true,
          ).toBuilder(),
      );

      testConfig = const EntryDisplayConfig(
        showCommentButton: true,
        showShareButton: false,
      );
    });

    testWidgets('displays vote button when entry is votable', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(entry: testEntry, config: testConfig),
            ),
          ),
        ),
      );

      // Find the vote button with fire icon
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

      // Check that the vote count is displayed
      expect(find.text('+3'), findsOneWidget); // 5 upvotes - 2 downvotes = 3
    });

    testWidgets('displays favorite button when favorite count > 0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(entry: testEntry, config: testConfig),
            ),
          ),
        ),
      );

      // Find the favorite button
      expect(
        find.byIcon(Icons.bookmark),
        findsOneWidget,
      ); // Filled bookmark since isFavorited = true

      // Check that the favorite count is displayed
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('displays comment button when showCommentButton is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(entry: testEntry, config: testConfig),
            ),
          ),
        ),
      );

      // Find the comment button
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);

      // Check that the comment count is displayed
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('displays disabled vote button when entry is not votable', (
      WidgetTester tester,
    ) async {
      final nonVotableEntry = testEntry.rebuild(
        (b) => b.rights = MwEntryRights(
          (b) => b
            ..vote = false
            ..edit = false
            ..delete = false
            ..pin = false
            ..comment = true
            ..complain = true,
        ).toBuilder(),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(entry: nonVotableEntry, config: testConfig),
            ),
          ),
        ),
      );

      // Vote button should be displayed but disabled
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

      // The button should have disabled styling (reduced opacity)
      final voteButton = find.byIcon(Icons.local_fire_department);
      final icon = tester.widget<Icon>(voteButton);
      expect(icon.color?.a, lessThan(1.0)); // Should have reduced alpha
    });

    testWidgets('displays favorite button even when favorite count is 0', (
      WidgetTester tester,
    ) async {
      final noFavoritesEntry = testEntry.rebuild(
        (b) => b
          ..favoriteCount = 0
          ..isFavorited = false,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(
                entry: noFavoritesEntry,
                config: testConfig,
              ),
            ),
          ),
        ),
      );

      // Favorite button should be displayed (bookmark icon)
      expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
      // Count should not be displayed when it's 0
      expect(find.text('0'), findsNothing);
    });

    testWidgets(
      'does not display comment button when showCommentButton is false',
      (WidgetTester tester) async {
        final configWithoutComments = const EntryDisplayConfig(
          showCommentButton: false,
          showShareButton: false,
        );

        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: EntryWidgetBase(
                  entry: testEntry,
                  config: configWithoutComments,
                ),
              ),
            ),
          ),
        );

        // Comment button should not be displayed
        expect(find.byIcon(Icons.chat_bubble_outline), findsNothing);
      },
    );

    testWidgets('shows correct vote button styling for upvoted entry', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(entry: testEntry, config: testConfig),
            ),
          ),
        ),
      );

      // Find the vote button container
      final voteButton = find.byIcon(Icons.local_fire_department);
      expect(voteButton, findsOneWidget);

      // The button should have orange background for upvoted entries
      final container = tester.widget<Container>(
        find.ancestor(of: voteButton, matching: find.byType(Container)).first,
      );

      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.color,
        equals(const Color(0xFFFF6B35)),
      ); // Mindwell orange
    });

    testWidgets('shows correct favorite button styling for favorited entry', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryWidgetBase(entry: testEntry, config: testConfig),
            ),
          ),
        ),
      );

      // Find the favorite button container
      final favoriteButton = find.byIcon(Icons.bookmark);
      expect(favoriteButton, findsOneWidget);

      // The button should have orange background for favorited entries
      final container = tester.widget<Container>(
        find
            .ancestor(of: favoriteButton, matching: find.byType(Container))
            .first,
      );

      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.color,
        equals(const Color(0xFFFF6B35)),
      ); // Mindwell orange
    });
  });
}
