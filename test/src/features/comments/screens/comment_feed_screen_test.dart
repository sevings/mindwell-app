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

class MockCommentFeedNotifier extends StateNotifier<CommentFeedState>
    implements CommentFeedNotifier {
  MockCommentFeedNotifier()
    : super(
        const CommentFeedState.loaded(
          comments: [],
          hasMore: false,
          isFetchingMore: false,
        ),
      );

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

  @override
  void updateCommentRating(int commentId, MwRating newRating) {
    // Don't do anything - just return immediately
  }
}

void main() {
  group('CommentFeedScreen', () {
    late MockUsersApi mockUsersApi;

    setUp(() {
      mockUsersApi = MockUsersApi();
    });

    Widget createTestWidget({required String username}) {
      return ProviderScope(
        overrides: [
          usersApiProvider.overrideWithValue(mockUsersApi),
          commentFeedProvider(
            username,
          ).overrideWith((ref) => MockCommentFeedNotifier()),
        ],
        child: MaterialApp(home: CommentFeedScreen(username: username)),
      );
    }

    testWidgets('renders with correct app bar title', (
      WidgetTester tester,
    ) async {
      const testUsername = 'testuser';

      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Verify that the custom app bar container is present
      expect(find.byType(Container), findsWidgets);

      // Verify that the title contains the username (localized format)
      expect(find.textContaining('Comments by @$testUsername'), findsOneWidget);
    });

    testWidgets('renders CommentFeedList widget', (WidgetTester tester) async {
      const testUsername = 'testuser';

      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Verify that the CommentFeedList is present
      expect(find.byType(CommentFeedList), findsOneWidget);
    });

    testWidgets('passes correct username to CommentFeedList', (
      WidgetTester tester,
    ) async {
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

    testWidgets('enables pull to refresh and infinite scroll', (
      WidgetTester tester,
    ) async {
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

      // Verify that the back button IconButton is present
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsNothing);
    });

    testWidgets('back button is tappable', (WidgetTester tester) async {
      const testUsername = 'testuser';

      await tester.pumpWidget(createTestWidget(username: testUsername));
      await tester.pumpAndSettle();

      // Find the back button by IconButton
      final backButtonFinder = find.byType(IconButton);
      expect(backButtonFinder, findsOneWidget);

      // Act - tap the back button (this will cause navigation)
      await tester.tap(backButtonFinder);
      await tester.pumpAndSettle();

      // Assert - The tap should not throw an exception
      // Note: We don't check for the IconButton after tap because
      // Navigator.pop() removes the screen from the navigation stack
    });

    testWidgets('can be instantiated with different usernames', (
      WidgetTester tester,
    ) async {
      const usernames = ['user1', 'user2', 'testuser123'];

      for (final username in usernames) {
        await tester.pumpWidget(createTestWidget(username: username));
        await tester.pumpAndSettle();

        // Verify that the title contains the correct username
        expect(find.textContaining('Comments by @$username'), findsOneWidget);

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

    testWidgets('handles special characters in username', (
      WidgetTester tester,
    ) async {
      const specialUsername = 'user-with-dashes_123';

      await tester.pumpWidget(createTestWidget(username: specialUsername));
      await tester.pumpAndSettle();

      // Verify that the title contains the special username
      expect(
        find.textContaining('Comments by @$specialUsername'),
        findsOneWidget,
      );

      // Verify that the CommentFeedList receives the correct username
      final commentFeedList = tester.widget<CommentFeedList>(
        find.byType(CommentFeedList),
      );
      expect(commentFeedList.username, equals(specialUsername));
    });

    group('App Bar Functionality', () {
      testWidgets('app bar has correct styling and structure', (
        WidgetTester tester,
      ) async {
        const testUsername = 'testuser';

        await tester.pumpWidget(createTestWidget(username: testUsername));
        await tester.pumpAndSettle();

        // Assert - Find the custom app bar container
        final container = find.byType(Container).first;
        expect(container, findsOneWidget);

        // Verify the container has the correct height
        final containerWidget = tester.widget<Container>(container);
        expect(containerWidget.constraints?.maxHeight, equals(kToolbarHeight));

        // Verify the app bar structure
        expect(find.byType(IconButton), findsOneWidget);
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        expect(
          find.textContaining('Comments by @$testUsername'),
          findsOneWidget,
        );
      });

      testWidgets('app bar title is centered', (WidgetTester tester) async {
        const testUsername = 'testuser';

        await tester.pumpWidget(createTestWidget(username: testUsername));
        await tester.pumpAndSettle();

        // Find the title text widget
        final titleText = find.textContaining('Comments by @$testUsername');
        expect(titleText, findsOneWidget);

        // Verify it's in an Expanded widget (which centers it)
        final expandedWidget = find.ancestor(
          of: titleText,
          matching: find.byType(Expanded),
        );
        expect(expandedWidget, findsOneWidget);
      });

      testWidgets('app bar has proper spacing for symmetry', (
        WidgetTester tester,
      ) async {
        const testUsername = 'testuser';

        await tester.pumpWidget(createTestWidget(username: testUsername));
        await tester.pumpAndSettle();

        // Find the spacer widget (SizedBox with width 48)
        final spacers = find.byType(SizedBox);
        expect(spacers, findsWidgets);

        // Find the specific spacer with width 48
        SizedBox? spacerWidget;
        for (int i = 0; i < tester.widgetList(spacers).length; i++) {
          final widget = tester.widget<SizedBox>(spacers.at(i));
          if (widget.width == 48.0) {
            spacerWidget = widget;
            break;
          }
        }
        expect(spacerWidget, isNotNull);
        expect(spacerWidget!.width, equals(48.0));
      });

      testWidgets('app bar has border decoration', (WidgetTester tester) async {
        const testUsername = 'testuser';

        await tester.pumpWidget(createTestWidget(username: testUsername));
        await tester.pumpAndSettle();

        // Find the container with decoration
        final container = find.byType(Container).first;
        final containerWidget = tester.widget<Container>(container);

        // Verify it has a decoration with border
        expect(containerWidget.decoration, isNotNull);
        expect(containerWidget.decoration, isA<BoxDecoration>());

        final decoration = containerWidget.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);
      });
    });
  });
}
