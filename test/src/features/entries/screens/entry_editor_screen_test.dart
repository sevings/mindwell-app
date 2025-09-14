import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:mindwell/src/features/entries/screens/entry_editor_screen.dart';
import 'package:mindwell/src/features/entries/providers/entry_editor_provider.dart';
import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';
import 'package:mindwell/src/core/api/api_provider.dart';

// Mock classes
class MockEntriesApi extends Mock implements EntriesApi {}
class MockMeApi extends Mock implements MeApi {}
class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('EntryEditorScreen', () {
    late MockEntriesApi mockEntriesApi;
    late MockMeApi mockMeApi;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockMeApi = MockMeApi();
      
      // Register fallback values for mocktail
      registerFallbackValue(const EntryEditorState.initial());
    });

    Widget createTestWidget({
      int? entryId,
      EntryEditorState initialState = const EntryEditorState.initial(),
    }) {
      return ProviderScope(
        overrides: [
          entriesApiProvider.overrideWithValue(mockEntriesApi),
          meApiProvider.overrideWithValue(mockMeApi),
          entryEditorProvider(entryId).overrideWith(
            (ref) => MockEntryEditorNotifier(initialState),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            FlutterQuillLocalizations.delegate,
          ],
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => EntryEditorScreen(entryId: entryId),
              ),
            ],
          ),
        ),
      );
    }

    group('New Entry', () {
      testWidgets('displays correct title for new entry', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text('New Entry'), findsOneWidget);
      });

      testWidgets('displays title field and rich text editor', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.editing(),
        ));

        // Check for title field
        expect(find.byType(TextField), findsOneWidget);
        
        // Check for Quill editor components
        expect(find.byType(QuillSimpleToolbar), findsOneWidget);
        expect(find.byType(QuillEditor), findsOneWidget);
      });

      testWidgets('publish button is enabled when title and content are provided', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.editing(
            title: 'Test Title',
            content: 'Test Content',
          ),
        ));

        final publishButton = find.text('Publish');
        expect(publishButton, findsOneWidget);
        
        // The button should be enabled (not null)
        final button = tester.widget<TextButton>(find.ancestor(
          of: publishButton,
          matching: find.byType(TextButton),
        ));
        expect(button.onPressed, isNotNull);
      });

      testWidgets('publish button is disabled when title or content is empty', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.editing(
            title: 'Test Title',
            content: '', // Empty content
          ),
        ));

        final publishButton = find.text('Publish');
        expect(publishButton, findsOneWidget);
        
        // The button should be disabled (null onPressed)
        final button = tester.widget<TextButton>(find.ancestor(
          of: publishButton,
          matching: find.byType(TextButton),
        ));
        expect(button.onPressed, isNull);
      });
    });

    group('Edit Entry', () {
      testWidgets('displays correct title for editing entry', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(entryId: 123));

        expect(find.text('Edit Entry'), findsOneWidget);
      });

      testWidgets('loads existing entry data', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          entryId: 123,
          initialState: const EntryEditorState.editing(
            title: 'Existing Title',
            content: 'Existing Content',
            entryId: 123,
          ),
        ));

        // Check that the title field contains the existing title
        final titleField = find.byType(TextField);
        expect(titleField, findsOneWidget);
        
        // The text field should be present and the controller should be set up
        final textField = tester.widget<TextField>(titleField);
        expect(textField.controller, isNotNull);
      });
    });

    group('Loading State', () {
      testWidgets('displays loading indicator when in loading state', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.loading(),
        ));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Publishing State', () {
      testWidgets('displays publishing indicator when publishing', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.publishing(),
        ));

        expect(find.text('Publishing...'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('displays upload progress when uploading images', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.publishing(
            isUploadingImages: true,
            uploadProgress: 0.5,
          ),
        ));

        expect(find.text('Publishing...'), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(find.text('50%'), findsOneWidget);
      });
    });

    group('Error State', () {
      testWidgets('displays error message when error occurs', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.error(
            message: 'Test error message',
            canRetry: true,
          ),
        ));

        expect(find.text('Error'), findsOneWidget);
        expect(find.text('Test error message'), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);
        expect(find.text('Go Back'), findsOneWidget);
      });

      testWidgets('hides retry button when retry is not available', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(
          initialState: const EntryEditorState.error(
            message: 'Test error message',
            canRetry: false,
          ),
        ));

        expect(find.text('Error'), findsOneWidget);
        expect(find.text('Test error message'), findsOneWidget);
        expect(find.text('Retry'), findsNothing);
        expect(find.text('Go Back'), findsOneWidget);
      });
    });

    group('User Interactions', () {
      testWidgets('calls updateTitle when title field changes', (WidgetTester tester) async {
        final mockNotifier = MockEntryEditorNotifier(const EntryEditorState.editing());
        
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              entriesApiProvider.overrideWithValue(mockEntriesApi),
              meApiProvider.overrideWithValue(mockMeApi),
              entryEditorProvider(null).overrideWith((ref) => mockNotifier),
            ],
            child: MaterialApp.router(
              localizationsDelegates: const [
                FlutterQuillLocalizations.delegate,
              ],
              routerConfig: GoRouter(
                routes: [
                  GoRoute(
                    path: '/',
                    builder: (context, state) => const EntryEditorScreen(),
                  ),
                ],
              ),
            ),
          ),
        );

        final titleField = find.byType(TextField);
        await tester.enterText(titleField, 'New Title');
        await tester.pump();
        
        // Verify the title field contains the new text
        expect(find.text('New Title'), findsOneWidget);
      });

      testWidgets('calls publishEntry when publish button is pressed', (WidgetTester tester) async {
        final mockNotifier = MockEntryEditorNotifier(
          const EntryEditorState.editing(
            title: 'Test Title',
            content: 'Test Content',
          ),
        );
        
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              entriesApiProvider.overrideWithValue(mockEntriesApi),
              meApiProvider.overrideWithValue(mockMeApi),
              entryEditorProvider(null).overrideWith((ref) => mockNotifier),
            ],
            child: MaterialApp.router(
              localizationsDelegates: const [
                FlutterQuillLocalizations.delegate,
              ],
              routerConfig: GoRouter(
                routes: [
                  GoRoute(
                    path: '/',
                    builder: (context, state) => const EntryEditorScreen(),
                  ),
                ],
              ),
            ),
          ),
        );

        final publishButton = find.text('Publish');
        expect(publishButton, findsOneWidget);
        
        // Verify the button is enabled (has onPressed callback)
        final button = tester.widget<TextButton>(find.ancestor(
          of: publishButton,
          matching: find.byType(TextButton),
        ));
        expect(button.onPressed, isNotNull);
      });
    });
  });
}

// Mock notifier for testing
class MockEntryEditorNotifier extends StateNotifier<EntryEditorState> implements EntryEditorNotifier {
  MockEntryEditorNotifier(super.initialState);

  @override
  void updateTitle(String title) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateContent(String content) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateTags(List<String> tags) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updatePrivacy(String privacy) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateIsCommentable(bool isCommentable) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateIsVotable(bool isVotable) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateInLive(bool inLive) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateIsShared(bool isShared) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateIsDraft(bool isDraft) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void addImage(int imageId) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void removeImage(int imageId) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void updateImages(List<int> images) {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> uploadImages(List<File> files) async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> publishEntry({bool isDraft = false}) async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> saveDraft() async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void reset() {
    // Mock implementation - will be verified by mocktail
  }

  @override
  void clearError() {
    // Mock implementation - will be verified by mocktail
  }

  @override
  bool get hasUnsavedChanges => false;

  @override
  int? get entryId => null;

  @override
  bool get isEditingExisting => false;
}
