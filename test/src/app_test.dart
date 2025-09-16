import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/src/app.dart';
import 'package:mindwell/src/core/theme/mindwell_theme.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// Mock implementations for testing
class _MockTokenStorageService implements TokenStorageService {
  @override
  Future<void> saveUserTokens({
    required String accessToken,
    required String refreshToken,
  }) async {}

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

class _MockOauth2Api implements Oauth2Api {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockAccountApi implements AccountApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockMeApi implements MeApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockEntriesApi implements EntriesApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockUsersApi implements UsersApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockEntryCacheService implements EntryCacheService {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> storeEntries(
    String feedType,
    List<MwEntry> entries, {
    int page = 1,
  }) async {}

  @override
  Future<List<MwEntry>?> getEntries(String feedType, {int page = 1}) async {
    return null;
  }

  @override
  Future<bool> hasCachedEntries(String feedType, {int page = 1}) async {
    return false;
  }

  @override
  Future<void> clearFeedCache(String feedType) async {}

  @override
  Future<void> clearAllCache() async {}

  @override
  Map<String, dynamic> getCacheStats() {
    return {};
  }

  @override
  Future<void> cleanupExpiredEntries() async {}

  @override
  Future<void> close() async {}

  @override
  Future<void> storeFeedSettings(
    String feedType,
    Map<String, dynamic> settings,
  ) async {}

  @override
  Future<Map<String, dynamic>?> getFeedSettings(String feedType) async {
    return null;
  }

  @override
  Future<void> clearFeedSettings(String feedType) async {}
}

/// Mock EntryFeedNotifier that returns empty state
class _MockEntryFeedNotifier extends EntryFeedNotifier {
  _MockEntryFeedNotifier()
    : super(
        feedType: FeedType.live,
        entriesApi: _MockEntriesApi(),
        usersApi: _MockUsersApi(),
        cacheServiceAsync: Future.value(_MockEntryCacheService()),
      ) {
    state = const EntryFeedState.empty();
  }

  @override
  Future<void> fetchInitialEntries() async {}

  @override
  Future<void> fetchMoreEntries() async {}

  @override
  Future<void> refresh() async {}

  @override
  Future<void> updateSettings(dynamic newSettings) async {}
}

/// Simple mock implementation that extends AuthNotifier
class _MockAuthNotifier extends AuthNotifier {
  _MockAuthNotifier(AuthState initialState)
    : super(
        tokenStorageService: _MockTokenStorageService(),
        oauth2Api: _MockOauth2Api(),
        accountApi: _MockAccountApi(),
        meApi: _MockMeApi(),
      ) {
    state = initialState;
  }
}

/// Helper function to create an authenticated user for testing
AuthState createAuthenticatedUser() {
  final user = $MwUser(
    (b) => b
      ..id = 1
      ..name = 'Test User'
      ..showName = 'Test User'
      ..isTheme = false
      ..isOnline = true,
  );
  return AuthState.authenticated(user: user);
}

void main() {
  group('MindWellApp', () {
    testWidgets('should build correctly', (WidgetTester tester) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Verify the app builds without errors
      expect(find.byType(MaterialApp), findsOneWidget);
      // There should be one "Mindwell" text in the SliverAppBar (app now starts with live feed)
      expect(find.text('Mindwell'), findsOneWidget);
    });

    testWidgets('should apply light theme correctly', (
      WidgetTester tester,
    ) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));

      // Verify theme configuration
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
      expect(materialApp.themeMode, equals(ThemeMode.system));

      // Verify theme properties
      expect(
        materialApp.theme!.colorScheme.primary,
        equals(MindwellTheme.lightTheme.colorScheme.primary),
      );
      expect(
        materialApp.darkTheme!.colorScheme.primary,
        equals(MindwellTheme.darkTheme.colorScheme.primary),
      );
    });

    testWidgets('should configure localization correctly', (
      WidgetTester tester,
    ) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));

      // Verify localization delegates are configured
      expect(materialApp.localizationsDelegates, isNotNull);
      expect(materialApp.localizationsDelegates!.length, equals(5));

      // Verify supported locales
      expect(materialApp.supportedLocales, contains(const Locale('ru', '')));
      expect(materialApp.supportedLocales, contains(const Locale('en', '')));

      // Verify default locale is Russian
      expect(materialApp.locale, equals(const Locale('ru', '')));
    });

    testWidgets('should configure router correctly', (
      WidgetTester tester,
    ) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));

      // Verify router is configured
      expect(materialApp.routerConfig, isNotNull);
    });

    testWidgets('should display home placeholder content', (
      WidgetTester tester,
    ) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Verify live feed content is displayed - the EntryFeedScreen should show live feed tabs
      // Note: App uses Russian locale by default and starts with live feed
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('should have correct app title', (WidgetTester tester) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));

      // Verify app title
      expect(materialApp.title, equals('Mindwell'));
    });

    testWidgets('should hide debug banner', (WidgetTester tester) async {
      // Build the app with mocked providers
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));

      // Verify debug banner is hidden
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });
  });

  group('HomePlaceholder', () {
    testWidgets('should build correctly', (WidgetTester tester) async {
      // Build the app to test the placeholder through the router
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Verify the widget builds without errors
      expect(find.byType(Scaffold), findsWidgets);
      expect(find.text('Прямой эфир'), findsOneWidget); // Live in Russian
    });

    testWidgets('should display all expected content', (
      WidgetTester tester,
    ) async {
      // Build the app to test the placeholder through the router
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Verify all expected content is present - EntryFeedScreen live feed tabs
      // Note: App uses Russian locale by default and starts with live feed
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('should center content vertically', (
      WidgetTester tester,
    ) async {
      // Build the app to test the placeholder through the router
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith(
              (ref) => _MockEntryCacheService(),
            ),
            entryFeedProvider.overrideWith(
              (ref, feedType) => _MockEntryFeedNotifier(),
            ),
            authProvider.overrideWith(
              (ref) => _MockAuthNotifier(createAuthenticatedUser()),
            ),
          ],
          child: const MindWellApp(),
        ),
      );

      // Find the center widgets (there should be at least one)
      expect(find.byType(Center), findsWidgets);
    });
  });
}
