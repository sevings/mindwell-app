import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';
import 'package:mindwell/src/features/entries/providers/entry_editor_provider.dart';
import 'package:mindwell/src/core/services/image_upload_service.dart';

class MockEntriesApi extends Mock implements EntriesApi {}
class MockMeApi extends Mock implements MeApi {}
class MockMwEntry extends Mock implements MwEntry {}
class MockImageUploadService extends Mock implements ImageUploadService {}

void main() {
  group('EntryEditorNotifier', () {
    late MockEntriesApi mockEntriesApi;
    late MockMeApi mockMeApi;
    late MockImageUploadService mockImageUploadService;
    late EntryEditorNotifier notifier;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockMeApi = MockMeApi();
      mockImageUploadService = MockImageUploadService();
    });

    group('New Entry Creation', () {
      setUp(() {
        notifier = EntryEditorNotifier(
          entryId: null,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          imageUploadService: mockImageUploadService,
        );
      });

      test('should initialize with empty editing state for new entry', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        
        expect(notifier.state, isA<EntryEditorState>());
        
        // Check that we're in editing state
        final isEditing = notifier.state.maybeWhen(
          editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => true,
          orElse: () => false,
        );
        expect(isEditing, isTrue);
      });

      test('should update title and mark as having unsaved changes', () {
        notifier.updateTitle('Test Title');
        
        final hasUnsavedChanges = notifier.state.maybeWhen(
          editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => hasUnsavedChanges,
          orElse: () => false,
        );
        expect(hasUnsavedChanges, isTrue);
      });

      test('should update content and mark as having unsaved changes', () {
        notifier.updateContent('Test Content');
        
        final hasUnsavedChanges = notifier.state.maybeWhen(
          editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => hasUnsavedChanges,
          orElse: () => false,
        );
        expect(hasUnsavedChanges, isTrue);
      });

      test('should update tags and mark as having unsaved changes', () {
        notifier.updateTags(['tag1', 'tag2']);
        
        final hasUnsavedChanges = notifier.state.maybeWhen(
          editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => hasUnsavedChanges,
          orElse: () => false,
        );
        expect(hasUnsavedChanges, isTrue);
      });

      test('should successfully create new entry', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        
        final mockEntry = MockMwEntry();
        when(() => mockMeApi.meTlogPost(
          content: any(named: 'content'),
          privacy: any(named: 'privacy'),
          title: any(named: 'title'),
          images: any(named: 'images'),
          tags: any(named: 'tags'),
          isCommentable: any(named: 'isCommentable'),
          isVotable: any(named: 'isVotable'),
          inLive: any(named: 'inLive'),
          isShared: any(named: 'isShared'),
          isDraft: any(named: 'isDraft'),
        )).thenAnswer((_) async => Response<MwEntry>(
          data: mockEntry,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/me/tlog'),
        ));

        notifier.updateTitle('Test Title');
        notifier.updateContent('Test Content');
        
        await notifier.publishEntry();
        
        final isSuccess = notifier.state.maybeWhen(
          success: (entry) => true,
          orElse: () => false,
        );
        expect(isSuccess, isTrue);
        
        verify(() => mockMeApi.meTlogPost(
          content: 'Test Content',
          privacy: 'all',
          title: 'Test Title',
          images: null,
          tags: null,
          isCommentable: true,
          isVotable: true,
          inLive: true,
          isShared: false,
          isDraft: false,
        )).called(1);
      });

      test('should show error when title is empty', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        
        notifier.updateContent('Test Content');
        
        await notifier.publishEntry();
        
        final isError = notifier.state.maybeWhen(
          error: (message, canRetry) => true,
          orElse: () => false,
        );
        expect(isError, isTrue);
        
        final errorMessage = notifier.state.maybeWhen(
          error: (message, canRetry) => message,
          orElse: () => '',
        );
        expect(errorMessage, equals('Title is required'));
      });

      test('should show error when content is empty', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        
        notifier.updateTitle('Test Title');
        
        await notifier.publishEntry();
        
        final isError = notifier.state.maybeWhen(
          error: (message, canRetry) => true,
          orElse: () => false,
        );
        expect(isError, isTrue);
        
        final errorMessage = notifier.state.maybeWhen(
          error: (message, canRetry) => message,
          orElse: () => '',
        );
        expect(errorMessage, equals('Content is required'));
      });

      test('should show error when API call fails', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        
        when(() => mockMeApi.meTlogPost(
          content: any(named: 'content'),
          privacy: any(named: 'privacy'),
          title: any(named: 'title'),
          images: any(named: 'images'),
          tags: any(named: 'tags'),
          isCommentable: any(named: 'isCommentable'),
          isVotable: any(named: 'isVotable'),
          inLive: any(named: 'inLive'),
          isShared: any(named: 'isShared'),
          isDraft: any(named: 'isDraft'),
        )).thenThrow(Exception('API Error'));

        notifier.updateTitle('Test Title');
        notifier.updateContent('Test Content');
        
        await notifier.publishEntry();
        
        final isError = notifier.state.maybeWhen(
          error: (message, canRetry) => true,
          orElse: () => false,
        );
        expect(isError, isTrue);
        
        final errorMessage = notifier.state.maybeWhen(
          error: (message, canRetry) => message,
          orElse: () => '',
        );
        expect(errorMessage, contains('Failed to publish entry'));
      });
    });

    group('Utility Methods', () {
      setUp(() {
        notifier = EntryEditorNotifier(
          entryId: null,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          imageUploadService: mockImageUploadService,
        );
      });

      test('should return correct hasUnsavedChanges status', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        
        expect(notifier.hasUnsavedChanges, isFalse);
        
        notifier.updateTitle('Test');
        expect(notifier.hasUnsavedChanges, isTrue);
      });

      test('should return correct entryId', () {
        expect(notifier.entryId, isNull);
        
        final notifierWithId = EntryEditorNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          imageUploadService: mockImageUploadService,
        );
        expect(notifierWithId.entryId, equals(123));
      });

      test('should return correct isEditingExisting status', () {
        expect(notifier.isEditingExisting, isFalse);
        
        final notifierWithId = EntryEditorNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          imageUploadService: mockImageUploadService,
        );
        expect(notifierWithId.isEditingExisting, isTrue);
      });
    });

    group('Preview Functionality', () {
      setUp(() {
        notifier = EntryEditorNotifier(
          entryId: null,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          imageUploadService: mockImageUploadService,
        );
      });

      test('should create preview successfully for new entry', () async {
        // Set up editing state with content
        notifier.updateTitle('Test Title');
        notifier.updateContent('Test Content');
        
        // Mock successful API response
        final mockEntry = MockMwEntry();
        when(() => mockEntry.id).thenReturn(123);
        when(() => mockEntry.title).thenReturn('Test Title');
        when(() => mockEntry.content).thenReturn('Test Content');
        
        when(() => mockMeApi.meTlogPost(
          content: any(named: 'content'),
          privacy: any(named: 'privacy'),
          title: any(named: 'title'),
          images: any(named: 'images'),
          tags: any(named: 'tags'),
          isCommentable: any(named: 'isCommentable'),
          isVotable: any(named: 'isVotable'),
          inLive: any(named: 'inLive'),
          isShared: any(named: 'isShared'),
          isDraft: true, // Should be true for preview
        )).thenAnswer((_) async => Response<MwEntry>(
          data: mockEntry,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/me/tlog'),
        ));
        
        // Call previewEntry
        await notifier.previewEntry();
        
        // Should be in preview state
        final isPreview = notifier.state.maybeWhen(
          preview: (entry) => true,
          orElse: () => false,
        );
        expect(isPreview, isTrue);
        
        // Verify API was called with draft=true
        verify(() => mockMeApi.meTlogPost(
          content: 'Test Content',
          privacy: 'all',
          title: 'Test Title',
          images: null,
          tags: null,
          isCommentable: true,
          isVotable: true,
          inLive: true,
          isShared: false,
          isDraft: true,
        )).called(1);
      });

      test('should fail preview when title is empty', () async {
        // Set up editing state without title
        notifier.updateContent('Test Content');
        
        // Call previewEntry
        await notifier.previewEntry();
        
        // Should be in error state
        final isError = notifier.state.maybeWhen(
          error: (message, canRetry) => message == 'Title is required for preview',
          orElse: () => false,
        );
        expect(isError, isTrue);
      });

      test('should fail preview when content is empty', () async {
        // Set up editing state without content
        notifier.updateTitle('Test Title');
        
        // Call previewEntry
        await notifier.previewEntry();
        
        // Should be in error state
        final isError = notifier.state.maybeWhen(
          error: (message, canRetry) => message == 'Content is required for preview',
          orElse: () => false,
        );
        expect(isError, isTrue);
      });

      test('should handle API error during preview creation', () async {
        // Set up editing state
        notifier.updateTitle('Test Title');
        notifier.updateContent('Test Content');
        
        // Mock API error
        when(() => mockMeApi.meTlogPost(
          content: any(named: 'content'),
          privacy: any(named: 'privacy'),
          title: any(named: 'title'),
          images: any(named: 'images'),
          tags: any(named: 'tags'),
          isCommentable: any(named: 'isCommentable'),
          isVotable: any(named: 'isVotable'),
          inLive: any(named: 'inLive'),
          isShared: any(named: 'isShared'),
          isDraft: true,
        )).thenThrow(Exception('API Error'));
        
        // Call previewEntry
        await notifier.previewEntry();
        
        // Should be in error state
        final isError = notifier.state.maybeWhen(
          error: (message, canRetry) => message.contains('Failed to create preview'),
          orElse: () => false,
        );
        expect(isError, isTrue);
      });

      test('should create preview for existing entry', () async {
        // Mock the initial entry loading
        final mockExistingEntry = MockMwEntry();
        when(() => mockExistingEntry.id).thenReturn(123);
        when(() => mockExistingEntry.title).thenReturn('Original Title');
        when(() => mockExistingEntry.content).thenReturn('Original Content');
        when(() => mockExistingEntry.editContent).thenReturn('Original Content');
        when(() => mockExistingEntry.tags).thenReturn(BuiltList<String>([]));
        when(() => mockExistingEntry.privacy).thenReturn(MwEntryPrivacyEnum.all);
        when(() => mockExistingEntry.isCommentable).thenReturn(true);
        when(() => mockExistingEntry.inLive).thenReturn(true);
        when(() => mockExistingEntry.isShared).thenReturn(false);
        when(() => mockExistingEntry.images).thenReturn(BuiltList<MwImage>([]));
        
        when(() => mockEntriesApi.entriesIdGet(id: 123)).thenAnswer((_) async => Response<MwEntry>(
          data: mockExistingEntry,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/entries/123'),
        ));
        
        // Set up notifier for existing entry
        notifier = EntryEditorNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          imageUploadService: mockImageUploadService,
        );
        
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 200));
        
        // Update the entry content
        notifier.updateTitle('Updated Title');
        notifier.updateContent('Updated Content');
        
        // Mock successful API response for updating existing entry
        final mockUpdatedEntry = MockMwEntry();
        when(() => mockUpdatedEntry.id).thenReturn(123);
        when(() => mockUpdatedEntry.title).thenReturn('Updated Title');
        when(() => mockUpdatedEntry.content).thenReturn('Updated Content');
        
        when(() => mockEntriesApi.entriesIdPut(
          id: 123,
          content: any(named: 'content'),
          privacy: any(named: 'privacy'),
          title: any(named: 'title'),
          images: any(named: 'images'),
          tags: any(named: 'tags'),
          isCommentable: any(named: 'isCommentable'),
          isVotable: any(named: 'isVotable'),
          inLive: any(named: 'inLive'),
          isShared: any(named: 'isShared'),
        )).thenAnswer((_) async => Response<MwEntry>(
          data: mockUpdatedEntry,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/entries/123'),
        ));
        
        // Call previewEntry
        await notifier.previewEntry();
        
        // Should be in preview state
        final isPreview = notifier.state.maybeWhen(
          preview: (entry) => true,
          orElse: () => false,
        );
        expect(isPreview, isTrue);
        
        // Verify API was called for updating existing entry
        verify(() => mockEntriesApi.entriesIdPut(
          id: 123,
          content: 'Updated Content',
          privacy: 'all',
          title: 'Updated Title',
          images: null,
          tags: null,
          isCommentable: true,
          isVotable: true,
          inLive: true,
          isShared: false,
        )).called(1);
      });
    });
  });
}
