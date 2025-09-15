import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/profile/providers/user_list_provider.dart';
import 'package:mindwell/src/features/profile/models/user_list_state.dart';

// Mock classes
class MockUsersApi extends Mock implements UsersApi {}
class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('UserListNotifier', () {
    late MockUsersApi mockUsersApi;
    late UserListNotifier userListNotifier;
    late MockResponse<MwFriendList> mockFriendListResponse;
    late MockResponse<MwUsersGet200Response> mockUsersResponse;

    setUp(() {
      mockUsersApi = MockUsersApi();
      mockFriendListResponse = MockResponse<MwFriendList>();
      mockUsersResponse = MockResponse<MwUsersGet200Response>();
    });

    group('followers list', () {
      setUp(() {
        userListNotifier = UserListNotifier(
          type: UserListType.followers,
          username: 'testuser',
          usersApi: mockUsersApi,
        );
      });

      test('should fetch followers list successfully and update state to loaded', () async {
        // Arrange
        final mockFriend = $MwFriend((b) => b
          ..id = 1
          ..name = 'follower1'
          ..showName = 'Follower One'
          ..isTheme = false
          ..isOnline = true
        );

        final mockFriendList = MwFriendList((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend])
          ..hasAfter = true
          ..nextAfter = 'cursor123'
          ..hasBefore = false
        );

        when(() => mockFriendListResponse.data).thenReturn(mockFriendList);
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenAnswer((_) async => mockFriendListResponse);

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(1));
            expect(users.first.name, equals('follower1'));
            expect(hasMore, isTrue);
            expect(nextAfter, equals('cursor123'));
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );
      });

      test('should handle API error and update state to error', () async {
        // Arrange
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/users/testuser/followers'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/testuser/followers'),
            statusCode: 404,
          ),
        ));

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (users, hasMore, nextAfter, nextBefore) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Пользователь не найден'));
          },
        );
      });

      test('should fetch next page successfully and append to existing users', () async {
        // Arrange
        final mockFriend1 = $MwFriend((b) => b
          ..id = 1
          ..name = 'follower1'
          ..showName = 'Follower One'
        );

        final mockFriend2 = $MwFriend((b) => b
          ..id = 2
          ..name = 'follower2'
          ..showName = 'Follower Two'
        );

        final initialFriendList = MwFriendList((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend1])
          ..hasAfter = true
          ..nextAfter = 'cursor123'
        );

        final nextPageFriendList = MwFriendList((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend2])
          ..hasAfter = false
          ..nextAfter = null
        );

        when(() => mockFriendListResponse.data).thenReturn(initialFriendList);
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenAnswer((_) async => mockFriendListResponse);

        // Load initial data
        await userListNotifier.fetchUserList();

        // Setup next page response
        when(() => mockFriendListResponse.data).thenReturn(nextPageFriendList);
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: 'cursor123',
        )).thenAnswer((_) async => mockFriendListResponse);

        // Act
        await userListNotifier.fetchNextPage();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(2));
            expect(users.first.name, equals('follower1'));
            expect(users.last.name, equals('follower2'));
            expect(hasMore, isFalse);
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );
      });
    });

    group('following list', () {
      setUp(() {
        userListNotifier = UserListNotifier(
          type: UserListType.following,
          username: 'testuser',
          usersApi: mockUsersApi,
        );
      });

      test('should fetch following list successfully', () async {
        // Arrange
        final mockFriend = $MwFriend((b) => b
          ..id = 1
          ..name = 'following1'
          ..showName = 'Following One'
        );

        final mockFriendList = MwFriendList((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend])
          ..hasAfter = false
        );

        when(() => mockFriendListResponse.data).thenReturn(mockFriendList);
        when(() => mockUsersApi.usersNameFollowingsGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenAnswer((_) async => mockFriendListResponse);

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(1));
            expect(users.first.name, equals('following1'));
            expect(hasMore, isFalse);
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );
      });
    });

    group('invited list', () {
      setUp(() {
        userListNotifier = UserListNotifier(
          type: UserListType.invited,
          username: 'testuser',
          usersApi: mockUsersApi,
        );
      });

      test('should fetch invited list successfully', () async {
        // Arrange
        final mockFriend = $MwFriend((b) => b
          ..id = 1
          ..name = 'invited1'
          ..showName = 'Invited One'
        );

        final mockFriendList = MwFriendList((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend])
          ..hasAfter = false
        );

        when(() => mockFriendListResponse.data).thenReturn(mockFriendList);
        when(() => mockUsersApi.usersNameInvitedGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenAnswer((_) async => mockFriendListResponse);

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(1));
            expect(users.first.name, equals('invited1'));
            expect(hasMore, isFalse);
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );
      });
    });

    group('general users list', () {
      setUp(() {
        userListNotifier = UserListNotifier(
          type: UserListType.users,
          username: 'testuser',
          usersApi: mockUsersApi,
        );
      });

      test('should fetch general users list successfully', () async {
        // Arrange
        final mockFriend = $MwFriend((b) => b
          ..id = 1
          ..name = 'user1'
          ..showName = 'User One'
        );

        final mockUsersData = MwUsersGet200Response((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend])
        );

        when(() => mockUsersResponse.data).thenReturn(mockUsersData);
        when(() => mockUsersApi.usersGet()).thenAnswer((_) async => mockUsersResponse);

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(1));
            expect(users.first.name, equals('user1'));
            expect(hasMore, isFalse);
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );
      });
    });

    group('refresh', () {
      setUp(() {
        userListNotifier = UserListNotifier(
          type: UserListType.followers,
          username: 'testuser',
          usersApi: mockUsersApi,
        );
      });

      test('should refresh the user list', () async {
        // Arrange
        final mockFriend = $MwFriend((b) => b
          ..id = 1
          ..name = 'follower1'
          ..showName = 'Follower One'
        );

        final mockFriendList = MwFriendList((b) => b
          ..users = ListBuilder<MwFriend>([mockFriend])
          ..hasAfter = false
        );

        when(() => mockFriendListResponse.data).thenReturn(mockFriendList);
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenAnswer((_) async => mockFriendListResponse);

        // Act
        await userListNotifier.refresh();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(1));
            expect(users.first.name, equals('follower1'));
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );
      });
    });

    group('error handling', () {
      setUp(() {
        userListNotifier = UserListNotifier(
          type: UserListType.followers,
          username: 'testuser',
          usersApi: mockUsersApi,
        );
      });

      test('should handle 403 error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/users/testuser/followers'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/testuser/followers'),
            statusCode: 403,
          ),
        ));

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (users, hasMore, nextAfter, nextBefore) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Нет доступа к списку пользователей'));
          },
        );
      });

      test('should handle 429 error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/users/testuser/followers'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/testuser/followers'),
            statusCode: 429,
          ),
        ));

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (users, hasMore, nextAfter, nextBefore) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Слишком много запросов. Попробуйте позже'));
          },
        );
      });

      test('should handle generic network error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/users/testuser/followers'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/testuser/followers'),
            statusCode: 500,
          ),
        ));

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (users, hasMore, nextAfter, nextBefore) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Произошла ошибка сети. Проверьте подключение к интернету'));
          },
        );
      });

      test('should handle unknown error correctly', () async {
        // Arrange
        when(() => mockUsersApi.usersNameFollowersGet(
          name: 'testuser',
          after: any(named: 'after'),
          before: any(named: 'before'),
        )).thenThrow(Exception('Unknown error'));

        // Act
        await userListNotifier.fetchUserList();

        // Assert
        expect(userListNotifier.state, isA<UserListState>());
        userListNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (users, hasMore, nextAfter, nextBefore) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Exception: Unknown error'));
          },
        );
      });
    });
  });
}