import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/router/app_router.dart';

void main() {
  group('AppRouter', () {
    testWidgets('navigates to home route correctly', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      
      // Assert
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Welcome to your mindful journal'), findsOneWidget);
    });

    testWidgets('navigates to notifications route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
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
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
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
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      await tester.pumpAndSettle();
      
      // Navigate to login
      AppRouter.router.go('/login');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Sign in to your account'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('navigates to register route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      await tester.pumpAndSettle();
      
      // Navigate to register
      AppRouter.router.go('/register');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Create your account'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('displays error screen for invalid route', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      await tester.pumpAndSettle();
      
      // Navigate to invalid route
      AppRouter.router.go('/invalid-route');
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    testWidgets('error screen go home button navigates to home', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      await tester.pumpAndSettle();
      
      // Navigate to invalid route
      AppRouter.router.go('/invalid-route');
      await tester.pumpAndSettle();
      
      // Tap go home button
      await tester.tap(find.text('Go Home'));
      await tester.pumpAndSettle();
      
      // Assert
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Welcome to your mindful journal'), findsOneWidget);
    });

    testWidgets('router has correct initial location', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      await tester.pumpAndSettle();
      
      // Assert
      expect(AppRouter.router.routerDelegate.currentConfiguration.uri.path, equals('/'));
    });

    testWidgets('shell route wraps authenticated screens', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      );
      
      // Assert - should have HomeScreen structure (AppBar with Mindwell title)
      expect(find.text('Mindwell'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
