import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'entry_detail_state.freezed.dart';

/// Represents the current state of the entry detail view.
/// 
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various entry detail loading scenarios.
@freezed
sealed class EntryDetailState with _$EntryDetailState {
  /// Initial state when the entry detail is first created
  const factory EntryDetailState.initial() = _Initial;

  /// Loading state when entry details are being fetched
  const factory EntryDetailState.loading() = _Loading;

  /// Loaded state when entry details have been successfully fetched
  /// 
  /// [entry] The entry with full details
  /// [comments] List of comments for this entry
  /// [hasMoreComments] Whether there are more comments to load
  /// [isLoadingComments] Whether comments are currently being loaded
  const factory EntryDetailState.loaded({
    required MwEntry entry,
    @Default([]) List<MwComment> comments,
    @Default(false) bool hasMoreComments,
    @Default(false) bool isLoadingComments,
  }) = _Loaded;

  /// Error state when fetching entry details fails
  /// 
  /// [message] The error message describing what went wrong
  /// [entry] Previously loaded entry (if any) to maintain UI state
  const factory EntryDetailState.error({
    required String message,
    MwEntry? entry,
  }) = _Error;
}
