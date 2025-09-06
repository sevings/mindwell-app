import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base class for all failures in the application
@freezed
sealed class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  const factory Failure.network({
    required String message,
  }) = NetworkFailure;

  const factory Failure.cache({
    required String message,
  }) = CacheFailure;

  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  const factory Failure.authentication({
    required String message,
  }) = AuthenticationFailure;

  const factory Failure.authorization({
    required String message,
  }) = AuthorizationFailure;

  const factory Failure.notFound({
    required String message,
  }) = NotFoundFailure;

  const factory Failure.timeout({
    required String message,
  }) = TimeoutFailure;

  const factory Failure.unknown({
    required String message,
    Object? originalError,
  }) = UnknownFailure;
}

extension FailureExtensions on Failure {
  /// Returns a user-friendly error message
  String get userMessage {
    return when(
      server: (message, statusCode) => 'Server error: $message',
      network: (message) => 'Network error: Please check your connection',
      cache: (message) => 'Cache error: $message',
      validation: (message, fieldErrors) => 'Validation error: $message',
      authentication: (message) => 'Authentication required',
      authorization: (message) => 'Access denied',
      notFound: (message) => 'Resource not found',
      timeout: (message) => 'Request timeout: Please try again',
      unknown: (message, originalError) => 'An unexpected error occurred',
    );
  }

  /// Returns true if this is a critical error that should be logged
  bool get isCritical {
    return when(
      server: (_, __) => true,
      network: (_) => false,
      cache: (_) => false,
      validation: (_, __) => false,
      authentication: (_) => false,
      authorization: (_) => false,
      notFound: (_) => false,
      timeout: (_) => false,
      unknown: (_, __) => true,
    );
  }
}