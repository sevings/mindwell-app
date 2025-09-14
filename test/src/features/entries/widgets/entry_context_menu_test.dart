import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/widgets/entry_context_menu.dart';

void main() {
  group('EntryContextMenu', () {
    late MwEntry mockEntry;
    late MwEntryRights mockRights;

    setUp(() {
      mockRights = MwEntryRights((b) => b
        ..edit = true
        ..delete = true
        ..pin = true
        ..comment = true
        ..vote = true
        ..complain = true);

      mockEntry = MwEntry((b) => b
        ..id = 1
        ..title = 'Test Entry'
        ..isPinned = false
        ..isWatching = false
        ..rights = mockRights.toBuilder());
    });

    testWidgets('displays context menu with correct options based on rights', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
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
      expect(find.text('Pin'), findsOneWidget);
      expect(find.text('Follow'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Copy Link'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Complain'), findsOneWidget);
    });

    testWidgets('shows unpin option when entry is pinned', (WidgetTester tester) async {
      final pinnedEntry = mockEntry.rebuild((b) => b..isPinned = true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: pinnedEntry,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      expect(find.text('Unpin'), findsOneWidget);
      expect(find.text('Pin'), findsNothing);
    });

    testWidgets('shows unfollow option when entry is being watched', (WidgetTester tester) async {
      final watchedEntry = mockEntry.rebuild((b) => b..isWatching = true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: watchedEntry,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      expect(find.text('Unfollow'), findsOneWidget);
      expect(find.text('Follow'), findsNothing);
    });

    testWidgets('hides options when user lacks permissions', (WidgetTester tester) async {
      final restrictedRights = MwEntryRights((b) => b
        ..edit = false
        ..delete = false
        ..pin = false
        ..comment = true
        ..vote = true
        ..complain = false);

      final restrictedEntry = mockEntry.rebuild((b) => b..rights = restrictedRights.toBuilder());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: restrictedEntry,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Should not show restricted options
      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Pin'), findsNothing);
      expect(find.text('Complain'), findsNothing);

      // Should still show allowed options
      expect(find.text('Follow'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Copy Link'), findsOneWidget);
    });

    testWidgets('calls correct callbacks when menu items are selected', (WidgetTester tester) async {
      bool pinCalled = false;
      bool followCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
              onPin: () => pinCalled = true,
              onFollow: () => followCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Test pin action
      await tester.tap(find.text('Pin'));
      await tester.pumpAndSettle();
      expect(pinCalled, isTrue);

      // Reset and test follow action
      pinCalled = false;
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Follow'));
      await tester.pumpAndSettle();
      expect(followCalled, isTrue);
    });

    testWidgets('shows loading indicator when isLoading is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
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
            body: EntryContextMenu(
              entry: mockEntry,
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
      expect(find.text('Are you sure you want to delete this entry?'), findsOneWidget);

      // Confirm deletion
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();

      expect(deleteCalled, isTrue);
    });

    testWidgets('copies link to clipboard when copy link is selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Copy Link'));
      await tester.pumpAndSettle();

      // Should show success message
      expect(find.text('Link copied to clipboard'), findsOneWidget);
    });

    testWidgets('returns empty widget when entry has no rights', (WidgetTester tester) async {
      final entryWithoutRights = mockEntry.rebuild((b) => b..rights = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: entryWithoutRights,
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsNothing);
    });
  });
}
