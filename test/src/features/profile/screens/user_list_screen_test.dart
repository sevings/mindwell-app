import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/features/profile/models/user_list_state.dart';
import 'package:mindwell/src/features/profile/screens/user_list_screen.dart';

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
        final state = UserListState.loaded(
          users: const [],
          hasMore: false,
        );
        expect(state, isA<UserListState>());
      });

      test('UserListState.error creates error state', () {
        const state = UserListState.error(
          message: 'Test error',
        );
        expect(state, isA<UserListState>());
      });
    });
  });
}
