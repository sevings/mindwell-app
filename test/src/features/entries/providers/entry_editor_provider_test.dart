import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

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
  });
}
