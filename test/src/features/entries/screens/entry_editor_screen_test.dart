import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:mindwell/src/features/entries/screens/entry_editor_screen.dart';
import 'package:mindwell/src/features/entries/providers/entry_editor_provider.dart';
import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';
import 'package:mindwell/l10n/app_localizations.dart';

class MockEntryEditorNotifier extends StateNotifier<EntryEditorState> implements EntryEditorNotifier {
  MockEntryEditorNotifier() : super(const EntryEditorState.initial());
  
  @override
  Future<void> updatePrivacy(String privacy) async {}
  
  @override
  Future<void> updateIsCommentable(bool isCommentable) async {}
  
  @override
  Future<void> updateIsVotable(bool isVotable) async {}
  
  @override
  Future<void> updateInLive(bool inLive) async {}
  
  @override
  Future<void> updateIsShared(bool isShared) async {}
  
  @override
  Future<void> updateIsDraft(bool isDraft) async {}
  
  @override
  void resetFromPreview() {}
  
  @override
  Future<void> updateIsAnonymous(bool isAnonymous) async {}
  
  @override
  Future<void> updateTitle(String title) async {}
  
  @override
  Future<void> updateContent(String content) async {}
  
  @override
  Future<void> updateTags(List<String> tags) async {}
  
  @override
  Future<void> addImage(int imageId) async {}
  
  @override
  Future<void> removeImage(int imageId) async {}
  
  @override
  Future<void> updateImages(List<int> images) async {}
  
  @override
  Future<void> uploadImages(List<File> files) async {}
  
  @override
  Future<void> publishEntry({bool isDraft = false}) async {}
  
  @override
  Future<void> saveDraft() async {}
  
  @override
  Future<void> previewEntry() async {}
  
  @override
  Future<void> retryLastOperation() async {}
  
  @override
  void reset() {}
  
  @override
  void clearError() {}
  
  @override
  int? get entryId => null;
  
  @override
  bool get hasUnsavedChanges => false;
  
  @override
  bool get isEditingExisting => false;
}

void main() {
  group('EntryEditorScreen', () {
    late MockEntryEditorNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockEntryEditorNotifier();
    });

    Widget createWidget({
      int? entryId,
      String? themeName,
    }) {
      return ProviderScope(
        overrides: [
          entryEditorProvider((entryId: entryId, themeName: themeName)).overrideWith((ref) => mockNotifier),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: EntryEditorScreen(
            entryId: entryId,
            themeName: themeName,
          ),
        ),
      );
    }

    testWidgets('displays correct title for new personal entry', (tester) async {
      // Set the state to editing
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Test Title',
        content: 'Test Content',
        isAnonymous: false,
      );

      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Check that the app bar shows "New Entry"
      expect(find.text('New Entry'), findsOneWidget);
    });

    testWidgets('displays correct title for new theme entry', (tester) async {
      // Set the state to editing
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Test Theme Entry',
        content: 'Test Theme Content',
        themeName: 'test-theme',
        isAnonymous: false,
      );

      await tester.pumpWidget(createWidget(themeName: 'test-theme'));
      await tester.pumpAndSettle();

      // Check that the app bar shows "New Entry" (same as personal entry)
      expect(find.text('New Entry'), findsOneWidget);
    });

    testWidgets('displays correct title for editing existing entry', (tester) async {
      // Set the state to editing
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Existing Entry',
        content: 'Existing Content',
        entryId: 123,
        isAnonymous: false,
      );

      await tester.pumpWidget(createWidget(entryId: 123));
      await tester.pumpAndSettle();

      // Check that the app bar shows "Edit Entry"
      expect(find.text('Edit Entry'), findsOneWidget);
    });

    testWidgets('shows settings button', (tester) async {
      // Set the state to editing
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Test Title',
        content: 'Test Content',
        isAnonymous: false,
      );

      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Check that settings button is present
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('shows preview button', (tester) async {
      // Set the state to editing
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Test Title',
        content: 'Test Content',
        isAnonymous: false,
      );

      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Check that preview button is present
      expect(find.byIcon(Icons.preview), findsOneWidget);
    });

    testWidgets('shows publish button', (tester) async {
      // Set the state to editing
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Test Title',
        content: 'Test Content',
        isAnonymous: false,
      );

      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Check that publish button is present
      expect(find.text('Publish'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      // Set the state to loading
      mockNotifier.state = const EntryEditorState.loading();

      await tester.pumpWidget(createWidget());
      await tester.pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

      // Check that loading indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error state', (tester) async {
      // Set the state to error
      mockNotifier.state = const EntryEditorState.error(
        message: 'Test error message',
        canRetry: true,
      );

      await tester.pumpWidget(createWidget());
      await tester.pump();

      // Check that error message is shown
      expect(find.text('Test error message'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.text('Go Back'), findsOneWidget);
    });

    // Note: Success state test is skipped because we can't easily mock MwEntry

    testWidgets('handles theme entry with anonymous setting', (tester) async {
      // Set the state to editing for theme entry
      mockNotifier.state = const EntryEditorState.editing(
        title: 'Test Theme Entry',
        content: 'Test Theme Content',
        themeName: 'test-theme',
        isAnonymous: true,
      );

      await tester.pumpWidget(createWidget(themeName: 'test-theme'));
      await tester.pumpAndSettle();

      // The screen should render without errors
      expect(find.text('New Entry'), findsOneWidget);
    });
  });
}
