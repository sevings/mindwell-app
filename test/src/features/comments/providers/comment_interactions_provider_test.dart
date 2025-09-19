import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/providers/comment_interactions_provider.dart';

class MockVotesApi extends Mock implements VotesApi {}

void main() {
  group('CommentInteractionsNotifier', () {
    late MockVotesApi mockVotesApi;
    late CommentInteractionsNotifier notifier;

    setUp(() {
      mockVotesApi = MockVotesApi();
      notifier = CommentInteractionsNotifier(votesApi: mockVotesApi);
    });

    group('voteComment', () {
      test('should successfully vote up on a comment', () async {
        // Arrange
        const commentId = 123;
        const isUpvote = true;
        final mockRating = MwRating(
          (b) => b
            ..id = commentId
            ..upCount = 5
            ..downCount = 1
            ..vote = 1,
        );

        final mockResponse = Response<MwRating>(
          data: mockRating,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await notifier.voteComment(commentId, isUpvote);

        // Assert
        expect(result, equals(mockRating));
        verify(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).called(1);
      });

      test('should successfully vote down on a comment', () async {
        // Arrange
        const commentId = 123;
        const isUpvote = false;
        final mockRating = MwRating(
          (b) => b
            ..id = commentId
            ..upCount = 4
            ..downCount = 2
            ..vote = -1,
        );

        final mockResponse = Response<MwRating>(
          data: mockRating,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await notifier.voteComment(commentId, isUpvote);

        // Assert
        expect(result, equals(mockRating));
        verify(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).called(1);
      });

      test('should return null when API call fails', () async {
        // Arrange
        const commentId = 123;
        const isUpvote = true;

        when(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/test'),
            ),
          ),
        );

        // Act
        final result = await notifier.voteComment(commentId, isUpvote);

        // Assert
        expect(result, isNull);
        verify(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).called(1);
      });

      test('should return null when response data is null', () async {
        // Arrange
        const commentId = 123;
        const isUpvote = true;

        final mockResponse = Response<MwRating>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await notifier.voteComment(commentId, isUpvote);

        // Assert
        expect(result, isNull);
        verify(
          () =>
              mockVotesApi.commentsIdVotePut(id: commentId, positive: isUpvote),
        ).called(1);
      });
    });

    group('removeVote', () {
      test('should successfully remove vote from a comment', () async {
        // Arrange
        const commentId = 123;
        final mockRating = MwRating(
          (b) => b
            ..id = commentId
            ..upCount = 4
            ..downCount = 1
            ..vote = 0,
        );

        final mockResponse = Response<MwRating>(
          data: mockRating,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockVotesApi.commentsIdVoteDelete(id: commentId),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await notifier.removeVote(commentId);

        // Assert
        expect(result, equals(mockRating));
        verify(
          () => mockVotesApi.commentsIdVoteDelete(id: commentId),
        ).called(1);
      });

      test('should return null when API call fails', () async {
        // Arrange
        const commentId = 123;

        when(() => mockVotesApi.commentsIdVoteDelete(id: commentId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/test'),
            ),
          ),
        );

        // Act
        final result = await notifier.removeVote(commentId);

        // Assert
        expect(result, isNull);
        verify(
          () => mockVotesApi.commentsIdVoteDelete(id: commentId),
        ).called(1);
      });
    });

    group('getVoteStatus', () {
      test('should successfully get vote status for a comment', () async {
        // Arrange
        const commentId = 123;
        final mockRating = MwRating(
          (b) => b
            ..id = commentId
            ..upCount = 5
            ..downCount = 1
            ..vote = 1,
        );

        final mockResponse = Response<MwRating>(
          data: mockRating,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockVotesApi.commentsIdVoteGet(id: commentId),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await notifier.getVoteStatus(commentId);

        // Assert
        expect(result, equals(mockRating));
        verify(() => mockVotesApi.commentsIdVoteGet(id: commentId)).called(1);
      });

      test('should return null when API call fails', () async {
        // Arrange
        const commentId = 123;

        when(() => mockVotesApi.commentsIdVoteGet(id: commentId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/test'),
            ),
          ),
        );

        // Act
        final result = await notifier.getVoteStatus(commentId);

        // Assert
        expect(result, isNull);
        verify(() => mockVotesApi.commentsIdVoteGet(id: commentId)).called(1);
      });
    });
  });
}
