import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/src/core/widgets/indicators/password_strength_indicator.dart';

void main() {
  group('PasswordStrengthIndicator', () {
    testWidgets('renders with weak strength correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              strength: PasswordStrength.weak,
              label: 'Password Strength',
            ),
          ),
        ),
      );

      expect(find.text('Password Strength'), findsOneWidget);
      expect(find.text('Weak'), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('renders with medium strength correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              strength: PasswordStrength.medium,
              label: 'Password Strength',
            ),
          ),
        ),
      );

      expect(find.text('Password Strength'), findsOneWidget);
      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('renders with strong strength correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              strength: PasswordStrength.strong,
              label: 'Password Strength',
            ),
          ),
        ),
      );

      expect(find.text('Password Strength'), findsOneWidget);
      expect(find.text('Strong'), findsOneWidget);
    });

    testWidgets('renders without label when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              strength: PasswordStrength.medium,
            ),
          ),
        ),
      );

      expect(find.text('Password Strength'), findsNothing);
      expect(find.text('Medium'), findsOneWidget);
    });

    testWidgets('renders without text when showText is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              strength: PasswordStrength.medium,
              showText: false,
            ),
          ),
        ),
      );

      expect(find.text('Medium'), findsNothing);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('applies custom height and border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              strength: PasswordStrength.medium,
              height: 8.0,
              borderRadius: 4.0,
            ),
          ),
        ),
      );

      // The widget should render without errors with custom dimensions
      expect(find.byType(PasswordStrengthIndicator), findsOneWidget);
    });
  });

  group('PasswordStrengthCalculator', () {
    test('calculates weak strength for empty password', () {
      expect(''.calculatePasswordStrength(), PasswordStrength.weak);
    });

    test('calculates weak strength for short password', () {
      expect('123'.calculatePasswordStrength(), PasswordStrength.weak);
      expect('abc'.calculatePasswordStrength(), PasswordStrength.weak);
    });

    test('calculates weak strength for simple password', () {
      expect('password'.calculatePasswordStrength(), PasswordStrength.weak);
      expect('12345678'.calculatePasswordStrength(), PasswordStrength.weak);
    });

    test('calculates medium strength for mixed case password', () {
      expect('Password123'.calculatePasswordStrength(), PasswordStrength.medium);
      expect('MyPassword'.calculatePasswordStrength(), PasswordStrength.medium);
    });

    test('calculates medium strength for password with numbers', () {
      expect('password123'.calculatePasswordStrength(), PasswordStrength.medium);
      expect('mypassword456'.calculatePasswordStrength(), PasswordStrength.medium);
    });

    test('calculates strong strength for complex password', () {
      expect('Password123!'.calculatePasswordStrength(), PasswordStrength.strong);
      expect('MySecure123@'.calculatePasswordStrength(), PasswordStrength.strong);
      expect('ComplexP@ssw0rd'.calculatePasswordStrength(), PasswordStrength.strong);
    });

    test('calculates strong strength for long password with multiple character types', () {
      expect('VeryLongPassword123!'.calculatePasswordStrength(), PasswordStrength.strong);
      expect('SuperSecureP@ssw0rd2024'.calculatePasswordStrength(), PasswordStrength.strong);
    });

    test('handles special characters correctly', () {
      expect('password!'.calculatePasswordStrength(), PasswordStrength.medium);
      expect('Password@'.calculatePasswordStrength(), PasswordStrength.medium);
      expect('Password123#'.calculatePasswordStrength(), PasswordStrength.strong);
    });

    test('handles edge cases', () {
      expect('a'.calculatePasswordStrength(), PasswordStrength.weak);
      expect('A'.calculatePasswordStrength(), PasswordStrength.weak);
      expect('1'.calculatePasswordStrength(), PasswordStrength.weak);
      expect('!'.calculatePasswordStrength(), PasswordStrength.weak);
      expect('Aa1!'.calculatePasswordStrength(), PasswordStrength.medium);
      expect('Aa1!Bb2@'.calculatePasswordStrength(), PasswordStrength.strong);
    });
  });
}
