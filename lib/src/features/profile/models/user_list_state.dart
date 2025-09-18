import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'user_list_state.freezed.dart';

/// Represents the different types of user lists that can be displayed.
enum UserListType {
  /// List of users who follow the specified user
  followers,

  /// List of users that the specified user follows
  following,

  /// List of users invited by the specified user
  invited,

  /// General user search/list
  users,
}

/// Represents the different tab types for the general user list screen.
enum UserListTabType {
  /// New users (invited)
  invited,

  /// Users waiting for approval
  waiting,

  /// Users ranked by popularity/activity
  rank,
}

/// Represents the state of a user list screen.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various user list loading scenarios.
@freezed
sealed class UserListState with _$UserListState {
  /// Initial state when the user list screen is first loaded.
  const factory UserListState.initial() = _Initial;

  /// Loading state when user list data is being fetched.
  const factory UserListState.loading() = _Loading;

  /// Loaded state when user list data has been successfully fetched.
  ///
  /// [users] List of users from the API.
  /// [hasMore] Whether there are more users to load (for pagination).
  /// [nextAfter] Cursor for the next page of results.
  /// [nextBefore] Cursor for the previous page of results.
  const factory UserListState.loaded({
    required List<MwFriend> users,
    @Default(false) bool hasMore,
    String? nextAfter,
    String? nextBefore,
  }) = _Loaded;

  /// Error state when user list data fetching fails.
  ///
  /// [message] The error message describing what went wrong.
  const factory UserListState.error({required String message}) = _Error;
}
