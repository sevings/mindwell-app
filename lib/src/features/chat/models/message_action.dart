import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_action.freezed.dart';

/// Available actions for messages
enum MessageActionType {
  /// Edit the message content
  edit,

  /// Delete the message
  delete,

  /// Report the message
  report,

  /// Retry sending a failed message
  retry,
}

/// Represents a message action that can be performed
@freezed
class MessageAction with _$MessageAction {
  const factory MessageAction.edit({
    required int messageId,
    required String currentContent,
  }) = EditMessageAction;

  const factory MessageAction.delete({required int messageId}) =
      DeleteMessageAction;

  const factory MessageAction.report({required int messageId, String? reason}) =
      ReportMessageAction;

  const factory MessageAction.retry({
    required int messageId,
    required String content,
  }) = RetryMessageAction;
}

/// Result of a message action
@freezed
class MessageActionResult with _$MessageActionResult {
  const factory MessageActionResult.success({String? message}) =
      MessageActionSuccess;

  const factory MessageActionResult.error({required String error}) =
      MessageActionError;
}
