import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/loaders/app_loader.dart';

void main() {
  group('AppLoader', () {
    testWidgets('renders correctly with default parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('renders with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(size: 32.0),
          ),
        ),
      );

      final progressIndicator = tester.widget<SizedBox>(
        find.byType(SizedBox),
      );
      expect(progressIndicator.width, 32.0);
      expect(progressIndicator.height, 32.0);
    });

    testWidgets('renders with custom color', (WidgetTester tester) async {
      const customColor = Colors.red;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(color: customColor),
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.valueColor?.value, customColor);
    });

    testWidgets('renders with custom stroke width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(strokeWidth: 4.0),
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.strokeWidth, 4.0);
    });

    testWidgets('renders with message', (WidgetTester tester) async {
      const message = 'Loading...';
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(message: message),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('renders without centering when centered is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(centered: false),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Center), findsNothing);
    });

    testWidgets('renders with message and custom parameters', (WidgetTester tester) async {
      const message = 'Please wait...';
      const customColor = Colors.blue;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(
              message: message,
              color: customColor,
              size: 40.0,
              strokeWidth: 3.0,
            ),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.valueColor?.value, customColor);
      expect(progressIndicator.strokeWidth, 3.0);
    });

    testWidgets('uses theme primary color when no custom color is provided', (WidgetTester tester) async {
      const primaryColor = Colors.purple;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: primaryColor),
          ),
          home: const Scaffold(
            body: AppLoader(),
          ),
        ),
      );

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.valueColor?.value, primaryColor);
    });

    testWidgets('applies correct text style for message', (WidgetTester tester) async {
      const message = 'Loading data...';
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLoader(message: message),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text(message));
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.style?.fontSize, 14.0);
    });
  });
}
