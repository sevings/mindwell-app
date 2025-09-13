import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/platform_app_bar.dart';

void main() {
  group('PlatformAppBar', () {
    testWidgets('renders correctly with title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const PlatformAppBar(
              title: Text('Test Title'),
            ),
            body: const Center(child: Text('Test Body')),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('renders with actions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const PlatformAppBar(
              title: Text('Test Title'),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: null,
                ),
              ],
            ),
            body: const Center(child: Text('Test Body')),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders with custom leading widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const PlatformAppBar(
              title: Text('Test Title'),
              leading: Icon(Icons.menu),
            ),
            body: const Center(child: Text('Test Body')),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('has correct preferred size', (WidgetTester tester) async {
      const appBar = PlatformAppBar(title: Text('Test Title'));
      
      expect(appBar.preferredSize.height, kToolbarHeight);
    });

    testWidgets('applies custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const PlatformAppBar(
              title: Text('Test Title'),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            body: const Center(child: Text('Test Body')),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.red);
      expect(appBar.foregroundColor, Colors.white);
    });
  });
}
