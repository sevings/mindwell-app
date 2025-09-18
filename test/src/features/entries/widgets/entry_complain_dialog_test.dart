import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mindwell/src/features/entries/widgets/entry_complain_dialog.dart';

// Mock classes
class MockEntriesApi extends Mock implements EntriesApi {}

class MockCommentsApi extends Mock implements CommentsApi {}

class MockWatchingsApi extends Mock implements WatchingsApi {}

void main() {
  group('EntryComplainDialog', () {
    late MwEntry mockEntry;

    setUp(() {
      mockEntry = MwEntry(
        (b) => b
          ..id = 123
          ..title = 'Test Entry'
          ..rights = MwEntryRights((b) => b..complain = true).toBuilder(),
      );
    });

    testWidgets('displays correct title and content', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryComplainDialog(
                entry: mockEntry,
                onComplaintSubmitted: () {},
              ),
            ),
          ),
        ),
      );

      // Verify dialog title
      expect(find.text('Complain'), findsOneWidget);
      expect(find.byIcon(Icons.report_outlined), findsOneWidget);

      // Verify dialog content
      expect(
        find.text('Report this entry for inappropriate content.'),
        findsOneWidget,
      );
      expect(find.text('Additional details (optional)'), findsOneWidget);
      expect(find.text('Please describe the issue...'), findsOneWidget);
    });

    testWidgets('has correct action buttons', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryComplainDialog(
                entry: mockEntry,
                onComplaintSubmitted: () {},
              ),
            ),
          ),
        ),
      );

      // Verify action buttons
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Submit Complaint'), findsOneWidget);
    });

    testWidgets('allows text input in the text field', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryComplainDialog(
                entry: mockEntry,
                onComplaintSubmitted: () {},
              ),
            ),
          ),
        ),
      );

      // Find the text field and enter text
      final textField = find.byType(TextFormField);
      expect(textField, findsOneWidget);

      await tester.enterText(
        textField,
        'This entry contains inappropriate content',
      );
      await tester.pump();

      // Verify text was entered
      expect(
        find.text('This entry contains inappropriate content'),
        findsOneWidget,
      );
    });

    testWidgets('has submit button with correct styling', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: EntryComplainDialog(
                entry: mockEntry,
                onComplaintSubmitted: () {},
              ),
            ),
          ),
        ),
      );

      // Verify submit button is present and has correct styling
      final submitButton = find.text('Submit Complaint');
      expect(submitButton, findsOneWidget);

      final elevatedButton = tester.widget<ElevatedButton>(
        find.ancestor(of: submitButton, matching: find.byType(ElevatedButton)),
      );
      expect(elevatedButton.style?.backgroundColor?.resolve({}), Colors.red);
    });

    testWidgets('can be dismissed with cancel button', (tester) async {
      bool dialogDismissed = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => EntryComplainDialog(
                        entry: mockEntry,
                        onComplaintSubmitted: () {},
                      ),
                    ).then((_) => dialogDismissed = true);
                  },
                  child: const Text('Show Dialog'),
                ),
              ),
            ),
          ),
        ),
      );

      // Show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.text('Complain'), findsOneWidget);

      // Tap cancel
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Complain'), findsNothing);
      expect(dialogDismissed, isTrue);
    });
  });
}
