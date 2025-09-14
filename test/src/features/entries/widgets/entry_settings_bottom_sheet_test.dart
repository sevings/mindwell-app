import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mindwell/src/features/entries/widgets/entry_settings_bottom_sheet.dart';
import 'package:mindwell/src/features/entries/providers/entry_editor_provider.dart';
import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';
import 'package:mindwell/l10n/app_localizations.dart';

class MockEntryEditorNotifier extends Mock implements EntryEditorNotifier {}

void main() {
  group('EntrySettingsBottomSheet', () {
    late MockEntryEditorNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockEntryEditorNotifier();
      
      // Setup default state
      when(() => mockNotifier.state).thenReturn(
        const EntryEditorState.editing(
          privacy: 'all',
          isCommentable: true,
          isVotable: true,
          inLive: true,
          isShared: false,
          isDraft: false,
        ),
      );
      
      // Setup default method calls
      when(() => mockNotifier.updatePrivacy(any())).thenReturn(null);
      when(() => mockNotifier.updateIsCommentable(any())).thenReturn(null);
      when(() => mockNotifier.updateIsVotable(any())).thenReturn(null);
      when(() => mockNotifier.updateInLive(any())).thenReturn(null);
      when(() => mockNotifier.updateIsShared(any())).thenReturn(null);
      when(() => mockNotifier.updateIsDraft(any())).thenReturn(null);
    });

    Widget createWidget({
      int? entryId,
      bool isThemeEntry = false,
    }) {
      return ProviderScope(
        overrides: [
          entryEditorProvider(entryId).overrideWith((ref) => mockNotifier),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: EntrySettingsBottomSheet(
              entryId: entryId,
              isThemeEntry: isThemeEntry,
            ),
          ),
        ),
      );
    }

    testWidgets('displays all settings sections for regular entry', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      // Check that all main sections are present
      expect(find.text('Entry Settings'), findsOneWidget);
      expect(find.text('Privacy Level'), findsOneWidget);
      expect(find.text('Comments & Voting'), findsOneWidget);
      expect(find.text('Visibility & Sharing'), findsOneWidget);
      
      // Anonymous section should not be present for regular entries
      expect(find.text('Posting Options'), findsNothing);
    });

    testWidgets('displays anonymous section for theme entry', (tester) async {
      await tester.pumpWidget(createWidget(isThemeEntry: true));
      await tester.pumpAndSettle();

      // Check that anonymous section is present for theme entries
      expect(find.text('Posting Options'), findsOneWidget);
      expect(find.text('Post Anonymously'), findsOneWidget);
    });

    testWidgets('calls updatePrivacy when privacy option is tapped', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      // Tap on private option
      await tester.tap(find.text('Private'));
      await tester.pump();

      // Verify that updatePrivacy was called
      verify(() => mockNotifier.updatePrivacy('private')).called(1);
    });

    testWidgets('calls updateIsCommentable when comment switch is toggled', (tester) async {
      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      // Find and tap the comment switch
      final commentSwitch = find.byKey(const ValueKey('allowComments'));
      await tester.tap(commentSwitch);
      await tester.pump();

      // Verify that updateIsCommentable was called
      verify(() => mockNotifier.updateIsCommentable(false)).called(1);
    });

    testWidgets('handles non-editing states gracefully', (tester) async {
      when(() => mockNotifier.state).thenReturn(
        const EntryEditorState.loading(),
      );

      await tester.pumpWidget(createWidget());
      await tester.pumpAndSettle();

      // Should not display any settings content
      expect(find.text('Entry Settings'), findsNothing);
      expect(find.text('Privacy Level'), findsNothing);
    });
  });

  group('showEntrySettingsBottomSheet', () {
    testWidgets('shows bottom sheet with correct configuration', (tester) async {
      final mockNotifier = MockEntryEditorNotifier();
      when(() => mockNotifier.state).thenReturn(
        const EntryEditorState.editing(
          privacy: 'all',
          isCommentable: true,
          isVotable: true,
          inLive: true,
          isShared: false,
          isDraft: false,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entryEditorProvider(null).overrideWith((ref) => mockNotifier),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(
              body: SizedBox(),
            ),
          ),
        ),
      );

      // Show the bottom sheet
      showEntrySettingsBottomSheet(
        context: tester.element(find.byType(SizedBox)),
        entryId: null,
        isThemeEntry: false,
      );

      await tester.pumpAndSettle();

      // Check that bottom sheet is displayed
      expect(find.byType(EntrySettingsBottomSheet), findsOneWidget);
    });
  });
}
