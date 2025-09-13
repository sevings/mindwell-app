import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/home/screens/home_screen.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('renders correctly with child content', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(child: testChild),
        ),
      );
      
      // Assert
      expect(find.text('Mindwell'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('displays app bar with correct title', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(child: testChild),
        ),
      );
      
      // Assert
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.title, isA<Text>());
      expect((appBar.title as Text).data, equals('Mindwell'));
      expect(appBar.centerTitle, isTrue);
    });

    testWidgets('displays child content in body', (WidgetTester tester) async {
      // Arrange
      const testChild = Column(
        children: [
          Text('First Child'),
          Text('Second Child'),
        ],
      );
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(child: testChild),
        ),
      );
      
      // Assert
      expect(find.text('First Child'), findsOneWidget);
      expect(find.text('Second Child'), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('has correct scaffold structure', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(child: testChild),
        ),
      );
      
      // Assert
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.appBar, isNotNull);
      expect(scaffold.body, isNotNull);
      expect(scaffold.bottomNavigationBar, isNull);
      expect(scaffold.drawer, isNull);
      expect(scaffold.floatingActionButton, isNull);
    });

    testWidgets('applies theme colors correctly', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surface: Colors.blue,
              onSurface: Colors.white,
            ),
          ),
          home: const HomeScreen(child: testChild),
        ),
      );
      
      // Assert
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, equals(Colors.blue));
      expect(appBar.foregroundColor, equals(Colors.white));
      expect(appBar.elevation, equals(0));
    });
  });
}
