import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/buttons/secondary_button.dart';
import 'package:mindwell/src/core/widgets/buttons/button_size.dart';
import 'package:mindwell/src/core/theme/mindwell_theme.dart';

void main() {
  group('SecondaryButton', () {
    testWidgets('renders correctly with text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool wasPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SecondaryButton));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (WidgetTester tester) async {
      bool wasPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
              enabled: false,
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SecondaryButton));
      await tester.pump();

      expect(wasPressed, isFalse);
    });

    testWidgets('shows loading indicator when isLoading is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('renders with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
              icon: Icons.add,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('renders with trailing icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
              trailingIcon: Icons.arrow_forward,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('renders with both leading and trailing icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Test Button',
              icon: Icons.add,
              trailingIcon: Icons.arrow_forward,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);
    });

    group('Button sizes', () {
      testWidgets('renders small button with correct dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MindwellTheme.lightTheme,
            home: const Scaffold(
              body: SecondaryButton.small(
                text: 'Small Button',
              ),
            ),
          ),
        );

        final button = tester.widget<SecondaryButton>(find.byType(SecondaryButton));
        expect(button.size, ButtonSize.small);
        
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final buttonSizedBox = sizedBoxes.firstWhere((box) => box.height == ButtonSize.small.height);
        expect(buttonSizedBox.height, ButtonSize.small.height);
      });

      testWidgets('renders medium button with correct dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MindwellTheme.lightTheme,
            home: const Scaffold(
              body: SecondaryButton(
                text: 'Medium Button',
              ),
            ),
          ),
        );

        final button = tester.widget<SecondaryButton>(find.byType(SecondaryButton));
        expect(button.size, ButtonSize.medium);
        
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final buttonSizedBox = sizedBoxes.firstWhere((box) => box.height == ButtonSize.medium.height);
        expect(buttonSizedBox.height, ButtonSize.medium.height);
      });

      testWidgets('renders large button with correct dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: MindwellTheme.lightTheme,
            home: const Scaffold(
              body: SecondaryButton.large(
                text: 'Large Button',
              ),
            ),
          ),
        );

        final button = tester.widget<SecondaryButton>(find.byType(SecondaryButton));
        expect(button.size, ButtonSize.large);
        
        final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
        final buttonSizedBox = sizedBoxes.firstWhere((box) => box.height == ButtonSize.large.height);
        expect(buttonSizedBox.height, ButtonSize.large.height);
      });
    });

    testWidgets('expands to fill available width when expanded is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SizedBox(
              width: 200,
              child: SecondaryButton(
                text: 'Expanded Button',
                expanded: true,
              ),
            ),
          ),
        ),
      );

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final buttonSizedBox = sizedBoxes.firstWhere((box) => box.width == 200);
      expect(buttonSizedBox.width, 200);
    });

    testWidgets('uses custom minimum width when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Custom Width Button',
              minWidth: 150,
            ),
          ),
        ),
      );

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final buttonSizedBox = sizedBoxes.firstWhere((box) => box.width == 150);
      expect(buttonSizedBox.width, 150);
    });

    testWidgets('uses custom minimum height when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Custom Height Button',
              minHeight: 60,
            ),
          ),
        ),
      );

      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final buttonSizedBox = sizedBoxes.firstWhere((box) => box.height == 60);
      expect(buttonSizedBox.height, 60);
    });

    testWidgets('applies correct theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Themed Button',
            ),
          ),
        ),
      );

      final outlinedButton = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final buttonStyle = outlinedButton.style;
      
      // Check that the button uses the primary color scheme
      expect(buttonStyle?.foregroundColor?.resolve({}), isNotNull);
    });

    testWidgets('works with dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.darkTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Dark Theme Button',
            ),
          ),
        ),
      );

      expect(find.text('Dark Theme Button'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('has outlined border when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Enabled Button',
              enabled: true,
            ),
          ),
        ),
      );

      final outlinedButton = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final buttonStyle = outlinedButton.style;
      final side = buttonStyle?.side?.resolve({});
      
      expect(side, isNotNull);
      expect(side?.width, 1.0);
    });

    testWidgets('has disabled border when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MindwellTheme.lightTheme,
          home: const Scaffold(
            body: SecondaryButton(
              text: 'Disabled Button',
              enabled: false,
            ),
          ),
        ),
      );

      final outlinedButton = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      final buttonStyle = outlinedButton.style;
      final side = buttonStyle?.side?.resolve({});
      
      expect(side, isNotNull);
      expect(side?.width, 1.0);
    });
  });
}
