import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for securely storing and retrieving authentication tokens.
/// 
/// Uses flutter_secure_storage to store tokens in the device's secure storage.
/// This ensures that tokens are encrypted and protected from unauthorized access.
class TokenStorageService {
  final FlutterSecureStorage _storage;

  /// Creates a TokenStorageService with the given storage instance.
  /// 
  /// [storage] The FlutterSecureStorage instance to use. If not provided,
  /// creates a default instance with secure options.
  TokenStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
            );

  // Keys for storing tokens
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  /// Saves both access and refresh tokens to secure storage.
  /// 
  /// [accessToken] The access token to store.
  /// [refreshToken] The refresh token to store.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
    ]);
  }

  /// Retrieves the access token from secure storage.
  /// 
  /// Returns the access token if it exists, null otherwise.
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Retrieves the refresh token from secure storage.
  /// 
  /// Returns the refresh token if it exists, null otherwise.
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Removes both access and refresh tokens from secure storage.
  /// 
  /// This is typically called when the user logs out or when tokens expire.
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  /// Checks if both tokens exist in secure storage.
  /// 
  /// Returns true if both access and refresh tokens are present, false otherwise.
  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }
}
