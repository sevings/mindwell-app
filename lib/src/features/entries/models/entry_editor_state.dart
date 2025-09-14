import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'entry_editor_state.freezed.dart';

/// Represents the current state of the entry editor.
/// 
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various entry editing scenarios.
@freezed
sealed class EntryEditorState with _$EntryEditorState {
  /// Initial state when the editor is first created
  const factory EntryEditorState.initial() = _Initial;

  /// Loading state when entry data is being fetched (for editing existing entries)
  const factory EntryEditorState.loading() = _Loading;

  /// Editing state when the user is actively editing an entry
  /// 
  /// [title] The current title of the entry
  /// [content] The current content of the entry (HTML format)
  /// [tags] List of tags for the entry
  /// [privacy] Privacy setting for the entry
  /// [isCommentable] Whether comments are allowed
  /// [isVotable] Whether voting is allowed
  /// [inLive] Whether the entry should appear in live feed
  /// [isShared] Whether the entry can be shared
  /// [isDraft] Whether this is a draft entry
  /// [images] List of image IDs attached to the entry
  /// [entryId] ID of the entry being edited (null for new entries)
  /// [hasUnsavedChanges] Whether there are unsaved changes
  const factory EntryEditorState.editing({
    @Default('') String title,
    @Default('') String content,
    @Default([]) List<String> tags,
    @Default('all') String privacy,
    @Default(true) bool isCommentable,
    @Default(true) bool isVotable,
    @Default(true) bool inLive,
    @Default(false) bool isShared,
    @Default(false) bool isDraft,
    @Default([]) List<int> images,
    int? entryId,
    @Default(false) bool hasUnsavedChanges,
  }) = _Editing;

  /// Publishing state when the entry is being saved/published
  /// 
  /// [isUploadingImages] Whether images are currently being uploaded
  /// [uploadProgress] Progress of image upload (0.0 to 1.0)
  const factory EntryEditorState.publishing({
    @Default(false) bool isUploadingImages,
    @Default(0.0) double uploadProgress,
  }) = _Publishing;

  /// Success state when the entry has been successfully saved/published
  /// 
  /// [entry] The created/updated entry
  const factory EntryEditorState.success({
    required MwEntry entry,
  }) = _Success;

  /// Error state when saving/publishing fails
  /// 
  /// [message] The error message describing what went wrong
  /// [canRetry] Whether the user can retry the operation
  const factory EntryEditorState.error({
    required String message,
    @Default(true) bool canRetry,
  }) = _Error;
}
