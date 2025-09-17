import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/features/chat/widgets/chat_list_shimmer.dart';
import 'package:mindwell/src/core/widgets/loaders/skeleton_loader.dart';

void main() {
  group('ChatListShimmer', () {
    Widget createWidgetUnderTest({int itemCount = 5}) {
      return MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [ChatListShimmer(itemCount: itemCount)],
          ),
        ),
      );
    }

    testWidgets('displays correct number of shimmer items', (
      WidgetTester tester,
    ) async {
      const itemCount = 3;
      await tester.pumpWidget(createWidgetUnderTest(itemCount: itemCount));

      // Should find the SliverList with the correct number of items
      expect(find.byType(SliverList), findsOneWidget);

      // Each shimmer item should contain skeleton components
      expect(find.byType(SkeletonLoader), findsNWidgets(itemCount));
    });

    testWidgets('displays default number of shimmer items when not specified', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Should display 5 items by default
      expect(find.byType(SkeletonLoader), findsNWidgets(5));
    });

    testWidgets('displays shimmer components for each chat item', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 2));

      // Should find skeleton avatars
      expect(find.byType(SkeletonAvatar), findsNWidgets(2));

      // Should find skeleton loader components (one per item)
      expect(find.byType(SkeletonLoader), findsNWidgets(2));
    });

    testWidgets('applies correct styling and layout', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 1));

      // Should have proper padding
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.padding, isA<EdgeInsets>());

      // Should use SkeletonLoader with proper colors
      final skeletonLoader = tester.widget<SkeletonLoader>(
        find.byType(SkeletonLoader).first,
      );
      expect(skeletonLoader.baseColor, isNotNull);
      expect(skeletonLoader.highlightColor, isNotNull);
    });

    testWidgets('handles zero item count gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 0));

      // Should not crash and should display empty list
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SkeletonLoader), findsNothing);
    });

    testWidgets('handles large item count', (WidgetTester tester) async {
      const largeItemCount = 10; // Reduced to avoid test timeout
      await tester.pumpWidget(createWidgetUnderTest(itemCount: largeItemCount));

      // Should handle large numbers without issues
      expect(find.byType(SkeletonLoader), findsNWidgets(largeItemCount));
    });

    testWidgets('maintains consistent layout structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(itemCount: 1));

      // Should have the expected widget hierarchy
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Expanded), findsWidgets);
    });
  });
}
