import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';

import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';

// Mock classes
class MockEntriesApi extends Mock implements EntriesApi {}
class MockEntryCacheService extends Mock implements EntryCacheService {}
class MockMwFeed extends Mock implements MwFeed {}
class MockMwEntry extends Mock implements MwEntry {}

// Helper functions for testing state
bool isLoadedState(EntryFeedState state) {
  return state.when(
    initial: () => false,
    loading: () => false,
    loaded: (entries, hasMore, settings) => true,
    error: (message, entries) => false,
    empty: () => false,
  );
}

bool isErrorState(EntryFeedState state) {
  return state.when(
    initial: () => false,
    loading: () => false,
    loaded: (entries, hasMore, settings) => false,
    error: (message, entries) => true,
    empty: () => false,
  );
}

bool isEmptyState(EntryFeedState state) {
  return state.when(
    initial: () => false,
    loading: () => false,
    loaded: (entries, hasMore, settings) => false,
    error: (message, entries) => false,
    empty: () => true,
  );
}

({List<MwEntry> entries, bool hasMore, FeedSettings settings})? getLoadedState(EntryFeedState state) {
  return state.when(
    initial: () => null,
    loading: () => null,
    loaded: (entries, hasMore, settings) => (entries: entries, hasMore: hasMore, settings: settings),
    error: (message, entries) => null,
    empty: () => null,
  );
}

({String message, List<MwEntry>? entries})? getErrorState(EntryFeedState state) {
  return state.when(
    initial: () => null,
    loading: () => null,
    loaded: (entries, hasMore, settings) => null,
    error: (message, entries) => (message: message, entries: entries),
    empty: () => null,
  );
}

void main() {
  group('EntryFeedNotifier', () {
    late MockEntriesApi mockEntriesApi;
    late MockEntryCacheService mockCacheService;
    late EntryFeedNotifier notifier;
    late MockMwFeed mockFeed;
    late List<MwEntry> mockEntries;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockCacheService = MockEntryCacheService();
      mockFeed = MockMwFeed();
      
      // Create mock entries
      mockEntries = [
        MockMwEntry(),
        MockMwEntry(),
        MockMwEntry(),
      ];
      
      // Setup default mock behavior
      when(() => mockFeed.entries).thenReturn(BuiltList(mockEntries));
      when(() => mockFeed.nextAfter).thenReturn('next_after_token');
      when(() => mockFeed.hasAfter).thenReturn(true);
      when(() => mockFeed.nextBefore).thenReturn('next_before_token');
      when(() => mockFeed.hasBefore).thenReturn(false);
      
      when(() => mockCacheService.getEntries(any(), page: any(named: 'page')))
          .thenAnswer((_) async => null);
      when(() => mockCacheService.storeEntries(any(), any(), page: any(named: 'page')))
          .thenAnswer((_) async {});
      when(() => mockCacheService.clearFeedCache(any()))
          .thenAnswer((_) async {});
    });

    group('fetchInitialEntries', () {
      test('should set loading state initially', () async {
        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        // Start fetching
        final future = notifier.fetchInitialEntries();
        
        // Check that state is loading
        expect(notifier.state.when(
          initial: () => false,
          loading: () => true,
          loaded: (entries, hasMore, settings) => false,
          error: (message, entries) => false,
          empty: () => false,
        ), isTrue);
        
        // Wait for completion
        await future;
      });

      test('should load from cache first if available', () async {
        final cachedEntries = [MockMwEntry(), MockMwEntry()];
        
        when(() => mockCacheService.getEntries(any(), page: any(named: 'page')))
            .thenAnswer((_) async => cachedEntries);
        
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        // Should show cached entries first, then API entries
        expect(isLoadedState(notifier.state), isTrue);
        final loadedState = getLoadedState(notifier.state);
        expect(loadedState, isNotNull);
        expect(loadedState!.entries, equals(mockEntries));
        expect(loadedState.hasMore, isTrue);
        
        // Verify cache was checked
        verify(() => mockCacheService.getEntries('live', page: 1)).called(1);
      });

      test('should fetch from API and cache the result', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        expect(isLoadedState(notifier.state), isTrue);
        final loadedState = getLoadedState(notifier.state);
        expect(loadedState!.entries, equals(mockEntries));
        expect(loadedState.hasMore, isTrue);
        
        // Verify API was called and result was cached
        verify(() => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          source_: 'all',
          section: 'entries',
        )).called(1);
        
        verify(() => mockCacheService.storeEntries('live', mockEntries, page: 1)).called(1);
      });

      test('should handle API errors gracefully', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenThrow(Exception('Network error'));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        expect(isErrorState(notifier.state), isTrue);
        final errorState = getErrorState(notifier.state);
        expect(errorState!.message, contains('Network error'));
        expect(errorState.entries, isNull);
      });

      test('should show cached data with error if API fails', () async {
        final cachedEntries = [MockMwEntry()];
        
        when(() => mockCacheService.getEntries(any(), page: any(named: 'page')))
            .thenAnswer((_) async => cachedEntries);
        
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenThrow(Exception('Network error'));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        expect(isErrorState(notifier.state), isTrue);
        final errorState = getErrorState(notifier.state);
        expect(errorState!.message, contains('Network error'));
        expect(errorState.entries, equals(cachedEntries));
      });

      test('should show empty state when no data available', () async {
        when(() => mockFeed.entries).thenReturn(BuiltList([]));
        when(() => mockFeed.hasAfter).thenReturn(false);
        
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        expect(isEmptyState(notifier.state), isTrue);
      });
    });

    group('fetchMoreEntries', () {
      test('should append new entries to existing list', () async {
        final initialEntries = [MockMwEntry(), MockMwEntry()];
        final newEntries = [MockMwEntry(), MockMwEntry()];
        
        when(() => mockFeed.entries).thenReturn(BuiltList(newEntries));
        when(() => mockFeed.nextAfter).thenReturn('new_next_after');
        when(() => mockFeed.hasAfter).thenReturn(false);
        
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        // Set initial state
        notifier.state = EntryFeedState.loaded(
          entries: initialEntries,
          hasMore: true,
          settings: FeedSettings.defaultSettings,
        );

        await notifier.fetchMoreEntries();

        expect(isLoadedState(notifier.state), isTrue);
        final loadedState = getLoadedState(notifier.state);
        expect(loadedState!.entries.length, equals(4)); // 2 initial + 2 new
        expect(loadedState.hasMore, isFalse);
        
        // Verify API was called with correct pagination token
        verify(() => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null, // Should use the stored nextAfter token
          before: null,
          source_: 'all',
          section: 'entries',
        )).called(1);
      });

      test('should not fetch more if already loading', () async {
        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        // Set initial state
        notifier.state = EntryFeedState.loaded(
          entries: [MockMwEntry()],
          hasMore: true,
          settings: FeedSettings.defaultSettings,
        );

        // Start first fetch
        final future1 = notifier.fetchMoreEntries();
        
        // Try to start second fetch while first is still running
        final future2 = notifier.fetchMoreEntries();
        
        await future1;
        await future2;
        
        // Should only call API once
        verify(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).called(1);
      });

      test('should not fetch more if no more entries available', () async {
        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        // Set initial state with hasMore = false
        notifier.state = EntryFeedState.loaded(
          entries: [MockMwEntry()],
          hasMore: false,
          settings: FeedSettings.defaultSettings,
        );

        await notifier.fetchMoreEntries();

        // Should not call API
        verifyNever(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        ));
      });
    });

    group('refresh', () {
      test('should clear cache and fetch fresh data', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.refresh();

        // Verify cache was cleared
        verify(() => mockCacheService.clearFeedCache('live')).called(1);
        
        // Verify fresh data was fetched
        verify(() => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          source_: 'all',
          section: 'entries',
        )).called(1);
      });
    });

    group('updateSettings', () {
      test('should clear cache and refetch with new settings', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        final newSettings = FeedSettings(
          entriesPerPage: 50,
          displayFormat: DisplayFormat.full,
        );

        await notifier.updateSettings(newSettings);

        // Verify cache was cleared
        verify(() => mockCacheService.clearFeedCache('live')).called(1);
        
        // Verify API was called with new limit
        verify(() => mockEntriesApi.entriesLiveGet(
          limit: 50,
          after: null,
          before: null,
          source_: 'all',
          section: 'entries',
        )).called(1);
      });

      test('should not refetch if settings are the same', () async {
        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.updateSettings(FeedSettings.defaultSettings);

        // Should not call API or clear cache
        verifyNever(() => mockCacheService.clearFeedCache(any()));
        verifyNever(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        ));
      });
    });

    group('setFeedParameter', () {
      test('should update parameter and refetch data', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.profile,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        // Set initial state first
        notifier.state = EntryFeedState.loaded(
          entries: [MockMwEntry()],
          hasMore: true,
          settings: FeedSettings.defaultSettings,
        );

        notifier.setFeedParameter('user123');

        // Should reset to initial state immediately, then start loading
        // Check that state is either initial or loading (depending on timing)
        final stateAfterSet = notifier.state.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (entries, hasMore, settings) => 'loaded',
          error: (message, entries) => 'error',
          empty: () => 'empty',
        );
        expect(['initial', 'loading'].contains(stateAfterSet), isTrue);
        
        // Wait for the async fetch to complete
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Should now be in loaded state with new data
        expect(isLoadedState(notifier.state), isTrue);
      });
    });

    group('setTagFilter', () {
      test('should update tag filter and refetch data', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        // Set initial state first
        notifier.state = EntryFeedState.loaded(
          entries: [MockMwEntry()],
          hasMore: true,
          settings: FeedSettings.defaultSettings,
        );

        notifier.setTagFilter('flutter');

        // Should reset to initial state immediately, then start loading
        final stateAfterSet = notifier.state.when(
          initial: () => 'initial',
          loading: () => 'loading',
          loaded: (entries, hasMore, settings) => 'loaded',
          error: (message, entries) => 'error',
          empty: () => 'empty',
        );
        expect(['initial', 'loading'].contains(stateAfterSet), isTrue);
        
        // Wait for the async fetch to complete
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Should now be in loaded state with new data
        expect(isLoadedState(notifier.state), isTrue);
      });

      test('should not refetch if tag filter is the same', () async {
        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
          tagFilter: 'flutter',
        );

        // Set initial state first
        notifier.state = EntryFeedState.loaded(
          entries: [MockMwEntry()],
          hasMore: true,
          settings: FeedSettings.defaultSettings,
        );

        notifier.setTagFilter('flutter');

        // Should not change state since tag is the same
        expect(isLoadedState(notifier.state), isTrue);
      });
    });

    group('tag filtering', () {
      test('should include tag parameter in live feed API call', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
          tagFilter: 'flutter',
        );

        await notifier.fetchInitialEntries();

        verify(() => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          tag: 'flutter',
          source_: 'all',
          section: 'entries',
        )).called(1);
      });

      test('should include tag parameter in best feed API call', () async {
        when(() => mockEntriesApi.entriesBestGet(
          limit: any(named: 'limit'),
          tag: any(named: 'tag'),
          query: any(named: 'query'),
          source_: any(named: 'source_'),
          category: any(named: 'category'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.best,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
          tagFilter: 'dart',
        );

        await notifier.fetchInitialEntries();

        verify(() => mockEntriesApi.entriesBestGet(
          limit: 20,
          tag: 'dart',
          query: null,
          source_: 'all',
          category: 'month',
        )).called(1);
      });

      test('should use tag filter in cache key', () async {
        when(() => mockCacheService.getEntries(any(), page: any(named: 'page')))
            .thenAnswer((_) async => null);
        
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
          tagFilter: 'flutter',
        );

        await notifier.fetchInitialEntries();

        // Verify cache was accessed with tag-specific key
        verify(() => mockCacheService.getEntries('live_tag_flutter', page: 1)).called(1);
        verify(() => mockCacheService.storeEntries('live_tag_flutter', mockEntries, page: 1)).called(1);
      });

      test('should clear tag-specific cache on refresh', () async {
        when(() => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
          tagFilter: 'flutter',
        );

        await notifier.refresh();

        // Verify tag-specific cache was cleared
        verify(() => mockCacheService.clearFeedCache('live_tag_flutter')).called(1);
      });
    });

    group('different feed types', () {
      test('should call correct API method for best feed', () async {
        when(() => mockEntriesApi.entriesBestGet(
          limit: any(named: 'limit'),
          tag: any(named: 'tag'),
          query: any(named: 'query'),
          source_: any(named: 'source_'),
          category: any(named: 'category'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.best,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        verify(() => mockEntriesApi.entriesBestGet(
          limit: 20,
          tag: null,
          query: null,
          source_: 'all',
          category: 'month',
        )).called(1);
      });

      test('should call correct API method for friends feed', () async {
        when(() => mockEntriesApi.entriesFriendsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
          query: any(named: 'query'),
        )).thenAnswer((_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ));

        notifier = EntryFeedNotifier(
          feedType: FeedType.friends,
          entriesApi: mockEntriesApi,
          cacheService: mockCacheService,
        );

        await notifier.fetchInitialEntries();

        verify(() => mockEntriesApi.entriesFriendsGet(
          limit: 20,
          after: null,
          before: null,
          tag: null,
          query: null,
        )).called(1);
      });
    });
  });
}
