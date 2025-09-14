import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/screens/comment_feed_screen.dart';
import 'package:mindwell/src/features/comments/models/comment_feed_state.dart';
import 'package:mindwell/src/features/comments/providers/comment_feed_provider.dart';
import 'package:mindwell/src/features/comments/widgets/comment_feed_list.dart';
import 'package:mindwell/src/core/api/api_provider.dart';

class MockUsersApi extends Mock implements UsersApi {}

class MockCommentFeedNotifier extends StateNotifier<CommentFeedState> implements CommentFeedNotifier {
  MockCommentFeedNotifier() : super(const CommentFeedState.loaded(
    comments: [],
    hasMore: false,
    isFetchingMore: false,
  ));
  
  @override
  Future<void> fetchInitialComments() async {
    // Don't do anything - just return immediately
    // This prevents real API calls
  }
  
  @override
  Future<void> fetchMoreComments() async {
    // Don't do anything - just return immediately
  }
  
  @override
  Future<void> refresh() async {
    // Don't do anything - just return immediately
  }
  
  @override
  void updateUsername(String username) {
    // Don't do anything - just return immediately
  }
}

void main() {
  group('CommentFeedScreen', () {
    late MockUsersApi mockUsersApi;

    setUp(() {
      mockUsersApi = MockUsersApi();
    });

    Widget createTestWidget({
      required String username,
    }) {
      return ProviderScope(
        overrides: [
          usersApiProvider.overrideWithValue(mockUsersApi),
        ],
        child: MaterialApp(
          home: CommentFeedScreen(username: username),
        ),
      );
    }

    testWidgets('renders with correct app bar title', (WidgetTester tester) async {
      const testUsername = 'testuser';
      
      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Verify that the app bar is present
      expect(find.byType(AppBar), findsOneWidget);
      
      // Verify that the title contains the username (fallback text if localization fails)
      expect(find.textContaining('@$testUsername'), findsOneWidget);
    });

    testWidgets('renders CommentFeedList widget', (WidgetTester tester) async {
      const testUsername = 'testuser';
      
      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Verify that the CommentFeedList is present
      expect(find.byType(CommentFeedList), findsOneWidget);
    });

    testWidgets('passes correct username to CommentFeedList', (WidgetTester tester) async {
      const testUsername = 'testuser';
      
      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Find the CommentFeedList widget
      final commentFeedList = tester.widget<CommentFeedList>(
        find.byType(CommentFeedList),
      );
      
      // Verify that the username is passed correctly
      expect(commentFeedList.username, equals(testUsername));
    });

    testWidgets('enables pull to refresh and infinite scroll', (WidgetTester tester) async {
      const testUsername = 'testuser';
      
      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Find the CommentFeedList widget
      final commentFeedList = tester.widget<CommentFeedList>(
        find.byType(CommentFeedList),
      );
      
      // Verify that pull to refresh and infinite scroll are enabled
      expect(commentFeedList.enablePullToRefresh, isTrue);
      expect(commentFeedList.enableInfiniteScroll, isTrue);
    });

    testWidgets('shows back button in app bar', (WidgetTester tester) async {
      const testUsername = 'testuser';
      
      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Verify that the app bar has automaticallyImplyLeading set to true
      // This will show a back button when appropriate
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.automaticallyImplyLeading, isTrue);
    });

    testWidgets('can be instantiated with different usernames', (WidgetTester tester) async {
      const usernames = ['user1', 'user2', 'testuser123'];
      
      for (final username in usernames) {
        await tester.pumpWidget(createTestWidget(username: username));
        await tester.pumpAndSettle();

        // Verify that the title contains the correct username
        expect(find.textContaining('@$username'), findsOneWidget);
        
        // Verify that the CommentFeedList receives the correct username
        final commentFeedList = tester.widget<CommentFeedList>(
          find.byType(CommentFeedList),
        );
        expect(commentFeedList.username, equals(username));
        
        // Clean up for next iteration
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
      }
    });

    testWidgets('handles special characters in username', (WidgetTester tester) async {
      const specialUsername = 'user-with-dashes_123';
      
      await tester.pumpWidget(createTestWidget(username: specialUsername));
      await tester.pumpAndSettle();

      // Verify that the title contains the special username
      expect(find.textContaining('@$specialUsername'), findsOneWidget);
      
      // Verify that the CommentFeedList receives the correct username
      final commentFeedList = tester.widget<CommentFeedList>(
        find.byType(CommentFeedList),
      );
      expect(commentFeedList.username, equals(specialUsername));
    });
  });
}
