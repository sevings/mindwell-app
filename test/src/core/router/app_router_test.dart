import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/src/core/router/app_router.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/profile/screens/profile_screen.dart';
import 'package:mindwell/src/features/profile/providers/profile_provider.dart';
import 'package:mindwell/src/features/profile/models/profile_state.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/src/core/widgets/notification_shimmer.dart';
import 'package:mindwell/src/features/notifications/providers/notification_list_provider.dart';
import 'package:mindwell/src/features/notifications/models/notification_list_state.dart';
import 'package:mindwell/src/features/chat/providers/chat_list_provider.dart';
import 'package:mindwell/src/features/chat/models/chat_list_state.dart';

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

class _MockNotificationsApi implements NotificationsApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockNotificationListNotifier extends StateNotifier<NotificationListState>
    implements NotificationListNotifier {
  _MockNotificationListNotifier()
    : super(const NotificationListState.initial());

  @override
  Future<void> fetchInitialNotifications() async {}

  @override
  Future<void> fetchMoreNotifications() async {}

  @override
  Future<void> refresh() async {}

  @override
  Future<void> markAsRead(int notificationId) async {}

  @override
  Future<void> markAllAsRead() async {}

  @override
  void clearAnimationFlags(Set<int> notificationIds) {}
}

class _MockEntriesApi implements EntriesApi {
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

class _MockUsersApi implements UsersApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockRelationsApi implements RelationsApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockChatsApi implements ChatsApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

/// Mock WebsocketService for testing
class _MockWebsocketService extends WebSocketService {
  _MockWebsocketService()
    : super(accountApi: _MockAccountApi(), ref: _MockRef());
}

/// Mock ChatListNotifier that doesn't make HTTP requests
class _MockChatListNotifier extends ChatListNotifier {
  _MockChatListNotifier() : super(_MockRef()) {
    state = const ChatListState.loaded(chats: [], hasMore: false);
  }

  // Override the private method to prevent HTTP requests
  // ignore: unused_element
  Future<void> _loadInitialChats() async {
    // Do nothing to prevent HTTP requests
  }
}

/// Mock Ref for testing
class _MockRef implements Ref {
  @override
  T read<T>(ProviderListenable<T> provider) {
    // Return mock APIs when requested
    if (provider.runtimeType == chatsApiProvider.runtimeType) {
      return _MockChatsApi() as T;
    }
    if (provider.runtimeType.toString().contains('WebsocketServiceProvider') ||
        provider.runtimeType.toString().contains('websocketServiceProvider') ||
        provider.runtimeType.toString().contains('WebSocketService') ||
        T.toString().contains('WebSocketService')) {
      return _MockWebsocketService() as T;
    }
    if (provider.runtimeType.toString().contains('accountApiProvider') ||
        provider.runtimeType.toString().contains('AccountApiProvider')) {
      return _MockAccountApi() as T;
    }
    throw UnimplementedError(
      'Provider not mocked: $provider (type: ${T.toString()})',
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

/// Mock ProfileNotifier that doesn't make HTTP requests
class _MockProfileNotifier extends ProfileNotifier {
  _MockProfileNotifier(ProfileState initialState)
    : super(
        username: 'test',
        usersApi: _MockUsersApi(),
        relationsApi: _MockRelationsApi(),
        meApi: _MockMeApi(),
      ) {
    state = initialState;
  }

  @override
  Future<void> fetchProfileData() async {
    // Override to prevent HTTP requests
  }
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

/// Helper function to wrap widgets with localization support for testing
Widget createTestWidget(Widget child, {AuthState? authState}) {
  final overrides = <Override>[
    entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
    entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
    entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
    usersApiProvider.overrideWith((ref) => _MockUsersApi()),
    notificationsApiProvider.overrideWith((ref) => _MockNotificationsApi()),
    chatsApiProvider.overrideWith((ref) => _MockChatsApi()),
    // Override notificationListProvider to prevent HTTP requests
    notificationListProvider.overrideWith(
      (ref) => _MockNotificationListNotifier(),
    ),
    // Override chatListProvider to prevent HTTP requests
    chatListProvider.overrideWith((ref) => _MockChatListNotifier()),
    // Override profileProvider to prevent HTTP requests
    profileProvider.overrideWith(
      (ref, username) => _MockProfileNotifier(const ProfileState.initial()),
    ),
  ];

  if (authState != null) {
    overrides.add(
      authProvider.overrideWith((ref) => _MockAuthNotifier(authState)),
    );
  }

  return ProviderScope(
    overrides: overrides,
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', ''), Locale('en', '')],
      locale: const Locale('ru', ''),
      builder: (context, child) => child ?? const SizedBox.shrink(),
    ),
  );
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
  group('AppRouter', () {
    testWidgets('navigates to home route correctly', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Assert - Check if EntryFeedScreen is rendered
      expect(find.byType(EntryFeedScreen), findsOneWidget);
      // Check if TabBar is present
      expect(find.byType(TabBar), findsOneWidget);
    });

    testWidgets('navigates to notifications route', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Navigate to notifications
      AppRouter.router.go('/notifications');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - Check if we're on the notifications route
      // The notifications content should be displayed
      expect(find.text('Notifications'), findsAtLeastNWidgets(1));
      // The notifications screen should be displayed (check for the shimmer loading state)
      expect(find.byType(NotificationShimmer), findsOneWidget);

      // Clean up any pending timers by pumping a few more times
      await tester.pump();
      await tester.pump();
    });

    testWidgets('navigates to chat route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Navigate to chat
      AppRouter.router.go('/chats');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert
      expect(
        find.text('Chats'),
        findsAtLeastNWidgets(1),
      ); // App bar title and nav bar label

      // Clean up any pending timers by pumping a few more times
      await tester.pump();
      await tester.pump();
    });

    testWidgets('navigates to login route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Navigate to login - authenticated users get redirected to live feed
      AppRouter.router.go('/login');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should be redirected to live feed since user is authenticated
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('navigates to register route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Navigate to register - authenticated users get redirected to home
      AppRouter.router.go('/register');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should be redirected to live feed since user is authenticated
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('displays error screen for invalid route', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Navigate to invalid route
      AppRouter.router.go('/invalid-route');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - Error screen should be displayed
      expect(find.text('Что-то пошло не так'), findsOneWidget);
      expect(find.text('На главную'), findsOneWidget);
    });

    testWidgets('error screen go home button navigates to home', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Navigate to invalid route
      AppRouter.router.go('/invalid-route');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Tap go home button
      await tester.tap(find.text('На главную'));
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - Should be back on live feed page
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('router has correct initial location', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );
      await tester.pump();

      // Assert
      expect(
        AppRouter.router.routerDelegate.currentConfiguration.uri.path,
        equals('/'),
      );
    });

    testWidgets('shell route wraps authenticated screens', (
      WidgetTester tester,
    ) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          const SizedBox.shrink(),
          authState: createAuthenticatedUser(),
        ),
      );

      // Wait for the app to fully load
      await tester.pumpAndSettle();

      // Assert - should have HomeScreen structure with feed content
      // The app should show feed content (Russian text indicates the feed is working)
      expect(find.text('Прямой эфир'), findsOneWidget);
      // There is one AppBar (either from HomeScreen or EntryFeedScreen)
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Authentication Route Guards', () {
    testWidgets(
      'redirects unauthenticated user from protected routes to login',
      (WidgetTester tester) async {
        // Arrange
        const authState = AuthState.unauthenticated();

        // Act
        await tester.pumpWidget(
          createTestWidget(const SizedBox.shrink(), authState: authState),
        );
        await tester.pump();

        // Try to navigate to protected route
        AppRouter.router.go('/profile');
        await tester.pump();
        await tester.pump(); // Additional pump to ensure navigation completes

        // Assert - should be redirected to login
        expect(
          find.text('Войти'),
          findsNWidgets(2),
        ); // AppBar title and body text
      },
    );

    testWidgets('redirects authenticated user from login to home', (
      WidgetTester tester,
    ) async {
      // Arrange
      final user = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'Test User'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true,
      );
      final authState = AuthState.authenticated(user: user);

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Try to navigate to login
      AppRouter.router.go('/login');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should be redirected to live feed
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('redirects authenticated user from register to home', (
      WidgetTester tester,
    ) async {
      // Arrange
      final user = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'Test User'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true,
      );
      final authState = AuthState.authenticated(user: user);

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Try to navigate to register
      AppRouter.router.go('/register');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should be redirected to live feed
      // Check for TabBar to ensure tabs are present
      expect(find.byType(TabBar), findsOneWidget);
      // Check for at least one tab (the tabs might not be fully rendered in test environment)
      expect(find.byType(Tab), findsWidgets);
    });

    testWidgets('allows unauthenticated user to access login route', (
      WidgetTester tester,
    ) async {
      // Arrange
      const authState = AuthState.unauthenticated();

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Navigate to login
      AppRouter.router.go('/login');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should stay on login page
      expect(
        find.text('Войти'),
        findsNWidgets(2),
      ); // AppBar title and body text
    });

    testWidgets('allows unauthenticated user to access register route', (
      WidgetTester tester,
    ) async {
      // Arrange
      const authState = AuthState.unauthenticated();

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Navigate to register
      AppRouter.router.go('/register');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should stay on register page
      expect(
        find.text('Регистрация'),
        findsNWidgets(2),
      ); // Tab text appears twice
    });

    testWidgets('allows authenticated user to access protected routes', (
      WidgetTester tester,
    ) async {
      // Arrange
      final user = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'Test User'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true,
      );
      final authState = AuthState.authenticated(user: user);

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes
      await tester.pump(); // Extra pump to ensure profile content is rendered

      // Assert - should stay on profile page and show ProfileScreen
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('does not redirect when auth state is initial', (
      WidgetTester tester,
    ) async {
      // Arrange
      const authState = AuthState.initial();

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Try to navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should stay on profile page (no redirect during initial state)
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('does not redirect when auth state is loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      const authState = AuthState.loading();

      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pump();

      // Try to navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pump();
      await tester.pump(); // Additional pump to ensure navigation completes

      // Assert - should stay on profile page (no redirect during loading state)
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets(
      'redirects user with error state from protected routes to login',
      (WidgetTester tester) async {
        // Arrange
        const authState = AuthState.error(message: 'Authentication failed');

        // Act
        await tester.pumpWidget(
          createTestWidget(const SizedBox.shrink(), authState: authState),
        );
        await tester.pump();

        // Try to navigate to protected route
        AppRouter.router.go('/notifications');
        await tester.pump();
        await tester.pump(); // Additional pump to ensure navigation completes

        // Assert - should be redirected to login
        expect(
          find.text('Войти'),
          findsNWidgets(2),
        ); // AppBar title and body text
      },
    );
  });
}
