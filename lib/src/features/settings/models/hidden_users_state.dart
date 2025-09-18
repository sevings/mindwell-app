import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'hidden_users_state.freezed.dart';

/// Represents the state of the hidden users list screen.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various hidden users loading scenarios.
@freezed
sealed class HiddenUsersState with _$HiddenUsersState {
  /// Initial state when the hidden users screen is first loaded.
  const factory HiddenUsersState.initial() = _Initial;

  /// Loading state when hidden users data is being fetched.
  const factory HiddenUsersState.loading() = _Loading;

  /// Loaded state when hidden users data has been successfully fetched.
  ///
  /// [users] List of hidden users from the API.
  /// [hasMore] Whether there are more users to load (for pagination).
  /// [nextAfter] Cursor for the next page of results.
  /// [nextBefore] Cursor for the previous page of results.
  const factory HiddenUsersState.loaded({
    required List<MwFriend> users,
    @Default(false) bool hasMore,
    String? nextAfter,
    String? nextBefore,
  }) = _Loaded;

  /// Error state when hidden users data fetching fails.
  ///
  /// [message] The error message describing what went wrong.
  const factory HiddenUsersState.error({required String message}) = _Error;
}
