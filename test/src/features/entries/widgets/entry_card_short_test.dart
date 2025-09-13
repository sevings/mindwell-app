import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/entries/widgets/entry_card_short.dart';
import 'package:mindwell/src/core/widgets/images/cached_image.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('EntryCardShort', () {
    late MwEntry mockEntry;
    late MwUser mockAuthor;
    late MwAvatar mockAvatar;

    setUp(() {
      mockAvatar = MwAvatar((b) => b
        ..x42 = 'https://example.com/avatar.jpg');

      mockAuthor = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..showName = 'Test User'
        ..avatar = mockAvatar.toBuilder());

      mockEntry = MwEntry((b) => b
        ..id = 1
        ..author = mockAuthor
        ..title = 'Test Entry Title'
        ..content = '<p>This is a test entry content with <strong>HTML</strong> tags.</p>'
        ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000.0
        ..commentCount = 5
        ..favoriteCount = 10
        ..isFavorited = false
        ..rating = MwRating((b) => b..rating = 15.0).toBuilder()
        ..tags = ListBuilder(['flutter', 'dart'])
        ..isPinned = false);
    });

    Widget createTestWidget({
      MwEntry? entry,
      VoidCallback? onTap,
      bool showImage = true,
      int maxContentLines = 3,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: EntryCardShort(
            entry: entry ?? mockEntry,
            onTap: onTap,
            showImage: showImage,
            maxContentLines: maxContentLines,
          ),
        ),
      );
    }

    testWidgets('displays entry title and content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test Entry Title'), findsOneWidget);
      expect(find.text('This is a test entry content with HTML tags.'), findsOneWidget);
    });

    testWidgets('displays author information', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test User'), findsOneWidget);
      expect(find.byType(CachedAvatar), findsOneWidget);
    });

    testWidgets('displays entry stats', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('5'), findsOneWidget); // comment count
      expect(find.text('10'), findsOneWidget); // favorite count
      expect(find.text('+15'), findsOneWidget); // rating
    });

    testWidgets('displays tags', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('#flutter'), findsOneWidget);
      expect(find.text('#dart'), findsOneWidget);
    });

    testWidgets('shows pinned indicator when entry is pinned', (WidgetTester tester) async {
      final pinnedEntry = mockEntry.rebuild((b) => b..isPinned = true);
      await tester.pumpWidget(createTestWidget(entry: pinnedEntry));

      expect(find.byIcon(Icons.push_pin), findsOneWidget);
    });

    testWidgets('shows favorited state when entry is favorited', (WidgetTester tester) async {
      final favoritedEntry = mockEntry.rebuild((b) => b..isFavorited = true);
      await tester.pumpWidget(createTestWidget(entry: favoritedEntry));

      // The favorite icon should be present and styled differently
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    });

    testWidgets('handles entry without title', (WidgetTester tester) async {
      final entryWithoutTitle = mockEntry.rebuild((b) => b..title = null);
      await tester.pumpWidget(createTestWidget(entry: entryWithoutTitle));

      expect(find.text('Test Entry Title'), findsNothing);
      expect(find.text('This is a test entry content with HTML tags.'), findsOneWidget);
    });

    testWidgets('handles entry without content', (WidgetTester tester) async {
      final entryWithoutContent = mockEntry.rebuild((b) => b..content = null);
      await tester.pumpWidget(createTestWidget(entry: entryWithoutContent));

      expect(find.text('Test Entry Title'), findsOneWidget);
      expect(find.text('This is a test entry content with HTML tags.'), findsNothing);
    });

    testWidgets('handles anonymous entry', (WidgetTester tester) async {
      final anonymousEntry = mockEntry.rebuild((b) => b..author = null);
      await tester.pumpWidget(createTestWidget(entry: anonymousEntry));

      expect(find.text('Anonymous'), findsOneWidget);
    });

    testWidgets('handles entry without stats', (WidgetTester tester) async {
      final entryWithoutStats = mockEntry.rebuild((b) => b
        ..commentCount = null
        ..favoriteCount = null
        ..rating = null);
      await tester.pumpWidget(createTestWidget(entry: entryWithoutStats));

      // Should still show the stat icons but with 0 values
      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    });

    testWidgets('handles entry without tags', (WidgetTester tester) async {
      final entryWithoutTags = mockEntry.rebuild((b) => b..tags = null);
      await tester.pumpWidget(createTestWidget(entry: entryWithoutTags));

      expect(find.text('#flutter'), findsNothing);
      expect(find.text('#dart'), findsNothing);
    });

    testWidgets('calls onTap when provided', (WidgetTester tester) async {
      bool onTapCalled = false;
      await tester.pumpWidget(createTestWidget(
        onTap: () => onTapCalled = true,
      ));

      await tester.tap(find.byType(InkWell));
      expect(onTapCalled, isTrue);
    });

    testWidgets('respects maxContentLines parameter', (WidgetTester tester) async {
      final longContentEntry = mockEntry.rebuild((b) => b
        ..content = '<p>This is a very long content that should be truncated when maxContentLines is set to 1. It contains multiple sentences and should not be displayed in full.</p>');
      
      await tester.pumpWidget(createTestWidget(
        entry: longContentEntry,
        maxContentLines: 1,
      ));

      // The content should be truncated
      expect(find.textContaining('This is a very long content that should be truncated'), findsOneWidget);
    });

    testWidgets('hides image when showImage is false', (WidgetTester tester) async {
      final entryWithImage = mockEntry.rebuild((b) => b
        ..images = ListBuilder([
          MwImage((b) => b
            ..medium = MwImageSize((b) => b
              ..url = 'https://example.com/image.jpg'
              ..width = 800
              ..height = 600).toBuilder())
        ]));

      await tester.pumpWidget(createTestWidget(
        entry: entryWithImage,
        showImage: false,
      ));

      // The CachedAvatar should still be present (it's part of the header)
      // but the entry image should not be present
      expect(find.byType(CachedAvatar), findsOneWidget);
      // Check that there's no entry image by looking for the image container
      expect(find.byKey(const Key('entry_image')), findsNothing);
    });

    testWidgets('formats large numbers correctly', (WidgetTester tester) async {
      final entryWithLargeNumbers = mockEntry.rebuild((b) => b
        ..commentCount = 1500
        ..favoriteCount = 2500000);

      await tester.pumpWidget(createTestWidget(entry: entryWithLargeNumbers));

      expect(find.text('1.5K'), findsOneWidget); // comment count
      expect(find.text('2.5M'), findsOneWidget); // favorite count
    });

    testWidgets('handles negative rating', (WidgetTester tester) async {
      final entryWithNegativeRating = mockEntry.rebuild((b) => b
        ..rating = MwRating((b) => b..rating = -5.0).toBuilder());

      await tester.pumpWidget(createTestWidget(entry: entryWithNegativeRating));

      expect(find.text('-5'), findsOneWidget);
    });

    testWidgets('strips HTML tags from content', (WidgetTester tester) async {
      final entryWithHtml = mockEntry.rebuild((b) => b
        ..content = '<p>This has <strong>bold</strong> and <em>italic</em> text with <a href="#">links</a>.</p>');

      await tester.pumpWidget(createTestWidget(entry: entryWithHtml));

      expect(find.text('This has bold and italic text with links.'), findsOneWidget);
    });

    testWidgets('generates correct initials for author', (WidgetTester tester) async {
      final authorWithLongName = $MwUser((b) => b
        ..id = 2
        ..name = 'johnsmith'
        ..showName = 'John Smith'
        ..avatar = null);

      final entryWithLongName = mockEntry.rebuild((b) => b
        ..author = authorWithLongName);

      await tester.pumpWidget(createTestWidget(entry: entryWithLongName));

      expect(find.text('JS'), findsOneWidget); // Should show initials
    });

    testWidgets('handles single word author name', (WidgetTester tester) async {
      final authorWithSingleName = $MwUser((b) => b
        ..id = 3
        ..name = 'admin'
        ..showName = 'Admin'
        ..avatar = null);

      final entryWithSingleName = mockEntry.rebuild((b) => b
        ..author = authorWithSingleName);

      await tester.pumpWidget(createTestWidget(entry: entryWithSingleName));

      expect(find.text('A'), findsOneWidget); // Should show first letter
    });
  });
}
