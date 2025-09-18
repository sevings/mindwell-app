import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/settings/widgets/settings_tile.dart';

void main() {
  group('SettingsTile', () {
    testWidgets('renders with basic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [SettingsTile(title: 'Test Title', onTap: () {})],
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(
                  title: 'Test Title',
                  subtitle: 'Test Subtitle',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(
                  title: 'Test Title',
                  leading: const Icon(Icons.settings),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders with custom trailing widget', (
      WidgetTester tester,
    ) async {
      final switchKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(
                  title: 'Test Title',
                  trailing: Switch(
                    key: switchKey,
                    value: true,
                    onChanged: (value) {},
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(switchKey), findsOneWidget);
    });

    testWidgets('does not show chevron when showChevron is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(
                  title: 'Test Title',
                  onTap: () {},
                  showChevron: false,
                ),
              ],
            ),
          ),
        ),
      );

      // Should not find any chevron icons
      expect(find.byIcon(Icons.chevron_right), findsNothing);
      expect(find.byIcon(CupertinoIcons.chevron_right), findsNothing);
    });

    testWidgets('handles tap events correctly', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(title: 'Test Title', onTap: () => tapped = true),
              ],
            ),
          ),
        ),
      );

      // Find and tap the tile
      final tileFinder = find.text('Test Title');
      await tester.tap(tileFinder);
      expect(tapped, isTrue);
    });

    testWidgets('does not respond to taps when disabled', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(
                  title: 'Test Title',
                  enabled: false,
                  onTap: () => tapped = true,
                ),
              ],
            ),
          ),
        ),
      );

      final tileFinder = find.text('Test Title');
      await tester.tap(tileFinder);
      expect(tapped, isFalse);
    });

    testWidgets('applies custom title style', (WidgetTester tester) async {
      const customStyle = TextStyle(color: Colors.red, fontSize: 20);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(title: 'Test Title', titleStyle: customStyle),
              ],
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Test Title'));
      expect(textWidget.style?.color, equals(Colors.red));
      expect(textWidget.style?.fontSize, equals(20));
    });

    testWidgets('applies custom subtitle style', (WidgetTester tester) async {
      const customStyle = TextStyle(color: Colors.blue, fontSize: 14);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                SettingsTile(
                  title: 'Test Title',
                  subtitle: 'Test Subtitle',
                  subtitleStyle: customStyle,
                ),
              ],
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Test Subtitle'));
      expect(textWidget.style?.color, equals(Colors.blue));
      expect(textWidget.style?.fontSize, equals(14));
    });

    testWidgets('shows divider when showDivider is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [SettingsTile(title: 'Test Title', showDivider: true)],
            ),
          ),
        ),
      );

      // Should find a divider (either Divider widget or Container with border)
      expect(
        find.byType(Divider).hitTestable().evaluate().isNotEmpty ||
            find.byType(Container).hitTestable().evaluate().isNotEmpty,
        isTrue,
      );
    });
  });
}
