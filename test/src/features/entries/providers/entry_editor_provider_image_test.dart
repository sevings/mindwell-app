import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/models/attached_image.dart';
import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';
import 'package:mindwell/src/features/entries/providers/entry_editor_provider.dart';
import 'package:mindwell/src/core/services/image_upload_service.dart';
import 'package:mindwell/src/core/services/image_polling_service.dart';

class MockEntriesApi extends Mock implements EntriesApi {}

class MockMeApi extends Mock implements MeApi {}

class MockThemesApi extends Mock implements ThemesApi {}

class MockImageUploadService extends Mock implements ImageUploadService {}

class MockImagePollingService extends Mock implements ImagePollingService {}

void main() {
  group('EntryEditorNotifier - Image Management', () {
    late MockEntriesApi mockEntriesApi;
    late MockMeApi mockMeApi;
    late MockThemesApi mockThemesApi;
    late MockImageUploadService mockImageUploadService;
    late MockImagePollingService mockImagePollingService;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockMeApi = MockMeApi();
      mockThemesApi = MockThemesApi();
      mockImageUploadService = MockImageUploadService();
      mockImagePollingService = MockImagePollingService();
    });

    EntryEditorNotifier createNotifier() {
      return EntryEditorNotifier(
        entryId: null,
        themeName: null,
        entriesApi: mockEntriesApi,
        meApi: mockMeApi,
        themesApi: mockThemesApi,
        imageUploadService: mockImageUploadService,
        imagePollingService: mockImagePollingService,
      );
    }

    group('addImage', () {
      test('should add image to state', () async {
        final notifier = createNotifier();
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));

        final mockImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = false,
        );
        final attachedImage = AttachedImage.ready(id: 123, image: mockImage);

        notifier.addImage(attachedImage);

        final state = notifier.state;
        expect(
          state.maybeWhen(
            editing:
                (
                  title,
                  content,
                  tags,
                  privacy,
                  isCommentable,
                  isVotable,
                  inLive,
                  isShared,
                  isDraft,
                  images,
                  entryId,
                  hasUnsavedChanges,
                  themeName,
                  isAnonymous,
                ) => images,
            orElse: () => <AttachedImage>[],
          ),
          contains(attachedImage),
        );
      });
    });

    group('removeImage', () {
      test('should remove image from state for new entry', () async {
        final notifier = createNotifier();
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        final mockImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = false,
        );
        final attachedImage = AttachedImage.ready(id: 123, image: mockImage);

        // Add image first
        notifier.addImage(attachedImage);

        // Remove image
        notifier.removeImage(123);

        final state = notifier.state;
        final images = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => images,
          orElse: () => <AttachedImage>[],
        );

        expect(images, isEmpty);
      });

      test('should track deleted images for existing entry', () async {
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        // Create notifier for existing entry
        final existingEntryNotifier = EntryEditorNotifier(
          entryId: 456,
          themeName: null,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          themesApi: mockThemesApi,
          imageUploadService: mockImageUploadService,
          imagePollingService: mockImagePollingService,
        );

        final mockImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = false,
        );
        final attachedImage = AttachedImage.ready(id: 123, image: mockImage);

        // Add image first
        existingEntryNotifier.addImage(attachedImage);

        // Remove image
        existingEntryNotifier.removeImage(123);

        final state = existingEntryNotifier.state;
        final images = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => images,
          orElse: () => <AttachedImage>[],
        );

        expect(images, isEmpty);
        // Note: We can't directly test the _deletedImageIds set as it's private,
        // but we can verify the image was removed from the state
      });
    });

    group('updateImageStatus', () {
      test('should update image status in state', () async {
        final notifier = createNotifier();
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        final mockImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = true,
        );
        final processingImage = AttachedImage.processing(
          id: 123,
          image: mockImage,
        );

        // Add processing image
        notifier.addImage(processingImage);

        // Update to ready
        final readyImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = false,
        );
        final readyAttachedImage = AttachedImage.ready(
          id: 123,
          image: readyImage,
        );

        notifier.updateImageStatus(123, readyAttachedImage);

        final state = notifier.state;
        final images = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => images,
          orElse: () => <AttachedImage>[],
        );

        expect(images.length, equals(1));
        expect(images.first.isReady, isTrue);
      });
    });

    group('reorderImages', () {
      test('should reorder images in state', () async {
        final notifier = createNotifier();
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        final mockImage1 = MwImage(
          (b) => b
            ..id = 1
            ..processing = false,
        );
        final mockImage2 = MwImage(
          (b) => b
            ..id = 2
            ..processing = false,
        );
        final mockImage3 = MwImage(
          (b) => b
            ..id = 3
            ..processing = false,
        );

        final attachedImage1 = AttachedImage.ready(id: 1, image: mockImage1);
        final attachedImage2 = AttachedImage.ready(id: 2, image: mockImage2);
        final attachedImage3 = AttachedImage.ready(id: 3, image: mockImage3);

        // Add images
        notifier.addImage(attachedImage1);
        notifier.addImage(attachedImage2);
        notifier.addImage(attachedImage3);

        // Reorder: move first image to last position
        notifier.reorderImages(0, 2);

        final state = notifier.state;
        final images = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => images,
          orElse: () => <AttachedImage>[],
        );

        expect(images.length, equals(3));
        expect(images[0].id, equals(2)); // Second image moved to first
        expect(images[1].id, equals(1)); // First image moved to second
        expect(images[2].id, equals(3)); // Third image stayed in last
      });
    });

    group('insertImageMarkdown', () {
      test('should insert image markdown into content', () async {
        final notifier = createNotifier();
        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
        const imageId = 123;
        const imageUrl = 'https://example.com/image.jpg';

        notifier.insertImageMarkdown(imageId, imageUrl);

        final state = notifier.state;
        final content = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => content,
          orElse: () => '',
        );

        expect(content, contains('![Image]($imageUrl)'));
      });
    });

    group('uploadImages', () {
      test('should upload images and add to state', () async {
        final notifier = createNotifier();
        // Set initial editing state
        notifier.state = const EntryEditorState.editing();
        final mockFile = File('test.jpg');
        final mockImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = false,
        );

        when(
          () => mockImageUploadService.uploadImages(
            any(),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => [mockImage]);

        await notifier.uploadImages([mockFile]);

        final state = notifier.state;
        final images = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => images,
          orElse: () => <AttachedImage>[],
        );

        expect(images.length, equals(1));
        expect(images.first.id, equals(123));
        expect(images.first.isReady, isTrue);
      });

      test('should handle processing images and start polling', () async {
        final notifier = createNotifier();
        // Set initial editing state
        notifier.state = const EntryEditorState.editing();
        final mockFile = File('test.jpg');
        final processingImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = true,
        );

        when(
          () => mockImageUploadService.uploadImages(
            any(),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenAnswer((_) async => [processingImage]);

        when(
          () => mockImagePollingService.startPolling(
            imageId: any(named: 'imageId'),
            onUpdate: any(named: 'onUpdate'),
            onComplete: any(named: 'onComplete'),
            onError: any(named: 'onError'),
          ),
        ).thenReturn(null);

        await notifier.uploadImages([mockFile]);

        final state = notifier.state;
        final images = state.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) => images,
          orElse: () => <AttachedImage>[],
        );

        expect(images.length, equals(1));
        expect(images.first.id, equals(123));
        expect(images.first.isProcessing, isTrue);

        // Verify polling was started
        verify(
          () => mockImagePollingService.startPolling(
            imageId: 123,
            onUpdate: any(named: 'onUpdate'),
            onComplete: any(named: 'onComplete'),
            onError: any(named: 'onError'),
          ),
        ).called(1);
      });

      test('should handle upload errors', () async {
        final notifier = createNotifier();
        final mockFile = File('test.jpg');

        when(
          () => mockImageUploadService.uploadImages(
            any(),
            onProgress: any(named: 'onProgress'),
          ),
        ).thenThrow(Exception('Upload failed'));

        await notifier.uploadImages([mockFile]);

        final state = notifier.state;
        expect(
          state.maybeWhen(
            error: (message, canRetry) => message,
            orElse: () => '',
          ),
          contains('Upload failed'),
        );
      });
    });

    group('dispose', () {
      test('should stop all polling on dispose', () {
        when(() => mockImagePollingService.stopAllPolling()).thenReturn(null);

        final testNotifier = EntryEditorNotifier(
          entryId: null,
          themeName: null,
          entriesApi: mockEntriesApi,
          meApi: mockMeApi,
          themesApi: mockThemesApi,
          imageUploadService: mockImageUploadService,
          imagePollingService: mockImagePollingService,
        );

        testNotifier.dispose();

        verify(() => mockImagePollingService.stopAllPolling()).called(1);
      });
    });
  });
}
