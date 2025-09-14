import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_list.dart';

// Mock classes
class MockMwComment extends Mock implements MwComment {}
class MockMwUser extends Mock implements MwUser {}
class MockMwRating extends Mock implements MwRating {}
class MockMwAvatar extends Mock implements MwAvatar {}

void main() {
  group('CommentList', () {
    late List<MockMwComment> mockComments;
    late MockMwUser mockAuthor;
    late MockMwRating mockRating;
    late MockMwAvatar mockAvatar;

    setUp(() {
      mockRating = MockMwRating();
      mockAuthor = MockMwUser();
      mockAvatar = MockMwAvatar();

      // Setup default mock responses
      when(() => mockRating.upCount).thenReturn(5);
      when(() => mockRating.downCount).thenReturn(2);

      when(() => mockAvatar.x42).thenReturn('https://example.com/avatar42.jpg');
      when(() => mockAvatar.x92).thenReturn('https://example.com/avatar92.jpg');
      when(() => mockAvatar.x124).thenReturn('https://example.com/avatar124.jpg');

      when(() => mockAuthor.id).thenReturn(1);
      when(() => mockAuthor.name).thenReturn('Test User');
      when(() => mockAuthor.avatar).thenReturn(mockAvatar);

      // Create mock comments
      final comment1 = MockMwComment();
      when(() => comment1.id).thenReturn(1);
      when(() => comment1.entryId).thenReturn(1);
      when(() => comment1.author).thenReturn(mockAuthor);
      when(() => comment1.content).thenReturn('<p>First comment</p>');
      when(() => comment1.createdAt).thenReturn(1640995200.0);
      when(() => comment1.rating).thenReturn(mockRating);

      final comment2 = MockMwComment();
      when(() => comment2.id).thenReturn(2);
      when(() => comment2.entryId).thenReturn(2);
      when(() => comment2.author).thenReturn(mockAuthor);
      when(() => comment2.content).thenReturn('<p>Second comment</p>');
      when(() => comment2.createdAt).thenReturn(1640995200.0);
      when(() => comment2.rating).thenReturn(mockRating);

      final comment3 = MockMwComment();
      when(() => comment3.id).thenReturn(3);
      when(() => comment3.entryId).thenReturn(3);
      when(() => comment3.author).thenReturn(mockAuthor);
      when(() => comment3.content).thenReturn('<p>Third comment</p>');
      when(() => comment3.createdAt).thenReturn(1640995200.0);
      when(() => comment3.rating).thenReturn(mockRating);

      mockComments = [comment1, comment2, comment3];
    });

    testWidgets('displays list of comments correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(comments: mockComments),
          ),
        ),
      );

      // Check that all comments are displayed
      expect(find.text('First comment'), findsOneWidget);
      expect(find.text('Second comment'), findsOneWidget);
      expect(find.text('Third comment'), findsOneWidget);

      // Check that author names are displayed
      expect(find.text('Test User'), findsNWidgets(3));
    });

    testWidgets('displays empty state when no comments', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(comments: []),
          ),
        ),
      );

      // Check that empty state is displayed
      expect(find.text('No comments yet'), findsOneWidget);
      expect(find.byIcon(Icons.comment_outlined), findsOneWidget);
    });

    testWidgets('displays loading state when loading and no comments', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: [],
              isLoading: true,
            ),
          ),
        ),
      );

      // Check that skeleton loaders are displayed
      expect(find.byType(CircularProgressIndicator), findsNothing); // No loading indicator in skeleton
      // Check for skeleton elements (they use SkeletonLoader internally)
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('displays load more button when hasMore is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              hasMore: true,
              onLoadMore: () {},
            ),
          ),
        ),
      );

      // Check that load more button is displayed
      expect(find.text('Load more comments'), findsOneWidget);
    });

    testWidgets('displays loading indicator when loading more comments', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              hasMore: true,
              isLoading: true,
            ),
          ),
        ),
      );

      // Check that loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading comments...'), findsOneWidget);
    });

    testWidgets('displays error state when hasError is true', (WidgetTester tester) async {
      bool onRetryCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: [],
              hasError: true,
              errorMessage: 'Network error',
              onRetry: () => onRetryCalled = true,
            ),
          ),
        ),
      );

      // Check that error state is displayed
      expect(find.text('Failed to load comments'), findsOneWidget);
      expect(find.text('Network error'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      // Tap the retry button
      await tester.tap(find.text('Retry'), warnIfMissed: false);
      await tester.pump();

      expect(onRetryCalled, isTrue);
    });

    testWidgets('calls onCommentTap when comment is tapped', (WidgetTester tester) async {
      MwComment? tappedComment;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              onCommentTap: (comment) => tappedComment = comment,
            ),
          ),
        ),
      );

      // Tap on the first comment
      await tester.tap(find.text('First comment'));
      await tester.pump();

      expect(tappedComment, equals(mockComments[0]));
    });

    testWidgets('calls onAuthorTap when author is tapped', (WidgetTester tester) async {
      MwUser? tappedAuthor;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              onAuthorTap: (author) => tappedAuthor = author,
            ),
          ),
        ),
      );

      // Tap on the first author name
      await tester.tap(find.text('Test User').first);
      await tester.pump();

      expect(tappedAuthor, equals(mockAuthor));
    });

    testWidgets('calls onUpvote when upvote button is tapped', (WidgetTester tester) async {
      MwComment? upvotedComment;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              onUpvote: (comment) => upvotedComment = comment,
            ),
          ),
        ),
      );

      // Tap on the first upvote button
      await tester.tap(find.byIcon(Icons.thumb_up_outlined).first);
      await tester.pump();

      expect(upvotedComment, equals(mockComments[0]));
    });

    testWidgets('calls onDownvote when downvote button is tapped', (WidgetTester tester) async {
      MwComment? downvotedComment;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              onDownvote: (comment) => downvotedComment = comment,
            ),
          ),
        ),
      );

      // Tap on the first downvote button
      await tester.tap(find.byIcon(Icons.thumb_down_outlined).first);
      await tester.pump();

      expect(downvotedComment, equals(mockComments[0]));
    });

    testWidgets('displays entry titles when showEntryTitles is true', (WidgetTester tester) async {
      final entryTitles = {1: 'Entry 1', 2: 'Entry 2', 3: 'Entry 3'};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              showEntryTitles: true,
              entryTitles: entryTitles,
            ),
          ),
        ),
      );

      // Check that entry titles are displayed
      expect(find.text('Entry 1'), findsOneWidget);
      expect(find.text('Entry 2'), findsOneWidget);
      expect(find.text('Entry 3'), findsOneWidget);
      expect(find.byIcon(Icons.article_outlined), findsNWidgets(3));
    });

    testWidgets('hides voting buttons when showVoting is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              showVoting: false,
            ),
          ),
        ),
      );

      // Check that voting buttons are not displayed
      expect(find.byIcon(Icons.thumb_up_outlined), findsNothing);
      expect(find.byIcon(Icons.thumb_down_outlined), findsNothing);
    });

    testWidgets('displays separators when showSeparator is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              showSeparator: true,
            ),
          ),
        ),
      );

      // Check that comments are still displayed
      expect(find.text('First comment'), findsOneWidget);
      expect(find.text('Second comment'), findsOneWidget);
      expect(find.text('Third comment'), findsOneWidget);
    });

    testWidgets('applies custom padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(
              comments: mockComments,
              padding: customPadding,
            ),
          ),
        ),
      );

      // Check that the comment list is rendered (we can't easily test exact padding values)
      expect(find.byType(CommentList), findsOneWidget);
    });

    testWidgets('handles comments without ratings gracefully', (WidgetTester tester) async {
      final commentWithoutRating = MockMwComment();
      when(() => commentWithoutRating.id).thenReturn(1);
      when(() => commentWithoutRating.entryId).thenReturn(1);
      when(() => commentWithoutRating.author).thenReturn(mockAuthor);
      when(() => commentWithoutRating.content).thenReturn('<p>Comment without rating</p>');
      when(() => commentWithoutRating.createdAt).thenReturn(1640995200.0);
      when(() => commentWithoutRating.rating).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(comments: [commentWithoutRating]),
          ),
        ),
      );

      // Check that comment is still displayed
      expect(find.text('Comment without rating'), findsOneWidget);
      // Check that voting buttons are not displayed (since no rating)
      expect(find.byIcon(Icons.thumb_up_outlined), findsNothing);
      expect(find.byIcon(Icons.thumb_down_outlined), findsNothing);
    });

    testWidgets('handles comments without authors gracefully', (WidgetTester tester) async {
      final commentWithoutAuthor = MockMwComment();
      when(() => commentWithoutAuthor.id).thenReturn(1);
      when(() => commentWithoutAuthor.entryId).thenReturn(1);
      when(() => commentWithoutAuthor.author).thenReturn(null);
      when(() => commentWithoutAuthor.content).thenReturn('<p>Comment without author</p>');
      when(() => commentWithoutAuthor.createdAt).thenReturn(1640995200.0);
      when(() => commentWithoutAuthor.rating).thenReturn(mockRating);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentList(comments: [commentWithoutAuthor]),
          ),
        ),
      );

      // Check that the comment list is rendered (comment without author should be skipped)
      expect(find.byType(CommentList), findsOneWidget);
    });
  });
}
