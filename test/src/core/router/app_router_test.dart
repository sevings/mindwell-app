import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/src/core/router/app_router.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// Mock implementations for testing
class _MockTokenStorageService implements TokenStorageService {
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

/// Helper function to wrap widgets with localization support for testing
Widget createTestWidget(Widget child, {AuthState? authState}) {
  return ProviderScope(
    overrides: authState != null
        ? [
            authProvider.overrideWith((ref) => _MockAuthNotifier(authState)),
          ]
        : [],
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
        Locale('en', ''),
      ],
      locale: const Locale('ru', ''),
      builder: (context, child) => child ?? const SizedBox.shrink(),
    ),
  );
}

/// Simple mock implementation that extends AuthNotifier
class _MockAuthNotifier extends AuthNotifier {
  _MockAuthNotifier(AuthState initialState) : super(
    tokenStorageService: _MockTokenStorageService(),
    oauth2Api: _MockOauth2Api(),
    accountApi: _MockAccountApi(),
    meApi: _MockMeApi(),
  ) {
    state = initialState;
  }
}

void main() {
  group('AppRouter', () {
    testWidgets('navigates to home route correctly', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(const SizedBox.shrink()));
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Лента'), findsOneWidget);
      expect(find.text('Your mindful journal entries'), findsOneWidget);
    });

    testWidgets('navigates to notifications route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestWidget(const SizedBox.shrink()));
      await tester.pumpAndSettle();
      
      // Navigate to notifications
      AppRouter.router.go('/notifications');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Stay updated with your mindful journey'), findsOneWidget);
    });

    testWidgets('navigates to chat route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();
      
      // Navigate to chat
      AppRouter.router.go('/chat');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Chat'), findsOneWidget);
      expect(find.text('Connect with your support community'), findsOneWidget);
    });

    testWidgets('navigates to login route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();
      
      // Navigate to login
      AppRouter.router.go('/login');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Войти'), findsNWidgets(2)); // AppBar title and body text
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('navigates to register route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();
      
      // Navigate to register
      AppRouter.router.go('/register');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Регистрация'), findsOneWidget); // Tab text
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays error screen for invalid route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();
      
      // Navigate to invalid route
      AppRouter.router.go('/invalid-route');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Что-то пошло не так'), findsOneWidget);
      expect(find.text('На главную'), findsOneWidget);
    });

    testWidgets('error screen go home button navigates to home', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();
      
      // Navigate to invalid route
      AppRouter.router.go('/invalid-route');
      await tester.pumpAndSettle();
      
      // Tap go home button
      await tester.tap(find.text('На главную'));
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Лента'), findsOneWidget);
      expect(find.text('Your mindful journal entries'), findsOneWidget);
    });

    testWidgets('router has correct initial location', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();
      
      // Assert
      expect(AppRouter.router.routerDelegate.currentConfiguration.uri.path, equals('/'));
    });

    testWidgets('shell route wraps authenticated screens', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink()),
      );
      
      // Assert - should have HomeScreen structure (AppBar with Mindwell title)
      expect(find.text('Mindwell'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Authentication Route Guards', () {
    testWidgets('redirects unauthenticated user from protected routes to login', (WidgetTester tester) async {
      // Arrange
      const authState = AuthState.unauthenticated();
      
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Try to navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pumpAndSettle();
      
      // Assert - should be redirected to login
      expect(find.text('Войти'), findsNWidgets(2)); // AppBar title and body text
    });

    testWidgets('redirects authenticated user from login to home', (WidgetTester tester) async {
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
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Try to navigate to login
      AppRouter.router.go('/login');
      await tester.pumpAndSettle();
      
      // Assert - should be redirected to home
      expect(find.text('Лента'), findsOneWidget);
      expect(find.text('Your mindful journal entries'), findsOneWidget);
    });

    testWidgets('redirects authenticated user from register to home', (WidgetTester tester) async {
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
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Try to navigate to register
      AppRouter.router.go('/register');
      await tester.pumpAndSettle();
      
      // Assert - should be redirected to home
      expect(find.text('Лента'), findsOneWidget);
      expect(find.text('Your mindful journal entries'), findsOneWidget);
    });

    testWidgets('allows unauthenticated user to access login route', (WidgetTester tester) async {
      // Arrange
      const authState = AuthState.unauthenticated();
      
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Navigate to login
      AppRouter.router.go('/login');
      await tester.pumpAndSettle();
      
      // Assert - should stay on login page
      expect(find.text('Войти'), findsNWidgets(2)); // AppBar title and body text
    });

    testWidgets('allows unauthenticated user to access register route', (WidgetTester tester) async {
      // Arrange
      const authState = AuthState.unauthenticated();
      
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Navigate to register
      AppRouter.router.go('/register');
      await tester.pumpAndSettle();
      
      // Assert - should stay on register page
      expect(find.text('Регистрация'), findsOneWidget); // Tab text
    });

    testWidgets('allows authenticated user to access protected routes', (WidgetTester tester) async {
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
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pumpAndSettle();
      
      // Assert - should stay on profile page
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Your personal profile and settings'), findsOneWidget);
    });

    testWidgets('does not redirect when auth state is initial', (WidgetTester tester) async {
      // Arrange
      const authState = AuthState.initial();
      
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Try to navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pumpAndSettle();
      
      // Assert - should stay on profile page (no redirect during initial state)
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('does not redirect when auth state is loading', (WidgetTester tester) async {
      // Arrange
      const authState = AuthState.loading();
      
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Try to navigate to protected route
      AppRouter.router.go('/profile');
      await tester.pumpAndSettle();
      
      // Assert - should stay on profile page (no redirect during loading state)
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('redirects user with error state from protected routes to login', (WidgetTester tester) async {
      // Arrange
      const authState = AuthState.error(message: 'Authentication failed');
      
      // Act
      await tester.pumpWidget(
        createTestWidget(const SizedBox.shrink(), authState: authState),
      );
      await tester.pumpAndSettle();
      
      // Try to navigate to protected route
      AppRouter.router.go('/notifications');
      await tester.pumpAndSettle();
      
      // Assert - should be redirected to login
      expect(find.text('Войти'), findsNWidgets(2)); // AppBar title and body text
    });
  });
}
