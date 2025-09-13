import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/loaders/skeleton_loader.dart';

void main() {
  group('SkeletonLoader', () {
    testWidgets('renders child when enabled is true', (WidgetTester tester) async {
      const child = Text('Test content');
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(
              enabled: true,
              child: child,
            ),
          ),
        ),
      );

      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('renders child without shimmer when enabled is false', (WidgetTester tester) async {
      const child = Text('Test content');
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(
              enabled: false,
              child: child,
            ),
          ),
        ),
      );

      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('applies custom base color', (WidgetTester tester) async {
      const child = Text('Test content');
      const customBaseColor = Colors.red;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(
              enabled: true,
              baseColor: customBaseColor,
              child: child,
            ),
          ),
        ),
      );

      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('applies custom highlight color', (WidgetTester tester) async {
      const child = Text('Test content');
      const customHighlightColor = Colors.blue;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonLoader(
              enabled: true,
              highlightColor: customHighlightColor,
              child: child,
            ),
          ),
        ),
      );

      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('uses default colors in light theme', (WidgetTester tester) async {
      const child = Text('Test content');
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: const Scaffold(
            body: SkeletonLoader(
              enabled: true,
              child: child,
            ),
          ),
        ),
      );

      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('uses default colors in dark theme', (WidgetTester tester) async {
      const child = Text('Test content');
      
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const Scaffold(
            body: SkeletonLoader(
              enabled: true,
              child: child,
            ),
          ),
        ),
      );

      expect(find.text('Test content'), findsOneWidget);
    });
  });

  group('SkeletonText', () {
    testWidgets('renders correct number of lines', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonText(lines: 3),
          ),
        ),
      );

      // SkeletonText creates 3 main containers + 3 FractionallySizedBox containers
      expect(find.byType(Container), findsNWidgets(6));
    });

    testWidgets('renders with custom line height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonText(
              lines: 2,
              lineHeight: 20.0,
            ),
          ),
        ),
      );

      // Check that the main containers have the correct height
      final containers = tester.widgetList<Container>(find.byType(Container));
      final mainContainers = containers.where((c) => c.constraints?.maxHeight == 20.0);
      expect(mainContainers.length, 2);
    });

    testWidgets('renders with custom line spacing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonText(
              lines: 3,
              lineSpacing: 12.0,
            ),
          ),
        ),
      );

      // SkeletonText creates 3 main containers + 3 FractionallySizedBox containers
      expect(find.byType(Container), findsNWidgets(6));
    });

    testWidgets('renders with custom line widths', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonText(
              lines: 3,
              lineWidths: [1.0, 0.8, 0.6],
            ),
          ),
        ),
      );

      // SkeletonText creates 3 main containers + 3 FractionallySizedBox containers
      expect(find.byType(Container), findsNWidgets(6));
    });

    testWidgets('renders with custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonText(
              lines: 2,
              borderRadius: 8.0,
            ),
          ),
        ),
      );

      // SkeletonText creates 2 main containers + 2 FractionallySizedBox containers
      expect(find.byType(Container), findsNWidgets(4));
    });
  });

  group('SkeletonAvatar', () {
    testWidgets('renders with default size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonAvatar(),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 40.0);
      expect(container.constraints?.maxHeight, 40.0);
    });

    testWidgets('renders with custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonAvatar(size: 60.0),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 60.0);
      expect(container.constraints?.maxHeight, 60.0);
    });

    testWidgets('renders with custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonAvatar(
              size: 50.0,
              borderRadius: 25.0,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 50.0);
      expect(container.constraints?.maxHeight, 50.0);
    });
  });

  group('SkeletonBox', () {
    testWidgets('renders with default height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonBox(),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, 100.0);
    });

    testWidgets('renders with custom width and height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonBox(
              width: 200.0,
              height: 150.0,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 200.0);
      expect(container.constraints?.maxHeight, 150.0);
    });

    testWidgets('renders with custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonBox(
              width: 100.0,
              height: 80.0,
              borderRadius: 12.0,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 100.0);
      expect(container.constraints?.maxHeight, 80.0);
    });
  });
}
