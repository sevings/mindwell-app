import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/src/core/widgets/bottom_nav_bar.dart';
import 'package:mindwell/src/core/providers/auth_provider.dart';

void main() {
  group('PlatformBottomNavBar', () {
    testWidgets('renders correctly when authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: 'testuser')),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: const Center(child: Text('Test Body')),
              bottomNavigationBar: const PlatformBottomNavBar(currentIndex: 0),
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
            authProvider.overrideWith((ref) => AuthNotifier()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: const Center(child: Text('Test Body')),
              bottomNavigationBar: const PlatformBottomNavBar(currentIndex: 0),
            ),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('shows correct selected tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: 'testuser')),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: const Center(child: Text('Test Body')),
              bottomNavigationBar: const PlatformBottomNavBar(currentIndex: 1),
            ),
          ),
        ),
      );

      final navigationBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(navigationBar.selectedIndex, 1);
    });

    testWidgets('displays all navigation items', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: 'testuser')),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: const Center(child: Text('Test Body')),
              bottomNavigationBar: const PlatformBottomNavBar(currentIndex: 0),
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