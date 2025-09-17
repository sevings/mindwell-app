import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'chat_list_state.freezed.dart';

/// State for the chat list feature.
///
/// Represents the different states the chat list can be in:
/// - loading: Initial loading state
/// - loaded: Successfully loaded with chat data
/// - error: Error state with error message
@freezed
class ChatListState with _$ChatListState {
  /// Initial loading state
  const factory ChatListState.loading() = ChatListLoading;

  /// Successfully loaded state with chat data
  const factory ChatListState.loaded({
    required List<MwChat> chats,
    @Default(false) bool isFetchingMore,
    @Default(false) bool hasMore,
  }) = ChatListLoaded;

  /// Error state with error message
  const factory ChatListState.error(String message) = ChatListError;
}
