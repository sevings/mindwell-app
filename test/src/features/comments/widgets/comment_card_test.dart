import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_card.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('CommentCard', () {
    late MwComment mockComment;
    late $MwUser mockAuthor;
    late MwRating mockRating;

    setUp(() {
      mockRating = MwRating(
        (b) => b
          ..upCount = 5
          ..downCount = 2,
      );

      mockAuthor = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'TestUser'
          ..avatar = MwAvatar(
            (b) => b..x92 = 'https://example.com/avatar.jpg',
          ).toBuilder(),
      );

      mockComment = MwComment(
        (b) => b
          ..id = 1
          ..author = mockAuthor.toBuilder().build()
          ..entryId = 123
          ..createdAt =
              1640995200.0 // Jan 1, 2022
          ..content =
              '<p>This is a test comment with <strong>HTML</strong> content.</p>'
          ..rating = mockRating.toBuilder()
          ..rights = MwCommentRights((b) => b..vote = true).toBuilder(),
      );
    });

    Widget createTestWidget({
      MwComment? comment,
      String? entryTitle,
      VoidCallback? onUpvote,
      VoidCallback? onDownvote,
      bool isVoting = false,
    }) {
      return MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Scaffold(
                body: CommentCard(
                  comment: comment ?? mockComment,
                  entryTitle: entryTitle,
                  onUpvote: onUpvote,
                  onDownvote: onDownvote,
                  isVoting: isVoting,
                ),
              ),
            ),
            GoRoute(
              path: '/entries/:id',
              builder: (context, state) =>
                  const Scaffold(body: Text('Entry Detail')),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) =>
                  const Scaffold(body: Text('Profile')),
            ),
          ],
        ),
      );
    }

    testWidgets('displays comment information correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(entryTitle: 'Test Entry Title'));

      // Check that author name is displayed
      expect(find.text('TestUser'), findsOneWidget);

      // Check that entry title is displayed when provided
      expect(find.text('Test Entry Title'), findsOneWidget);

      // Check that comment content snippet is displayed (HTML stripped)
      expect(
        find.textContaining('This is a test comment with HTML content.'),
        findsOneWidget,
      );

      // Check that voting button is displayed (fire icon)
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

      // Check that net vote count is displayed (5 - 2 = 3)
      expect(find.text('+3'), findsOneWidget);
    });

    testWidgets('displays comment without entry title', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Check that author name is displayed
      expect(find.text('TestUser'), findsOneWidget);

      // Check that entry title is not displayed
      expect(find.byIcon(Icons.article_outlined), findsNothing);

      // Check that comment content is displayed
      expect(
        find.textContaining('This is a test comment with HTML content.'),
        findsOneWidget,
      );
    });

    testWidgets('handles comment without rating', (WidgetTester tester) async {
      final commentWithoutRating = mockComment.rebuild((b) => b..rating = null);

      await tester.pumpWidget(createTestWidget(comment: commentWithoutRating));

      // Check that author name is displayed
      expect(find.text('TestUser'), findsOneWidget);

      // Check that voting button is not displayed
      expect(find.byIcon(Icons.local_fire_department), findsNothing);
    });

    testWidgets('handles comment without author', (WidgetTester tester) async {
      final commentWithoutAuthor = mockComment.rebuild((b) => b..author = null);

      await tester.pumpWidget(createTestWidget(comment: commentWithoutAuthor));

      // Check that nothing is rendered
      expect(find.byType(CommentCard), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget); // The shrink widget
    });

    testWidgets('handles empty comment content', (WidgetTester tester) async {
      final commentWithEmptyContent = mockComment.rebuild(
        (b) => b
          ..content = null
          ..editContent = null,
      );

      await tester.pumpWidget(
        createTestWidget(comment: commentWithEmptyContent),
      );

      // Check that "Comment deleted" message is displayed
      expect(find.text('Comment deleted'), findsOneWidget);
    });

    testWidgets('handles long comment content with truncation', (
      WidgetTester tester,
    ) async {
      final longContent =
          '<p>${'This is a very long comment content. ' * 20}</p>';
      final commentWithLongContent = mockComment.rebuild(
        (b) => b..content = longContent,
      );

      await tester.pumpWidget(
        createTestWidget(comment: commentWithLongContent),
      );

      // Check that content is truncated (should not contain the full content)
      expect(
        find.textContaining('This is a very long comment content.'),
        findsOneWidget,
      );
      expect(
        find.textContaining(
          'This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content. This is a very long comment content.',
        ),
        findsNothing,
      );
    });

    testWidgets('displays voting state correctly when isVoting is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(isVoting: true));

      // Check that voting button is disabled (no tap handlers)
      final voteButton = find.byIcon(Icons.local_fire_department);

      expect(voteButton, findsOneWidget);

      // Check that loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('calls onUpvote when vote button is tapped (not voted)', (
      WidgetTester tester,
    ) async {
      bool upvoteCalled = false;
      void onUpvote() => upvoteCalled = true;

      await tester.pumpWidget(createTestWidget(onUpvote: onUpvote));

      // Find and tap the vote button (should trigger upvote since user hasn't voted)
      final voteIcon = find.byIcon(Icons.local_fire_department);
      await tester.tap(voteIcon);
      await tester.pump();

      expect(upvoteCalled, isTrue);
    });

    testWidgets('calls onDownvote when vote button is tapped (already upvoted)', (
      WidgetTester tester,
    ) async {
      bool downvoteCalled = false;
      void onDownvote() => downvoteCalled = true;

      // Create a comment that is already upvoted
      final upvotedRating = MwRating(
        (b) => b
          ..upCount = 6
          ..downCount = 2
          ..vote = 1,
      ); // User has upvoted
      final upvotedComment = mockComment.rebuild(
        (b) => b
          ..rating = upvotedRating.toBuilder()
          ..rights = MwCommentRights((b) => b..vote = true).toBuilder(),
      );

      await tester.pumpWidget(
        createTestWidget(comment: upvotedComment, onDownvote: onDownvote),
      );

      // Find and tap the vote button (should trigger downvote since user has already upvoted)
      final voteIcon = find.byIcon(Icons.local_fire_department);
      await tester.tap(voteIcon);
      await tester.pump();

      expect(downvoteCalled, isTrue);
    });

    testWidgets('does not call vote callbacks when isVoting is true', (
      WidgetTester tester,
    ) async {
      bool upvoteCalled = false;
      bool downvoteCalled = false;
      void onUpvote() => upvoteCalled = true;
      void onDownvote() => downvoteCalled = true;

      await tester.pumpWidget(
        createTestWidget(
          onUpvote: onUpvote,
          onDownvote: onDownvote,
          isVoting: true,
        ),
      );

      // Try to tap vote button
      final voteIcon = find.byIcon(Icons.local_fire_department);

      await tester.tap(voteIcon);
      await tester.pump();

      expect(upvoteCalled, isFalse);
      expect(downvoteCalled, isFalse);
    });

    testWidgets('displays timestamp correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that timestamp is displayed (format may vary based on date)
      expect(find.textContaining('Jan 1, 2022'), findsOneWidget);
    });

    testWidgets('displays comment indicator', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that comment indicator is displayed
      expect(find.text('Comment'), findsOneWidget);
      expect(find.byIcon(Icons.comment_outlined), findsOneWidget);
    });

    testWidgets('has correct tap targets for navigation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Check that the main card is tappable
      expect(find.byType(InkWell), findsOneWidget);

      // Check that author name/avatar is tappable
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('handles author without avatar', (WidgetTester tester) async {
      final authorWithoutAvatar = mockAuthor.rebuild((b) => b..avatar = null);
      final commentWithAuthorWithoutAvatar = mockComment.rebuild(
        (b) => b..author = authorWithoutAvatar.toBuilder().build(),
      );

      await tester.pumpWidget(
        createTestWidget(comment: commentWithAuthorWithoutAvatar),
      );

      // Check that author name is still displayed
      expect(find.text('TestUser'), findsOneWidget);

      // Check that fallback avatar is displayed
      expect(find.text('T'), findsOneWidget); // First letter of name
    });

    testWidgets('handles author without name', (WidgetTester tester) async {
      final authorWithoutName = mockAuthor.rebuild((b) => b..name = null);
      final commentWithAuthorWithoutName = mockComment.rebuild(
        (b) => b..author = authorWithoutName.toBuilder().build(),
      );

      await tester.pumpWidget(
        createTestWidget(comment: commentWithAuthorWithoutName),
      );

      // Check that fallback name is displayed
      expect(find.text('Unknown'), findsOneWidget);
    });

    testWidgets('strips HTML tags from content snippet', (
      WidgetTester tester,
    ) async {
      final commentWithHtml = mockComment.rebuild(
        (b) => b
          ..content =
              '<p>This is <strong>bold</strong> and <em>italic</em> text with <a href="#">link</a>.</p>',
      );

      await tester.pumpWidget(createTestWidget(comment: commentWithHtml));

      // Check that HTML tags are stripped from the displayed text
      expect(
        find.textContaining('This is bold and italic text with link.'),
        findsOneWidget,
      );
      expect(find.textContaining('<strong>'), findsNothing);
      expect(find.textContaining('<em>'), findsNothing);
      expect(find.textContaining('<a'), findsNothing);
    });
  });
}
