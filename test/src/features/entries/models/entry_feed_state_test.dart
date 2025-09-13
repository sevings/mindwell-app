import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';

void main() {
  group('EntryFeedState', () {
    late MwEntry mockEntry;
    late FeedSettings mockSettings;

    setUp(() {
      mockEntry = MwEntry((b) => b
        ..id = 1
        ..title = 'Test Entry'
        ..content = 'Test content'
        ..createdAt = 1234567890.0
        ..author = $MwUser((b) => b
          ..id = 1
          ..name = 'Test User'
        )
      );

      mockSettings = const FeedSettings(
        entriesPerPage: 20,
        displayFormat: DisplayFormat.short,
        sortOrder: SortOrder.newest,
      );
    });

    test('should create initial state', () {
      const state = EntryFeedState.initial();

      expect(state, isA<EntryFeedState>());
    });

    test('should create loading state', () {
      const state = EntryFeedState.loading();

      expect(state, isA<EntryFeedState>());
    });

    test('should create loaded state with required parameters', () {
      final state = EntryFeedState.loaded(
        entries: [mockEntry],
        settings: mockSettings,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (entries, hasMore, settings) {
          expect(entries, [mockEntry]);
          expect(hasMore, false); // default value
          expect(settings, mockSettings);
        },
        error: (message, entries) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });

    test('should create loaded state with hasMore true', () {
      final state = EntryFeedState.loaded(
        entries: [mockEntry],
        hasMore: true,
        settings: mockSettings,
      );

      state.when(
        initial: () => fail('Expected loaded state'),
        loading: () => fail('Expected loaded state'),
        loaded: (entries, hasMore, settings) {
          expect(entries, [mockEntry]);
          expect(hasMore, true);
          expect(settings, mockSettings);
        },
        error: (message, entries) => fail('Expected loaded state'),
        empty: () => fail('Expected loaded state'),
      );
    });

    test('should create error state with message', () {
      const state = EntryFeedState.error(
        message: 'Network error',
      );

      state.when(
        initial: () => fail('Expected error state'),
        loading: () => fail('Expected error state'),
        loaded: (entries, hasMore, settings) => fail('Expected error state'),
        error: (message, entries) {
          expect(message, 'Network error');
          expect(entries, isNull);
        },
        empty: () => fail('Expected error state'),
      );
    });

    test('should create error state with previous entries', () {
      final state = EntryFeedState.error(
        message: 'Network error',
        entries: [mockEntry],
      );

      state.when(
        initial: () => fail('Expected error state'),
        loading: () => fail('Expected error state'),
        loaded: (entries, hasMore, settings) => fail('Expected error state'),
        error: (message, entries) {
          expect(message, 'Network error');
          expect(entries, [mockEntry]);
        },
        empty: () => fail('Expected error state'),
      );
    });

    test('should create empty state', () {
      const state = EntryFeedState.empty();

      expect(state, isA<EntryFeedState>());
    });

    test('should be immutable', () {
      final state1 = EntryFeedState.loaded(
        entries: [mockEntry],
        settings: mockSettings,
      );
      final state2 = EntryFeedState.loaded(
        entries: [mockEntry],
        settings: mockSettings,
      );

      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
    });

    test('should support pattern matching', () {
      const loadingState = EntryFeedState.loading();
      const emptyState = EntryFeedState.empty();

      expect(
        loadingState.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (entries, hasMore, settings) => 'loaded',
          error: (message, entries) => 'error',
          empty: () => 'empty',
        ),
        'loading',
      );

      expect(
        emptyState.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (entries, hasMore, settings) => 'loaded',
          error: (message, entries) => 'error',
          empty: () => 'empty',
        ),
        'empty',
      );
    });

    test('should support maybeWhen', () {
      const loadingState = EntryFeedState.loading();

      final result = loadingState.maybeWhen(
        loading: () => 'loading',
        orElse: () => 'other',
      );

      expect(result, 'loading');
    });

    test('should support map', () {
      final loadedState = EntryFeedState.loaded(
        entries: [mockEntry],
        settings: mockSettings,
      );

      final result = loadedState.map(
        initial: (state) => 'initial',
        loading: (state) => 'loading',
        loaded: (state) => 'loaded: ${state.entries.length} entries',
        error: (state) => 'error: ${state.message}',
        empty: (state) => 'empty',
      );

      expect(result, 'loaded: 1 entries');
    });
  });
}
