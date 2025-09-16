import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell_api/mindwell_api.dart';

class MockEntriesApi extends Mock implements EntriesApi {}
class MockUsersApi extends Mock implements UsersApi {}
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

class MockAuthNotifier extends AuthNotifier {
  MockAuthNotifier(AuthState initialState) : super(
    tokenStorageService: MockTokenStorageService(),
    oauth2Api: MockOauth2Api(),
    accountApi: MockAccountApi(),
    meApi: MockMeApi(),
  ) {
    state = initialState;
  }
}

class MockTokenStorageService implements TokenStorageService {
  @override
  Future<void> saveUserTokens({required String accessToken, required String refreshToken}) async {}

  @override
  Future<void> saveAppToken(String appToken) async {}

  @override
  Future<String?> getAccessToken() async => null;

  @override
  Future<String?> getRefreshToken() async => null;

  @override
  Future<String?> getAppToken() async => null;

  @override
  Future<bool> hasUserTokens() async => false;

  @override
  Future<bool> hasAppToken() async => false;

  @override
  Future<void> clearUserTokens() async {}

  @override
  Future<void> clearAppToken() async {}
}

class MockOauth2Api implements Oauth2Api {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class MockAccountApi implements AccountApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class MockMeApi implements MeApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  group('EntryFeedScreen My Entries', () {
    late MockEntryFeedNotifier mockNotifier;
    late MockEntriesApi mockEntriesApi;
    late MockUsersApi mockUsersApi;
    late MockEntryCacheService mockCacheService;

    setUp(() {
      mockNotifier = MockEntryFeedNotifier();
      mockEntriesApi = MockEntriesApi();
      mockUsersApi = MockUsersApi();
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

    Widget createTestWidget({AuthState? authState}) {
      final overrides = <Override>[
        entriesApiProvider.overrideWith((ref) => mockEntriesApi),
        usersApiProvider.overrideWith((ref) => mockUsersApi),
        entryCacheServiceProvider.overrideWith((ref) => mockCacheService),
        // Override all possible feed providers
        for (final ft in FeedType.values) ...[
          // Override the unified feed provider for all feed types
          entryFeedProvider((feedType: ft, feedParameter: null)).overrideWith((ref) => mockNotifier),
        ],
      ];
      
      if (authState != null) {
        overrides.add(authProvider.overrideWith((ref) => MockAuthNotifier(authState)));
      }
      
      return ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          home: Scaffold(
            body: EntryFeedScreen(feedType: FeedType.profile),
          ),
        ),
      );
    }

    testWidgets('should render my entries screen without error when authenticated', (WidgetTester tester) async {
      // Arrange
      final user = $MwUser((b) => b
        ..id = 1
        ..name = 'Test User'
        ..showName = 'Test User'
        ..isTheme = false
        ..isOnline = true
      );
      final authState = AuthState.authenticated(user: user);
      
      // Act
      await tester.pumpWidget(createTestWidget(authState: authState));
      await tester.pump();
      
      // Assert - should render without throwing an error
      expect(find.byType(EntryFeedScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle profile feed type correctly', (WidgetTester tester) async {
      // Arrange
      final user = $MwUser((b) => b
        ..id = 123
        ..name = 'Test User'
        ..showName = 'Test User'
        ..isTheme = false
        ..isOnline = true
      );
      final authState = AuthState.authenticated(user: user);
      
      // Act
      await tester.pumpWidget(createTestWidget(authState: authState));
      await tester.pump();
      
      // Assert - should render the profile feed screen
      expect(find.byType(EntryFeedScreen), findsOneWidget);
      // Should not throw the "Profile feed requires a user ID parameter" error
      expect(tester.takeException(), isNull);
    });
  });
}
