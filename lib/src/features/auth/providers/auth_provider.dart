import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../config/config.dart';
import '../../../core/api/api_provider.dart';
import '../../../core/services/token_storage_service.dart';
import '../models/auth_state.dart';

/// The main authentication provider that manages the authentication state.
///
/// This provider uses StateNotifierProvider to manage the AuthState and provides
/// methods for login, registration, logout, and checking authentication status.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    tokenStorageService: ref.read(tokenStorageServiceProvider),
    oauth2Api: ref.read(oauth2ApiProvider),
    accountApi: ref.read(accountApiProvider),
    meApi: ref.read(meApiProvider),
  );
});

/// Notifier class that manages authentication state and business logic.
///
/// This class handles all authentication operations including login, registration,
/// logout, and checking authentication status. It uses the provided API clients
/// and token storage service to manage authentication tokens and user data.
class AuthNotifier extends StateNotifier<AuthState> {
  /// The token storage service for managing authentication tokens.
  final TokenStorageService _tokenStorageService;

  /// The OAuth2 API client for authentication operations.
  final Oauth2Api _oauth2Api;

  /// The Account API client for account-related operations.
  final AccountApi _accountApi;

  /// The Me API client for getting current user information.
  final MeApi _meApi;

  /// Creates an AuthNotifier with the required dependencies.
  AuthNotifier({
    required TokenStorageService tokenStorageService,
    required Oauth2Api oauth2Api,
    required AccountApi accountApi,
    required MeApi meApi,
  }) : _tokenStorageService = tokenStorageService,
       _oauth2Api = oauth2Api,
       _accountApi = accountApi,
       _meApi = meApi,
       super(const AuthState.initial());

  /// Attempts to log in with the provided email and password.
  ///
  /// This method:
  /// 1. Sets the state to loading
  /// 2. Calls the OAuth2 token endpoint with password grant
  /// 3. Saves the tokens to secure storage
  /// 4. Fetches the current user profile
  /// 5. Updates the state to authenticated or error
  ///
  /// [email] The user's email address
  /// [password] The user's password
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    try {
      // Call OAuth2 token endpoint with password grant
      final tokenResponse = await _oauth2Api.oauth2TokenPost(
        grantType: 'password',
        clientId: Config.clientId,
        clientSecret: Config.clientSecret,
        username: email,
        password: password,
      );

      final token = tokenResponse.data;
      if (token?.accessToken == null || token?.refreshToken == null) {
        throw Exception('Invalid token response');
      }

      // Save tokens to secure storage
      await _tokenStorageService.saveUserTokens(
        accessToken: token!.accessToken!,
        refreshToken: token.refreshToken!,
      );

      // Fetch current user profile
      final userResponse = await _meApi.meGet();
      final userProfile = userResponse.data;
      if (userProfile == null) {
        throw Exception('Failed to fetch user profile');
      }

      // Convert MwAuthProfile to $MwUser for the AuthState
      final user = $MwUser(
        (b) => b
          ..id = userProfile.id
          ..name = userProfile.name
          ..showName = userProfile.showName
          ..isTheme = userProfile.isTheme
          ..isOnline = userProfile.isOnline
          ..avatar = userProfile.avatar?.toBuilder(),
      );

      state = AuthState.authenticated(user: user, authSource: AuthSource.login);
    } catch (e) {
      state = AuthState.error(message: _getErrorMessage(e));
    }
  }

  /// Attempts to register a new user account.
  ///
  /// This method:
  /// 1. Sets the state to loading
  /// 2. Calls the account registration endpoint
  /// 3. If successful, automatically logs in the user
  /// 4. Updates the state to authenticated or error
  ///
  /// [username] The desired username
  /// [email] The user's email address
  /// [password] The user's password
  Future<void> register(String username, String email, String password) async {
    state = const AuthState.loading();

    try {
      // Call account registration endpoint
      final registerResponse = await _accountApi.accountRegisterPost(
        email: email,
        password: password,
        name: username,
      );

      final userProfile = registerResponse.data;
      if (userProfile == null) {
        throw Exception('Registration failed');
      }

      // After successful registration, automatically log in
      await _loginAfterRegistration(email, password);
    } catch (e) {
      state = AuthState.error(message: _getErrorMessage(e));
    }
  }

  /// Internal method to handle login after successful registration.
  ///
  /// This method is similar to login() but sets the authSource to registration
  /// to indicate the user came from the registration flow.
  Future<void> _loginAfterRegistration(String email, String password) async {
    try {
      // Call OAuth2 token endpoint with password grant
      final tokenResponse = await _oauth2Api.oauth2TokenPost(
        grantType: 'password',
        clientId: Config.clientId,
        clientSecret: Config.clientSecret,
        username: email,
        password: password,
      );

      final token = tokenResponse.data;
      if (token?.accessToken == null || token?.refreshToken == null) {
        throw Exception('Invalid token response');
      }

      // Save tokens to secure storage
      await _tokenStorageService.saveUserTokens(
        accessToken: token!.accessToken!,
        refreshToken: token.refreshToken!,
      );

      // Fetch current user profile
      final userResponse = await _meApi.meGet();
      final userProfile = userResponse.data;
      if (userProfile == null) {
        throw Exception('Failed to fetch user profile');
      }

      // Convert MwAuthProfile to $MwUser for the AuthState
      final user = $MwUser(
        (b) => b
          ..id = userProfile.id
          ..name = userProfile.name
          ..showName = userProfile.showName
          ..isTheme = userProfile.isTheme
          ..isOnline = userProfile.isOnline
          ..avatar = userProfile.avatar?.toBuilder(),
      );

      state = AuthState.authenticated(
        user: user,
        authSource: AuthSource.registration,
      );
    } catch (e) {
      state = AuthState.error(message: _getErrorMessage(e));
    }
  }

  /// Logs out the current user.
  ///
  /// This method:
  /// 1. Clears only user authentication tokens (keeps app token)
  /// 2. Updates the state to unauthenticated
  Future<void> logout() async {
    try {
      await _tokenStorageService.clearUserTokens();
      state = const AuthState.unauthenticated();
    } catch (e) {
      // Even if clearing tokens fails, we should still log out
      state = const AuthState.unauthenticated();
    }
  }

  /// Checks the authentication status on app startup.
  ///
  /// This method:
  /// 1. Checks if user tokens exist in secure storage
  /// 2. If tokens exist, fetches the current user profile
  /// 3. Updates the state to authenticated or unauthenticated
  Future<void> checkAuthStatus() async {
    try {
      final hasUserTokens = await _tokenStorageService.hasUserTokens();
      if (!hasUserTokens) {
        state = const AuthState.unauthenticated();
        return;
      }

      // Try to fetch current user profile with existing tokens
      final userResponse = await _meApi.meGet();
      final userProfile = userResponse.data;
      if (userProfile == null) {
        // If we can't fetch user profile, clear tokens and logout
        await _tokenStorageService.clearUserTokens();
        state = const AuthState.unauthenticated();
        return;
      }

      // Convert MwAuthProfile to $MwUser for the AuthState
      final user = $MwUser(
        (b) => b
          ..id = userProfile.id
          ..name = userProfile.name
          ..showName = userProfile.showName
          ..isTheme = userProfile.isTheme
          ..isOnline = userProfile.isOnline
          ..avatar = userProfile.avatar?.toBuilder(),
      );

      state = AuthState.authenticated(user: user, authSource: AuthSource.login);
    } catch (e) {
      // If any error occurs, clear tokens and logout
      await _tokenStorageService.clearUserTokens();
      state = const AuthState.unauthenticated();
    }
  }

  /// Attempts to refresh the access token using the refresh token.
  ///
  /// This method:
  /// 1. Gets the current refresh token
  /// 2. Calls the OAuth2 token endpoint with refresh_token grant
  /// 3. Saves the new tokens to secure storage
  /// 4. Returns true if successful, false otherwise
  ///
  /// Returns true if token refresh was successful, false otherwise.
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _tokenStorageService.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }

      final tokenResponse = await _oauth2Api.oauth2TokenPost(
        grantType: 'refresh_token',
        clientId: Config.clientId,
        clientSecret: Config.clientSecret,
        refreshToken: refreshToken,
      );

      final token = tokenResponse.data;
      if (token?.accessToken == null || token?.refreshToken == null) {
        return false;
      }

      await _tokenStorageService.saveUserTokens(
        accessToken: token!.accessToken!,
        refreshToken: token.refreshToken!,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Gets or fetches the app token for API calls when user is not authenticated.
  ///
  /// This method:
  /// 1. Checks if an app token is already stored
  /// 2. If not, fetches a new app token using client_credentials grant
  /// 3. Saves the app token to secure storage
  /// 4. Returns the app token
  ///
  /// Returns the app token if successful, null otherwise.
  Future<String?> getAppToken() async {
    try {
      // Check if we already have a valid app token
      final existingToken = await _tokenStorageService.getAppToken();
      if (existingToken != null) {
        return existingToken;
      }

      // Fetch new app token using client_credentials grant
      final tokenResponse = await _oauth2Api.oauth2TokenPost(
        grantType: 'client_credentials',
        clientId: Config.clientId,
        clientSecret: Config.clientSecret,
      );

      final token = tokenResponse.data;
      if (token?.accessToken == null) {
        return null;
      }

      // Save the app token to secure storage
      await _tokenStorageService.saveAppToken(token!.accessToken!);

      return token.accessToken!;
    } catch (e) {
      return null;
    }
  }

  /// Extracts a user-friendly error message from an exception.
  ///
  /// This method handles different types of exceptions and returns
  /// appropriate error messages for display to the user.
  ///
  /// [error] The exception that occurred
  /// Returns a user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.response?.statusCode) {
        case 401:
          return 'Неверный email или пароль';
        case 422:
          return 'Неверные данные для регистрации';
        case 409:
          return 'Пользователь с таким email уже существует';
        case 429:
          return 'Слишком много попыток. Попробуйте позже';
        default:
          return 'Произошла ошибка сети. Проверьте подключение к интернету';
      }
    }

    if (error is Exception) {
      return error.toString();
    }

    return 'Произошла неизвестная ошибка';
  }
}
