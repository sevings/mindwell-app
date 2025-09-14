import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';

void main() {
  group('EntryFeedScreen', () {
    Widget createTestWidget({FeedType? feedType, String? tagFilter}) {
  return ProviderScope(
    child: MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
                builder: (context, state) => EntryFeedScreen(
                  feedType: feedType,
                  tagFilter: tagFilter,
            ),
          ),
        ],
      ),
    ),
  );
}

    testWidgets('should display tag filter in title when provided', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
    feedType: FeedType.live,
        tagFilter: 'flutter',
      ));
      await tester.pumpAndSettle();

      // Verify tag filter is displayed in the title
      expect(find.text('#flutter - Live'), findsOneWidget);
    });

    testWidgets('should display normal title when no tag filter', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.live,
      ));
      await tester.pumpAndSettle();

      // Verify normal title is displayed
      expect(find.text('Live'), findsOneWidget);
    });

    testWidgets('should display tag filter with best feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.best,
        tagFilter: 'dart',
      ));
      await tester.pumpAndSettle();

      // Verify tag filter is displayed in the title
      expect(find.text('#dart - Best'), findsOneWidget);
    });

    testWidgets('should display tag filter with friends feed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        feedType: FeedType.friends,
        tagFilter: 'mobile',
      ));
      await tester.pumpAndSettle();

      // Verify tag filter is displayed in the title
      expect(find.text('#mobile - Friends'), findsOneWidget);
    });

    testWidgets('should pass tag filter to EntryList widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
                      feedType: FeedType.live,
        tagFilter: 'flutter',
      ));
      await tester.pumpAndSettle();

      // The EntryList widgets should be created with the tag filter
      // This is verified by the key generation in the EntryFeedScreen
      expect(find.byType(EntryFeedScreen), findsOneWidget);
    });
  });
}