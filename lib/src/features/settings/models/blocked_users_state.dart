import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'blocked_users_state.freezed.dart';

/// Represents the state of the blocked users list screen.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various blocked users loading scenarios.
@freezed
sealed class BlockedUsersState with _$BlockedUsersState {
  /// Initial state when the blocked users screen is first loaded.
  const factory BlockedUsersState.initial() = _Initial;

  /// Loading state when blocked users data is being fetched.
  const factory BlockedUsersState.loading() = _Loading;

  /// Loaded state when blocked users data has been successfully fetched.
  ///
  /// [users] List of blocked users from the API.
  /// [hasMore] Whether there are more users to load (for pagination).
  /// [nextAfter] Cursor for the next page of results.
  /// [nextBefore] Cursor for the previous page of results.
  const factory BlockedUsersState.loaded({
    required List<MwFriend> users,
    @Default(false) bool hasMore,
    String? nextAfter,
    String? nextBefore,
  }) = _Loaded;

  /// Error state when blocked users data fetching fails.
  ///
  /// [message] The error message describing what went wrong.
  const factory BlockedUsersState.error({required String message}) = _Error;
}
