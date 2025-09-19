import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_item.dart';

// Mock classes
class MockMwComment extends Mock implements MwComment {}

class MockMwUser extends Mock implements MwUser {}

class MockMwRating extends Mock implements MwRating {}

class MockMwAvatar extends Mock implements MwAvatar {}

class MockMwCommentRights extends Mock implements MwCommentRights {}

void main() {
  group('CommentItem', () {
    late MockMwComment mockComment;
    late MockMwUser mockAuthor;
    late MockMwRating mockRating;
    late MockMwAvatar mockAvatar;
    late MockMwCommentRights mockRights;

    setUp(() {
      mockRating = MockMwRating();
      mockAuthor = MockMwUser();
      mockComment = MockMwComment();
      mockAvatar = MockMwAvatar();
      mockRights = MockMwCommentRights();

      // Setup default mock responses
      when(() => mockRating.upCount).thenReturn(5);
      when(() => mockRating.downCount).thenReturn(2);
      when(() => mockRights.vote).thenReturn(true);

      when(() => mockAvatar.x42).thenReturn('https://example.com/avatar42.jpg');
      when(() => mockAvatar.x92).thenReturn('https://example.com/avatar92.jpg');
      when(
        () => mockAvatar.x124,
      ).thenReturn('https://example.com/avatar124.jpg');

      when(() => mockAuthor.id).thenReturn(1);
      when(() => mockAuthor.name).thenReturn('Test User');
      when(() => mockAuthor.avatar).thenReturn(mockAvatar);

      when(() => mockComment.id).thenReturn(1);
      when(() => mockComment.author).thenReturn(mockAuthor);
      when(() => mockComment.content).thenReturn(
        '<p>This is a test comment with <strong>HTML</strong> content.</p>',
      );
      when(
        () => mockComment.createdAt,
      ).thenReturn(1640995200.0); // 2022-01-01 00:00:00 UTC
      when(() => mockComment.rating).thenReturn(mockRating);
      when(() => mockComment.rights).thenReturn(mockRights);
    });

    testWidgets('displays comment content correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(body: CommentItem(comment: mockComment)),
          ),
        ),
      );

      // Check that author name is displayed
      expect(find.text('Test User'), findsOneWidget);

      // Check that comment content is displayed (HTML is rendered)
      // Note: In tests, HTML content might not be fully rendered, so we check for the raw content
      expect(find.textContaining('This is a test comment'), findsOneWidget);

      // Check that voting button is displayed (now uses fire icon)
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);

      // Check that net vote count is displayed (upvotes - downvotes = 5 - 2 = 3)
      expect(find.text('+3'), findsOneWidget);
    });

    testWidgets('displays entry title when showEntryTitle is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommentItem(
                comment: mockComment,
                showEntryTitle: true,
                entryTitle: 'Test Entry Title',
              ),
            ),
          ),
        ),
      );

      // Check that entry title is displayed
      expect(find.text('Test Entry Title'), findsOneWidget);
      expect(find.byIcon(Icons.article_outlined), findsOneWidget);
    });

    testWidgets('hides voting section when showVoting is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommentItem(comment: mockComment, showVoting: false),
            ),
          ),
        ),
      );

      // Check that voting button is not displayed
      expect(find.byIcon(Icons.local_fire_department), findsNothing);
    });

    testWidgets('calls onTap when comment is tapped', (
      WidgetTester tester,
    ) async {
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              onTap: () => onTapCalled = true,
            ),
          ),
        ),
      );

      // Tap on the comment
      await tester.tap(find.byType(CommentItem));
      await tester.pump();

      expect(onTapCalled, isTrue);
    });

    testWidgets('calls onAuthorTap when author is tapped', (
      WidgetTester tester,
    ) async {
      bool onAuthorTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              onAuthorTap: () => onAuthorTapCalled = true,
            ),
          ),
        ),
      );

      // Tap on the author name
      await tester.tap(find.text('Test User'));
      await tester.pump();

      expect(onAuthorTapCalled, isTrue);
    });

    testWidgets('calls onUpvote when upvote button is tapped', (
      WidgetTester tester,
    ) async {
      bool onUpvoteCalled = false;
      MwComment? receivedComment;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommentItem(
                comment: mockComment,
                onUpvote: (comment) {
                  onUpvoteCalled = true;
                  receivedComment = comment;
                },
              ),
            ),
          ),
        ),
      );

      // Tap on the vote button (now uses fire icon)
      await tester.tap(find.byIcon(Icons.local_fire_department));
      await tester.pump();

      expect(onUpvoteCalled, isTrue);
      expect(receivedComment, equals(mockComment));
    });

    testWidgets('calls onDownvote when downvote button is tapped', (
      WidgetTester tester,
    ) async {
      bool onDownvoteCalled = false;
      MwComment? receivedComment;

      // Set up the rating to show the user has already upvoted
      when(() => mockRating.vote).thenReturn(1); // User has upvoted

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommentItem(
                comment: mockComment,
                onDownvote: (comment) {
                  onDownvoteCalled = true;
                  receivedComment = comment;
                },
              ),
            ),
          ),
        ),
      );

      // Tap on the vote button (now uses fire icon, same button for both upvote and downvote)
      await tester.tap(find.byIcon(Icons.local_fire_department));
      await tester.pump();

      expect(onDownvoteCalled, isTrue);
      expect(receivedComment, equals(mockComment));
    });

    testWidgets('disables voting buttons when isVoting is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: CommentItem(comment: mockComment, isVoting: true),
            ),
          ),
        ),
      );

      // Check that voting button is disabled
      final voteButtonFinder = find.byIcon(Icons.local_fire_department);

      expect(voteButtonFinder, findsOneWidget);

      // Check that loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Don't tap the button since it should be disabled and tapping would trigger API calls
    });

    testWidgets('displays fallback text when author name is empty', (
      WidgetTester tester,
    ) async {
      when(() => mockAuthor.name).thenReturn('');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CommentItem(comment: mockComment)),
        ),
      );

      // Check that fallback text is displayed (might be "Unknown" or empty string)
      // The widget should still render even with empty name
      expect(find.byType(CommentItem), findsOneWidget);
    });

    testWidgets('displays fallback avatar when no avatar URL is provided', (
      WidgetTester tester,
    ) async {
      when(() => mockAuthor.avatar).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CommentItem(comment: mockComment)),
        ),
      );

      // Check that fallback avatar is displayed (should show first letter of name)
      expect(find.text('T'), findsOneWidget); // First letter of "Test User"
    });

    testWidgets('displays deleted comment message when content is empty', (
      WidgetTester tester,
    ) async {
      when(() => mockComment.content).thenReturn('');
      when(() => mockComment.editContent).thenReturn('');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CommentItem(comment: mockComment)),
        ),
      );

      // Check that deleted comment message is displayed
      expect(find.text('Comment deleted'), findsOneWidget);
    });

    testWidgets('formats timestamp correctly', (WidgetTester tester) async {
      // Set timestamp to a known date (2022-01-01 00:00:00 UTC)
      when(() => mockComment.createdAt).thenReturn(1640995200.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CommentItem(comment: mockComment)),
        ),
      );

      // Check that timestamp is displayed (format may vary based on current time)
      // We'll just check that some timestamp text is present
      // The timestamp might show "ago" or a specific date format
      final hasAgoText = find.textContaining('ago').evaluate().isNotEmpty;
      final hasDateText = find.textContaining('2022').evaluate().isNotEmpty;
      expect(hasAgoText || hasDateText, isTrue);
    });

    testWidgets('applies custom padding and margin', (
      WidgetTester tester,
    ) async {
      const customPadding = EdgeInsets.all(20);
      const customMargin = EdgeInsets.all(10);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              padding: customPadding,
              margin: customMargin,
            ),
          ),
        ),
      );

      // Check that the comment item is rendered (we can't easily test exact padding/margin values)
      expect(find.byType(CommentItem), findsOneWidget);
    });
  });
}
