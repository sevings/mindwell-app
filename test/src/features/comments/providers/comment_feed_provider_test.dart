import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/models/comment_feed_state.dart';
import 'package:mindwell/src/features/comments/providers/comment_feed_provider.dart';

// Mock classes
class MockUsersApi extends Mock implements UsersApi {}

class MockResponse extends Mock implements Response<MwCommentList> {}

class MockMwCommentList extends Mock implements MwCommentList {}

class MockMwComment extends Mock implements MwComment {}

void main() {
  group('CommentFeedNotifier', () {
    late MockUsersApi mockUsersApi;
    late CommentFeedNotifier notifier;
    late MockResponse mockResponse;
    late MockMwCommentList mockCommentList;
    late MockMwComment mockComment;

    setUp(() {
      mockUsersApi = MockUsersApi();
      mockResponse = MockResponse();
      mockCommentList = MockMwCommentList();
      mockComment = MockMwComment();
      
      notifier = CommentFeedNotifier(
        username: 'testuser',
        usersApi: mockUsersApi,
      );
    });

    group('initialization', () {
      test('should start with initial state', () {
        expect(notifier.state, const CommentFeedState.initial());
      });
    });

    group('fetchInitialComments', () {
      test('should set loading state when fetching starts', () async {
        // Arrange
        final commentsList = BuiltList<MwComment>([]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async {
          // Add a small delay to ensure we can catch the loading state
          await Future.delayed(const Duration(milliseconds: 10));
          return mockResponse;
        });
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(commentsList);

        // Act
        final future = notifier.fetchInitialComments();
        
        // Check loading state immediately
        expect(notifier.state, const CommentFeedState.loading());
        
        await future;
      });

      test('should set loaded state with comments when fetch succeeds', () async {
        // Arrange
        final comments = BuiltList<MwComment>([mockComment, mockComment]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(comments);
        when(() => mockCommentList.nextAfter).thenReturn('next_token');
        when(() => mockCommentList.hasAfter).thenReturn(true);

        // Act
        await notifier.fetchInitialComments();

        // Assert
        expect(notifier.state, isA<CommentFeedState>());
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (loadedComments, hasMore, isFetchingMore) {
            expect(loadedComments, hasLength(2));
            expect(hasMore, isTrue);
            expect(isFetchingMore, isFalse);
          },
          error: (message, comments) => fail('Should not be error'),
          empty: () => fail('Should not be empty'),
        );
      });

      test('should set empty state when no comments are returned', () async {
        // Arrange
        final commentsList = BuiltList<MwComment>([]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(commentsList);

        // Act
        await notifier.fetchInitialComments();

        // Assert
        expect(notifier.state, const CommentFeedState.empty());
      });

      test('should set error state when API call fails', () async {
        // Arrange
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 404,
          ),
        ));

        // Act
        await notifier.fetchInitialComments();

        // Assert
        expect(notifier.state, isA<CommentFeedState>());
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) => fail('Should not be loaded'),
          error: (message, comments) {
            expect(message, 'Пользователь не найден');
            expect(comments, isNull);
          },
          empty: () => fail('Should not be empty'),
        );
      });

      test('should not fetch if already loading', () async {
        // Arrange
        final commentsList = BuiltList<MwComment>([]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(commentsList);

        // Act
        final future1 = notifier.fetchInitialComments();
        final future2 = notifier.fetchInitialComments();
        
        await future1;
        await future2;

        // Assert
        verify(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).called(1); // Should only be called once
      });
    });

    group('fetchMoreComments', () {
      test('should fetch more comments and append to existing list', () async {
        // Arrange - First set up initial state
        final initialComments = BuiltList<MwComment>([mockComment]);
        final newComments = BuiltList<MwComment>([mockComment, mockComment]);
        
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(initialComments);
        when(() => mockCommentList.nextAfter).thenReturn('next_token');
        when(() => mockCommentList.hasAfter).thenReturn(true);

        await notifier.fetchInitialComments();

        // Arrange - Set up for fetchMore
        final mockResponse2 = MockResponse();
        final mockCommentList2 = MockMwCommentList();
        
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
          after: 'next_token',
        )).thenAnswer((_) async => mockResponse2);
        when(() => mockResponse2.data).thenReturn(mockCommentList2);
        when(() => mockCommentList2.data).thenReturn(newComments);
        when(() => mockCommentList2.nextAfter).thenReturn('next_token_2');
        when(() => mockCommentList2.hasAfter).thenReturn(false);

        // Act
        await notifier.fetchMoreComments();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) {
            expect(comments, hasLength(3)); // 1 initial + 2 new
            expect(hasMore, isFalse);
            expect(isFetchingMore, isFalse);
          },
          error: (message, comments) => fail('Should not be error'),
          empty: () => fail('Should not be empty'),
        );
      });

      test('should not fetch more if no more comments available', () async {
        // Arrange - Set up state with no more comments
        final comments = BuiltList<MwComment>([mockComment]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(comments);
        when(() => mockCommentList.nextAfter).thenReturn('next_token');
        when(() => mockCommentList.hasAfter).thenReturn(false);

        await notifier.fetchInitialComments();

        // Act
        await notifier.fetchMoreComments();

        // Assert - Only the initial call should have been made, not the fetchMore call
        verify(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).called(1); // Only initial call
        verifyNever(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
          after: any(named: 'after'),
        )); // No fetchMore call
      });

      test('should not fetch more if already loading', () async {
        // Arrange - Set up initial state
        final comments = BuiltList<MwComment>([mockComment]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(comments);
        when(() => mockCommentList.nextAfter).thenReturn('next_token');
        when(() => mockCommentList.hasAfter).thenReturn(true);

        await notifier.fetchInitialComments();

        // Mock a slow response for fetchMore
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
          after: 'next_token',
        )).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return mockResponse;
        });

        // Act
        final future1 = notifier.fetchMoreComments();
        final future2 = notifier.fetchMoreComments();
        
        await future1;
        await future2;

        // Assert
        verify(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
          after: 'next_token',
        )).called(1); // Should only be called once
      });

      test('should revert to previous state if fetchMore fails', () async {
        // Arrange - Set up initial state
        final comments = BuiltList<MwComment>([mockComment]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(comments);
        when(() => mockCommentList.nextAfter).thenReturn('next_token');
        when(() => mockCommentList.hasAfter).thenReturn(true);

        await notifier.fetchInitialComments();

        // Arrange - Set up error for fetchMore
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
          after: 'next_token',
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/test'),
        ));

        // Act
        await notifier.fetchMoreComments();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) {
            expect(comments, hasLength(1)); // Should revert to original state
            expect(hasMore, isTrue);
            expect(isFetchingMore, isFalse);
          },
          error: (message, comments) => fail('Should not be error'),
          empty: () => fail('Should not be empty'),
        );
      });
    });

    group('refresh', () {
      test('should reset pagination and fetch fresh data', () async {
        // Arrange - Set up initial state with pagination
        final comments = BuiltList<MwComment>([mockComment]);
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);
        when(() => mockResponse.data).thenReturn(mockCommentList);
        when(() => mockCommentList.data).thenReturn(comments);
        when(() => mockCommentList.nextAfter).thenReturn('next_token');
        when(() => mockCommentList.hasAfter).thenReturn(true);

        await notifier.fetchInitialComments();

        // Arrange - Set up for refresh
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.refresh();

        // Assert
        verify(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).called(2); // Called once for initial, once for refresh
      });
    });

    group('error handling', () {
      test('should handle 404 error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 404,
          ),
        ));

        // Act
        await notifier.fetchInitialComments();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) => fail('Should not be loaded'),
          error: (message, comments) {
            expect(message, 'Пользователь не найден');
          },
          empty: () => fail('Should not be empty'),
        );
      });

      test('should handle 403 error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 403,
          ),
        ));

        // Act
        await notifier.fetchInitialComments();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) => fail('Should not be loaded'),
          error: (message, comments) {
            expect(message, 'Нет доступа к комментариям этого пользователя');
          },
          empty: () => fail('Should not be empty'),
        );
      });

      test('should handle 429 error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 429,
          ),
        ));

        // Act
        await notifier.fetchInitialComments();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) => fail('Should not be loaded'),
          error: (message, comments) {
            expect(message, 'Слишком много запросов. Попробуйте позже');
          },
          empty: () => fail('Should not be empty'),
        );
      });

      test('should handle generic network error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameCommentsGet(
          name: 'testuser',
          limit: 30,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 500,
          ),
        ));

        // Act
        await notifier.fetchInitialComments();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be initial'),
          loading: () => fail('Should not be loading'),
          loaded: (comments, hasMore, isFetchingMore) => fail('Should not be loaded'),
          error: (message, comments) {
            expect(message, 'Произошла ошибка сети. Проверьте подключение к интернету');
          },
          empty: () => fail('Should not be empty'),
        );
      });
    });
  });
}
