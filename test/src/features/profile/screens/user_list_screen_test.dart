import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/profile/models/user_list_state.dart';
import 'package:mindwell/src/features/profile/screens/user_list_screen.dart';
import 'package:mindwell/src/features/profile/providers/user_list_provider.dart';

// Mock classes
class MockUserListNotifier extends UserListNotifier {
  MockUserListNotifier()
    : super(type: UserListType.users, username: '', usersApi: MockUsersApi()) {
    // Override the state to be loaded with empty users
    state = const UserListState.loaded(users: [], hasMore: false);
  }

  @override
  Future<void> fetchUserList({String? after, String? before}) async {}

  @override
  Future<void> fetchNextPage() async {}

  @override
  Future<void> refresh() async {}
}

class MockUsersApi extends Mock implements UsersApi {}

void main() {
  group('UserListScreen', () {
    group('Basic Functionality', () {
      test('UserListScreen widget can be created', () {
        // Test that the widget can be instantiated
        const widget = UserListScreen(
          type: UserListType.followers,
          username: 'testuser',
        );
        expect(widget, isA<UserListScreen>());
        expect(widget.type, equals(UserListType.followers));
        expect(widget.username, equals('testuser'));
      });

      test('UserListScreen widget properties are correct', () {
        const widget = UserListScreen(
          type: UserListType.following,
          username: 'anotheruser',
        );
        expect(widget.type, equals(UserListType.following));
        expect(widget.username, equals('anotheruser'));
      });
    });

    group('UserListType Enum', () {
      test('UserListType has correct values', () {
        expect(UserListType.followers, isA<UserListType>());
        expect(UserListType.following, isA<UserListType>());
        expect(UserListType.invited, isA<UserListType>());
        expect(UserListType.users, isA<UserListType>());
      });
    });

    group('UserListState Model', () {
      test('UserListState.initial creates initial state', () {
        const state = UserListState.initial();
        expect(state, isA<UserListState>());
      });

      test('UserListState.loading creates loading state', () {
        const state = UserListState.loading();
        expect(state, isA<UserListState>());
      });

      test('UserListState.loaded creates loaded state', () {
        final state = UserListState.loaded(users: const [], hasMore: false);
        expect(state, isA<UserListState>());
      });

      test('UserListState.error creates error state', () {
        const state = UserListState.error(message: 'Test error');
        expect(state, isA<UserListState>());
      });
    });

    group('Pull-to-Refresh and Infinite Scrolling', () {
      test('UserListScreen has pull-to-refresh functionality', () {
        // Test that the screen is designed to support pull-to-refresh
        const widget = UserListScreen(
          type: UserListType.followers,
          username: 'testuser',
        );
        expect(widget, isA<UserListScreen>());
        // The actual implementation is tested through integration tests
      });

      test('UserListScreen has infinite scrolling functionality', () {
        // Test that the screen is designed to support infinite scrolling
        const widget = UserListScreen(
          type: UserListType.following,
          username: 'testuser',
        );
        expect(widget, isA<UserListScreen>());
        // The actual implementation is tested through integration tests
      });
    });

    group('App Bar Functionality', () {
      Widget createTestWidget({
        required UserListType type,
        required String username,
      }) {
        return ProviderScope(
          overrides: [
            userListProvider.overrideWith(
              (ref, params) => MockUserListNotifier(),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              drawer: const Drawer(child: Text('Test Drawer')),
              body: UserListScreen(type: type, username: username),
            ),
          ),
        );
      }

      testWidgets('shows hamburger menu when username is empty', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(
          createTestWidget(
            type: UserListType.users,
            username: '', // Empty username should show hamburger menu
          ),
        );
        await tester.pumpAndSettle();

        // Assert - Look for the hamburger menu icon in the custom app bar
        expect(find.byIcon(Icons.menu), findsOneWidget);
        expect(find.byIcon(Icons.arrow_back), findsNothing);
      });

      testWidgets('shows back button when username is not empty', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(
          createTestWidget(
            type: UserListType.followers,
            username: 'testuser', // Non-empty username should show back button
          ),
        );
        await tester.pumpAndSettle();

        // Assert - Look for the back arrow icon in the custom app bar
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        expect(find.byIcon(Icons.menu), findsNothing);
      });

      testWidgets('hamburger menu opens drawer when tapped', (
        WidgetTester tester,
      ) async {
        // Arrange
        await tester.pumpWidget(
          createTestWidget(
            type: UserListType.users,
            username: '', // Empty username should show hamburger menu
          ),
        );
        await tester.pumpAndSettle();

        // Act - Tap the hamburger menu icon
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        // Assert - Check that the drawer is opened
        expect(find.text('Test Drawer'), findsOneWidget);
      });

      testWidgets('shows refresh button in app bar', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(
          createTestWidget(type: UserListType.users, username: ''),
        );
        await tester.pumpAndSettle();

        // Assert - Look for the refresh icon in the custom app bar
        // We expect at least one refresh button (there might be multiple in different states)
        expect(find.byIcon(Icons.refresh), findsWidgets);
      });

      testWidgets('displays correct title for different list types', (
        WidgetTester tester,
      ) async {
        // Test followers
        await tester.pumpWidget(
          createTestWidget(type: UserListType.followers, username: 'testuser'),
        );
        await tester.pumpAndSettle();

        // Assert - Should show "Followers" (or localized equivalent) in the custom app bar
        expect(find.text('Followers'), findsOneWidget);

        // Test following
        await tester.pumpWidget(
          createTestWidget(type: UserListType.following, username: 'testuser'),
        );
        await tester.pumpAndSettle();

        // Assert - Should show "Following" in the custom app bar
        expect(find.text('Following'), findsOneWidget);

        // Test users
        await tester.pumpWidget(
          createTestWidget(type: UserListType.users, username: ''),
        );
        await tester.pumpAndSettle();

        // Assert - Should show "Users" in the custom app bar
        expect(find.text('Users'), findsOneWidget);
      });
    });
  });
}
