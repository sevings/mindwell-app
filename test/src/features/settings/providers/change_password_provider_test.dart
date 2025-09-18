import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import 'package:mindwell/src/features/settings/providers/change_password_provider.dart';

class MockMindwellApi extends Mock implements MindwellApi {}

class MockAccountApi extends Mock implements AccountApi {}

void main() {
  group('ChangePasswordNotifier', () {
    late MockMindwellApi mockApi;
    late MockAccountApi mockAccountApi;
    late ChangePasswordNotifier notifier;

    setUp(() {
      mockApi = MockMindwellApi();
      mockAccountApi = MockAccountApi();

      when(() => mockApi.getAccountApi()).thenReturn(mockAccountApi);

      notifier = ChangePasswordNotifier(mockApi);
    });

    test('initial state is initial', () {
      expect(notifier.state, const ChangePasswordState.initial());
    });

    test('changePassword sets loading state', () async {
      // Mock successful API response
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer(
        (_) async => Response<void>(
          requestOptions: RequestOptions(path: '/account/password'),
          statusCode: 200,
        ),
      );

      // Start the password change operation
      final future = notifier.changePassword('oldPassword', 'newPassword');

      // Check that state is loading
      expect(notifier.state, const ChangePasswordState.loading());

      // Wait for completion
      await future;
    });

    test('changePassword sets success state on successful API call', () async {
      // Mock successful API response
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer(
        (_) async => Response<void>(
          requestOptions: RequestOptions(path: '/account/password'),
          statusCode: 200,
        ),
      );

      await notifier.changePassword('oldPassword', 'newPassword');

      expect(notifier.state, const ChangePasswordState.success());

      verify(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: 'oldPassword',
          newPassword: 'newPassword',
        ),
      ).called(1);
    });

    test(
      'changePassword sets error state on API failure with 400 status',
      () async {
        // Mock API failure with 400 status
        when(
          () => mockAccountApi.accountPasswordPost(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/password'),
            response: Response(
              requestOptions: RequestOptions(path: '/account/password'),
              statusCode: 400,
            ),
          ),
        );

        await notifier.changePassword('oldPassword', 'newPassword');

        expect(
          notifier.state,
          const ChangePasswordState.error(
            'Invalid current password or new password requirements not met',
          ),
        );
      },
    );

    test(
      'changePassword sets error state on API failure with 401 status',
      () async {
        // Mock API failure with 401 status
        when(
          () => mockAccountApi.accountPasswordPost(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/password'),
            response: Response(
              requestOptions: RequestOptions(path: '/account/password'),
              statusCode: 401,
            ),
          ),
        );

        await notifier.changePassword('oldPassword', 'newPassword');

        expect(
          notifier.state,
          const ChangePasswordState.error('Current password is incorrect'),
        );
      },
    );

    test(
      'changePassword sets error state on API failure with 403 status',
      () async {
        // Mock API failure with 403 status
        when(
          () => mockAccountApi.accountPasswordPost(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/password'),
            response: Response(
              requestOptions: RequestOptions(path: '/account/password'),
              statusCode: 403,
            ),
          ),
        );

        await notifier.changePassword('oldPassword', 'newPassword');

        expect(
          notifier.state,
          const ChangePasswordState.error(
            'You are not authorized to change password',
          ),
        );
      },
    );

    test(
      'changePassword sets error state on API failure with 422 status',
      () async {
        // Mock API failure with 422 status
        when(
          () => mockAccountApi.accountPasswordPost(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/password'),
            response: Response(
              requestOptions: RequestOptions(path: '/account/password'),
              statusCode: 422,
            ),
          ),
        );

        await notifier.changePassword('oldPassword', 'newPassword');

        expect(
          notifier.state,
          const ChangePasswordState.error(
            'New password does not meet requirements',
          ),
        );
      },
    );

    test(
      'changePassword sets error state on API failure with 500 status',
      () async {
        // Mock API failure with 500 status
        when(
          () => mockAccountApi.accountPasswordPost(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/password'),
            response: Response(
              requestOptions: RequestOptions(path: '/account/password'),
              statusCode: 500,
            ),
          ),
        );

        await notifier.changePassword('oldPassword', 'newPassword');

        expect(
          notifier.state,
          const ChangePasswordState.error(
            'Server error. Please try again later',
          ),
        );
      },
    );

    test(
      'changePassword sets error state on API failure with unknown status',
      () async {
        // Mock API failure with unknown status
        when(
          () => mockAccountApi.accountPasswordPost(
            oldPassword: any(named: 'oldPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/password'),
            response: Response(
              requestOptions: RequestOptions(path: '/account/password'),
              statusCode: 418,
            ),
          ),
        );

        await notifier.changePassword('oldPassword', 'newPassword');

        expect(
          notifier.state,
          const ChangePasswordState.error(
            'Failed to change password. Please try again',
          ),
        );
      },
    );

    test('changePassword sets error state on non-DioException', () async {
      // Mock non-DioException
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenThrow(Exception('Network error'));

      await notifier.changePassword('oldPassword', 'newPassword');

      expect(
        notifier.state,
        const ChangePasswordState.error('Failed to change password'),
      );
    });
  });
}
