import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell/src/core/services/draft_storage_service.dart';
import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';
import 'package:mindwell/src/features/entries/models/attached_image.dart';
import 'package:mindwell_api/mindwell_api.dart';

class MockBox extends Mock implements Box<String> {}

void main() {
  group('DraftStorageService', () {
    late DraftStorageService service;
    late MockBox mockBox;

    setUp(() {
      mockBox = MockBox();
      service = DraftStorageService(box: mockBox);
    });

    group('saveDraft', () {
      test(
        'should save draft when in editing state with unsaved changes',
        () async {
          // Arrange
          final draft = const EntryEditorState.editing(
            title: 'Test Title',
            content: 'Test content',
            tags: ['tag1', 'tag2'],
            hasUnsavedChanges: true,
          );

          when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

          // Act
          await service.saveDraft(draft);

          // Assert
          verify(() => mockBox.put('current_draft', any())).called(1);
        },
      );

      test('should not save draft when hasUnsavedChanges is false', () async {
        // Arrange
        final draft = const EntryEditorState.editing(
          title: 'Test Title',
          content: 'Test content',
          hasUnsavedChanges: false,
        );

        // Act
        await service.saveDraft(draft);

        // Assert
        verifyNever(() => mockBox.put(any(), any()));
      });

      test('should not save draft when not in editing state', () async {
        // Arrange
        const draft = EntryEditorState.loading();

        // Act
        await service.saveDraft(draft);

        // Assert
        verifyNever(() => mockBox.put(any(), any()));
      });

      test('should handle save errors gracefully', () async {
        // Arrange
        final draft = const EntryEditorState.editing(
          title: 'Test Title',
          hasUnsavedChanges: true,
        );

        when(
          () => mockBox.put(any(), any()),
        ).thenThrow(Exception('Save failed'));

        // Act & Assert - should not throw
        await service.saveDraft(draft);
      });

      test('should serialize draft data correctly', () async {
        // Arrange
        final draft = EntryEditorState.editing(
          title: 'Test Title',
          content: '<p>Test content</p>',
          tags: ['tag1', 'tag2'],
          privacy: 'friends',
          isCommentable: false,
          isVotable: true,
          inLive: false,
          isShared: true,
          isDraft: true,
          images: [
            AttachedImage.ready(id: 1, image: MwImage()),
            AttachedImage.ready(id: 2, image: MwImage()),
            AttachedImage.ready(id: 3, image: MwImage()),
          ],
          entryId: 123,
          hasUnsavedChanges: true,
        );

        String? savedData;
        when(() => mockBox.put(any(), any())).thenAnswer((invocation) async {
          savedData = invocation.positionalArguments[1] as String;
        });

        // Act
        await service.saveDraft(draft);

        // Assert
        expect(savedData, isNotNull);
        final decodedData = jsonDecode(savedData!) as Map<String, dynamic>;
        expect(decodedData['title'], equals('Test Title'));
        expect(decodedData['content'], equals('<p>Test content</p>'));
        expect(decodedData['tags'], equals(['tag1', 'tag2']));
        expect(decodedData['privacy'], equals('friends'));
        expect(decodedData['isCommentable'], equals(false));
        expect(decodedData['isVotable'], equals(true));
        expect(decodedData['inLive'], equals(false));
        expect(decodedData['isShared'], equals(true));
        expect(decodedData['isDraft'], equals(true));
        expect(decodedData['images'], equals([1, 2, 3]));
        expect(decodedData['entryId'], equals(123));
        expect(decodedData['hasUnsavedChanges'], equals(true));
        expect(decodedData['savedAt'], isA<int>());
      });
    });

    group('loadDraft', () {
      test('should return null when no draft exists', () async {
        // Arrange
        when(() => mockBox.get('current_draft')).thenReturn(null);

        // Act
        final result = await service.loadDraft();

        // Assert
        expect(result, isNull);
      });

      test('should return draft when valid data exists', () async {
        // Arrange
        final draftData = jsonEncode({
          'title': 'Test Title',
          'content': 'Test content',
          'tags': ['tag1'],
          'privacy': 'all',
          'isCommentable': true,
          'isVotable': true,
          'inLive': true,
          'isShared': false,
          'isDraft': false,
          'images': [],
          'entryId': null,
          'hasUnsavedChanges': false,
        });

        when(() => mockBox.get('current_draft')).thenReturn(draftData);

        // Act
        final result = await service.loadDraft();

        // Assert
        expect(result, isNotNull);
        expect(result, isA<EntryEditorState>());

        result!.when(
          initial: () => fail('Expected editing state'),
          loading: () => fail('Expected editing state'),
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
              ) {
                expect(title, equals('Test Title'));
                expect(content, equals('Test content'));
                expect(tags, equals(['tag1']));
                expect(hasUnsavedChanges, equals(false));
              },
          publishing: (isUploadingImages, uploadProgress) =>
              fail('Expected editing state'),
          success: (entry) => fail('Expected editing state'),
          preview: (entry) => fail('Expected editing state'),
          error: (message, canRetry) => fail('Expected editing state'),
        );
      });

      test('should clear corrupted draft and return null', () async {
        // Arrange
        when(() => mockBox.get('current_draft')).thenReturn('invalid json');
        when(() => mockBox.delete('current_draft')).thenAnswer((_) async {});

        // Act
        final result = await service.loadDraft();

        // Assert
        expect(result, isNull);
        verify(() => mockBox.delete('current_draft')).called(1);
      });

      test('should handle load errors gracefully', () async {
        // Arrange
        when(
          () => mockBox.get('current_draft'),
        ).thenThrow(Exception('Load failed'));

        // Act & Assert - should not throw
        final result = await service.loadDraft();
        expect(result, isNull);
      });

      test('should handle missing fields with defaults', () async {
        // Arrange
        final draftData = jsonEncode({
          'title': 'Test Title',
          // Missing other fields - should use defaults
        });

        when(() => mockBox.get('current_draft')).thenReturn(draftData);

        // Act
        final result = await service.loadDraft();

        // Assert
        expect(result, isNotNull);
        expect(result, isA<EntryEditorState>());

        result!.when(
          initial: () => fail('Expected editing state'),
          loading: () => fail('Expected editing state'),
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
              ) {
                expect(title, equals('Test Title'));
                expect(content, equals('')); // default
                expect(tags, equals([])); // default
                expect(privacy, equals('all')); // default
                expect(isCommentable, equals(true)); // default
                expect(isVotable, equals(true)); // default
                expect(inLive, equals(true)); // default
                expect(isShared, equals(false)); // default
                expect(isDraft, equals(false)); // default
                expect(images, equals([])); // default
                expect(entryId, isNull); // default
                expect(hasUnsavedChanges, equals(false)); // default
              },
          publishing: (isUploadingImages, uploadProgress) =>
              fail('Expected editing state'),
          success: (entry) => fail('Expected editing state'),
          preview: (entry) => fail('Expected editing state'),
          error: (message, canRetry) => fail('Expected editing state'),
        );
      });
    });

    group('hasDraft', () {
      test('should return true when draft exists', () async {
        // Arrange
        when(() => mockBox.containsKey('current_draft')).thenReturn(true);

        // Act
        final result = await service.hasDraft();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when draft does not exist', () async {
        // Arrange
        when(() => mockBox.containsKey('current_draft')).thenReturn(false);

        // Act
        final result = await service.hasDraft();

        // Assert
        expect(result, isFalse);
      });

      test('should handle errors gracefully', () async {
        // Arrange
        when(
          () => mockBox.containsKey('current_draft'),
        ).thenThrow(Exception('Check failed'));

        // Act & Assert - should not throw
        final result = await service.hasDraft();
        expect(result, isFalse);
      });
    });

    group('clearDraft', () {
      test('should delete draft from storage', () async {
        // Arrange
        when(() => mockBox.delete('current_draft')).thenAnswer((_) async {});

        // Act
        await service.clearDraft();

        // Assert
        verify(() => mockBox.delete('current_draft')).called(1);
      });

      test('should handle delete errors gracefully', () async {
        // Arrange
        when(
          () => mockBox.delete('current_draft'),
        ).thenThrow(Exception('Delete failed'));

        // Act & Assert - should not throw
        await service.clearDraft();
      });
    });

    group('getDraftMetadata', () {
      test('should return null when no draft exists', () async {
        // Arrange
        when(() => mockBox.get('current_draft')).thenReturn(null);

        // Act
        final result = await service.getDraftMetadata();

        // Assert
        expect(result, isNull);
      });

      test('should return metadata for valid draft', () async {
        // Arrange
        final draftData = jsonEncode({
          'title': 'Test Title',
          'content': '<p>Test content</p>',
          'tags': ['tag1', 'tag2'],
          'privacy': 'all',
          'isCommentable': true,
          'isVotable': true,
          'inLive': true,
          'isShared': false,
          'isDraft': true,
          'images': [1, 2],
          'entryId': null,
          'hasUnsavedChanges': true,
        });

        when(() => mockBox.get('current_draft')).thenReturn(draftData);

        // Act
        final result = await service.getDraftMetadata();

        // Assert
        expect(result, isNotNull);
        expect(result!['hasTitle'], isTrue);
        expect(result['hasContent'], isTrue);
        expect(result['tagsCount'], equals(2));
        expect(
          result['imagesCount'],
          equals(0),
        ); // Images are not restored from draft
        expect(result['isDraft'], isTrue);
        expect(result['hasUnsavedChanges'], isTrue);
        expect(result['dataSize'], isA<int>());
        expect(result['createdAt'], isA<String>());
      });

      test('should return null for corrupted draft', () async {
        // Arrange
        when(() => mockBox.get('current_draft')).thenReturn('invalid json');

        // Act
        final result = await service.getDraftMetadata();

        // Assert
        expect(result, isNull);
      });

      test('should handle errors gracefully', () async {
        // Arrange
        when(
          () => mockBox.get('current_draft'),
        ).thenThrow(Exception('Metadata failed'));

        // Act & Assert - should not throw
        final result = await service.getDraftMetadata();
        expect(result, isNull);
      });
    });

    group('close', () {
      test('should close the box', () async {
        // Arrange
        when(() => mockBox.close()).thenAnswer((_) async {});

        // Act
        await service.close();

        // Assert
        verify(() => mockBox.close()).called(1);
      });

      test('should handle close errors gracefully', () async {
        // Arrange
        when(() => mockBox.close()).thenThrow(Exception('Close failed'));

        // Act & Assert - should not throw
        await service.close();
      });
    });
  });
}
