import 'package:freezed_annotation/freezed_annotation.dart';
import 'entry.dart';

part 'entry_feed_state.freezed.dart';

@freezed
sealed class EntryFeedState with _$EntryFeedState {
  const factory EntryFeedState.loading() = EntryFeedLoading;
  
  const factory EntryFeedState.loaded({
    required List<Entry> entries,
    @Default(false) bool isFetchingMore,
    @Default(true) bool hasMore,
    required FeedSettings settings,
    int? currentPage,
  }) = EntryFeedLoaded;
  
  const factory EntryFeedState.error({
    required String errorMessage,
    List<Entry>? previousEntries,
    FeedSettings? settings,
  }) = EntryFeedError;
}