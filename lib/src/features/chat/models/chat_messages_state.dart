import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'chat_messages_state.freezed.dart';

/// Message status for tracking message delivery and read states
enum MessageStatus {
  /// Message is being sent
  sending,

  /// Message was sent successfully
  sent,

  /// Message delivery failed
  failed,

  /// Message was delivered
  delivered,

  /// Message was read
  read,
}

/// State for the chat messages feature.
///
/// Represents the different states the chat messages can be in:
/// - loading: Initial loading state
/// - loaded: Successfully loaded with message data
/// - error: Error state with error message
@freezed
class ChatMessagesState with _$ChatMessagesState {
  /// Initial loading state
  const factory ChatMessagesState.loading() = ChatMessagesLoading;

  /// Successfully loaded state with message data
  const factory ChatMessagesState.loaded({
    required List<MwMessage> messages,
    @Default({}) Map<int, MessageStatus> messageStatus,
    @Default(false) bool isFetchingMore,
    @Default(false) bool hasMore,
    @Default(false) bool isSending,
  }) = ChatMessagesLoaded;

  /// Error state with error message
  const factory ChatMessagesState.error(String message) = ChatMessagesError;
}
