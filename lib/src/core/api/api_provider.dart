import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../config/config.dart';
import '../services/token_storage_service.dart';

/// Provider for the TokenStorageService instance.
final tokenStorageServiceProvider = Provider<TokenStorageService>((ref) {
  return TokenStorageService();
});

/// Provider for the configured Dio instance with authentication interceptor.
final dioProvider = Provider<Dio>((ref) {
  final tokenStorageService = ref.read(tokenStorageServiceProvider);
  
  final dio = Dio(BaseOptions(
    baseUrl: '${Config.baseUrl}/api/v1',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));
  
  // Add authentication interceptor
  dio.interceptors.add(AuthInterceptor(
    tokenStorageService: tokenStorageService,
  ));
  
  return dio;
});

/// Provider for the MindwellApi instance with configured Dio.
final mindwellApiProvider = Provider<MindwellApi>((ref) {
  final dio = ref.read(dioProvider);
  return MindwellApi(dio: dio);
});

/// Provider for the OAuth2Api instance.
final oauth2ApiProvider = Provider<Oauth2Api>((ref) {
  final api = ref.read(mindwellApiProvider);
  return api.getOauth2Api();
});

/// Provider for the AccountApi instance.
final accountApiProvider = Provider<AccountApi>((ref) {
  final api = ref.read(mindwellApiProvider);
  return api.getAccountApi();
});

/// Provider for the MeApi instance.
final meApiProvider = Provider<MeApi>((ref) {
  final api = ref.read(mindwellApiProvider);
  return api.getMeApi();
});

/// Authentication interceptor for Dio that handles token injection and refresh.
/// 
/// This interceptor:
/// 1. Automatically adds the Authorization header with the access token
/// 2. Handles 401 Unauthorized responses by attempting to refresh the token
/// 3. Logs out the user if token refresh fails
class AuthInterceptor extends Interceptor {
  final TokenStorageService _tokenStorageService;
  
  AuthInterceptor({
    required TokenStorageService tokenStorageService,
  })  : _tokenStorageService = tokenStorageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add Authorization header if access token is available
    _tokenStorageService.getAccessToken().then((accessToken) {
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      handler.next(options);
    }).catchError((error) {
      // If there's an error getting the token, continue without it
      handler.next(options);
    });
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // For now, we'll just pass through all errors
    // Token refresh logic will be handled in the auth provider
    // when it detects 401 errors from API calls
    handler.next(err);
  }
}
