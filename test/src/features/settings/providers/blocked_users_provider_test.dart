import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/settings/providers/blocked_users_provider.dart';
import 'package:mindwell/src/features/settings/models/blocked_users_state.dart';

class MockMeApi extends Mock implements MeApi {}

class MockRelationsApi extends Mock implements RelationsApi {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('BlockedUsersNotifier', () {
    late MockMeApi mockMeApi;
    late MockRelationsApi mockRelationsApi;
    late BlockedUsersNotifier notifier;

    setUp(() {
      mockMeApi = MockMeApi();
      mockRelationsApi = MockRelationsApi();
      notifier = BlockedUsersNotifier(
        meApi: mockMeApi,
        relationsApi: mockRelationsApi,
      );
    });

    group('init', () {
      test('should fetch blocked users successfully', () async {
        // Arrange
        final mockFriend1 = $MwFriend(
          (b) => b
            ..id = 1
            ..name = 'blockeduser1'
            ..showName = 'Blocked User One'
            ..isTheme = false
            ..isOnline = false,
        );

        final mockFriend2 = $MwFriend(
          (b) => b
            ..id = 2
            ..name = 'blockeduser2'
            ..showName = 'Blocked User Two'
            ..isTheme = false
            ..isOnline = false,
        );

        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend1, mockFriend2])
            ..hasAfter = true
            ..nextAfter = 'next_cursor'
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.init();

        // Assert
        final state = notifier.state;
        expect(state, isA<BlockedUsersState>());
        state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(2));
            expect(users.first.name, equals('blockeduser1'));
            expect(users.last.name, equals('blockeduser2'));
            expect(hasMore, isTrue);
            expect(nextAfter, equals('next_cursor'));
          },
          error: (message) => fail('Should not be in error state: $message'),
        );

        verify(() => mockMeApi.meIgnoredGet()).called(1);
      });

      test('should handle empty blocked users list', () async {
        // Arrange
        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([])
            ..hasAfter = false
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.init();

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, isEmpty);
            expect(hasMore, isFalse);
          },
          error: (message) => fail('Should not be in error state: $message'),
        );
      });

      test('should handle API error', () async {
        // Arrange
        when(() => mockMeApi.meIgnoredGet()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            response: Response(
              requestOptions: RequestOptions(path: '/test'),
              statusCode: 500,
            ),
          ),
        );

        // Act
        await notifier.init();

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (users, hasMore, nextAfter, nextBefore) =>
              fail('Should not be in loaded state'),
          error: (message) =>
              expect(message, equals('Ошибка сервера. Попробуйте позже')),
        );
      });

      test('should handle null response data', () async {
        // Arrange
        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(null);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.init();

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (users, hasMore, nextAfter, nextBefore) =>
              fail('Should not be in loaded state'),
          error: (message) =>
              expect(message, contains('Blocked users list not found')),
        );
      });
    });

    group('unblockUser', () {
      test('should unblock user successfully', () async {
        // Arrange
        final username = 'testuser';

        final mockFriend1 = $MwFriend(
          (b) => b
            ..id = 1
            ..name = username
            ..showName = 'Test User'
            ..isTheme = false
            ..isOnline = false,
        );

        final mockFriend2 = $MwFriend(
          (b) => b
            ..id = 2
            ..name = 'otheruser'
            ..showName = 'Other User'
            ..isTheme = false
            ..isOnline = false,
        );

        // Set up initial loaded state
        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend1, mockFriend2])
            ..hasAfter = false
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Mock the unblock API call
        when(
          () => mockRelationsApi.relationsToNameDelete(name: username),
        ).thenAnswer((_) async => MockResponse<MwRelationship>());

        // Initialize with data
        await notifier.init();

        // Act
        await notifier.unblockUser(username);

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(1));
            expect(users.first.name, equals('otheruser'));
          },
          error: (message) => fail('Should not be in error state: $message'),
        );

        verify(
          () => mockRelationsApi.relationsToNameDelete(name: username),
        ).called(1);
      });

      test('should handle unblock API error gracefully', () async {
        // Arrange
        final username = 'testuser';

        final mockFriend = $MwFriend(
          (b) => b
            ..id = 1
            ..name = username
            ..showName = 'Test User'
            ..isTheme = false
            ..isOnline = false,
        );

        // Set up initial loaded state
        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend])
            ..hasAfter = false
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Mock the unblock API call to throw an error
        when(
          () => mockRelationsApi.relationsToNameDelete(name: username),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            response: Response(
              requestOptions: RequestOptions(path: '/test'),
              statusCode: 404,
            ),
          ),
        );

        // Initialize with data
        await notifier.init();
        final initialState = notifier.state;

        // Act
        await notifier.unblockUser(username);

        // Assert - state should remain unchanged on error
        expect(notifier.state, equals(initialState));
        verify(
          () => mockRelationsApi.relationsToNameDelete(name: username),
        ).called(1);
      });
    });

    group('fetchNextPage', () {
      test('should fetch next page successfully', () async {
        // Arrange
        final mockFriend1 = $MwFriend(
          (b) => b
            ..id = 1
            ..name = 'user1'
            ..showName = 'User One'
            ..isTheme = false
            ..isOnline = false,
        );

        final mockFriend2 = $MwFriend(
          (b) => b
            ..id = 2
            ..name = 'user2'
            ..showName = 'User Two'
            ..isTheme = false
            ..isOnline = false,
        );

        final mockFriend3 = $MwFriend(
          (b) => b
            ..id = 3
            ..name = 'user3'
            ..showName = 'User Three'
            ..isTheme = false
            ..isOnline = false,
        );

        // Set up initial loaded state with pagination info
        final initialFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend1])
            ..hasAfter = true
            ..nextAfter = 'cursor1'
            ..hasBefore = false,
        );

        final initialResponse = MockResponse<MwFriendList>();
        when(() => initialResponse.data).thenReturn(initialFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => initialResponse);

        // Set up next page response
        final nextFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend2, mockFriend3])
            ..hasAfter = false
            ..hasBefore = false,
        );

        final nextResponse = MockResponse<MwFriendList>();
        when(() => nextResponse.data).thenReturn(nextFriendList);
        when(
          () => mockMeApi.meIgnoredGet(after: 'cursor1'),
        ).thenAnswer((_) async => nextResponse);

        // Initialize with first page
        await notifier.init();

        // Act
        await notifier.fetchNextPage();

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (users, hasMore, nextAfter, nextBefore) {
            expect(users, hasLength(3));
            expect(hasMore, isFalse);
            expect(nextAfter, isNull);
          },
          error: (message) => fail('Should not be in error state: $message'),
        );

        verify(() => mockMeApi.meIgnoredGet(after: 'cursor1')).called(1);
      });

      test('should not fetch next page when no more data available', () async {
        // Arrange
        final mockFriend = $MwFriend(
          (b) => b
            ..id = 1
            ..name = 'user1'
            ..showName = 'User One'
            ..isTheme = false
            ..isOnline = false,
        );

        // Set up initial loaded state with no more data
        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend])
            ..hasAfter = false
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Initialize
        await notifier.init();

        // Act
        await notifier.fetchNextPage();

        // Assert - should only make the initial call, no additional pagination calls
        verify(() => mockMeApi.meIgnoredGet()).called(1);
        verifyNever(() => mockMeApi.meIgnoredGet(after: any(named: 'after')));
      });

      test('should handle fetch next page error gracefully', () async {
        // Arrange
        final mockFriend = $MwFriend(
          (b) => b
            ..id = 1
            ..name = 'user1'
            ..showName = 'User One'
            ..isTheme = false
            ..isOnline = false,
        );

        // Set up initial loaded state
        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend])
            ..hasAfter = true
            ..nextAfter = 'cursor1'
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Mock next page call to throw error
        when(() => mockMeApi.meIgnoredGet(after: 'cursor1')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            response: Response(
              requestOptions: RequestOptions(path: '/test'),
              statusCode: 500,
            ),
          ),
        );

        // Initialize
        await notifier.init();
        final initialState = notifier.state;

        // Act
        await notifier.fetchNextPage();

        // Assert - state should remain unchanged on error
        expect(notifier.state, equals(initialState));
        verify(() => mockMeApi.meIgnoredGet(after: 'cursor1')).called(1);
      });
    });

    group('refresh', () {
      test('should refresh blocked users list', () async {
        // Arrange
        final mockFriend = $MwFriend(
          (b) => b
            ..id = 1
            ..name = 'user1'
            ..showName = 'User One'
            ..isTheme = false
            ..isOnline = false,
        );

        final mockFriendList = MwFriendList(
          (b) => b
            ..users = ListBuilder<MwFriend>([mockFriend])
            ..hasAfter = false
            ..hasBefore = false,
        );

        final mockResponse = MockResponse<MwFriendList>();
        when(() => mockResponse.data).thenReturn(mockFriendList);
        when(
          () => mockMeApi.meIgnoredGet(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.refresh();

        // Assert
        verify(() => mockMeApi.meIgnoredGet()).called(1);
      });
    });

    group('error handling', () {
      test(
        'should return appropriate error messages for different HTTP status codes',
        () async {
          final testCases = [
            (401, 'Необходимо войти в систему'),
            (403, 'Нет доступа к списку заблокированных пользователей'),
            (404, 'Пользователь не найден'),
            (429, 'Слишком много запросов. Попробуйте позже'),
            (500, 'Ошибка сервера. Попробуйте позже'),
            (null, 'Произошла ошибка сети. Проверьте подключение к интернету'),
          ];

          for (final (statusCode, expectedMessage) in testCases) {
            // Arrange
            when(() => mockMeApi.meIgnoredGet()).thenThrow(
              DioException(
                requestOptions: RequestOptions(path: '/test'),
                response: statusCode != null
                    ? Response(
                        requestOptions: RequestOptions(path: '/test'),
                        statusCode: statusCode,
                      )
                    : null,
              ),
            );

            // Act
            await notifier.init();

            // Assert
            final state = notifier.state;
            state.when(
              initial: () => fail('Should not be in initial state'),
              loading: () => fail('Should not be in loading state'),
              loaded: (users, hasMore, nextAfter, nextBefore) =>
                  fail('Should not be in loaded state'),
              error: (message) => expect(message, equals(expectedMessage)),
            );

            // Reset for next iteration
            reset(mockMeApi);
          }
        },
      );
    });
  });
}
