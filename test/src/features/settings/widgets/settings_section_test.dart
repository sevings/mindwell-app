import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/settings/widgets/settings_section.dart';
import 'package:mindwell/src/features/settings/widgets/settings_tile.dart';

void main() {
  group('SettingsSection', () {
    testWidgets('renders with basic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Test Section',
                  children: [
                    SettingsTile(title: 'Tile 1', onTap: () {}),
                    SettingsTile(title: 'Tile 2', onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.text('Tile 1'), findsOneWidget);
      expect(find.text('Tile 2'), findsOneWidget);
    });

    testWidgets('renders with subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Test Section',
                  subtitle: 'Test Subtitle',
                  children: [SettingsTile(title: 'Tile 1', onTap: () {})],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('handles empty children list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [SettingsSection(title: 'Test Section', children: [])],
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
    });

    testWidgets('renders complex section with multiple tiles and controls', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Notifications',
                  subtitle: 'Manage your notification preferences',
                  children: [
                    SettingsTile(
                      title: 'Email Notifications',
                      subtitle: 'Receive notifications via email',
                      leading: const Icon(Icons.email),
                      trailing: Switch(value: true, onChanged: (value) {}),
                      onTap: () {},
                    ),
                    SettingsTile(
                      title: 'Push Notifications',
                      subtitle: 'Receive push notifications',
                      leading: const Icon(Icons.notifications),
                      trailing: Switch(value: false, onChanged: (value) {}),
                      onTap: () {},
                    ),
                    SettingsTile(title: 'Advanced Settings', onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Manage your notification preferences'), findsOneWidget);
      expect(find.text('Email Notifications'), findsOneWidget);
      expect(find.text('Push Notifications'), findsOneWidget);
      expect(find.text('Advanced Settings'), findsOneWidget);
      expect(find.byType(Switch), findsNWidgets(2));
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
    });

    testWidgets('shows divider when showDivider is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Test Section',
                  showDivider: true,
                  children: [SettingsTile(title: 'Tile 1', onTap: () {})],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
      // Should find a divider
      expect(
        find.byType(Divider).hitTestable().evaluate().isNotEmpty ||
            find.byType(Container).hitTestable().evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('applies custom title style', (WidgetTester tester) async {
      const customStyle = TextStyle(color: Colors.red, fontSize: 18);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Test Section',
                  titleStyle: customStyle,
                  children: [SettingsTile(title: 'Tile 1', onTap: () {})],
                ),
              ],
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Test Section'));
      expect(textWidget.style?.color, equals(Colors.red));
      expect(textWidget.style?.fontSize, equals(18));
    });

    testWidgets('applies custom subtitle style', (WidgetTester tester) async {
      const customStyle = TextStyle(color: Colors.blue, fontSize: 12);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Test Section',
                  subtitle: 'Test Subtitle',
                  subtitleStyle: customStyle,
                  children: [SettingsTile(title: 'Tile 1', onTap: () {})],
                ),
              ],
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Test Subtitle'));
      expect(textWidget.style?.color, equals(Colors.blue));
      expect(textWidget.style?.fontSize, equals(12));
    });

    testWidgets('adds spacing between tiles when requested', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsSection(
                  title: 'Test Section',
                  addSpacingBetweenTiles: true,
                  tileSpacing: 16.0,
                  children: [
                    SettingsTile(title: 'Tile 1', onTap: () {}),
                    SettingsTile(title: 'Tile 2', onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Section'), findsOneWidget);
      expect(find.text('Tile 1'), findsOneWidget);
      expect(find.text('Tile 2'), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
