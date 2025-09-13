import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell/src/app.dart';
import 'package:mindwell/src/core/theme/mindwell_theme.dart';

void main() {
  group('MindWellApp', () {
    testWidgets('should build correctly', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Verify the app builds without errors
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Mindwell'), findsOneWidget);
    });

    testWidgets('should apply light theme correctly', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      
      // Verify theme configuration
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
      expect(materialApp.themeMode, equals(ThemeMode.system));
      
      // Verify theme properties
      expect(materialApp.theme!.colorScheme.primary, equals(MindwellTheme.lightTheme.colorScheme.primary));
      expect(materialApp.darkTheme!.colorScheme.primary, equals(MindwellTheme.darkTheme.colorScheme.primary));
    });

    testWidgets('should configure localization correctly', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      
      // Verify localization delegates are configured
      expect(materialApp.localizationsDelegates, isNotNull);
      expect(materialApp.localizationsDelegates!.length, equals(4));
      
      // Verify supported locales
      expect(materialApp.supportedLocales, contains(const Locale('ru', '')));
      expect(materialApp.supportedLocales, contains(const Locale('en', '')));
      
      // Verify default locale is Russian
      expect(materialApp.locale, equals(const Locale('ru', '')));
    });

    testWidgets('should configure router correctly', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      
      // Verify router is configured
      expect(materialApp.routerConfig, isNotNull);
    });

    testWidgets('should display home placeholder content', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Verify home content is displayed
      expect(find.text('Лента'), findsOneWidget);
      expect(find.text('Your mindful journal entries'), findsOneWidget);
      expect(find.byIcon(Icons.article), findsOneWidget);
    });

    testWidgets('should have correct app title', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      
      // Verify app title
      expect(materialApp.title, equals('Mindwell'));
    });

    testWidgets('should hide debug banner', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Get the MaterialApp widget
      final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
      
      // Verify debug banner is hidden
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });
  });

  group('HomePlaceholder', () {
    testWidgets('should build correctly', (WidgetTester tester) async {
      // Build the app to test the placeholder through the router
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Verify the widget builds without errors
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Лента'), findsOneWidget);
    });

    testWidgets('should display all expected content', (WidgetTester tester) async {
      // Build the app to test the placeholder through the router
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Verify all expected content is present
      expect(find.text('Лента'), findsOneWidget);
      expect(find.text('Your mindful journal entries'), findsOneWidget);
      expect(find.byIcon(Icons.article), findsOneWidget);
    });

    testWidgets('should center content vertically', (WidgetTester tester) async {
      // Build the app to test the placeholder through the router
      await tester.pumpWidget(
        const ProviderScope(
          child: MindWellApp(),
        ),
      );

      // Find the center widgets (there should be at least one)
      expect(find.byType(Center), findsWidgets);
    });
  });
}
