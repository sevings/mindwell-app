import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'notification_list_state.freezed.dart';

/// State management for the notifications list screen.
///
/// This state handles different states of the notifications list including
/// loading, loaded with data, error states, and empty states.
@freezed
class NotificationListState with _$NotificationListState {
  /// Initial state when the screen is first loaded.
  const factory NotificationListState.initial() = _Initial;

  /// Loading state when fetching notifications from the API.
  const factory NotificationListState.loading() = _Loading;

  /// Loaded state when notifications have been successfully fetched.
  ///
  /// [notifications] - List of notifications to display
  /// [unreadCount] - Number of unread notifications
  /// [hasMore] - Whether there are more notifications to load
  const factory NotificationListState.loaded({
    required List<MwNotification> notifications,
    required int unreadCount,
    required bool hasMore,
  }) = _Loaded;

  /// Error state when an error occurs while fetching notifications.
  ///
  /// [message] - Error message to display to the user
  /// [notifications] - Previously loaded notifications (if any) to show
  /// while displaying the error
  const factory NotificationListState.error({
    required String message,
    @Default([]) List<MwNotification> notifications,
  }) = _Error;

  /// Empty state when no notifications are available.
  const factory NotificationListState.empty() = _Empty;
}
