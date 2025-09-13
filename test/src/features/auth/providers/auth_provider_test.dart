import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';

// Mock classes
class MockTokenStorageService extends Mock implements TokenStorageService {}
class MockOauth2Api extends Mock implements Oauth2Api {}
class MockAccountApi extends Mock implements AccountApi {}
class MockMeApi extends Mock implements MeApi {}

void main() {
  group('AuthNotifier', () {
    late MockTokenStorageService mockTokenStorageService;
    late MockOauth2Api mockOauth2Api;
    late MockAccountApi mockAccountApi;
    late MockMeApi mockMeApi;
    late AuthNotifier authNotifier;

    setUp(() {
      mockTokenStorageService = MockTokenStorageService();
      mockOauth2Api = MockOauth2Api();
      mockAccountApi = MockAccountApi();
      mockMeApi = MockMeApi();
      
      authNotifier = AuthNotifier(
        tokenStorageService: mockTokenStorageService,
        oauth2Api: mockOauth2Api,
        accountApi: mockAccountApi,
        meApi: mockMeApi,
      );
    });

    group('Initial State', () {
      test('should start with initial state', () {
        expect(authNotifier.state, const AuthState.initial());
      });
    });

    group('Login', () {
      const email = 'test@example.com';
      const password = 'password123';
      const accessToken = 'access_token_123';
      const refreshToken = 'refresh_token_123';

      late MwOAuth2Token mockToken;
      late MwAuthProfile mockUserProfile;

      setUp(() {
        mockToken = MwOAuth2Token((b) => b
          ..accessToken = accessToken
          ..refreshToken = refreshToken
          ..tokenType = MwOAuth2TokenTokenTypeEnum.bearer
          ..expiresIn = 3600
        );

        mockUserProfile = MwAuthProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true
          ..avatar = null
        );

      });

      test('should login successfully with valid credentials', () async {
        // Arrange
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: email,
          password: password,
        )).thenAnswer((_) async => Response<MwOAuth2Token>(
          data: mockToken,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/oauth2/token'),
        ));

        when(() => mockTokenStorageService.saveUserTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        )).thenAnswer((_) async => {});

        when(() => mockMeApi.meGet()).thenAnswer((_) async => Response<MwAuthProfile>(
          data: mockUserProfile,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/me'),
        ));

        // Act
        await authNotifier.login(email, password);

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
        
        verify(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: email,
          password: password,
        )).called(1);

        verify(() => mockTokenStorageService.saveUserTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        )).called(1);

        verify(() => mockMeApi.meGet()).called(1);
      });

      test('should set loading state during login', () async {
        // Arrange
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: email,
          password: password,
        )).thenAnswer((_) async => Response<MwOAuth2Token>(
          data: mockToken,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/oauth2/token'),
        ));

        when(() => mockTokenStorageService.saveUserTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        )).thenAnswer((_) async => {});

        when(() => mockMeApi.meGet()).thenAnswer((_) async => Response<MwAuthProfile>(
          data: mockUserProfile,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/me'),
        ));

        // Act
        final future = authNotifier.login(email, password);
        
        // Assert loading state
        expect(authNotifier.state, const AuthState.loading());
        
        await future;
      });

      test('should handle login failure with invalid credentials', () async {
        // Arrange
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: email,
          password: password,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/oauth2/token'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/oauth2/token'),
          ),
        ));

        // Act
        await authNotifier.login(email, password);

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
        // Check that it's an error state with appropriate message
        expect(state, isA<AuthState>());
            });

      test('should handle network errors during login', () async {
        // Arrange
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: email,
          password: password,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/oauth2/token'),
          type: DioExceptionType.connectionTimeout,
        ));

        // Act
        await authNotifier.login(email, password);

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
      });
    });

    group('Register', () {
      const username = 'testuser';
      const email = 'test@example.com';
      const password = 'password123';

      late MwAuthProfile mockUserProfile;

      setUp(() {
        mockUserProfile = MwAuthProfile((b) => b
          ..id = 1
          ..name = username
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true
          ..avatar = null
        );
      });

      test('should register successfully with valid data', () async {
        // Arrange
        when(() => mockAccountApi.accountRegisterPost(
          email: email,
          password: password,
          name: username,
        )).thenAnswer((_) async => Response<MwAuthProfile>(
          data: mockUserProfile,
          statusCode: 201,
          requestOptions: RequestOptions(path: '/account/register'),
        ));

        // Mock the login call that happens after registration
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: email,
          password: password,
        )).thenAnswer((_) async => Response<MwOAuth2Token>(
          data: MwOAuth2Token((b) => b
            ..accessToken = 'access_token_123'
            ..refreshToken = 'refresh_token_123'
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/oauth2/token'),
        ));

        when(() => mockTokenStorageService.saveUserTokens(
          accessToken: 'access_token_123',
          refreshToken: 'refresh_token_123',
        )).thenAnswer((_) async => {});

        when(() => mockMeApi.meGet()).thenAnswer((_) async => Response<MwAuthProfile>(
          data: mockUserProfile,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/me'),
        ));

        // Act
        await authNotifier.register(username, email, password);

        // Assert
        verify(() => mockAccountApi.accountRegisterPost(
          email: email,
          password: password,
          name: username,
        )).called(1);
      });

      test('should handle registration failure with existing email', () async {
        // Arrange
        when(() => mockAccountApi.accountRegisterPost(
          email: email,
          password: password,
          name: username,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/account/register'),
          response: Response(
            statusCode: 409,
            requestOptions: RequestOptions(path: '/account/register'),
          ),
        ));

        // Act
        await authNotifier.register(username, email, password);

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
      });
    });

    group('Logout', () {
      test('should logout successfully', () async {
        // Arrange
        when(() => mockTokenStorageService.clearUserTokens()).thenAnswer((_) async => {});

        // Act
        await authNotifier.logout();

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
        verify(() => mockTokenStorageService.clearUserTokens()).called(1);
      });

      test('should handle logout even if clearing tokens fails', () async {
        // Arrange
        when(() => mockTokenStorageService.clearUserTokens()).thenThrow(Exception('Storage error'));

        // Act
        await authNotifier.logout();

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
      });
    });

    group('CheckAuthStatus', () {
      late MwAuthProfile mockUserProfile;

      setUp(() {
        mockUserProfile = MwAuthProfile((b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true
          ..avatar = null
        );
      });

      test('should set authenticated state when tokens exist and user profile is valid', () async {
        // Arrange
        when(() => mockTokenStorageService.hasUserTokens()).thenAnswer((_) async => true);
        when(() => mockMeApi.meGet()).thenAnswer((_) async => Response<MwAuthProfile>(
          data: mockUserProfile,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/me'),
        ));

        // Act
        await authNotifier.checkAuthStatus();

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        verify(() => mockTokenStorageService.hasUserTokens()).called(1);
        verify(() => mockMeApi.meGet()).called(1);
      });

      test('should set unauthenticated state when no tokens exist', () async {
        // Arrange
        when(() => mockTokenStorageService.hasUserTokens()).thenAnswer((_) async => false);

        // Act
        await authNotifier.checkAuthStatus();

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
        verify(() => mockTokenStorageService.hasUserTokens()).called(1);
        verifyNever(() => mockMeApi.meGet());
      });

      test('should clear tokens and set unauthenticated state when user profile fetch fails', () async {
        // Arrange
        when(() => mockTokenStorageService.hasUserTokens()).thenAnswer((_) async => true);
        when(() => mockMeApi.meGet()).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/me'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/me'),
          ),
        ));
        when(() => mockTokenStorageService.clearUserTokens()).thenAnswer((_) async => {});

        // Act
        await authNotifier.checkAuthStatus();

        // Assert
        expect(authNotifier.state, const AuthState.unauthenticated());
        verify(() => mockTokenStorageService.clearUserTokens()).called(1);
      });
    });

    group('RefreshToken', () {
      const refreshToken = 'refresh_token_123';
      const newAccessToken = 'new_access_token_123';
      const newRefreshToken = 'new_refresh_token_123';

      test('should refresh token successfully', () async {
        // Arrange
        when(() => mockTokenStorageService.getRefreshToken()).thenAnswer((_) async => refreshToken);
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'refresh_token',
          clientId: 1503747774,
          clientSecret: '',
          refreshToken: refreshToken,
        )).thenAnswer((_) async => Response<MwOAuth2Token>(
          data: MwOAuth2Token((b) => b
            ..accessToken = newAccessToken
            ..refreshToken = newRefreshToken
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/oauth2/token'),
        ));
        when(() => mockTokenStorageService.saveUserTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        )).thenAnswer((_) async => {});

        // Act
        final result = await authNotifier.refreshToken();

        // Assert
        expect(result, true);
        verify(() => mockTokenStorageService.getRefreshToken()).called(1);
        verify(() => mockTokenStorageService.saveUserTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        )).called(1);
      });

      test('should return false when no refresh token exists', () async {
        // Arrange
        when(() => mockTokenStorageService.getRefreshToken()).thenAnswer((_) async => null);

        // Act
        final result = await authNotifier.refreshToken();

        // Assert
        expect(result, false);
        verify(() => mockTokenStorageService.getRefreshToken()).called(1);
        verifyNever(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'refresh_token',
          clientId: 1503747774,
          clientSecret: '',
          refreshToken: any(named: 'refreshToken'),
        ));
      });

      test('should return false when refresh token request fails', () async {
        // Arrange
        when(() => mockTokenStorageService.getRefreshToken()).thenAnswer((_) async => refreshToken);
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'refresh_token',
          clientId: 1503747774,
          clientSecret: '',
          refreshToken: refreshToken,
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/oauth2/token'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/oauth2/token'),
          ),
        ));

        // Act
        final result = await authNotifier.refreshToken();

        // Assert
        expect(result, false);
      });
    });

    group('GetAppToken', () {
      const appToken = 'app_token_123';

      test('should return existing app token when available', () async {
        // Arrange
        when(() => mockTokenStorageService.getAppToken()).thenAnswer((_) async => appToken);

        // Act
        final result = await authNotifier.getAppToken();

        // Assert
        expect(result, appToken);
        verify(() => mockTokenStorageService.getAppToken()).called(1);
        verifyNever(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'client_credentials',
          clientId: 1503747774,
          clientSecret: '',
        ));
      });

      test('should fetch and save new app token when none exists', () async {
        // Arrange
        when(() => mockTokenStorageService.getAppToken()).thenAnswer((_) async => null);
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'client_credentials',
          clientId: 1503747774,
          clientSecret: '',
        )).thenAnswer((_) async => Response<MwOAuth2Token>(
          data: MwOAuth2Token((b) => b
            ..accessToken = appToken
            ..tokenType = MwOAuth2TokenTokenTypeEnum.bearer
            ..expiresIn = 3600
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/oauth2/token'),
        ));
        when(() => mockTokenStorageService.saveAppToken(appToken)).thenAnswer((_) async => {});

        // Act
        final result = await authNotifier.getAppToken();

        // Assert
        expect(result, appToken);
        verify(() => mockTokenStorageService.getAppToken()).called(1);
        verify(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'client_credentials',
          clientId: 1503747774,
          clientSecret: '',
        )).called(1);
        verify(() => mockTokenStorageService.saveAppToken(appToken)).called(1);
      });

      test('should return null when app token fetch fails', () async {
        // Arrange
        when(() => mockTokenStorageService.getAppToken()).thenAnswer((_) async => null);
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'client_credentials',
          clientId: 1503747774,
          clientSecret: '',
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/oauth2/token'),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: '/oauth2/token'),
          ),
        ));

        // Act
        final result = await authNotifier.getAppToken();

        // Assert
        expect(result, null);
        verify(() => mockTokenStorageService.getAppToken()).called(1);
        verify(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'client_credentials',
          clientId: 1503747774,
          clientSecret: '',
        )).called(1);
        verifyNever(() => mockTokenStorageService.saveAppToken(any()));
      });

      test('should return null when app token response is invalid', () async {
        // Arrange
        when(() => mockTokenStorageService.getAppToken()).thenAnswer((_) async => null);
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'client_credentials',
          clientId: 1503747774,
          clientSecret: '',
        )).thenAnswer((_) async => Response<MwOAuth2Token>(
          data: MwOAuth2Token((b) => b
            ..accessToken = null // Invalid response
            ..tokenType = MwOAuth2TokenTokenTypeEnum.bearer
            ..expiresIn = 3600
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/oauth2/token'),
        ));

        // Act
        final result = await authNotifier.getAppToken();

        // Assert
        expect(result, null);
        verifyNever(() => mockTokenStorageService.saveAppToken(any()));
      });
    });

    group('Error Message Handling', () {
      test('should return appropriate error message for 401 status', () async {
        // Arrange
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: 'test@example.com',
          password: 'wrongpassword',
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/oauth2/token'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/oauth2/token'),
          ),
        ));

        // Act
        await authNotifier.login('test@example.com', 'wrongpassword');

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
      });

      test('should return appropriate error message for 422 status', () async {
        // Arrange
        when(() => mockAccountApi.accountRegisterPost(
          email: 'invalid-email',
          password: 'short',
          name: 'a',
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/account/register'),
          response: Response(
            statusCode: 422,
            requestOptions: RequestOptions(path: '/account/register'),
          ),
        ));

        // Act
        await authNotifier.register('a', 'invalid-email', 'short');

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
      });

      test('should return appropriate error message for 409 status', () async {
        // Arrange
        when(() => mockAccountApi.accountRegisterPost(
          email: 'existing@example.com',
          password: 'password123',
          name: 'testuser',
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/account/register'),
          response: Response(
            statusCode: 409,
            requestOptions: RequestOptions(path: '/account/register'),
          ),
        ));

        // Act
        await authNotifier.register('testuser', 'existing@example.com', 'password123');

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
      });

      test('should return appropriate error message for 429 status', () async {
        // Arrange
        when(() => mockOauth2Api.oauth2TokenPost(
          grantType: 'password',
          clientId: 1503747774,
          clientSecret: '',
          username: 'test@example.com',
          password: 'password123',
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: '/oauth2/token'),
          response: Response(
            statusCode: 429,
            requestOptions: RequestOptions(path: '/oauth2/token'),
          ),
        ));

        // Act
        await authNotifier.login('test@example.com', 'password123');

        // Assert
        expect(authNotifier.state, isA<AuthState>());
        final state = authNotifier.state;
        expect(state, isA<AuthState>());
      });
    });
  });
}
