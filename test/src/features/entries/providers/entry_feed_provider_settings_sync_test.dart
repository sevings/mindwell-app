import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';

class MockEntriesApi extends Mock implements EntriesApi {}

class MockUsersApi extends Mock implements UsersApi {}

class MockEntryCacheService extends Mock implements EntryCacheService {}

class MockMwFeed extends Mock implements MwFeed {}

void main() {
  group('EntryFeedProvider Settings Synchronization', () {
    late MockEntriesApi mockEntriesApi;
    late MockUsersApi mockUsersApi;
    late MockEntryCacheService mockCacheService;
    late MockMwFeed mockFeed;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockUsersApi = MockUsersApi();
      mockCacheService = MockEntryCacheService();
      mockFeed = MockMwFeed();
    });

    testWidgets('Settings should be properly synchronized between feed and settings UI', (
      tester,
    ) async {
      // This test reproduces the bug described in the issue:
      // 1. Open live feed, open settings, disable switch source=themes and save
      // 2. Reopen settings - switch should be disabled as expected
      // 3. Press refresh or reopen feed - feed should use new settings (source=users)
      // 4. Restart app and open live feed - feed should use new settings (source=users)
      // 5. Open feed settings - should show new settings with disabled source=themes switch

      // Arrange: Setup initial state with default settings (both sources enabled)
      final initialSettings = FeedSettings.defaultSettings;
      final updatedSettings = initialSettings.copyWith(includeThemes: false);

      // Mock cache service to return initial settings
      when(() => mockCacheService.getFeedSettings('live')).thenAnswer(
        (_) async => {
          'entriesPerPage': initialSettings.entriesPerPage,
          'displayFormat': initialSettings.displayFormat.name,
          'sortOrder': initialSettings.sortOrder.name,
          'includeTlogs': initialSettings.includeTlogs,
          'includeThemes': initialSettings.includeThemes,
        },
      );

      // Mock API response
      when(
        () => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
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

      // Mock cache operations
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
        () => mockCacheService.storeFeedSettings(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockCacheService.clearFeedCache(any()),
      ).thenAnswer((_) async {});

      // Create provider instance
      final provider = EntryFeedNotifier(
        feedType: FeedType.live,
        entriesApi: mockEntriesApi,
        usersApi: mockUsersApi,
        cacheServiceAsync: Future.value(mockCacheService),
      );

      // Wait for initialization
      await tester.pumpAndSettle();

      // Act 1: Initial load should use default settings (both sources enabled)
      await provider.fetchInitialEntries();
      await tester.pumpAndSettle();

      // Verify initial API call uses 'all' source (both enabled)
      verify(
        () => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          tag: null,
          source_: 'all', // Both sources enabled
          section: 'entries',
        ),
      ).called(1);

      // Act 2: Update settings to disable themes
      await provider.updateSettings(updatedSettings);
      await tester.pumpAndSettle();

      // Verify settings were saved to cache
      verify(
        () => mockCacheService.storeFeedSettings('live', {
          'entriesPerPage': 20,
          'displayFormat': 'short',
          'sortOrder': 'newest',
          'includeTlogs': true,
          'includeThemes': false,
        }),
      ).called(1);

      // Verify cache was cleared
      verify(() => mockCacheService.clearFeedCache('live')).called(1);

      // Verify new API call uses 'users' source (only tlogs enabled)
      verify(
        () => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          tag: null,
          source_: 'users', // Only tlogs enabled
          section: 'entries',
        ),
      ).called(1);

      // The test should pass if the settings are properly saved and used
      // This test will fail if there's a settings synchronization issue
    });

    // Note: The second test was simplified to focus on core functionality
    // The main synchronization issue is covered by the first test

    testWidgets('Settings should persist across app restarts', (tester) async {
      // This test verifies that settings are properly loaded from cache when the app restarts

      // Mock cache service to return settings with themes disabled (simulating app restart)
      when(() => mockCacheService.getFeedSettings('live')).thenAnswer(
        (_) async => {
          'entriesPerPage': 20,
          'displayFormat': 'short',
          'sortOrder': 'newest',
          'includeTlogs': true,
          'includeThemes': false, // Themes disabled from previous session
        },
      );

      when(
        () => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
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
        () => mockCacheService.storeFeedSettings(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockCacheService.clearFeedCache(any()),
      ).thenAnswer((_) async {});

      // Create new provider instance (simulating app restart)
      final provider = EntryFeedNotifier(
        feedType: FeedType.live,
        entriesApi: mockEntriesApi,
        usersApi: mockUsersApi,
        cacheServiceAsync: Future.value(mockCacheService),
      );

      await tester.pumpAndSettle();

      // Fetch initial entries (this should load settings from cache)
      await provider.fetchInitialEntries();
      await tester.pumpAndSettle();

      // Verify that the provider loaded settings from cache
      verify(() => mockCacheService.getFeedSettings('live')).called(1);

      // Verify that the API call uses 'users' source (themes disabled from cache)
      verify(
        () => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          tag: null,
          source_: 'users', // Should use cached settings (themes disabled)
          section: 'entries',
        ),
      ).called(1);
    });

    testWidgets('Settings should be synchronized between different feed types', (
      tester,
    ) async {
      // This test verifies that settings are properly synchronized for different feed types
      // (e.g., live feed vs best feed)

      // Mock cache service for both feed types
      when(() => mockCacheService.getFeedSettings('live')).thenAnswer(
        (_) async => {
          'entriesPerPage': 20,
          'displayFormat': 'short',
          'sortOrder': 'newest',
          'includeTlogs': true,
          'includeThemes': true, // Live feed has themes enabled
        },
      );

      when(() => mockCacheService.getFeedSettings('best')).thenAnswer(
        (_) async => {
          'entriesPerPage': 20,
          'displayFormat': 'short',
          'sortOrder': 'newest',
          'includeTlogs': true,
          'includeThemes': false, // Best feed has themes disabled
        },
      );

      when(
        () => mockEntriesApi.entriesLiveGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
          tag: any(named: 'tag'),
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

      when(
        () => mockEntriesApi.entriesBestGet(
          limit: any(named: 'limit'),
          tag: any(named: 'tag'),
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
        () => mockCacheService.storeFeedSettings(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => mockCacheService.clearFeedCache(any()),
      ).thenAnswer((_) async {});

      // Create live feed provider
      final liveProvider = EntryFeedNotifier(
        feedType: FeedType.live,
        entriesApi: mockEntriesApi,
        usersApi: mockUsersApi,
        cacheServiceAsync: Future.value(mockCacheService),
      );

      await tester.pumpAndSettle();
      await liveProvider.fetchInitialEntries();
      await tester.pumpAndSettle();

      // Verify live feed uses 'all' source (both enabled)
      verify(
        () => mockEntriesApi.entriesLiveGet(
          limit: 20,
          after: null,
          before: null,
          tag: null,
          source_: 'all', // Both sources enabled
          section: 'entries',
        ),
      ).called(1);

      // Create best feed provider
      final bestProvider = EntryFeedNotifier(
        feedType: FeedType.best,
        entriesApi: mockEntriesApi,
        usersApi: mockUsersApi,
        cacheServiceAsync: Future.value(mockCacheService),
      );

      await tester.pumpAndSettle();
      await bestProvider.fetchInitialEntries();
      await tester.pumpAndSettle();

      // Verify best feed uses 'users' source (themes disabled)
      verify(
        () => mockEntriesApi.entriesBestGet(
          limit: 20,
          tag: null,
          source_: 'users', // Only tlogs enabled
          category: 'month',
        ),
      ).called(1);

      // Verify that both providers loaded their respective settings from cache
      verify(() => mockCacheService.getFeedSettings('live')).called(1);
      verify(() => mockCacheService.getFeedSettings('best')).called(1);
    });

    testWidgets(
      'Settings should be properly synchronized when refresh is called',
      (tester) async {
        // This test verifies that settings are properly synchronized when refresh is called
        // (e.g., pull-to-refresh functionality)

        final settingsWithThemesDisabled = FeedSettings.defaultSettings
            .copyWith(includeThemes: false);

        // Mock cache service
        when(() => mockCacheService.getFeedSettings('live')).thenAnswer(
          (_) async => {
            'entriesPerPage': 20,
            'displayFormat': 'short',
            'sortOrder': 'newest',
            'includeTlogs': true,
            'includeThemes': true,
          },
        );

        when(
          () => mockEntriesApi.entriesLiveGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
            tag: any(named: 'tag'),
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
          () => mockCacheService.storeFeedSettings(any(), any()),
        ).thenAnswer((_) async {});
        when(
          () => mockCacheService.clearFeedCache(any()),
        ).thenAnswer((_) async {});

        // Create provider instance
        final provider = EntryFeedNotifier(
          feedType: FeedType.live,
          entriesApi: mockEntriesApi,
          usersApi: mockUsersApi,
          cacheServiceAsync: Future.value(mockCacheService),
        );

        await tester.pumpAndSettle();

        // Initial load
        await provider.fetchInitialEntries();
        await tester.pumpAndSettle();

        // Update settings to disable themes
        await provider.updateSettings(settingsWithThemesDisabled);
        await tester.pumpAndSettle();

        // Refresh the feed
        await provider.refresh();
        await tester.pumpAndSettle();

        // Verify that refresh still uses the updated settings
        // The API call should use 'users' source (themes disabled)
        verify(
          () => mockEntriesApi.entriesLiveGet(
            limit: 20,
            after: null,
            before: null,
            tag: null,
            source_: 'users', // Should use the updated settings
            section: 'entries',
          ),
        ).called(2); // Called once in updateSettings, once in refresh

        // Verify that cache was cleared during refresh
        verify(
          () => mockCacheService.clearFeedCache('live'),
        ).called(2); // Called once in updateSettings, once in refresh
      },
    );
  });
}
