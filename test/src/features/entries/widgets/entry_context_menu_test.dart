import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/widgets/entry_context_menu.dart';

void main() {
  group('EntryContextMenu', () {
    late MwEntry mockEntry;

    setUp(() {
      mockEntry = MwEntry(
        (b) => b
          ..id = 123
          ..title = 'Test Entry'
          ..isPinned = false
          ..isWatching = false
          ..rights = MwEntryRights(
            (b) => b
              ..pin = true
              ..edit = true
              ..delete = true
              ..complain = true,
          ).toBuilder(),
      );
    });

    testWidgets('shows correct menu items based on entry rights', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
              onPin: () {},
              onUnpin: () {},
              onFollow: () {},
              onUnfollow: () {},
              onEdit: () {},
              onDelete: () {},
              onComplain: () {},
              onShare: () {},
              onCopyLink: () {},
            ),
          ),
        ),
      );

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Verify that all expected menu items are present
      expect(find.text('Pin'), findsOneWidget);
      expect(find.text('Follow'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Copy Link'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      expect(find.text('Complain'), findsOneWidget);
    });

    testWidgets('shows correct menu items when entry is pinned and watched', (
      tester,
    ) async {
      final pinnedWatchedEntry = mockEntry.rebuild(
        (b) => b
          ..isPinned = true
          ..isWatching = true,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: pinnedWatchedEntry,
              onPin: () {},
              onUnpin: () {},
              onFollow: () {},
              onUnfollow: () {},
              onEdit: () {},
              onDelete: () {},
              onComplain: () {},
              onShare: () {},
              onCopyLink: () {},
            ),
          ),
        ),
      );

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Verify that the menu shows "Unpin" and "Unfollow"
      expect(find.text('Unpin'), findsOneWidget);
      expect(find.text('Unfollow'), findsOneWidget);
    });

    testWidgets('copy link action is available', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
              onPin: () {},
              onUnpin: () {},
              onFollow: () {},
              onUnfollow: () {},
              onEdit: () {},
              onDelete: () {},
              onComplain: () {},
              onShare: () {},
              onCopyLink: () {},
            ),
          ),
        ),
      );

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Verify copy link option is available
      expect(find.text('Copy Link'), findsOneWidget);
    });

    testWidgets('hides menu items when user lacks permissions', (tester) async {
      final restrictedEntry = MwEntry(
        (b) => b
          ..id = 123
          ..title = 'Test Entry'
          ..isPinned = false
          ..isWatching = false
          ..rights = MwEntryRights(
            (b) => b
              ..pin = false
              ..edit = false
              ..delete = false
              ..complain = false,
          ).toBuilder(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: restrictedEntry,
              onPin: () {},
              onUnpin: () {},
              onFollow: () {},
              onUnfollow: () {},
              onEdit: () {},
              onDelete: () {},
              onComplain: () {},
              onShare: () {},
              onCopyLink: () {},
            ),
          ),
        ),
      );

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      // Verify that restricted items are not shown
      expect(find.text('Pin'), findsNothing);
      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Complain'), findsNothing);

      // But public items should still be shown
      expect(find.text('Follow'), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);
      expect(find.text('Copy Link'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryContextMenu(
              entry: mockEntry,
              isLoading: true,
              onPin: () {},
              onUnpin: () {},
              onFollow: () {},
              onUnfollow: () {},
              onEdit: () {},
              onDelete: () {},
              onComplain: () {},
              onShare: () {},
              onCopyLink: () {},
            ),
          ),
        ),
      );

      // Verify that loading indicator is shown instead of menu icon
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsNothing);
    });
  });
}
