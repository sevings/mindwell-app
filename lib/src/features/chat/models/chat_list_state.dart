import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'chat_list_state.freezed.dart';

/// Represents the current state of the chat list.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various chat list loading scenarios.
@freezed
sealed class ChatListState with _$ChatListState {
  /// Initial state when the chat list is first created
  const factory ChatListState.initial() = _Initial;

  /// Loading state when chats are being fetched
  const factory ChatListState.loading() = _Loading;

  /// Loaded state when chats have been successfully fetched
  ///
  /// [chats] List of chats to display
  /// [hasMore] Whether there are more chats to load
  /// [unreadCount] Total number of unread messages across all chats
  const factory ChatListState.loaded({
    required List<MwChat> chats,
    @Default(false) bool hasMore,
    @Default(0) int unreadCount,
  }) = _Loaded;

  /// Error state when fetching chats fails
  ///
  /// [message] The error message describing what went wrong
  /// [chats] Previously loaded chats (if any) to maintain UI state
  const factory ChatListState.error({
    required String message,
    List<MwChat>? chats,
  }) = _Error;

  /// Empty state when no chats are available
  const factory ChatListState.empty() = _Empty;
}
