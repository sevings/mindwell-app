import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/entries/widgets/entry_card_full.dart';
import 'package:mindwell/src/core/widgets/images/cached_image.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('EntryCardFull', () {
    late MwEntry mockEntry;
    late MwUser mockAuthor;
    late MwAvatar mockAvatar;

    setUp(() {
      mockAvatar = MwAvatar((b) => b..x42 = 'https://example.com/avatar.jpg');

      mockAuthor = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
          ..avatar = mockAvatar.toBuilder(),
      );

      mockEntry = MwEntry(
        (b) => b
          ..id = 1
          ..author = mockAuthor
          ..title = 'Test Entry Title'
          ..content =
              '<p>This is a test entry content with <strong>HTML</strong> tags. It contains multiple sentences to test the full card display format.</p>'
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000.0
          ..commentCount = 5
          ..favoriteCount = 10
          ..isFavorited = false
          ..rating = MwRating((b) => b..rating = 15.0).toBuilder()
          ..tags = ListBuilder(['flutter', 'dart', 'testing'])
          ..isPinned = false,
      );
    });

    Widget createTestWidget({
      MwEntry? entry,
      VoidCallback? onTap,
      bool showImages = true,
      int maxContentLines = 8,
    }) {
      return MaterialApp(
        home: EntryCardFull(
          entry: entry ?? mockEntry,
          onTap: onTap,
          showImages: showImages,
          maxContentLines: maxContentLines,
        ),
      );
    }

    testWidgets('displays entry title and content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test Entry Title'), findsOneWidget);
      expect(
        find.text(
          'This is a test entry content with HTML tags. It contains multiple sentences to test the full card display format.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays author information with larger avatar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test User'), findsOneWidget);
      expect(find.byType(CachedAvatar), findsOneWidget);

      // Verify avatar size is 42.0 (standardized across all widgets)
      final avatarWidget = tester.widget<CachedAvatar>(
        find.byType(CachedAvatar),
      );
      expect(avatarWidget.size, equals(42.0));
    });

    testWidgets('displays entry stats with labels', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('5'), findsOneWidget); // comment button count
      expect(find.text('10'), findsOneWidget); // favorite count
      expect(find.text('+15'), findsOneWidget); // rating
    });

    testWidgets('displays tags in wrap layout', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('#flutter'), findsOneWidget);
      expect(find.text('#dart'), findsOneWidget);
      expect(find.text('#testing'), findsOneWidget);
    });

    testWidgets('shows pinned indicator with text when entry is pinned', (
      WidgetTester tester,
    ) async {
      final pinnedEntry = mockEntry.rebuild((b) => b..isPinned = true);
      await tester.pumpWidget(createTestWidget(entry: pinnedEntry));

      expect(find.byIcon(Icons.push_pin), findsOneWidget);
      expect(find.text('Закреплено'), findsOneWidget);
    });

    testWidgets('shows favorited state when entry is favorited', (
      WidgetTester tester,
    ) async {
      final favoritedEntry = mockEntry.rebuild((b) => b..isFavorited = true);
      await tester.pumpWidget(createTestWidget(entry: favoritedEntry));

      // The favorite icon should be present and styled differently
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    });

    testWidgets('handles entry without title', (WidgetTester tester) async {
      final entryWithoutTitle = mockEntry.rebuild((b) => b..title = null);
      await tester.pumpWidget(createTestWidget(entry: entryWithoutTitle));

      expect(find.text('Test Entry Title'), findsNothing);
      expect(
        find.text(
          'This is a test entry content with HTML tags. It contains multiple sentences to test the full card display format.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('handles entry without content', (WidgetTester tester) async {
      final entryWithoutContent = mockEntry.rebuild((b) => b..content = null);
      await tester.pumpWidget(createTestWidget(entry: entryWithoutContent));

      expect(find.text('Test Entry Title'), findsOneWidget);
      expect(
        find.text(
          'This is a test entry content with HTML tags. It contains multiple sentences to test the full card display format.',
        ),
        findsNothing,
      );
    });

    testWidgets('handles anonymous entry', (WidgetTester tester) async {
      final anonymousEntry = mockEntry.rebuild((b) => b..author = null);
      await tester.pumpWidget(createTestWidget(entry: anonymousEntry));

      expect(find.text('Anonymous'), findsOneWidget);
    });

    testWidgets('handles entry without stats', (WidgetTester tester) async {
      final entryWithoutStats = mockEntry.rebuild(
        (b) => b
          ..commentCount = null
          ..favoriteCount = null
          ..rating = null,
      );
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
      expect(find.text('#testing'), findsNothing);
    });

    testWidgets('calls onTap when provided', (WidgetTester tester) async {
      bool onTapCalled = false;
      await tester.pumpWidget(
        createTestWidget(onTap: () => onTapCalled = true),
      );

      await tester.tap(find.byType(InkWell));
      expect(onTapCalled, isTrue);
    });

    testWidgets('respects maxContentLines parameter', (
      WidgetTester tester,
    ) async {
      final longContentEntry = mockEntry.rebuild(
        (b) => b
          ..content =
              '<p>This is a very long content that should be truncated when maxContentLines is set to 2. It contains multiple sentences and should not be displayed in full. This is additional content to ensure truncation works properly.</p>',
      );

      await tester.pumpWidget(
        createTestWidget(entry: longContentEntry, maxContentLines: 2),
      );

      // The content should be truncated
      expect(
        find.textContaining(
          'This is a very long content that should be truncated',
        ),
        findsOneWidget,
      );
    });

    testWidgets('hides images when showImages is false', (
      WidgetTester tester,
    ) async {
      final entryWithImages = mockEntry.rebuild(
        (b) => b
          ..images = ListBuilder([
            MwImage(
              (b) => b
                ..medium = MwImageSize(
                  (b) => b
                    ..url = 'https://example.com/image1.jpg'
                    ..width = 800
                    ..height = 600,
                ).toBuilder(),
            ),
            MwImage(
              (b) => b
                ..medium = MwImageSize(
                  (b) => b
                    ..url = 'https://example.com/image2.jpg'
                    ..width = 800
                    ..height = 600,
                ).toBuilder(),
            ),
          ]),
      );

      await tester.pumpWidget(
        createTestWidget(entry: entryWithImages, showImages: false),
      );

      // The CachedAvatar should still be present (it's part of the header)
      // but the entry images should not be present
      expect(find.byType(CachedAvatar), findsOneWidget);
      // Check that there's no entry images by looking for the image container
      expect(find.byKey(const Key('entry_images')), findsNothing);
    });

    // Note: Image tests are skipped because they require network access
    // which is not available in the test environment and causes layout issues

    testWidgets('shows share button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.share_outlined), findsOneWidget);
    });

    testWidgets('shows comment button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    });

    testWidgets('formats large numbers correctly', (WidgetTester tester) async {
      final entryWithLargeNumbers = mockEntry.rebuild(
        (b) => b
          ..commentCount = 1500
          ..favoriteCount = 2500000,
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithLargeNumbers));

      expect(find.text('1.5K'), findsOneWidget); // comment count
      expect(find.text('2.5M'), findsOneWidget); // favorite count
    });

    testWidgets('handles negative rating', (WidgetTester tester) async {
      final entryWithNegativeRating = mockEntry.rebuild(
        (b) => b..rating = MwRating((b) => b..rating = -5.0).toBuilder(),
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithNegativeRating));

      expect(find.text('-5'), findsOneWidget);
    });

    testWidgets('strips HTML tags from content', (WidgetTester tester) async {
      final entryWithHtml = mockEntry.rebuild(
        (b) => b
          ..content =
              '<p>This has <strong>bold</strong> and <em>italic</em> text with <a href="#">links</a>.</p>',
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithHtml));

      expect(
        find.text('This has bold and italic text with links.'),
        findsOneWidget,
      );
    });

    testWidgets('generates correct initials for author', (
      WidgetTester tester,
    ) async {
      final authorWithLongName = $MwUser(
        (b) => b
          ..id = 2
          ..name = 'johnsmith'
          ..showName = 'John Smith'
          ..avatar = null,
      );

      final entryWithLongName = mockEntry.rebuild(
        (b) => b..author = authorWithLongName,
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithLongName));

      expect(find.text('JS'), findsOneWidget); // Should show initials
    });

    testWidgets('handles single word author name', (WidgetTester tester) async {
      final authorWithSingleName = $MwUser(
        (b) => b
          ..id = 3
          ..name = 'admin'
          ..showName = 'Admin'
          ..avatar = null,
      );

      final entryWithSingleName = mockEntry.rebuild(
        (b) => b..author = authorWithSingleName,
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithSingleName));

      expect(find.text('A'), findsOneWidget); // Should show first letter
    });

    testWidgets('displays more detailed timestamp format', (
      WidgetTester tester,
    ) async {
      final oldEntry = mockEntry.rebuild(
        (b) => b
          ..createdAt =
              (DateTime.now()
                  .subtract(const Duration(days: 2))
                  .millisecondsSinceEpoch /
              1000.0),
      );

      await tester.pumpWidget(createTestWidget(entry: oldEntry));

      expect(find.text('2д'), findsOneWidget);
    });

    testWidgets('limits tags display to 5 items', (WidgetTester tester) async {
      final entryWithManyTags = mockEntry.rebuild(
        (b) => b
          ..tags = ListBuilder([
            'tag1',
            'tag2',
            'tag3',
            'tag4',
            'tag5',
            'tag6',
            'tag7',
          ]),
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithManyTags));

      // Should show only first 5 tags
      expect(find.text('#tag1'), findsOneWidget);
      expect(find.text('#tag2'), findsOneWidget);
      expect(find.text('#tag3'), findsOneWidget);
      expect(find.text('#tag4'), findsOneWidget);
      expect(find.text('#tag5'), findsOneWidget);
      // Should not show more than 5
      expect(find.text('#tag6'), findsNothing);
      expect(find.text('#tag7'), findsNothing);
    });

    testWidgets('shows larger title text style', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final titleText = tester.widget<Text>(find.text('Test Entry Title'));
      expect(
        titleText.style?.fontSize,
        greaterThan(14.0),
      ); // Should be titleMedium
    });

    testWidgets('decodes HTML entities in title', (WidgetTester tester) async {
      final entryWithHtmlEntities = mockEntry.rebuild(
        (b) => b..title = 'Title with &lt;brackets&gt; &amp; symbols',
      );

      await tester.pumpWidget(createTestWidget(entry: entryWithHtmlEntities));

      // Should decode HTML entities in title
      expect(find.text('Title with <brackets> & symbols'), findsOneWidget);
    });
  });
}
