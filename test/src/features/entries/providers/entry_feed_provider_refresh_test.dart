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

class MockUsersApi extends Mock implements UsersApi {}

class MockEntryCacheService extends Mock implements EntryCacheService {}

class MockMwFeed extends Mock implements MwFeed {}

class MockMwEntry extends Mock implements MwEntry {}

void main() {
  group('EntryFeedNotifier - Refresh Settings Fix', () {
    late MockEntriesApi mockEntriesApi;
    late MockUsersApi mockUsersApi;
    late MockEntryCacheService mockCacheService;
    late EntryFeedNotifier notifier;
    late MockMwFeed mockFeed;
    late List<MwEntry> mockEntries;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockUsersApi = MockUsersApi();
      mockCacheService = MockEntryCacheService();
      mockFeed = MockMwFeed();

      // Create mock entries
      mockEntries = [MockMwEntry(), MockMwEntry(), MockMwEntry()];

      // Setup default mock behavior
      when(() => mockFeed.entries).thenReturn(BuiltList(mockEntries));
      when(() => mockFeed.nextAfter).thenReturn('next_after_token');
      when(() => mockFeed.hasAfter).thenReturn(true);
      when(() => mockFeed.nextBefore).thenReturn('next_before_token');
      when(() => mockFeed.hasBefore).thenReturn(false);

      when(
        () => mockCacheService.getEntries(any(), page: any(named: 'page')),
      ).thenAnswer((_) async => null);
      when(
        () => mockCacheService.storeEntries(
          any(),
          any(),
          page: any(named: 'page'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockCacheService.clearFeedCache(any()),
      ).thenAnswer((_) async {});
    });

    test(
      'refresh should use current settings from state, not default settings',
      () async {
        when(
          () => mockEntriesApi.entriesLiveGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
            source_: any(named: 'source_'),
            section: any(named: 'section'),
          ),
        ).thenAnswer(
          (_) async => Response<MwFeed>(
            data: mockFeed,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        notifier = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          usersApi: mockUsersApi,
          cacheServiceAsync: Future.value(mockCacheService),
        );

        // Set initial state with custom settings
        final customSettings = FeedSettings(
          entriesPerPage: 50,
          displayFormat: DisplayFormat.full,
          includeTlogs: false,
          includeThemes: true,
        );

        notifier.state = EntryFeedState.loaded(
          entries: [],
          hasMore: false,
          settings: customSettings,
        );

        // Now call refresh - it should use the custom settings from state
        await notifier.refresh();

        // Verify that the API was called with the custom settings (50 entries, themes only)
        verify(
          () => mockEntriesApi.entriesLiveGet(
            limit: 50, // Should use custom settings, not default 20
            after: null,
            before: null,
            source_:
                'themes', // Should use custom settings (themes only), not default 'all'
            section: 'entries',
          ),
        ).called(1);
      },
    );

    test('refresh should preserve settings after multiple updates', () async {
      when(
        () => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        ),
      ).thenAnswer(
        (_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ),
      );

      notifier = EntryFeedNotifier(
        feedType: FeedType.live,
        entriesApi: mockEntriesApi,
        usersApi: mockUsersApi,
        cacheServiceAsync: Future.value(mockCacheService),
      );

      // Make multiple settings updates
      await notifier.updateSettings(FeedSettings(entriesPerPage: 10));
      await notifier.updateSettings(
        FeedSettings(entriesPerPage: 10, displayFormat: DisplayFormat.full),
      );

      final finalSettings = FeedSettings(
        entriesPerPage: 10,
        displayFormat: DisplayFormat.full,
        includeTlogs: false,
        includeThemes: true,
      );
      await notifier.updateSettings(finalSettings);

      // Now call refresh - it should use the final settings
      await notifier.refresh();

      // Verify that the API was called with the final settings
      // Note: updateSettings also calls fetchInitialEntries, so we expect 2 calls total
      verify(
        () => mockEntriesApi.entriesLiveGet(
          limit: 10, // Should use final settings
          after: null,
          before: null,
          source_: 'themes', // Should use final settings (themes only)
          section: 'entries',
        ),
      ).called(2); // 1 from updateSettings + 1 from refresh
    });

    test(
      'refresh should work correctly for different feed types with custom settings',
      () async {
        when(
          () => mockEntriesApi.entriesBestGet(
            limit: any(named: 'limit'),
            tag: any(named: 'tag'),
            query: any(named: 'query'),
            source_: any(named: 'source_'),
            category: any(named: 'category'),
          ),
        ).thenAnswer(
          (_) async => Response<MwFeed>(
            data: mockFeed,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        notifier = EntryFeedNotifier(
          feedType: FeedType.best,
          entriesApi: mockEntriesApi,
          usersApi: mockUsersApi,
          cacheServiceAsync: Future.value(mockCacheService),
        );

        // Set custom settings for best feed
        final bestFeedSettings = FeedSettings(
          entriesPerPage: 30,
          includeTlogs: true,
          includeThemes: false,
        );

        notifier.state = EntryFeedState.loaded(
          entries: [],
          hasMore: false,
          settings: bestFeedSettings,
        );

        // Call refresh
        await notifier.refresh();

        // Verify that the API was called with the custom settings
        verify(
          () => mockEntriesApi.entriesBestGet(
            limit: 30, // Should use custom settings
            tag: null,
            query: null,
            source_: 'users', // Should use custom settings (tlogs only)
            category: 'month',
          ),
        ).called(1);
      },
    );

    test('refresh should handle state transitions correctly', () async {
      when(
        () => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        ),
      ).thenAnswer(
        (_) async => Response<MwFeed>(
          data: mockFeed,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        ),
      );

      notifier = EntryFeedNotifier(
        feedType: FeedType.live,
        entriesApi: mockEntriesApi,
        usersApi: mockUsersApi,
        cacheServiceAsync: Future.value(mockCacheService),
      );

      // Test with different state types
      final customSettings = FeedSettings(entriesPerPage: 25);

      // Test with loaded state
      notifier.state = EntryFeedState.loaded(
        entries: [],
        hasMore: false,
        settings: customSettings,
      );
      await notifier.refresh();

      // Test with error state (should fall back to internal settings)
      notifier.state = EntryFeedState.error(message: 'Test error', entries: []);
      await notifier.refresh();

      // Test with empty state (should fall back to internal settings)
      notifier.state = const EntryFeedState.empty();
      await notifier.refresh();

      // Verify API was called multiple times
      verify(
        () => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          source_: any(named: 'source_'),
          section: any(named: 'section'),
        ),
      ).called(3);
    });
  });
}
