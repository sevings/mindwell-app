import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell/src/features/home/screens/home_screen.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// Mock AuthNotifier for testing
class MockAuthNotifier extends AuthNotifier {
  MockAuthNotifier(AuthState initialState) : super(
    tokenStorageService: _MockTokenStorageService(),
    oauth2Api: _MockOauth2Api(),
    accountApi: _MockAccountApi(),
    meApi: _MockMeApi(),
  ) {
    state = initialState;
  }
}

/// Mock implementations
class _MockTokenStorageService implements TokenStorageService {
  @override
  Future<void> saveUserTokens({required String accessToken, required String refreshToken}) async {}
  @override
  Future<String?> getAccessToken() async => null;
  @override
  Future<String?> getRefreshToken() async => null;
  @override
  Future<void> saveAppToken(String appToken) async {}
  @override
  Future<String?> getAppToken() async => null;
  @override
  Future<void> clearUserTokens() async {}
  @override
  Future<void> clearAppToken() async {}
  @override
  Future<bool> hasUserTokens() async => false;
  @override
  Future<bool> hasAppToken() async => false;
}

class _MockOauth2Api extends Mock implements Oauth2Api {}
class _MockAccountApi extends Mock implements AccountApi {}
class _MockMeApi extends Mock implements MeApi {}

/// Helper function to create test user
$MwUser _createTestUser() {
  return $MwUser((b) => b
    ..id = 1
    ..name = 'testuser'
    ..showName = 'Test User'
    ..isTheme = false
    ..isOnline = true
  );
}

void main() {
  group('HomeScreen', () {
    testWidgets('renders correctly with child content', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(AuthState.authenticated(user: _createTestUser()))),
          ],
          child: const MaterialApp(
            home: HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Mindwell'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('displays platform app bar with correct title', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(AuthState.authenticated(user: _createTestUser()))),
          ],
          child: const MaterialApp(
            home: HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Mindwell'), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('displays child content in body', (WidgetTester tester) async {
      // Arrange
      const testChild = Column(
        children: [
          Text('First Child'),
          Text('Second Child'),
        ],
      );
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(AuthState.authenticated(user: _createTestUser()))),
          ],
          child: const MaterialApp(
            home: HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      expect(find.text('First Child'), findsOneWidget);
      expect(find.text('Second Child'), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('has correct scaffold structure with navigation components', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(AuthState.authenticated(user: _createTestUser()))),
          ],
          child: const MaterialApp(
            home: HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.appBar, isNotNull);
      expect(scaffold.body, isNotNull);
      expect(scaffold.bottomNavigationBar, isNotNull);
      expect(scaffold.drawer, isNotNull);
      expect(scaffold.floatingActionButton, isNotNull);
    });

    testWidgets('shows floating action button when authenticated', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(AuthState.authenticated(user: _createTestUser()))),
          ],
          child: const MaterialApp(
            home: HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('hides floating action button when not authenticated', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(const AuthState.unauthenticated())),
          ],
          child: const MaterialApp(
            home: HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('applies theme colors correctly', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(AuthState.authenticated(user: _createTestUser()))),
          ],
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                surface: Colors.blue,
                onSurface: Colors.white,
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
            ),
            home: const HomeScreen(child: testChild),
          ),
        ),
      );
      
      // Assert
      final fab = tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(fab.backgroundColor, equals(Colors.orange));
      expect(fab.foregroundColor, equals(Colors.white));
    });
  });
}
