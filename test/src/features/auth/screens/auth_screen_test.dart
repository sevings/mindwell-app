import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindwell/src/features/auth/screens/auth_screen.dart';
import 'package:mindwell/src/features/auth/widgets/login_form.dart';
import 'package:mindwell/src/features/auth/widgets/registration_form.dart';

void main() {
  group('AuthScreen', () {
    Widget createTestWidget({Widget? child}) {
      return ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
            // Add minimal localization for testing
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
          ],
          home: child ?? const AuthScreen(),
        ),
      );
    }

    testWidgets('displays app title in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Mindwell'), findsAtLeastNWidgets(1));
    });

    testWidgets('displays tab bar with login and register tabs', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Login'), findsAtLeastNWidgets(1));
      expect(find.text('Register'), findsAtLeastNWidgets(1));
    });

    testWidgets('displays tab icons', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.login), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('displays welcome section with app branding', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Mindwell'), findsAtLeastNWidgets(1));
      expect(find.text('Your mindful journey starts here'), findsOneWidget);
      expect(find.byIcon(Icons.psychology), findsOneWidget);
    });

    testWidgets('shows login form by default', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Check that login form elements are present
      expect(find.byType(LoginForm), findsOneWidget);
    });

    testWidgets('switches to registration form when register tab is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Initially should show login form
      expect(find.byType(LoginForm), findsOneWidget);
      expect(find.byType(RegistrationForm), findsNothing);

      // Tap on register tab
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Should now show registration form
      expect(find.byType(RegistrationForm), findsOneWidget);
      expect(find.byType(LoginForm), findsNothing);
    });

    testWidgets('switches back to login form when login tab is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Switch to register tab first
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Verify we're on register tab
      expect(find.byType(RegistrationForm), findsOneWidget);

      // Switch back to login tab
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Should now show login form
      expect(find.byType(LoginForm), findsOneWidget);
      expect(find.byType(RegistrationForm), findsNothing);
    });

    testWidgets('has proper tab controller setup', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find the DefaultTabController
      final tabControllerFinder = find.byType(DefaultTabController);
      expect(tabControllerFinder, findsOneWidget);

      // Find the TabBar
      final tabBarFinder = find.byType(TabBar);
      expect(tabBarFinder, findsOneWidget);

      // Find the TabBarView
      final tabBarViewFinder = find.byType(TabBarView);
      expect(tabBarViewFinder, findsOneWidget);
    });

    testWidgets('applies proper styling to tabs', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find the TabBar
      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      
      // Verify tab styling properties
      expect(tabBar.indicatorWeight, 3.0);
      expect(tabBar.tabs.length, 2);
    });

    testWidgets('has scrollable content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find the SingleChildScrollView
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has proper padding and layout', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find the SafeArea
      expect(find.byType(SafeArea), findsAtLeastNWidgets(1));

      // Find the Container with gradient
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsAtLeastNWidgets(1));
    });

    testWidgets('displays both forms in TabBarView', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Find the TabBarView
      final tabBarView = tester.widget<TabBarView>(find.byType(TabBarView));
      
      // Verify it has 2 children (login and register forms)
      expect(tabBarView.children.length, 2);
    });

    testWidgets('handles tab switching with proper state management', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Start on login tab
      expect(find.byType(LoginForm), findsOneWidget);

      // Switch to register tab
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      // Verify register form is shown
      expect(find.byType(RegistrationForm), findsOneWidget);

      // Switch back to login tab
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify login form is shown again
      expect(find.byType(LoginForm), findsOneWidget);
    });
  });
}
