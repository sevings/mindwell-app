import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mindwell/src/core/router/app_router.dart';
import 'package:mindwell/l10n/app_localizations.dart';

/// Helper function to wrap widgets with localization support for testing
Widget createTestWidget(Widget child) {
  return MaterialApp.router(
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
  );
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
      expect(find.text('Регистрация'), findsNWidgets(2)); // AppBar title and body text
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
}
