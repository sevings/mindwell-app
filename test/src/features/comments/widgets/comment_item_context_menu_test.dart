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
      mockRights = MwCommentRights((b) => b
        ..edit = true
        ..delete = true
        ..vote = true
        ..complain = true);

      mockAuthor = $MwUser((b) => b
        ..id = 1
        ..name = 'Test User');

      mockComment = MwComment((b) => b
        ..id = 1
        ..content = 'Test comment'
        ..author = mockAuthor
        ..rights = mockRights.toBuilder());
    });

    testWidgets('shows context menu button when showContextMenu is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsOneWidget);
    });

    testWidgets('hides context menu button when showContextMenu is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: false,
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsNothing);
    });

    testWidgets('shows context menu on long press when showContextMenu is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
            ),
          ),
        ),
      );

      // Find the main InkWell (the one with onLongPress) and perform long press
      final inkWells = find.byType(InkWell);
      expect(inkWells, findsWidgets);

      // Find the InkWell that has onLongPress by checking its properties
      InkWell? mainInkWell;
      for (int i = 0; i < inkWells.evaluate().length; i++) {
        final widget = tester.widget<InkWell>(inkWells.at(i));
        if (widget.onLongPress != null) {
          mainInkWell = widget;
          break;
        }
      }
      
      expect(mainInkWell, isNotNull);

      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();

      // Should show bottom sheet with context menu
      expect(find.text('Comment Actions'), findsOneWidget);
      expect(find.text('Upvote'), findsOneWidget);
      expect(find.text('Downvote'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Complain'), findsOneWidget);
    });

    testWidgets('calls correct callbacks when context menu actions are selected', (WidgetTester tester) async {
      bool editCalled = false;
      bool deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
              onEdit: () => editCalled = true,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      // Long press to show context menu
      final inkWells = find.byType(InkWell);
      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();

      // Test edit action
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(editCalled, isTrue);

      // Reset and test delete action
      editCalled = false;
      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      
      // Should show confirmation dialog
      expect(find.text('Are you sure you want to delete this comment?'), findsOneWidget);
      
      // Confirm deletion
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();
      expect(deleteCalled, isTrue);
    });

    testWidgets('shows confirmation dialog for delete action', (WidgetTester tester) async {
      bool deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      // Long press to show context menu
      final inkWells = find.byType(InkWell);
      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();

      // Tap delete
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

    testWidgets('hides context menu options when user lacks permissions', (WidgetTester tester) async {
      final restrictedRights = MwCommentRights((b) => b
        ..edit = false
        ..delete = false
        ..vote = false
        ..complain = false);

      final restrictedComment = mockComment.rebuild((b) => b..rights = restrictedRights.toBuilder());

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

      // Long press to show context menu
      final inkWells = find.byType(InkWell);
      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();

      // Should not show any options
      expect(find.text('Upvote'), findsNothing);
      expect(find.text('Downvote'), findsNothing);
      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Complain'), findsNothing);
    });

    testWidgets('displays error-colored text for destructive actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
            ),
          ),
        ),
      );

      // Long press to show context menu
      final inkWells = find.byType(InkWell);
      await tester.longPress(inkWells.first);
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

    testWidgets('closes context menu when action is selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommentItem(
              comment: mockComment,
              showContextMenu: true,
            ),
          ),
        ),
      );

      // Long press to show context menu
      final inkWells = find.byType(InkWell);
      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();

      // Verify context menu is shown
      expect(find.text('Comment Actions'), findsOneWidget);

      // Tap an action
      await tester.tap(find.text('Upvote'));
      await tester.pumpAndSettle();

      // Context menu should be closed
      expect(find.text('Comment Actions'), findsNothing);
    });

    testWidgets('does not show context menu when comment has no rights', (WidgetTester tester) async {
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

      // Long press should not show context menu
      final inkWells = find.byType(InkWell);
      await tester.longPress(inkWells.first);
      await tester.pumpAndSettle();

      expect(find.text('Comment Actions'), findsNothing);
    });
  });
}
