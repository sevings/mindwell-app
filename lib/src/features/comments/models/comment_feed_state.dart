import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'comment_feed_state.freezed.dart';

/// Represents the current state of the comment feed.
/// 
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various comment feed loading scenarios.
@freezed
sealed class CommentFeedState with _$CommentFeedState {
  /// Initial state when the feed is first created
  const factory CommentFeedState.initial() = _Initial;

  /// Loading state when comments are being fetched
  const factory CommentFeedState.loading() = _Loading;

  /// Loaded state when comments have been successfully fetched
  /// 
  /// [comments] List of comments to display
  /// [hasMore] Whether there are more comments to load
  /// [isFetchingMore] Whether additional comments are currently being fetched
  const factory CommentFeedState.loaded({
    required List<MwComment> comments,
    @Default(false) bool hasMore,
    @Default(false) bool isFetchingMore,
  }) = _Loaded;

  /// Error state when fetching comments fails
  /// 
  /// [message] The error message describing what went wrong
  /// [comments] Previously loaded comments (if any) to maintain UI state
  const factory CommentFeedState.error({
    required String message,
    List<MwComment>? comments,
  }) = _Error;

  /// Empty state when no comments are available
  const factory CommentFeedState.empty() = _Empty;
}
