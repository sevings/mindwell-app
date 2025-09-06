import 'package:freezed_annotation/freezed_annotation.dart';
import '../error/failures.dart';

part 'result.freezed.dart';

/// A Result type that encapsulates either a success value or a failure
@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(Failure failure) = Failed<T>;
}

extension ResultExtensions<T> on Result<T> {
  /// Returns true if this is a success result
  bool get isSuccess => when(
        success: (_) => true,
        failure: (_) => false,
      );

  /// Returns true if this is a failure result
  bool get isFailure => when(
        success: (_) => false,
        failure: (_) => true,
      );

  /// Returns the value if success, otherwise null
  T? get valueOrNull => when(
        success: (value) => value,
        failure: (_) => null,
      );

  /// Returns the failure if failed, otherwise null
  Failure? get failureOrNull => when(
        success: (_) => null,
        failure: (failure) => failure,
      );

  /// Maps the success value to a new type
  Result<R> map<R>(R Function(T) mapper) => when(
        success: (value) => Result.success(mapper(value)),
        failure: (failure) => Result.failure(failure),
      );

  /// Flat maps the success value to a new Result
  Result<R> flatMap<R>(Result<R> Function(T) mapper) => when(
        success: (value) => mapper(value),
        failure: (failure) => Result.failure(failure),
      );

  /// Returns the value if success, otherwise throws an exception
  T get value => when(
        success: (value) => value,
        failure: (failure) => throw Exception(failure.userMessage),
      );

  /// Returns the value if success, otherwise returns the default value
  T valueOr(T defaultValue) => when(
        success: (value) => value,
        failure: (_) => defaultValue,
      );

  /// Executes the appropriate callback based on the result
  R fold<R>(
    R Function(T value) onSuccess,
    R Function(Failure failure) onFailure,
  ) =>
      when(
        success: onSuccess,
        failure: onFailure,
      );
}