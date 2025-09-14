import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/models/comment_feed_state.dart';
import 'package:mindwell/src/features/comments/providers/comment_feed_provider.dart';
import 'package:mindwell/src/features/comments/widgets/comment_feed_list.dart';
import 'package:mindwell/src/core/api/api_provider.dart';

class MockUsersApi extends Mock implements UsersApi {}

void main() {
  group('CommentFeedList', () {
    late MockUsersApi mockUsersApi;

    setUp(() {
      mockUsersApi = MockUsersApi();
    });

    Widget createTestWidget({
      required String username,
      bool enablePullToRefresh = true,
      bool enableInfiniteScroll = true,
      int loadMoreThreshold = 3,
      EdgeInsetsGeometry? padding,
    }) {
      return ProviderScope(
        overrides: [
          usersApiProvider.overrideWithValue(mockUsersApi),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CommentFeedList(
              username: username,
              enablePullToRefresh: enablePullToRefresh,
              enableInfiniteScroll: enableInfiniteScroll,
              loadMoreThreshold: loadMoreThreshold,
              padding: padding,
            ),
          ),
        ),
      );
    }

    testWidgets('can be instantiated with different parameters', (WidgetTester tester) async {
      // Test that the widget can be created with different parameters
      expect(() => CommentFeedList(username: 'testuser'), returnsNormally);
      expect(() => CommentFeedList(
        username: 'testuser',
        enablePullToRefresh: false,
      ), returnsNormally);
      expect(() => CommentFeedList(
        username: 'testuser',
        enableInfiniteScroll: false,
      ), returnsNormally);
      expect(() => CommentFeedList(
        username: 'testuser',
        loadMoreThreshold: 5,
      ), returnsNormally);
    });

    testWidgets('has correct default values', (WidgetTester tester) async {
      // Test that the widget has correct default values
      final widget = CommentFeedList(username: 'testuser');
      expect(widget.username, equals('testuser'));
      expect(widget.enablePullToRefresh, isTrue);
      expect(widget.enableInfiniteScroll, isTrue);
      expect(widget.loadMoreThreshold, equals(3));
    });

    testWidgets('displays loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      await tester.pump();

      // Should show the widget without errors
      expect(find.byType(CommentFeedList), findsOneWidget);
    });

    testWidgets('displays loaded state with comments', (WidgetTester tester) async {
      final author1 = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..avatar = MwAvatar((b) => b..x42 = 'avatar.jpg').toBuilder());
      
      final author2 = $MwUser((b) => b
        ..id = 2
        ..name = 'testuser2'
        ..avatar = MwAvatar((b) => b..x42 = 'avatar2.jpg').toBuilder());

      final comments = [
        MwComment((b) => b
          ..id = 1
          ..content = 'Test comment 1'
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..author = author1.toBuilder().build()
          ..rating = MwRating((b) => b
            ..upCount = 5
            ..downCount = 1).toBuilder()),
        MwComment((b) => b
          ..id = 2
          ..content = 'Test comment 2'
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..author = author2.toBuilder().build()
          ..rating = MwRating((b) => b
            ..upCount = 3
            ..downCount = 0).toBuilder()),
      ];

      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to loaded
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = CommentFeedState.loaded(
        comments: comments,
        hasMore: false,
      );
      
      await tester.pump();

      // Should show comment cards
      expect(find.text('Test comment 1'), findsOneWidget);
      expect(find.text('Test comment 2'), findsOneWidget);
      expect(find.text('testuser'), findsOneWidget);
      expect(find.text('testuser2'), findsOneWidget);
    });

    testWidgets('displays empty state when no comments', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to empty
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = const CommentFeedState.empty();
      
      await tester.pump();

      // Should show empty state
      expect(find.text('Нет комментариев'), findsOneWidget);
      expect(find.textContaining('У этого пользователя пока нет комментариев'), findsOneWidget);
      expect(find.text('Обновить'), findsOneWidget);
    });

    testWidgets('displays error state when fetch fails', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to error
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = const CommentFeedState.error(
        message: 'Network error',
      );
      
      await tester.pump();

      // Should show error state
      expect(find.text('Ошибка загрузки'), findsOneWidget);
      expect(find.text('Network error'), findsOneWidget);
      expect(find.text('Попробовать снова'), findsOneWidget);
    });

    testWidgets('shows loading more indicator when hasMore is true', (WidgetTester tester) async {
      final author = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..avatar = MwAvatar((b) => b..x42 = 'avatar.jpg').toBuilder());

      final comments = [
        MwComment((b) => b
          ..id = 1
          ..content = 'Test comment'
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..author = author.toBuilder().build()),
      ];

      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to loaded with hasMore = true
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = CommentFeedState.loaded(
        comments: comments,
        hasMore: true,
      );
      
      await tester.pump();

      // Should show loading more indicator
      expect(find.text('Загрузка...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('handles pull-to-refresh when enabled', (WidgetTester tester) async {
      final author = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..avatar = MwAvatar((b) => b..x42 = 'avatar.jpg').toBuilder());

      final comments = [
        MwComment((b) => b
          ..id = 1
          ..content = 'Test comment'
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..author = author.toBuilder().build()),
      ];

      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to loaded
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = CommentFeedState.loaded(
        comments: comments,
        hasMore: false,
      );
      
      await tester.pump();

      // Should show RefreshIndicator
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('does not show RefreshIndicator when pull-to-refresh is disabled', (WidgetTester tester) async {
      final author = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..avatar = MwAvatar((b) => b..x42 = 'avatar.jpg').toBuilder());

      final comments = [
        MwComment((b) => b
          ..id = 1
          ..content = 'Test comment'
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..author = author.toBuilder().build()),
      ];

      await tester.pumpWidget(createTestWidget(
        username: 'testuser',
        enablePullToRefresh: false,
      ));
      
      // Override the provider state to loaded
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = CommentFeedState.loaded(
        comments: comments,
        hasMore: false,
      );
      
      await tester.pump();

      // Should not show RefreshIndicator
      expect(find.byType(RefreshIndicator), findsNothing);
    });

    testWidgets('handles error state retry button tap', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to error
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = const CommentFeedState.error(
        message: 'Network error',
      );
      
      await tester.pump();

      // Tap retry button
      await tester.tap(find.text('Попробовать снова'));
      await tester.pump();

      // Should not throw any errors
      expect(find.byType(CommentFeedList), findsOneWidget);
    });

    testWidgets('handles empty state refresh button tap', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(username: 'testuser'));
      
      // Override the provider state to empty
      final container = ProviderScope.containerOf(tester.element(find.byType(CommentFeedList)));
      container.read(commentFeedProvider('testuser').notifier).state = const CommentFeedState.empty();
      
      await tester.pump();

      // Tap refresh button
      await tester.tap(find.text('Обновить'));
      await tester.pump();

      // Should not throw any errors
      expect(find.byType(CommentFeedList), findsOneWidget);
    });
  });
}