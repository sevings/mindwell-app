import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell/src/core/widgets/bottom_nav_bar.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell_api/mindwell_api.dart';

void main() {
  group('PlatformBottomNavBar', () {
    testWidgets('renders correctly when authenticated', (WidgetTester tester) async {
      // Create a mock user
      final mockUser = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..showName = 'Test User'
        ..isTheme = false
        ..isOnline = true
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(
              AuthState.authenticated(user: mockUser),
            )),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Test Body')),
              bottomNavigationBar: PlatformBottomNavBar(currentIndex: 0),
            ),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('Feed'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Chat'), findsOneWidget);
    });

    testWidgets('hides when not authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(
              const AuthState.unauthenticated(),
            )),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Test Body')),
              bottomNavigationBar: PlatformBottomNavBar(currentIndex: 0),
            ),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('shows correct selected tab', (WidgetTester tester) async {
      // Create a mock user
      final mockUser = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..showName = 'Test User'
        ..isTheme = false
        ..isOnline = true
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(
              AuthState.authenticated(user: mockUser),
            )),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Test Body')),
              bottomNavigationBar: PlatformBottomNavBar(currentIndex: 1),
            ),
          ),
        ),
      );

      final navigationBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(navigationBar.selectedIndex, 1);
    });

    testWidgets('displays all navigation items', (WidgetTester tester) async {
      // Create a mock user
      final mockUser = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..showName = 'Test User'
        ..isTheme = false
        ..isOnline = true
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => MockAuthNotifier(
              AuthState.authenticated(user: mockUser),
            )),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Test Body')),
              bottomNavigationBar: PlatformBottomNavBar(currentIndex: 0),
            ),
          ),
        ),
      );

      // Verify all navigation items are displayed
      expect(find.text('Feed'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Chat'), findsOneWidget);
    });
  });
}

/// Mock AuthNotifier for testing
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

// Mock classes for dependencies
class MockTokenStorageService extends Mock implements TokenStorageService {}
class MockOauth2Api extends Mock implements Oauth2Api {}
class MockAccountApi extends Mock implements AccountApi {}
class MockMeApi extends Mock implements MeApi {}