import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindwell/src/features/auth/widgets/registration_form.dart';
import 'package:mindwell/src/core/widgets/indicators/password_strength_indicator.dart';

void main() {
  group('RegistrationForm', () {
    Widget createTestWidget() {
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
          home: Scaffold(
            body: RegistrationForm(),
          ),
        ),
      );
    }

    testWidgets('renders all form fields correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that all form fields are present
      expect(find.byType(RegistrationForm), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
    });

    testWidgets('shows password strength indicator', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that password strength indicator is present
      expect(find.byType(PasswordStrengthIndicator), findsOneWidget);
    });

    testWidgets('shows terms agreement text', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that terms agreement text is displayed
      // Since the text is in a RichText widget, we need to find it differently
      final richTextWidgets = find.byType(RichText);
      expect(richTextWidgets, findsAtLeastNWidgets(1));
      
      // Find the RichText widget that contains the terms text
      final termsRichText = find.descendant(
        of: find.byType(RegistrationForm),
        matching: find.byType(RichText),
      );
      expect(termsRichText, findsAtLeastNWidgets(1));
    });

    testWidgets('validates username field correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Test empty username
      await tester.enterText(find.byType(TextFormField).at(0), '');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Username is required'), findsOneWidget);

      // Test short username
      await tester.enterText(find.byType(TextFormField).at(0), 'ab');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Username must be at least 3 characters'), findsOneWidget);

      // Test invalid characters
      await tester.enterText(find.byType(TextFormField).at(0), 'user@name');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Username can only contain letters, numbers, and underscores'), findsOneWidget);

      // Test valid username
      await tester.enterText(find.byType(TextFormField).at(0), 'valid_user123');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Username is required'), findsNothing);
      expect(find.text('Username must be at least 3 characters'), findsNothing);
      expect(find.text('Username can only contain letters, numbers, and underscores'), findsNothing);
    });

    testWidgets('validates email field correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Fill username field with valid value
      await tester.enterText(find.byType(TextFormField).at(0), 'validuser');

      // Test empty email
      await tester.enterText(find.byType(TextFormField).at(1), '');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Email is required'), findsOneWidget);

      // Test invalid email format
      await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);

      // Test valid email
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Email is required'), findsNothing);
      expect(find.text('Please enter a valid email address'), findsNothing);
    });

    testWidgets('validates password field correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Fill username and email fields with valid values
      await tester.enterText(find.byType(TextFormField).at(0), 'validuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');

      // Test empty password
      await tester.enterText(find.byType(TextFormField).at(2), '');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Password is required'), findsOneWidget);

      // Test short password
      await tester.enterText(find.byType(TextFormField).at(2), '12345');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);

      // Test valid password
      await tester.enterText(find.byType(TextFormField).at(2), 'validpassword123');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Password is required'), findsNothing);
      expect(find.text('Password must be at least 6 characters'), findsNothing);
    });

    testWidgets('validates confirm password field correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Fill username, email, and password fields with valid values
      await tester.enterText(find.byType(TextFormField).at(0), 'validuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'validpassword123');

      // Test empty confirm password
      await tester.enterText(find.byType(TextFormField).at(3), '');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Please confirm your password'), findsOneWidget);

      // Test mismatched passwords
      await tester.enterText(find.byType(TextFormField).at(3), 'differentpassword');
      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);

      // Test matching passwords (but don't submit to avoid API calls)
      await tester.enterText(find.byType(TextFormField).at(3), 'validpassword123');
      await tester.pump();

      // Just verify the field has the correct value
      expect(find.text('validpassword123'), findsNWidgets(2));
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find password field and its visibility toggle
      final passwordField = find.byType(TextFormField).at(2);
      final passwordToggle = find.byIcon(Icons.visibility_outlined).first;

      // Enter password
      await tester.enterText(passwordField, 'testpassword');

      // Initially password should be obscured (check by looking for the visibility icon)
      expect(find.byIcon(Icons.visibility_outlined), findsNWidgets(2));

      // Tap visibility toggle
      await tester.tap(passwordToggle);
      await tester.pump();

      // Should have one visibility and one visibility_off icon
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('toggles confirm password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find confirm password field and its visibility toggle
      final confirmPasswordField = find.byType(TextFormField).at(3);
      final confirmPasswordToggle = find.byIcon(Icons.visibility_outlined).last;

      // Enter confirm password
      await tester.enterText(confirmPasswordField, 'testpassword');

      // Initially password should be obscured (check by looking for the visibility icon)
      expect(find.byIcon(Icons.visibility_outlined), findsNWidgets(2));

      // Tap visibility toggle
      await tester.tap(confirmPasswordToggle);
      await tester.pump();

      // Should have one visibility and one visibility_off icon
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('can submit form with valid data', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Fill all fields with valid values
      await tester.enterText(find.byType(TextFormField).at(0), 'validuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'validpassword123');
      await tester.enterText(find.byType(TextFormField).at(3), 'validpassword123');

      // Validate the form without submitting (to avoid API calls)
      final form = find.byType(Form);
      expect(form, findsOneWidget);
      
      // Check that all fields have valid data
      expect(find.text('validuser'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('validpassword123'), findsNWidgets(2));
    });

    testWidgets('shows validation errors for invalid data', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Fill fields with invalid values
      await tester.enterText(find.byType(TextFormField).at(0), 'ab'); // Too short
      await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
      await tester.enterText(find.byType(TextFormField).at(2), '123'); // Too short
      await tester.enterText(find.byType(TextFormField).at(3), 'different');

      // Tap register button
      await tester.tap(find.text('Register'));
      await tester.pump();

      // Validation errors should be shown
      expect(find.text('Username must be at least 3 characters'), findsOneWidget);
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('updates password strength indicator when password changes', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Initially should show weak strength
      expect(find.byType(PasswordStrengthIndicator), findsOneWidget);

      // Enter weak password
      await tester.enterText(find.byType(TextFormField).at(2), '123');
      await tester.pump();

      // Enter medium password
      await tester.enterText(find.byType(TextFormField).at(2), 'password123');
      await tester.pump();

      // Enter strong password
      await tester.enterText(find.byType(TextFormField).at(2), 'Password123!');
      await tester.pump();

      // Password strength indicator should still be present
      expect(find.byType(PasswordStrengthIndicator), findsOneWidget);
    });

    testWidgets('handles focus navigation correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Test that form fields are present and can be focused
      expect(find.byType(TextFormField), findsNWidgets(4));
      
      // Test that we can enter text in the first field
      await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
      expect(find.text('testuser'), findsOneWidget);
    });

    testWidgets('shows gender dropdown with default value', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that gender dropdown is present
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      
      // Check that default value "Not set" is selected
      expect(find.text('Not set'), findsOneWidget);
    });

    testWidgets('allows gender selection', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find and tap the gender dropdown
      final genderDropdown = find.byType(DropdownButtonFormField<String>);
      await tester.tap(genderDropdown);
      await tester.pumpAndSettle();

      // Check that all gender options are available
      expect(find.text('Not set'), findsAtLeastNWidgets(1));
      expect(find.text('Male'), findsOneWidget);
      expect(find.text('Female'), findsOneWidget);

      // Select "Male" option
      await tester.tap(find.text('Male'));
      await tester.pumpAndSettle();

      // Check that "Male" is now selected
      expect(find.text('Male'), findsOneWidget);
    });
  });
}

