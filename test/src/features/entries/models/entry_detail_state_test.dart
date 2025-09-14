import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/models/entry_detail_state.dart';

// Mock classes
class MockMwEntry extends Mock implements MwEntry {}
class MockMwComment extends Mock implements MwComment {}
class MockMwUser extends Mock implements MwUser {}
class MockMwRating extends Mock implements MwRating {}

void main() {
  group('EntryDetailState', () {
    late MockMwEntry mockEntry;
    late MockMwComment mockComment;
    late MockMwUser mockUser;
    late MockMwRating mockRating;

    setUp(() {
      mockUser = MockMwUser();
      mockRating = MockMwRating();
      mockEntry = MockMwEntry();
      mockComment = MockMwComment();

      // Setup default mock responses
      when(() => mockUser.id).thenReturn(1);
      when(() => mockUser.name).thenReturn('testuser');

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

      when(() => mockComment.id).thenReturn(456);
      when(() => mockComment.content).thenReturn('Test comment');
      when(() => mockComment.author).thenReturn(mockUser);
      when(() => mockComment.entryId).thenReturn(123);
      when(() => mockComment.createdAt).thenReturn(1640995200.0);
    });

    test('should create initial state', () {
      const state = EntryDetailState.initial();
      
      expect(state, isA<EntryDetailState>());
      expect(state.when(
        initial: () => true,
        loading: () => false,
        loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => false,
        error: (message, entry) => false,
      ), isTrue);
    });

    test('should create loading state', () {
      const state = EntryDetailState.loading();
      
      expect(state, isA<EntryDetailState>());
      expect(state.when(
        initial: () => false,
        loading: () => true,
        loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => false,
        error: (message, entry) => false,
      ), isTrue);
    });

    test('should create loaded state with default values', () {
      final state = EntryDetailState.loaded(entry: mockEntry);
      
      expect(state, isA<EntryDetailState>());
      
      final result = state.when(
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
      
      expect(result, isNotNull);
      expect(result!.entry, equals(mockEntry));
      expect(result.comments, isEmpty);
      expect(result.hasMoreComments, isFalse);
      expect(result.isLoadingComments, isFalse);
    });

    test('should create loaded state with custom values', () {
      final comments = [mockComment];
      final state = EntryDetailState.loaded(
        entry: mockEntry,
        comments: comments,
        hasMoreComments: true,
        isLoadingComments: true,
      );
      
      expect(state, isA<EntryDetailState>());
      
      final result = state.when(
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
      
      expect(result, isNotNull);
      expect(result!.entry, equals(mockEntry));
      expect(result.comments, equals(comments));
      expect(result.hasMoreComments, isTrue);
      expect(result.isLoadingComments, isTrue);
    });

    test('should create error state without entry', () {
      const state = EntryDetailState.error(message: 'Test error');
      
      expect(state, isA<EntryDetailState>());
      
      final result = state.when(
        initial: () => null,
        loading: () => null,
        loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => null,
        error: (message, entry) => (message: message, entry: entry),
      );
      
      expect(result, isNotNull);
      expect(result!.message, equals('Test error'));
      expect(result.entry, isNull);
    });

    test('should create error state with entry', () {
      final state = EntryDetailState.error(
        message: 'Test error',
        entry: mockEntry,
      );
      
      expect(state, isA<EntryDetailState>());
      
      final result = state.when(
        initial: () => null,
        loading: () => null,
        loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => null,
        error: (message, entry) => (message: message, entry: entry),
      );
      
      expect(result, isNotNull);
      expect(result!.message, equals('Test error'));
      expect(result.entry, equals(mockEntry));
    });

    test('should support equality comparison', () {
      const state1 = EntryDetailState.initial();
      const state2 = EntryDetailState.initial();
      const state3 = EntryDetailState.loading();
      
      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
      
      final loadedState1 = EntryDetailState.loaded(entry: mockEntry);
      final loadedState2 = EntryDetailState.loaded(entry: mockEntry);
      final loadedState3 = EntryDetailState.loaded(
        entry: mockEntry,
        comments: [mockComment],
      );
      
      expect(loadedState1, equals(loadedState2));
      expect(loadedState1, isNot(equals(loadedState3)));
    });

    test('should support toString', () {
      const initialState = EntryDetailState.initial();
      const loadingState = EntryDetailState.loading();
      final loadedState = EntryDetailState.loaded(entry: mockEntry);
      const errorState = EntryDetailState.error(message: 'Test error');
      
      expect(initialState.toString(), contains('initial'));
      expect(loadingState.toString(), contains('loading'));
      expect(loadedState.toString(), contains('loaded'));
      expect(errorState.toString(), contains('error'));
    });

    test('should support pattern matching', () {
      final loadedState = EntryDetailState.loaded(
        entry: mockEntry,
        comments: [mockComment],
        hasMoreComments: true,
        isLoadingComments: false,
      );
      
      // Test pattern matching with when
      final result = loadedState.when(
        initial: () => 'initial',
        loading: () => 'loading',
        loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => 
            'loaded: ${entry.id}, ${comments.length} comments, hasMore: $hasMoreComments, loading: $isLoadingComments',
        error: (message, entry) => 'error: $message',
      );
      
      expect(result, equals('loaded: 123, 1 comments, hasMore: true, loading: false'));
    });
  });
}
