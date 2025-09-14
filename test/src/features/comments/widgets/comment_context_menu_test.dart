import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_context_menu.dart';

void main() {
  group('CommentContextMenu', () {
    late MwComment mockComment;
    late MwCommentRights mockRights;

    setUp(() {
      mockRights = MwCommentRights((b) => b
        ..edit = true
        ..delete = true
        ..vote = true
        ..complain = true);

      mockComment = MwComment((b) => b
        ..id = 1
        ..content = 'Test comment'
        ..rights = mockRights.toBuilder());
    });

    testWidgets('displays context menu with correct options based on rights', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: mockComment,
            ),
          ),
        ),
      );

      // Find the popup menu button
      final popupButton = find.byType(PopupMenuButton<String>);
      expect(popupButton, findsOneWidget);

      // Tap the popup menu button
      await tester.tap(popupButton);
      await tester.pumpAndSettle();

      // Check that menu items are displayed
      expect(find.text('Upvote'), findsOneWidget);
      expect(find.text('Downvote'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Complain'), findsOneWidget);
    });

    testWidgets('hides options when user lacks permissions', (WidgetTester tester) async {
      final restrictedRights = MwCommentRights((b) => b
        ..edit = false
        ..delete = false
        ..vote = false
        ..complain = false);

      final restrictedComment = mockComment.rebuild((b) => b..rights = restrictedRights.toBuilder());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: restrictedComment,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Should not show any options
      expect(find.text('Upvote'), findsNothing);
      expect(find.text('Downvote'), findsNothing);
      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Complain'), findsNothing);
    });

    testWidgets('calls correct callbacks when menu items are selected', (WidgetTester tester) async {
      bool upvoteCalled = false;
      bool downvoteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: mockComment,
              onUpvote: () => upvoteCalled = true,
              onDownvote: () => downvoteCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Test upvote action
      await tester.tap(find.text('Upvote'));
      await tester.pumpAndSettle();
      expect(upvoteCalled, isTrue);

      // Reset and test downvote action
      upvoteCalled = false;
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Downvote'));
      await tester.pumpAndSettle();
      expect(downvoteCalled, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: mockComment,
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsNothing);
    });

    testWidgets('shows confirmation dialog for delete action', (WidgetTester tester) async {
      bool deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: mockComment,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Should show confirmation dialog
      expect(find.text('Delete'), findsWidgets);
      expect(find.text('Are you sure you want to delete this comment?'), findsOneWidget);

      // Confirm deletion
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();

      expect(deleteCalled, isTrue);
    });

    testWidgets('returns empty widget when comment has no rights', (WidgetTester tester) async {
      final commentWithoutRights = mockComment.rebuild((b) => b..rights = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: commentWithoutRights,
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsNothing);
    });

    testWidgets('displays error-colored text for destructive actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentContextMenu(
              comment: mockComment,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Find delete and complain menu items
      final deleteItem = find.text('Delete');
      final complainItem = find.text('Complain');

      expect(deleteItem, findsOneWidget);
      expect(complainItem, findsOneWidget);

      // Check that the text has error color
      final deleteText = tester.widget<Text>(deleteItem);
      final complainText = tester.widget<Text>(complainItem);

      expect(deleteText.style?.color, isNotNull);
      expect(complainText.style?.color, isNotNull);
    });
  });
}
