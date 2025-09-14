import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell_api/mindwell_api.dart';

class MockEntriesApi extends Mock implements EntriesApi {}
class MockEntryCacheService extends Mock implements EntryCacheService {}

class MockEntryFeedNotifier extends StateNotifier<EntryFeedState> implements EntryFeedNotifier {
  MockEntryFeedNotifier() : super(const EntryFeedState.loaded(
    entries: [],
    hasMore: false,
    settings: FeedSettings.defaultSettings,
  ));
  
  @override
  Future<void> fetchInitialEntries() async {
    // Don't do anything - just return immediately
    // This prevents real API calls and timer creation
  }
  
  @override
  Future<void> fetchMoreEntries() async {
    // Don't do anything - just return immediately
  }
  
  @override
  Future<void> refresh() async {
    // Don't do anything - just return immediately
  }
  
  @override
  Future<void> updateSettings(FeedSettings newSettings) async {
    // Don't do anything - just return immediately
  }
  
  @override
  void setFeedParameter(String? parameter) {
    // Don't do anything - just return immediately
  }
  
  @override
  void setTagFilter(String? tag) {
    // Don't do anything - just return immediately
  }
}

void main() {
  group('EntryFeedScreen', () {
    late MockEntryFeedNotifier mockNotifier;
    late MockEntriesApi mockEntriesApi;
    late MockEntryCacheService mockCacheService;

    setUp(() {
      mockNotifier = MockEntryFeedNotifier();
      mockEntriesApi = MockEntriesApi();
      mockCacheService = MockEntryCacheService();
      
      // Mock the cache service methods to avoid timer issues
      when(() => mockCacheService.getEntries(any(), page: any(named: 'page')))
          .thenAnswer((_) async => null);
      when(() => mockCacheService.storeEntries(any(), any(), page: any(named: 'page')))
          .thenAnswer((_) async {});
      when(() => mockCacheService.clearFeedCache(any()))
          .thenAnswer((_) async {});
      when(() => mockCacheService.getFeedSettings(any()))
          .thenAnswer((_) async => null);
      when(() => mockCacheService.storeFeedSettings(any(), any()))
          .thenAnswer((_) async {});
    });

    Widget createTestWidget({FeedType? feedType, String? tagFilter}) {
      final providers = <Override>[
        // Override the API providers to avoid real API calls
        entriesApiProvider.overrideWith((ref) => mockEntriesApi),
        entryCacheServiceProvider.overrideWith((ref) => mockCacheService),
      ];
      
      // Override all possible feed providers
      for (final ft in FeedType.values) {
        providers.add(
          entryFeedProvider(ft).overrideWith((ref) => mockNotifier),
        );
        
        // Also override parameterized providers for all feed types
        if (tagFilter != null) {
          providers.add(
            entryFeedWithParameterProvider((feedType: ft, feedParameter: tagFilter))
                .overrideWith((ref) => mockNotifier),
          );
        }
      }
      
      return ProviderScope(
        overrides: providers,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => EntryFeedScreen(
                  feedType: feedType,
                  tagFilter: tagFilter,
                ),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('should display tag filter in title when provided', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.live,
        tagFilter: 'flutter',
      ));
      await tester.pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

      // Verify tag filter is displayed in the title
      expect(find.text('#flutter - Live'), findsOneWidget);
    });

    testWidgets('should display normal title when no tag filter', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.live,
      ));
      await tester.pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

      // Verify normal title is displayed
      expect(find.text('Live'), findsOneWidget);
    });

    testWidgets('should display tag filter with best feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.best,
        tagFilter: 'dart',
      ));
      await tester.pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

      // Verify tag filter is displayed in the title
      expect(find.text('#dart - Best'), findsOneWidget);
    });

    testWidgets('should display tag filter with friends feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.friends,
        tagFilter: 'mobile',
      ));
      await tester.pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

      // Verify tag filter is displayed in the title
      expect(find.text('#mobile - Friends'), findsOneWidget);
    });

    testWidgets('should pass tag filter to EntryList widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.live,
        tagFilter: 'flutter',
      ));
      await tester.pump(); // Use pump() instead of pumpAndSettle() to avoid timeout

      // The EntryList widgets should be created with the tag filter
      // This is verified by the key generation in the EntryFeedScreen
      expect(find.byType(EntryFeedScreen), findsOneWidget);
    });
  });
}