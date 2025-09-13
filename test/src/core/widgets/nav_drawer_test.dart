import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mindwell/src/core/widgets/nav_drawer.dart';
import 'package:mindwell/src/core/providers/auth_provider.dart';
import 'package:mindwell/l10n/app_localizations.dart';

/// Helper function to wrap widgets with localization support for testing
Widget createTestWidgetWithLocalization(Widget child) {
  return MaterialApp(
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
    home: child,
  );
}

void main() {
  group('NavDrawer', () {
    testWidgets('renders correctly when authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: 'testuser')),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('testuser'), findsOneWidget);
      
      // Check that key navigation items exist
      expect(find.text('Новая запись'), findsOneWidget);
      expect(find.text('Мои записи'), findsOneWidget);
      expect(find.text('Подписки'), findsOneWidget);
      expect(find.text('Прямой эфир'), findsOneWidget);
      expect(find.text('Лучшее'), findsOneWidget);
      expect(find.text('Выйти'), findsOneWidget);
    });

    testWidgets('renders correctly when not authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Mindwell'), findsOneWidget);
      expect(find.text('Your mindful journal'), findsOneWidget);
      
      // Check that key navigation items exist
      expect(find.text('Войти'), findsOneWidget);
      expect(find.text('Регистрация'), findsOneWidget);
      expect(find.text('Прямой эфир'), findsOneWidget);
      expect(find.text('Лучшее'), findsOneWidget);
      expect(find.text('Mindwell v1.0.0'), findsOneWidget);
    });

    testWidgets('shows user avatar when authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: 'testuser')),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('T'), findsOneWidget); // First letter of username
    });

    testWidgets('shows app icon when not authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.psychology), findsOneWidget);
    });

    testWidgets('shows logout button when authenticated', (WidgetTester tester) async {
      final authNotifier = AuthNotifier();
      authNotifier.login(userId: 'test-user', username: 'testuser');

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => authNotifier),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      // Verify logout button is present
      expect(find.text('Выйти'), findsOneWidget);
    });

    testWidgets('displays all navigation items when authenticated', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: 'testuser')),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      // Verify key navigation items are displayed
      expect(find.text('Новая запись'), findsOneWidget);
      expect(find.text('Мои записи'), findsOneWidget);
      expect(find.text('Подписки'), findsOneWidget);
      expect(find.text('Прямой эфир'), findsOneWidget);
      expect(find.text('Лучшее'), findsOneWidget);
    });

    testWidgets('shows user ID when available', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user-123', username: 'testuser')),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(find.text('ID: test-user-123'), findsOneWidget);
    });

    testWidgets('handles empty username gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => AuthNotifier()
              ..login(userId: 'test-user', username: '')),
          ],
          child: createTestWidgetWithLocalization(
            const Scaffold(
              drawer: NavDrawer(),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      );

      // Open the drawer
      await tester.dragFrom(
        tester.getTopLeft(find.byType(Scaffold)),
        const Offset(300, 0),
      );
      await tester.pumpAndSettle();

      expect(find.text(''), findsOneWidget); // Empty username shows empty string
      expect(find.text('U'), findsOneWidget); // Fallback avatar letter
    });
  });
}
