import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../lib/src/features/auth/widgets/login_form.dart';
import '../../../../../lib/src/features/auth/providers/auth_provider.dart';
import '../../../../../lib/src/features/auth/models/auth_state.dart';

void main() {
  group('LoginForm', () {
    Widget createTestWidget() {
      return ProviderScope(
        child: const MaterialApp(
          localizationsDelegates: [
            // Add minimal localization for testing
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ru'),
          ],
          home: Scaffold(
            body: LoginForm(),
          ),
        ),
      );
    }

    testWidgets('renders all form elements correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that email field is present
      expect(find.byType(TextFormField), findsNWidgets(2));
      
      // Check that login button is present
      expect(find.text('Login'), findsOneWidget);
      
      // Check that forgot password link is present
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('shows password visibility toggle', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find the password visibility toggle button
      final visibilityButton = find.byIcon(Icons.visibility_outlined);
      expect(visibilityButton, findsOneWidget);

      // Tap the visibility button
      await tester.tap(visibilityButton);
      await tester.pumpAndSettle();

      // Check that the icon changed to visibility_off
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('validates empty email field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Try to submit the form with empty email
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Check that validation error appears
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('validates invalid email format', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter invalid email
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'invalid-email');
      await tester.pumpAndSettle();

      // Try to submit the form
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Check that validation error appears
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('validates empty password field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid email
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      // Try to submit the form with empty password
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Check that validation error appears
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('validates password length', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid email
      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      // Enter short password
      final passwordField = find.byType(TextFormField).last;
      await tester.enterText(passwordField, '123');
      await tester.pumpAndSettle();

      // Try to submit the form
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Check that validation error appears
      expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    });

    testWidgets('handles forgot password tap', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap forgot password link
      final forgotPasswordLink = find.text('Forgot password?');
      await tester.tap(forgotPasswordLink);
      await tester.pumpAndSettle();

      // Check that placeholder message is shown
      expect(find.text('Forgot password functionality coming soon'), findsOneWidget);
    });

    testWidgets('disposes controllers properly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Remove the widget to trigger dispose
      await tester.pumpWidget(const SizedBox.shrink());

      // No exceptions should be thrown during disposal
      expect(tester.takeException(), isNull);
    });
  });
}
