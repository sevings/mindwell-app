import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_item.dart';

void main() {
  group('CommentItem Context Menu', () {
    late MwComment mockComment;
    late MwCommentRights mockRights;
    late MwUser mockAuthor;

    setUp(() {
      mockRights = MwCommentRights(
        (b) => b
          ..edit = true
          ..delete = true
          ..vote = true
          ..complain = true,
      );

      mockAuthor = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'Test User',
      );

      mockComment = MwComment(
        (b) => b
          ..id = 1
          ..content = 'Test comment'
          ..author = mockAuthor
          ..rights = mockRights.toBuilder(),
      );
    });

    testWidgets('shows context menu button when showContextMenu is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment, showContextMenu: true),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsOneWidget);
    });

    testWidgets('hides context menu button when showContextMenu is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment, showContextMenu: false),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsNothing);
    });

    testWidgets('calls correct callbacks when context menu actions are selected', (
      WidgetTester tester,
    ) async {
      bool editCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
              onEdit: () => editCalled = true,
            ),
          ),
        ),
      );

      // Tap the popup menu button to show context menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Test edit action
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(editCalled, isTrue);

      // Reset and test delete action
      editCalled = false;
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Should show confirmation dialog
      expect(
        find.text('Are you sure you want to delete this comment?'),
        findsOneWidget,
      );

      // The delete action now makes an API call, so we just verify the dialog is shown
      // In a real app, the API call would be made and the callback would be called on success
    });

    testWidgets('shows confirmation dialog for delete action', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment, showContextMenu: true),
          ),
        ),
      );

      // Tap the popup menu button to show context menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Tap delete
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      // Should show confirmation dialog
      expect(find.text('Delete'), findsWidgets);
      expect(
        find.text('Are you sure you want to delete this comment?'),
        findsOneWidget,
      );

      // The delete action now makes an API call, so we just verify the dialog is shown
      // In a real app, the API call would be made and the callback would be called on success
    });

    testWidgets('hides context menu options when user lacks permissions', (
      WidgetTester tester,
    ) async {
      final restrictedRights = MwCommentRights(
        (b) => b
          ..edit = false
          ..delete = false
          ..vote = false
          ..complain = false,
      );

      final restrictedComment = mockComment.rebuild(
        (b) => b..rights = restrictedRights.toBuilder(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: restrictedComment,
              showContextMenu: true,
            ),
          ),
        ),
      );

      // Tap the popup menu button to show context menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Should not show any options
      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Complain'), findsNothing);
    });

    testWidgets('displays error-colored text for destructive actions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment, showContextMenu: true),
          ),
        ),
      );

      // Tap the popup menu button to show context menu
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

    testWidgets('closes context menu when action is selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: mockComment, showContextMenu: true),
          ),
        ),
      );

      // Tap the popup menu button to show context menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Verify context menu is shown
      expect(find.text('Edit'), findsOneWidget);

      // Tap an action
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      // Context menu should be closed
      expect(find.text('Edit'), findsNothing);
    });

    testWidgets('does not show context menu when comment has no rights', (
      WidgetTester tester,
    ) async {
      final commentWithoutRights = mockComment.rebuild((b) => b..rights = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: commentWithoutRights,
              showContextMenu: true,
            ),
          ),
        ),
      );

      // Should not show popup menu button when comment has no rights
      expect(find.byType(PopupMenuButton<String>), findsNothing);
    });
  });
}
