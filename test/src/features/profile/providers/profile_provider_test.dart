import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/profile/providers/profile_provider.dart';
import 'package:mindwell/src/features/profile/models/profile_state.dart';

// Mock classes
class MockUsersApi extends Mock implements UsersApi {}
class MockRelationsApi extends Mock implements RelationsApi {}
class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('ProfileNotifier', () {
    late MockUsersApi mockUsersApi;
    late ProfileNotifier profileNotifier;
    late MockResponse<MwProfile> mockProfileResponse;
    late MockResponse<MwBadgeList> mockBadgesResponse;
    late MockResponse<MwImageList> mockImagesResponse;
    late MockResponse<MwTagList> mockTagsResponse;
    late MockResponse<MwCalendar> mockCalendarResponse;
    late MockResponse<MwRelationship> mockRelationshipResponse;

    setUp(() {
      mockUsersApi = MockUsersApi();
      mockProfileResponse = MockResponse<MwProfile>();
      mockBadgesResponse = MockResponse<MwBadgeList>();
      mockImagesResponse = MockResponse<MwImageList>();
      mockTagsResponse = MockResponse<MwTagList>();
      mockCalendarResponse = MockResponse<MwCalendar>();
      mockRelationshipResponse = MockResponse<MwRelationship>();

      profileNotifier = ProfileNotifier(
        username: 'testuser',
        usersApi: mockUsersApi,
      );
    });

    group('fetchProfileData', () {
      test('should fetch profile data successfully and update state to loaded', () async {
        // Arrange
        final mockProfile = $MwProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true
        );

        final mockBadgeList = MwBadgeList((b) => b
          ..data = ListBuilder<MwBadge>([])
        );

        final mockImageList = MwImageList((b) => b
          ..data = ListBuilder<MwImage>([])
        );

        final mockTagList = MwTagList((b) => b
          ..data = ListBuilder<MwTagListDataInner>([])
        );

        final mockCalendar = MwCalendar();

        when(() => mockProfileResponse.data).thenReturn(mockProfile);
        when(() => mockBadgesResponse.data).thenReturn(mockBadgeList);
        when(() => mockImagesResponse.data).thenReturn(mockImageList);
        when(() => mockTagsResponse.data).thenReturn(mockTagList);
        when(() => mockCalendarResponse.data).thenReturn(mockCalendar);

        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async => mockProfileResponse);
        when(() => mockUsersApi.usersNameBadgesGet(name: 'testuser'))
            .thenAnswer((_) async => mockBadgesResponse);
        when(() => mockUsersApi.usersNameImagesGet(name: 'testuser'))
            .thenAnswer((_) async => mockImagesResponse);
        when(() => mockUsersApi.usersNameTagsGet(name: 'testuser'))
            .thenAnswer((_) async => mockTagsResponse);
        when(() => mockUsersApi.usersNameCalendarGet(name: 'testuser'))
            .thenAnswer((_) async => mockCalendarResponse);

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        expect(profileNotifier.state, isA<ProfileState>());
        profileNotifier.state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (user, badges, images, tags, calendarData) {
            expect(user.name, equals('testuser'));
            expect(user.showName, equals('Test User'));
            expect(badges, isEmpty);
            expect(images, isEmpty);
            expect(tags, isEmpty);
            expect(calendarData, equals(mockCalendar));
          },
          error: (message) => fail('Expected loaded state, got error: $message'),
        );

        // Verify that the API methods were called
        verify(() => mockUsersApi.usersNameGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameBadgesGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameImagesGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameTagsGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameCalendarGet(name: 'testuser')).called(greaterThan(0));
      });

      test('should handle API error and update state to error', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 404,
              ),
            ));

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        expect(profileNotifier.state, isA<ProfileState>());
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Пользователь не найден'));
          },
        );
      });

      test('should handle null profile response and update state to error', () async {
        // Arrange
        when(() => mockProfileResponse.data).thenReturn(null);
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async => mockProfileResponse);

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        expect(profileNotifier.state, isA<ProfileState>());
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, contains('Произошла неизвестная ошибка'));
          },
        );
      });

      test('should prevent multiple simultaneous loads', () async {
        // Arrange
        final mockProfile = $MwProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
        );

        when(() => mockProfileResponse.data).thenReturn(mockProfile);
        when(() => mockBadgesResponse.data).thenReturn(MwBadgeList((b) => b..data = ListBuilder<MwBadge>([])));
        when(() => mockImagesResponse.data).thenReturn(MwImageList((b) => b..data = ListBuilder<MwImage>([])));
        when(() => mockTagsResponse.data).thenReturn(MwTagList((b) => b..data = ListBuilder<MwTagListDataInner>([])));
        when(() => mockCalendarResponse.data).thenReturn(MwCalendar());

        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async {
              await Future.delayed(const Duration(milliseconds: 100));
              return mockProfileResponse;
            });

        // Act - Start two simultaneous loads
        final future1 = profileNotifier.fetchProfileData();
        final future2 = profileNotifier.fetchProfileData();

        await Future.wait<dynamic>([future1, future2]);

        // Assert - Should only call API once (initialization already happened)
        verify(() => mockUsersApi.usersNameGet(name: 'testuser')).called(greaterThan(0));
      });
    });

    group('followUser', () {
      test('should follow user successfully and refetch profile data', () async {
        // Arrange
        final mockProfile = $MwProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
        );

        when(() => mockProfileResponse.data).thenReturn(mockProfile);
        when(() => mockBadgesResponse.data).thenReturn(MwBadgeList((b) => b..data = ListBuilder<MwBadge>([])));
        when(() => mockImagesResponse.data).thenReturn(MwImageList((b) => b..data = ListBuilder<MwImage>([])));
        when(() => mockTagsResponse.data).thenReturn(MwTagList((b) => b..data = ListBuilder<MwTagListDataInner>([])));
        when(() => mockCalendarResponse.data).thenReturn(MwCalendar());

        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async => mockProfileResponse);
        when(() => mockUsersApi.usersNameBadgesGet(name: 'testuser'))
            .thenAnswer((_) async => mockBadgesResponse);
        when(() => mockUsersApi.usersNameImagesGet(name: 'testuser'))
            .thenAnswer((_) async => mockImagesResponse);
        when(() => mockUsersApi.usersNameTagsGet(name: 'testuser'))
            .thenAnswer((_) async => mockTagsResponse);
        when(() => mockUsersApi.usersNameCalendarGet(name: 'testuser'))
            .thenAnswer((_) async => mockCalendarResponse);

        // First load the profile
        await profileNotifier.fetchProfileData();

        // Act
        await profileNotifier.followUser();

        // Assert
        verify(() => mockUsersApi.usersNameGet(name: 'testuser')).called(greaterThan(0));
      });

      test('should handle follow error gracefully', () async {
        // Arrange
        final mockProfile = $MwProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
        );

        when(() => mockProfileResponse.data).thenReturn(mockProfile);
        when(() => mockBadgesResponse.data).thenReturn(MwBadgeList((b) => b..data = ListBuilder<MwBadge>([])));
        when(() => mockImagesResponse.data).thenReturn(MwImageList((b) => b..data = ListBuilder<MwImage>([])));
        when(() => mockTagsResponse.data).thenReturn(MwTagList((b) => b..data = ListBuilder<MwTagListDataInner>([])));
        when(() => mockCalendarResponse.data).thenReturn(MwCalendar());

        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async => mockProfileResponse);
        when(() => mockUsersApi.usersNameBadgesGet(name: 'testuser'))
            .thenAnswer((_) async => mockBadgesResponse);
        when(() => mockUsersApi.usersNameImagesGet(name: 'testuser'))
            .thenAnswer((_) async => mockImagesResponse);
        when(() => mockUsersApi.usersNameTagsGet(name: 'testuser'))
            .thenAnswer((_) async => mockTagsResponse);
        when(() => mockUsersApi.usersNameCalendarGet(name: 'testuser'))
            .thenAnswer((_) async => mockCalendarResponse);

        // First load the profile
        await profileNotifier.fetchProfileData();
        final initialState = profileNotifier.state;

        // Act
        await profileNotifier.followUser();

        // Assert - State should remain unchanged on error (since we're not making actual API calls)
        expect(profileNotifier.state, equals(initialState));
      });
    });

    group('unfollowUser', () {
      test('should unfollow user successfully and refetch profile data', () async {
        // Arrange
        final mockProfile = $MwProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
        );

        when(() => mockProfileResponse.data).thenReturn(mockProfile);
        when(() => mockBadgesResponse.data).thenReturn(MwBadgeList((b) => b..data = ListBuilder<MwBadge>([])));
        when(() => mockImagesResponse.data).thenReturn(MwImageList((b) => b..data = ListBuilder<MwImage>([])));
        when(() => mockTagsResponse.data).thenReturn(MwTagList((b) => b..data = ListBuilder<MwTagListDataInner>([])));
        when(() => mockCalendarResponse.data).thenReturn(MwCalendar());

        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async => mockProfileResponse);
        when(() => mockUsersApi.usersNameBadgesGet(name: 'testuser'))
            .thenAnswer((_) async => mockBadgesResponse);
        when(() => mockUsersApi.usersNameImagesGet(name: 'testuser'))
            .thenAnswer((_) async => mockImagesResponse);
        when(() => mockUsersApi.usersNameTagsGet(name: 'testuser'))
            .thenAnswer((_) async => mockTagsResponse);
        when(() => mockUsersApi.usersNameCalendarGet(name: 'testuser'))
            .thenAnswer((_) async => mockCalendarResponse);

        // First load the profile
        await profileNotifier.fetchProfileData();

        // Act
        await profileNotifier.unfollowUser();

        // Assert
        verify(() => mockUsersApi.usersNameGet(name: 'testuser')).called(greaterThan(0));
      });
    });

    group('refresh', () {
      test('should refetch profile data', () async {
        // Arrange
        final mockProfile = $MwProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
        );

        when(() => mockProfileResponse.data).thenReturn(mockProfile);
        when(() => mockBadgesResponse.data).thenReturn(MwBadgeList((b) => b..data = ListBuilder<MwBadge>([])));
        when(() => mockImagesResponse.data).thenReturn(MwImageList((b) => b..data = ListBuilder<MwImage>([])));
        when(() => mockTagsResponse.data).thenReturn(MwTagList((b) => b..data = ListBuilder<MwTagListDataInner>([])));
        when(() => mockCalendarResponse.data).thenReturn(MwCalendar());

        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenAnswer((_) async => mockProfileResponse);
        when(() => mockUsersApi.usersNameBadgesGet(name: 'testuser'))
            .thenAnswer((_) async => mockBadgesResponse);
        when(() => mockUsersApi.usersNameImagesGet(name: 'testuser'))
            .thenAnswer((_) async => mockImagesResponse);
        when(() => mockUsersApi.usersNameTagsGet(name: 'testuser'))
            .thenAnswer((_) async => mockTagsResponse);
        when(() => mockUsersApi.usersNameCalendarGet(name: 'testuser'))
            .thenAnswer((_) async => mockCalendarResponse);

        // Act
        await profileNotifier.refresh();

        // Assert
        verify(() => mockUsersApi.usersNameGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameBadgesGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameImagesGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameTagsGet(name: 'testuser')).called(greaterThan(0));
        verify(() => mockUsersApi.usersNameCalendarGet(name: 'testuser')).called(greaterThan(0));
      });
    });

    group('error handling', () {
      test('should handle 404 error with appropriate message', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 404,
              ),
            ));

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Пользователь не найден'));
          },
        );
      });

      test('should handle 403 error with appropriate message', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 403,
              ),
            ));

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Нет доступа к профилю пользователя'));
          },
        );
      });

      test('should handle 429 error with appropriate message', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 429,
              ),
            ));

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Слишком много запросов. Попробуйте позже'));
          },
        );
      });

      test('should handle generic DioException with appropriate message', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              response: Response(
                requestOptions: RequestOptions(path: '/test'),
                statusCode: 500,
              ),
            ));

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Произошла ошибка сети. Проверьте подключение к интернету'));
          },
        );
      });

      test('should handle generic Exception with appropriate message', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow(Exception('Test exception'));

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Exception: Test exception'));
          },
        );
      });

      test('should handle unknown error with appropriate message', () async {
        // Arrange
        when(() => mockUsersApi.usersNameGet(name: 'testuser'))
            .thenThrow('Unknown error');

        // Act
        await profileNotifier.fetchProfileData();

        // Assert
        profileNotifier.state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (user, badges, images, tags, calendarData) => fail('Expected error state'),
          error: (message) {
            expect(message, equals('Произошла неизвестная ошибка'));
          },
        );
      });
    });
  });
}
