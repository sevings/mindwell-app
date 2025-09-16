import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'auth_state.freezed.dart';

/// Represents the source of authentication.
enum AuthSource {
  /// User authenticated via login.
  login,

  /// User authenticated via registration.
  registration,
}

/// Represents the current authentication state of the application.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various authentication scenarios.
@freezed
sealed class AuthState with _$AuthState {
  /// Initial state when the app starts and authentication status is unknown.
  const factory AuthState.initial() = _Initial;

  /// Loading state when authentication operations are in progress.
  const factory AuthState.loading() = _Loading;

  /// Authenticated state when the user is successfully logged in.
  ///
  /// [user] The authenticated user information from the API.
  /// [authSource] The source of authentication (login or registration).
  const factory AuthState.authenticated({
    required $MwUser user,
    @Default(AuthSource.login) AuthSource authSource,
  }) = _Authenticated;

  /// Unauthenticated state when the user is not logged in.
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// Error state when authentication operations fail.
  ///
  /// [message] The error message describing what went wrong.
  const factory AuthState.error({required String message}) = _Error;
}
