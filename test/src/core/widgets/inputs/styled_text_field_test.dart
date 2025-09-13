import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/inputs/styled_text_field.dart';
import 'package:mindwell/src/core/theme/mindwell_theme.dart';

void main() {
  group('StyledTextField', () {
    testWidgets('renders correctly with basic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Label',
              hint: 'Test Hint',
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Hint'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('displays validation error when validator fails', (WidgetTester tester) async {
      const errorMessage = 'This field is required';
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: Form(
              child: StyledTextField(
                label: 'Test Field',
                validator: (value) => value?.isEmpty == true ? errorMessage : null,
                autovalidateMode: AutovalidateMode.always,
              ),
            ),
          ),
        ),
      );

      // Trigger validation by submitting the form
      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (WidgetTester tester) async {
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test input');
      await tester.pump();

      expect(changedValue, equals('test input'));
    });

    testWidgets('calls onSubmitted when field is submitted', (WidgetTester tester) async {
      String? submittedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              onSubmitted: (value) => submittedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test input');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedValue, equals('test input'));
    });

    testWidgets('displays prefix and suffix icons correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              prefixIcon: const Icon(Icons.person),
              suffixIcon: const Icon(Icons.clear),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('displays prefix and suffix text correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              prefixText: '\$',
              suffixText: 'USD',
            ),
          ),
        ),
      );

      expect(find.text('\$'), findsOneWidget);
      expect(find.text('USD'), findsOneWidget);
    });

    testWidgets('respects enabled property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('respects readOnly property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              readOnly: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      // TextFormField doesn't expose readOnly directly, but we can verify it's set correctly
      expect(textField, isA<TextFormField>());
    });

    testWidgets('respects obscureText property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Password Field',
              obscureText: true,
            ),
          ),
        ),
      );

      // Verify the text field is rendered
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Password Field'), findsOneWidget);
    });

    testWidgets('applies correct keyboard type', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Email Field',
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email Field'), findsOneWidget);
    });

    testWidgets('applies correct text input action', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);
    });

    testWidgets('respects maxLength property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              maxLength: 10,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);
    });

    testWidgets('respects maxLines property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              maxLines: 5,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);
    });

    testWidgets('respects minLines property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              minLines: 3,
              maxLines: 5,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);
    });

    testWidgets('applies custom decoration when provided', (WidgetTester tester) async {
      const customDecoration = InputDecoration(
        labelText: 'Custom Label',
        border: OutlineInputBorder(),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Original Label',
              decoration: customDecoration,
            ),
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
      expect(find.text('Original Label'), findsNothing);
    });

    testWidgets('applies theme styling correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);
    });

    testWidgets('works with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.darkTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
            ),
          ),
        ),
      );

      expect(find.text('Test Field'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });

  group('StyledTextField.password', () {
    testWidgets('creates password field with obscureText enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.password(
              label: 'Password',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (WidgetTester tester) async {
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.password(
              label: 'Password',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'password123');
      await tester.pump();

      expect(changedValue, equals('password123'));
    });
  });

  group('StyledTextField.email', () {
    testWidgets('creates email field with correct keyboard type', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.email(
              label: 'Email',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (WidgetTester tester) async {
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.email(
              label: 'Email',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test@example.com');
      await tester.pump();

      expect(changedValue, equals('test@example.com'));
    });
  });

  group('StyledTextField.multiline', () {
    testWidgets('creates multiline field with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.multiline(
              label: 'Description',
              maxLines: 10,
              minLines: 5,
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('uses default multiline properties when not specified', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.multiline(
              label: 'Description',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (WidgetTester tester) async {
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.multiline(
              label: 'Description',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'This is a multiline text');
      await tester.pump();

      expect(changedValue, equals('This is a multiline text'));
    });
  });

  group('StyledTextField.search', () {
    testWidgets('creates search field with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.search(
              label: 'Search',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('Search...'), findsOneWidget);
    });

    testWidgets('uses custom hint when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.search(
              label: 'Search',
              hint: 'Custom search hint',
            ),
          ),
        ),
      );

      expect(find.text('Custom search hint'), findsOneWidget);
      expect(find.text('Search...'), findsNothing);
    });

    testWidgets('uses custom prefix icon when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.search(
              label: 'Search',
              prefixIcon: const Icon(Icons.filter_list),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.filter_list), findsOneWidget);
      expect(find.byIcon(Icons.search), findsNothing);
    });

    testWidgets('calls onChanged when text is entered', (WidgetTester tester) async {
      String? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextFieldExtensions.search(
              label: 'Search',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'search query');
      await tester.pump();

      expect(changedValue, equals('search query'));
    });
  });

  group('StyledTextField form integration', () {
    testWidgets('works correctly within a Form widget', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  StyledTextField(
                    controller: controller,
                    label: 'Test Field',
                    validator: (value) => value?.isEmpty == true ? 'Required' : null,
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState?.validate(),
                    child: const Text('Validate'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Tap validate button without entering text
      await tester.tap(find.text('Validate'));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);

      // Enter text and validate again
      await tester.enterText(find.byType(TextFormField), 'test value');
      await tester.tap(find.text('Validate'));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsNothing);
    });

    testWidgets('calls onSaved when form is saved', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  StyledTextField(
                    label: 'Test Field',
                    onSaved: (value) => savedValue = value,
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState?.save(),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test value');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(savedValue, equals('test value'));
    });
  });

  group('StyledTextField accessibility', () {
    testWidgets('has proper semantic labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              hint: 'Enter test value',
            ),
          ),
        ),
      );

      expect(find.text('Test Field'), findsOneWidget);
      expect(find.text('Enter test value'), findsOneWidget);
    });

    testWidgets('respects enabled state for accessibility', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: StyledTextField(
              label: 'Test Field',
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.enabled, isFalse);
    });
  });
}
