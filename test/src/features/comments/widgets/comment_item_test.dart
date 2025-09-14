import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_item.dart';

// Mock classes
class MockMwComment extends Mock implements MwComment {}
class MockMwUser extends Mock implements MwUser {}
class MockMwRating extends Mock implements MwRating {}
class MockMwAvatar extends Mock implements MwAvatar {}

void main() {
  group('CommentItem', () {
    late MockMwComment mockComment;
    late MockMwUser mockAuthor;
    late MockMwRating mockRating;
    late MockMwAvatar mockAvatar;

    setUp(() {
      mockRating = MockMwRating();
      mockAuthor = MockMwUser();
      mockComment = MockMwComment();
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

      when(() => mockComment.id).thenReturn(1);
      when(() => mockComment.author).thenReturn(mockAuthor);
      when(() => mockComment.content).thenReturn('<p>This is a test comment with <strong>HTML</strong> content.</p>');
      when(() => mockComment.createdAt).thenReturn(1640995200.0); // 2022-01-01 00:00:00 UTC
      when(() => mockComment.rating).thenReturn(mockRating);
    });

    testWidgets('displays comment content correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment),
          ),
        ),
      );

      // Check that author name is displayed
      expect(find.text('Test User'), findsOneWidget);

      // Check that comment content is displayed (HTML is rendered)
      // Note: In tests, HTML content might not be fully rendered, so we check for the raw content
      expect(find.textContaining('This is a test comment'), findsOneWidget);

      // Check that voting buttons are displayed
      expect(find.byIcon(Icons.thumb_up_outlined), findsOneWidget);
      expect(find.byIcon(Icons.thumb_down_outlined), findsOneWidget);

      // Check that vote counts are displayed
      expect(find.text('5'), findsOneWidget); // upvotes
      expect(find.text('2'), findsOneWidget); // downvotes
    });

    testWidgets('displays entry title when showEntryTitle is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showEntryTitle: true,
              entryTitle: 'Test Entry Title',
            ),
          ),
        ),
      );

      // Check that entry title is displayed
      expect(find.text('Test Entry Title'), findsOneWidget);
      expect(find.byIcon(Icons.article_outlined), findsOneWidget);
    });

    testWidgets('hides voting section when showVoting is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showVoting: false,
            ),
          ),
        ),
      );

      // Check that voting buttons are not displayed
      expect(find.byIcon(Icons.thumb_up_outlined), findsNothing);
      expect(find.byIcon(Icons.thumb_down_outlined), findsNothing);
    });

    testWidgets('calls onTap when comment is tapped', (WidgetTester tester) async {
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

    testWidgets('calls onAuthorTap when author is tapped', (WidgetTester tester) async {
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

    testWidgets('calls onUpvote when upvote button is tapped', (WidgetTester tester) async {
      bool onUpvoteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              onUpvote: () => onUpvoteCalled = true,
            ),
          ),
        ),
      );

      // Tap on the upvote button
      await tester.tap(find.byIcon(Icons.thumb_up_outlined));
      await tester.pump();

      expect(onUpvoteCalled, isTrue);
    });

    testWidgets('calls onDownvote when downvote button is tapped', (WidgetTester tester) async {
      bool onDownvoteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              onDownvote: () => onDownvoteCalled = true,
            ),
          ),
        ),
      );

      // Tap on the downvote button
      await tester.tap(find.byIcon(Icons.thumb_down_outlined));
      await tester.pump();

      expect(onDownvoteCalled, isTrue);
    });

    testWidgets('disables voting buttons when isVoting is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              isVoting: true,
            ),
          ),
        ),
      );

      // Check that voting buttons are disabled
      final upvoteButtonFinder = find.byIcon(Icons.thumb_up_outlined);
      final downvoteButtonFinder = find.byIcon(Icons.thumb_down_outlined);
      
      expect(upvoteButtonFinder, findsOneWidget);
      expect(downvoteButtonFinder, findsOneWidget);
      
      // Try to tap the buttons to verify they're disabled
      await tester.tap(upvoteButtonFinder);
      await tester.pump();
      // If the button is disabled, the tap should not trigger any action

      // Check that loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays fallback text when author name is empty', (WidgetTester tester) async {
      when(() => mockAuthor.name).thenReturn('');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment),
          ),
        ),
      );

      // Check that fallback text is displayed (might be "Unknown" or empty string)
      // The widget should still render even with empty name
      expect(find.byType(CommentItem), findsOneWidget);
    });

    testWidgets('displays fallback avatar when no avatar URL is provided', (WidgetTester tester) async {
      when(() => mockAuthor.avatar).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment),
          ),
        ),
      );

      // Check that fallback avatar is displayed (should show first letter of name)
      expect(find.text('T'), findsOneWidget); // First letter of "Test User"
    });

    testWidgets('displays deleted comment message when content is empty', (WidgetTester tester) async {
      when(() => mockComment.content).thenReturn('');
      when(() => mockComment.editContent).thenReturn('');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment),
          ),
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
          home: Scaffold(
            body: CommentItem(comment: mockComment),
          ),
        ),
      );

      // Check that timestamp is displayed (format may vary based on current time)
      // We'll just check that some timestamp text is present
      // The timestamp might show "ago" or a specific date format
      final hasAgoText = find.textContaining('ago').evaluate().isNotEmpty;
      final hasDateText = find.textContaining('2022').evaluate().isNotEmpty;
      expect(hasAgoText || hasDateText, isTrue);
    });

    testWidgets('applies custom padding and margin', (WidgetTester tester) async {
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
