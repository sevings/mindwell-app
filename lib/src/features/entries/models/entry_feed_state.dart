import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'feed_settings.dart';

part 'entry_feed_state.freezed.dart';

/// Represents the current state of the entry feed.
/// 
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various feed loading scenarios.
@freezed
sealed class EntryFeedState with _$EntryFeedState {
  /// Initial state when the feed is first created
  const factory EntryFeedState.initial() = _Initial;

  /// Loading state when entries are being fetched
  const factory EntryFeedState.loading() = _Loading;

  /// Loaded state when entries have been successfully fetched
  /// 
  /// [entries] List of entries to display
  /// [hasMore] Whether there are more entries to load
  /// [settings] Current feed settings
  const factory EntryFeedState.loaded({
    required List<MwEntry> entries,
    @Default(false) bool hasMore,
    required FeedSettings settings,
  }) = _Loaded;

  /// Error state when fetching entries fails
  /// 
  /// [message] The error message describing what went wrong
  /// [entries] Previously loaded entries (if any) to maintain UI state
  const factory EntryFeedState.error({
    required String message,
    List<MwEntry>? entries,
  }) = _Error;

  /// Empty state when no entries are available
  const factory EntryFeedState.empty() = _Empty;
}
