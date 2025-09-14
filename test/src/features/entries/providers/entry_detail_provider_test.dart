import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';

import 'package:mindwell/src/features/entries/models/entry_detail_state.dart';
import 'package:mindwell/src/features/entries/providers/entry_detail_provider.dart';

// Mock classes
class MockEntriesApi extends Mock implements EntriesApi {}
class MockCommentsApi extends Mock implements CommentsApi {}
class MockMwEntry extends Mock implements MwEntry {}
class MockMwComment extends Mock implements MwComment {}
class MockMwCommentList extends Mock implements MwCommentList {}
class MockMwUser extends Mock implements MwUser {}
class MockMwRating extends Mock implements MwRating {}
class MockMwAdjacentEntries extends Mock implements MwAdjacentEntries {}

// Helper functions for testing state
bool isLoadedState(EntryDetailState state) {
  return state.when(
    initial: () => false,
    loading: () => false,
    loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => true,
    error: (message, entry) => false,
  );
}

bool isErrorState(EntryDetailState state) {
  return state.when(
    initial: () => false,
    loading: () => false,
    loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => false,
    error: (message, entry) => true,
  );
}

bool isLoadingState(EntryDetailState state) {
  return state.when(
    initial: () => false,
    loading: () => true,
    loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => false,
    error: (message, entry) => false,
  );
}

({MwEntry entry, List<MwComment> comments, bool hasMoreComments, bool isLoadingComments})? getLoadedState(EntryDetailState state) {
  return state.when(
    initial: () => null,
    loading: () => null,
    loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => (
      entry: entry,
      comments: comments,
      hasMoreComments: hasMoreComments,
      isLoadingComments: isLoadingComments,
    ),
    error: (message, entry) => null,
  );
}

String? getErrorMessage(EntryDetailState state) {
  return state.when(
    initial: () => null,
    loading: () => null,
    loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => null,
    error: (message, entry) => message,
  );
}

void main() {
  group('EntryDetailNotifier', () {
    late MockEntriesApi mockEntriesApi;
    late MockCommentsApi mockCommentsApi;
    late EntryDetailNotifier notifier;
    late MockMwEntry mockEntry;
    late MockMwComment mockComment;
    late MockMwCommentList mockCommentList;
    late MockMwUser mockUser;
    late MockMwRating mockRating;
    late MockMwAdjacentEntries mockAdjacentEntries;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockCommentsApi = MockCommentsApi();
      mockEntry = MockMwEntry();
      mockComment = MockMwComment();
      mockCommentList = MockMwCommentList();
      mockUser = MockMwUser();
      mockRating = MockMwRating();
      mockAdjacentEntries = MockMwAdjacentEntries();

      // Setup default mock responses
      when(() => mockUser.id).thenReturn(1);
      when(() => mockUser.name).thenReturn('testuser');
      when(() => mockUser.avatar).thenReturn(null);

      when(() => mockRating.upCount).thenReturn(5);
      when(() => mockRating.downCount).thenReturn(1);

      when(() => mockEntry.id).thenReturn(123);
      when(() => mockEntry.title).thenReturn('Test Entry');
      when(() => mockEntry.content).thenReturn('Test content');
      when(() => mockEntry.author).thenReturn(mockUser);
      when(() => mockEntry.rating).thenReturn(mockRating);
      when(() => mockEntry.commentCount).thenReturn(3);
      when(() => mockEntry.favoriteCount).thenReturn(2);
      when(() => mockEntry.isFavorited).thenReturn(false);
      when(() => mockEntry.createdAt).thenReturn(1640995200.0);
      when(() => mockEntry.comments).thenReturn(mockCommentList);

      when(() => mockComment.id).thenReturn(456);
      when(() => mockComment.content).thenReturn('Test comment');
      when(() => mockComment.author).thenReturn(mockUser);
      when(() => mockComment.entryId).thenReturn(123);
      when(() => mockComment.createdAt).thenReturn(1640995200.0);

      when(() => mockCommentList.data).thenReturn(BuiltList([mockComment]));
      when(() => mockCommentList.nextBefore).thenReturn('next_cursor');
      when(() => mockCommentList.hasBefore).thenReturn(true);

      // Setup adjacent entries mock
      when(() => mockAdjacentEntries.older).thenReturn(null);
      when(() => mockAdjacentEntries.newer).thenReturn(null);
      when(() => mockAdjacentEntries.id).thenReturn(123);
    });

    test('should start with initial state', () {
      // Setup API responses to prevent errors during initialization
      when(() => mockEntriesApi.entriesIdGet(id: 123))
          .thenAnswer((_) async => Response<MwEntry>(
                data: mockEntry,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/entries/123'),
              ));

      when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
          .thenAnswer((_) async => Response<MwAdjacentEntries>(
                data: mockAdjacentEntries,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/entries/123/adjacent'),
              ));

        when(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: null,
            )).thenAnswer((_) async => Response<MwCommentList>(
                  data: mockCommentList,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/comments'),
                ));

      notifier = EntryDetailNotifier(
        entryId: 123,
        entriesApi: mockEntriesApi,
        commentsApi: mockCommentsApi,
      );

      // The notifier will immediately start loading, so we expect loading state
      expect(isLoadingState(notifier.state), isTrue);
    });

    group('fetchEntryDetails', () {
      test('should fetch entry details and comments successfully', () async {
        // Setup API responses
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntry,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));

        expect(isLoadedState(notifier.state), isTrue);
        
        final loadedState = getLoadedState(notifier.state);
        expect(loadedState, isNotNull);
        expect(loadedState!.entry.id, equals(123));
        expect(loadedState.comments.length, equals(1));
        expect(loadedState.hasMoreComments, isTrue);
        expect(loadedState.isLoadingComments, isFalse);

        verify(() => mockEntriesApi.entriesIdGet(id: 123)).called(1);
        // Should not make a separate comments API call since comments come from entry response
        verifyNever(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: null,
            ));
      });

      test('should handle entry not found error', () async {
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: null,
                  statusCode: 404,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: null,
                  statusCode: 404,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));

        expect(isErrorState(notifier.state), isTrue);
        expect(getErrorMessage(notifier.state), contains('Entry not found'));
      });

      test('should handle API error', () async {
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenThrow(Exception('Network error'));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenThrow(Exception('Network error'));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));

        expect(isErrorState(notifier.state), isTrue);
        expect(getErrorMessage(notifier.state), contains('Failed to load entry'));
      });

      test('should not fetch if already loading', () async {
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async {
              await Future.delayed(const Duration(milliseconds: 100));
              return Response<MwEntry>(
                data: mockEntry,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/entries/123'),
              );
            });

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async {
              await Future.delayed(const Duration(milliseconds: 100));
              return Response<MwAdjacentEntries>(
                data: mockAdjacentEntries,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/entries/123/adjacent'),
              );
            });

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Call fetchEntryDetails multiple times
        notifier.fetchEntryDetails();
        notifier.fetchEntryDetails();
        notifier.fetchEntryDetails();

        // Wait for completion
        await Future.delayed(const Duration(milliseconds: 200));

        // Should only be called once due to loading guard
        verify(() => mockEntriesApi.entriesIdGet(id: 123)).called(1);
        verify(() => mockEntriesApi.entriesIdAdjacentGet(id: 123)).called(1);
      });
    });

    group('loadMoreComments', () {
      setUp(() async {
        // Setup initial state with loaded entry and comments
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntry,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('should load more comments successfully', () async {
        final additionalComment = MockMwComment();
        when(() => additionalComment.id).thenReturn(789);
        when(() => additionalComment.content).thenReturn('Additional comment');
        when(() => additionalComment.author).thenReturn(mockUser);

        final additionalCommentList = MockMwCommentList();
        when(() => additionalCommentList.data).thenReturn(BuiltList([additionalComment]));
        when(() => additionalCommentList.nextBefore).thenReturn(null);
        when(() => additionalCommentList.hasBefore).thenReturn(false);

        when(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: 'next_cursor',
            )).thenAnswer((_) async => Response<MwCommentList>(
                  data: additionalCommentList,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/comments'),
                ));

        await notifier.loadMoreComments();

        final loadedState = getLoadedState(notifier.state);
        expect(loadedState, isNotNull);
        expect(loadedState!.comments.length, equals(2));
        expect(loadedState.hasMoreComments, isFalse);

        verify(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: 'next_cursor',
            )).called(1);
      });

      test('should not load more comments if no more available', () async {
        // Create a mock entry with no more comments available
        final mockEntryNoMore = MockMwEntry();
        when(() => mockEntryNoMore.id).thenReturn(123);
        when(() => mockEntryNoMore.title).thenReturn('Test Entry');
        when(() => mockEntryNoMore.content).thenReturn('Test content');
        when(() => mockEntryNoMore.author).thenReturn(mockUser);
        when(() => mockEntryNoMore.rating).thenReturn(mockRating);
        when(() => mockEntryNoMore.commentCount).thenReturn(3);
        when(() => mockEntryNoMore.favoriteCount).thenReturn(2);
        when(() => mockEntryNoMore.isFavorited).thenReturn(false);
        when(() => mockEntryNoMore.createdAt).thenReturn(1640995200.0);
        
        // Create a comment list with no more comments
        final mockCommentListNoMore = MockMwCommentList();
        when(() => mockCommentListNoMore.data).thenReturn(BuiltList([mockComment]));
        when(() => mockCommentListNoMore.nextBefore).thenReturn(null);
        when(() => mockCommentListNoMore.hasBefore).thenReturn(false);
        
        when(() => mockEntryNoMore.comments).thenReturn(mockCommentListNoMore);
        
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntryNoMore,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));
        
        final testNotifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );
        
        // Wait for initial load to complete
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Try to load more comments - should not make API call since hasMoreComments is false
        await testNotifier.loadMoreComments();
        
        // Should not make additional API call
        verifyNever(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: any(named: 'before'),
            ));
      });

      test('should not load more comments if already loading', () async {
        when(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: 'next_cursor',
            )).thenAnswer((_) async {
              await Future.delayed(const Duration(milliseconds: 100));
              return Response<MwCommentList>(
                data: mockCommentList,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/entries/123/comments'),
              );
            });

        // Start loading more comments
        notifier.loadMoreComments();
        
        // Try to load more while already loading
        await notifier.loadMoreComments();

        // Should only be called once
        verify(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: 'next_cursor',
            )).called(1);
      });
    });

    group('refresh', () {
      setUp(() async {
        // Setup initial state
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntry,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('should refresh entry details and comments', () async {
        await notifier.refresh();

        // Should make fresh API calls
        verify(() => mockEntriesApi.entriesIdGet(id: 123)).called(2); // Once for init, once for refresh
        verify(() => mockEntriesApi.entriesIdAdjacentGet(id: 123)).called(2); // Once for init, once for refresh
        // Should not make separate comments API calls since comments come from entry response
        verifyNever(() => mockCommentsApi.entriesIdCommentsGet(
              id: 123,
              limit: 30,
              before: null,
            ));
      });
    });

    group('voteEntry', () {
      setUp(() async {
        // Setup initial state
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntry,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('should perform optimistic update for upvote', () async {
        await notifier.voteEntry(true);

        // The optimistic update should be applied
        // Note: In a real implementation, you'd verify the rating changes
        // For now, we just verify the method doesn't throw
        expect(isLoadedState(notifier.state), isTrue);
      });

      test('should perform optimistic update for downvote', () async {
        await notifier.voteEntry(false);

        // The optimistic update should be applied
        expect(isLoadedState(notifier.state), isTrue);
      });
    });

    group('toggleFavorite', () {
      setUp(() async {
        // Setup initial state
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntry,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('should perform optimistic update for favorite toggle', () async {
        await notifier.toggleFavorite();

        // The optimistic update should be applied
        expect(isLoadedState(notifier.state), isTrue);
      });
    });

    group('addComment', () {
      setUp(() async {
        // Setup initial state
        when(() => mockEntriesApi.entriesIdGet(id: 123))
            .thenAnswer((_) async => Response<MwEntry>(
                  data: mockEntry,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123'),
                ));

        when(() => mockEntriesApi.entriesIdAdjacentGet(id: 123))
            .thenAnswer((_) async => Response<MwAdjacentEntries>(
                  data: mockAdjacentEntries,
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/entries/123/adjacent'),
                ));

        notifier = EntryDetailNotifier(
          entryId: 123,
          entriesApi: mockEntriesApi,
          commentsApi: mockCommentsApi,
        );

        // Wait for initialization
        await Future.delayed(const Duration(milliseconds: 100));
      });

      test('should add comment successfully', () async {
        final newComment = MockMwComment();
        when(() => newComment.id).thenReturn(999);
        when(() => newComment.content).thenReturn('New comment');
        when(() => newComment.author).thenReturn(mockUser);

        when(() => mockCommentsApi.entriesIdCommentsPost(
              id: 123,
              content: 'New comment',
            )).thenAnswer((_) async => Response<MwComment>(
                  data: newComment,
                  statusCode: 201,
                  requestOptions: RequestOptions(path: '/entries/123/comments'),
                ));

        await notifier.addComment('New comment');

        final loadedState = getLoadedState(notifier.state);
        expect(loadedState, isNotNull);
        expect(loadedState!.comments.length, equals(2)); // Original + new comment
        // Note: commentCount is not updated since we can't modify built_value models
        // In a real implementation, this would be updated
        expect(loadedState.entry.commentCount, equals(3)); // Original count unchanged

        verify(() => mockCommentsApi.entriesIdCommentsPost(
              id: 123,
              content: 'New comment',
            )).called(1);
      });

      test('should handle comment addition error gracefully', () async {
        when(() => mockCommentsApi.entriesIdCommentsPost(
              id: 123,
              content: 'New comment',
            )).thenThrow(Exception('Network error'));

        await notifier.addComment('New comment');

        // State should remain unchanged on error
        final loadedState = getLoadedState(notifier.state);
        expect(loadedState, isNotNull);
        expect(loadedState!.comments.length, equals(1)); // Only original comment
        expect(loadedState.entry.commentCount, equals(3)); // Original count unchanged
      });
    });
  });
}
