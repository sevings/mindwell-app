import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:mindwell/src/features/comments/models/comment_feed_state.dart';

void main() {
  group('CommentFeedState', () {
    late MwComment mockComment;

    setUp(() {
      mockComment = MwComment((b) => b
        ..id = 1
        ..content = 'Test comment content'
        ..createdAt = 1234567890.0
        ..entryId = 1
        ..author = $MwUser((b) => b
          ..id = 1
          ..name = 'Test User'
        )
        ..rating = MwRating((b) => b
          ..rating = 0.0
          ..upCount = 0
          ..downCount = 0
        ).toBuilder()
      );
    });

    test('should create initial state', () {
      const state = CommentFeedState.initial();

      expect(state, isA<CommentFeedState>());
    });

    test('should create loading state', () {
      const state = CommentFeedState.loading();

      expect(state, isA<CommentFeedState>());
    });

    test('should create loaded state with required parameters', () {
      final state = CommentFeedState.loaded(
        comments: [mockComment],
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (comments, hasMore, isFetchingMore) {
          expect(comments, [mockComment]);
          expect(hasMore, false); // default value
          expect(isFetchingMore, false); // default value
        },
        error: (message, comments) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });

    test('should create loaded state with hasMore true', () {
      final state = CommentFeedState.loaded(
        comments: [mockComment],
        hasMore: true,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (comments, hasMore, isFetchingMore) {
          expect(comments, [mockComment]);
          expect(hasMore, true);
          expect(isFetchingMore, false); // default value
        },
        error: (message, comments) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });

    test('should create loaded state with isFetchingMore true', () {
      final state = CommentFeedState.loaded(
        comments: [mockComment],
        isFetchingMore: true,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (comments, hasMore, isFetchingMore) {
          expect(comments, [mockComment]);
          expect(hasMore, false); // default value
          expect(isFetchingMore, true);
        },
        error: (message, comments) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });

    test('should create loaded state with all parameters', () {
      final state = CommentFeedState.loaded(
        comments: [mockComment],
        hasMore: true,
        isFetchingMore: true,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (comments, hasMore, isFetchingMore) {
          expect(comments, [mockComment]);
          expect(hasMore, true);
          expect(isFetchingMore, true);
        },
        error: (message, comments) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });

    test('should create error state with message', () {
      const state = CommentFeedState.error(
        message: 'Network error',
      );

      state.when(
        initial: () => fail('Expected error state'),
        loading: () => fail('Expected error state'),
        loaded: (comments, hasMore, isFetchingMore) => fail('Expected loaded state'),
        error: (message, comments) {
          expect(message, 'Network error');
          expect(comments, isNull);
        },
        empty: () => fail('Expected error state'),
      );
    });

    test('should create error state with previous comments', () {
      final state = CommentFeedState.error(
        message: 'Network error',
        comments: [mockComment],
      );

      state.when(
        initial: () => fail('Expected error state'),
        loading: () => fail('Expected error state'),
        loaded: (comments, hasMore, isFetchingMore) => fail('Expected loaded state'),
        error: (message, comments) {
          expect(message, 'Network error');
          expect(comments, [mockComment]);
        },
        empty: () => fail('Expected error state'),
      );
    });

    test('should create empty state', () {
      const state = CommentFeedState.empty();

      expect(state, isA<CommentFeedState>());
    });

    test('should be immutable', () {
      final state1 = CommentFeedState.loaded(
        comments: [mockComment],
      );
      final state2 = CommentFeedState.loaded(
        comments: [mockComment],
      );

      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
    });

    test('should support pattern matching', () {
      const loadingState = CommentFeedState.loading();
      const emptyState = CommentFeedState.empty();

      expect(
        loadingState.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (comments, hasMore, isFetchingMore) => 'loaded',
          error: (message, comments) => 'error',
          empty: () => 'empty',
        ),
        'loading',
      );

      expect(
        emptyState.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (comments, hasMore, isFetchingMore) => 'loaded',
          error: (message, comments) => 'error',
          empty: () => 'empty',
        ),
        'empty',
      );
    });

    test('should support maybeWhen', () {
      const loadingState = CommentFeedState.loading();

      final result = loadingState.maybeWhen(
        loading: () => 'loading',
        orElse: () => 'other',
      );

      expect(result, 'loading');
    });

    test('should support map', () {
      final loadedState = CommentFeedState.loaded(
        comments: [mockComment],
      );

      final result = loadedState.map(
        initial: (state) => 'initial',
        loading: (state) => 'loading',
        loaded: (state) => 'loaded: ${state.comments.length} comments',
        error: (state) => 'error: ${state.message}',
        empty: (state) => 'empty',
      );

      expect(result, 'loaded: 1 comments');
    });

    test('should handle multiple comments in loaded state', () {
      final comment2 = MwComment((b) => b
        ..id = 2
        ..content = 'Second comment'
        ..createdAt = 1234567891.0
        ..entryId = 1
        ..author = $MwUser((b) => b
          ..id = 2
          ..name = 'Another User'
        )
        ..rating = MwRating((b) => b
          ..rating = 0.0
          ..upCount = 0
          ..downCount = 0
        ).toBuilder()
      );

      final state = CommentFeedState.loaded(
        comments: [mockComment, comment2],
        hasMore: true,
        isFetchingMore: false,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (comments, hasMore, isFetchingMore) {
          expect(comments, hasLength(2));
          expect(comments, [mockComment, comment2]);
          expect(hasMore, true);
          expect(isFetchingMore, false);
        },
        error: (message, comments) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });
  });
}
