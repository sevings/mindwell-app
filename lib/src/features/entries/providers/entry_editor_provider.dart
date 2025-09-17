import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/services/image_upload_service.dart';
import '../../../core/services/image_polling_service.dart';
import '../models/entry_editor_state.dart';
import '../models/attached_image.dart';
import '../services/entry_settings_backup_service.dart';

/// Provider for the EntryEditorNotifier that manages the state of entry editing.
///
/// Takes an optional [entryId] and [themeName] as parameters to create separate providers for each entry.
/// If [entryId] is null, it's for creating a new entry.
/// If [themeName] is provided, it's for creating a theme entry.
final entryEditorProvider =
    StateNotifierProvider.family<
      EntryEditorNotifier,
      EntryEditorState,
      ({int? entryId, String? themeName})
    >((ref, params) {
      final entriesApi = ref.read(entriesApiProvider);
      final meApi = ref.read(meApiProvider);
      final themesApi = ref.read(themesApiProvider);
      final imageUploadService = ref.read(imageUploadServiceProvider);
      final imagePollingService = ref.read(imagePollingServiceProvider);

      return EntryEditorNotifier(
        entryId: params.entryId,
        themeName: params.themeName,
        entriesApi: entriesApi,
        meApi: meApi,
        themesApi: themesApi,
        imageUploadService: imageUploadService,
        imagePollingService: imagePollingService,
      );
    });

/// Notifier that manages the state and logic for creating and editing entries.
///
/// This class handles:
/// - Loading existing entry data for editing
/// - Managing entry form state (title, content, tags, etc.)
/// - Uploading images and managing image attachments
/// - Publishing/saving entries (both new and existing)
/// - Draft management and autosaving
/// - Error handling and state management
class EntryEditorNotifier extends StateNotifier<EntryEditorState> {
  final int? _entryId;
  final String? _themeName;
  final EntriesApi _entriesApi;
  final MeApi _meApi;
  final ThemesApi _themesApi;
  final ImageUploadService _imageUploadService;
  final ImagePollingService _imagePollingService;
  final Logger _logger = Logger('EntryEditorNotifier');

  bool _isInitialized = false;
  final Set<int> _deletedImageIds =
      {}; // Track images deleted from existing entries
  EntryEditorState?
  _previewBackup; // Store original editing state before preview

  EntryEditorNotifier({
    required int? entryId,
    required String? themeName,
    required EntriesApi entriesApi,
    required MeApi meApi,
    required ThemesApi themesApi,
    required ImageUploadService imageUploadService,
    required ImagePollingService imagePollingService,
  }) : _entryId = entryId,
       _themeName = themeName,
       _entriesApi = entriesApi,
       _meApi = meApi,
       _themesApi = themesApi,
       _imageUploadService = imageUploadService,
       _imagePollingService = imagePollingService,
       super(const EntryEditorState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by loading existing entry data if editing.
  Future<void> _initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Always reset to appropriate state when initializing
    if (_entryId != null) {
      await _loadExistingEntry();
    } else {
      // Start with empty editing state for new entry
      state = EntryEditorState.editing(themeName: _themeName);
    }
  }

  /// Load existing entry data for editing.
  Future<void> _loadExistingEntry() async {
    if (_entryId == null) return;

    _logger.info('Loading existing entry $_entryId for editing');
    state = const EntryEditorState.loading();

    try {
      final response = await _entriesApi.entriesIdGet(id: _entryId);
      final entry = response.data;

      if (entry == null) {
        throw Exception('Entry not found');
      }

      _logger.info('Loaded entry $_entryId for editing');

      // Convert entry data to editing state
      state = EntryEditorState.editing(
        title: entry.title ?? '',
        content: entry.editContent ?? entry.content ?? '',
        tags: entry.tags?.toList() ?? [],
        privacy: entry.privacy?.name ?? 'all',
        isCommentable: entry.isCommentable ?? true,
        isVotable: true, // Default to true as it's not in the API model
        inLive: entry.inLive ?? true,
        isShared: entry.isShared ?? false,
        isDraft: false, // Existing entries are not drafts
        images:
            entry.images
                ?.map(
                  (img) => img.id != null
                      ? AttachedImage.ready(id: img.id!, image: img)
                      : null,
                )
                .where((attachedImage) => attachedImage != null)
                .cast<AttachedImage>()
                .toList() ??
            [],
        entryId: _entryId,
        hasUnsavedChanges: false,
        themeName: _themeName,
        isAnonymous: false, // Will be determined from entry data if available
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to load entry $_entryId for editing',
        e,
        stackTrace,
      );
      state = EntryEditorState.error(
        message: 'Failed to load entry: ${e.toString()}',
        canRetry: true,
      );
    }
  }

  /// Update the entry title.
  void updateTitle(String title) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(title: title, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            oldTitle,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(title: title, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the entry content.
  void updateContent(String content) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(content: content, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            oldContent,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(content: content, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the entry tags.
  void updateTags(List<String> tags) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(tags: tags, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            oldTags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(tags: tags, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the privacy setting.
  void updatePrivacy(String privacy) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(privacy: privacy, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            oldPrivacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => _updatePrivacyWithBackup(
            title,
            content,
            tags,
            oldPrivacy,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(privacy: privacy, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update privacy with backup logic to preserve values when options are hidden/shown.
  EntryEditorState _updatePrivacyWithBackup(
    String title,
    String content,
    List<String> tags,
    String oldPrivacy,
    String newPrivacy,
    bool isCommentable,
    bool isVotable,
    bool inLive,
    bool isShared,
    bool isDraft,
    List<AttachedImage> images,
    int? entryId,
    bool hasUnsavedChanges,
    String? themeName,
    bool isAnonymous,
  ) {
    bool newIsCommentable = isCommentable;
    bool newIsVotable = isVotable;
    bool newInLive = inLive;

    final entryKey = entryId?.toString() ?? 'new_entry';

    // Handle transition from non-restrictive to restrictive privacy
    if (oldPrivacy != 'me' && newPrivacy == 'me') {
      // Backup current values before hiding
      EntrySettingsBackupService.backupSettings(
        entryKey,
        isCommentable: isCommentable,
        isVotable: isVotable,
        inLive: inLive,
      );
      // Disable options for 'me' privacy
      newIsCommentable = false;
      newIsVotable = false;
      newInLive = false;
    } else if (oldPrivacy != 'followers' && newPrivacy == 'followers') {
      // Backup current live feed value before hiding
      EntrySettingsBackupService.backupSettings(
        entryKey,
        isCommentable: isCommentable,
        isVotable: isVotable,
        inLive: inLive,
      );
      // Disable live feed for 'followers' privacy
      newInLive = false;
    }

    // Handle transition from restrictive to non-restrictive privacy
    if (oldPrivacy == 'me' && newPrivacy != 'me') {
      // Restore backed up values
      final backup = EntrySettingsBackupService.restoreSettings(entryKey);
      if (backup != null) {
        newIsCommentable = backup.isCommentable;
        newIsVotable = backup.isVotable;
        newInLive = backup.inLive;
      } else {
        newIsCommentable = true;
        newIsVotable = true;
        newInLive = true;
      }
      // Clear backup
      EntrySettingsBackupService.clearBackup(entryKey);
    } else if (oldPrivacy == 'followers' &&
        newPrivacy != 'followers' &&
        newPrivacy != 'me') {
      // Restore backed up live feed value
      final backup = EntrySettingsBackupService.restoreSettings(entryKey);
      if (backup != null) {
        newInLive = backup.inLive;
      } else {
        newInLive = true;
      }
      // Clear backup
      EntrySettingsBackupService.clearBackup(entryKey);
    }

    return EntryEditorState.editing(
      title: title,
      content: content,
      tags: tags,
      privacy: newPrivacy,
      isCommentable: newIsCommentable,
      isVotable: newIsVotable,
      inLive: newInLive,
      isShared: isShared,
      isDraft: isDraft,
      images: images,
      entryId: entryId,
      hasUnsavedChanges: true,
      themeName: themeName,
      isAnonymous: isAnonymous,
    );
  }

  /// Update the commentable setting.
  void updateIsCommentable(bool isCommentable) {
    state = state.when(
      initial: () => EntryEditorState.editing(
        isCommentable: isCommentable,
        hasUnsavedChanges: true,
      ),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            oldIsCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(
        isCommentable: isCommentable,
        hasUnsavedChanges: true,
      ),
      error: (message, canRetry) => state,
    );
  }

  /// Update the votable setting.
  void updateIsVotable(bool isVotable) {
    state = state.when(
      initial: () => EntryEditorState.editing(
        isVotable: isVotable,
        hasUnsavedChanges: true,
      ),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            oldIsVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(
        isVotable: isVotable,
        hasUnsavedChanges: true,
      ),
      error: (message, canRetry) => state,
    );
  }

  /// Update the live feed setting.
  void updateInLive(bool inLive) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(inLive: inLive, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            oldInLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(inLive: inLive, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the shared setting.
  void updateIsShared(bool isShared) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(isShared: isShared, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            oldIsShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(isShared: isShared, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the draft setting.
  void updateIsDraft(bool isDraft) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(isDraft: isDraft, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            oldIsDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(isDraft: isDraft, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the anonymous setting (only for theme entries).
  void updateIsAnonymous(bool isAnonymous) {
    state = state.when(
      initial: () => EntryEditorState.editing(
        isAnonymous: isAnonymous,
        hasUnsavedChanges: true,
      ),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            oldIsAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(
        isAnonymous: isAnonymous,
        hasUnsavedChanges: true,
      ),
      error: (message, canRetry) => state,
    );
  }

  /// Add an image to the entry.
  void addImage(AttachedImage attachedImage) {
    state = state.when(
      initial: () => EntryEditorState.editing(
        images: [attachedImage],
        hasUnsavedChanges: true,
      ),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: [...images, attachedImage],
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(
        images: [attachedImage],
        hasUnsavedChanges: true,
      ),
      error: (message, canRetry) => state,
    );
  }

  /// Remove an image from the entry.
  void removeImage(int imageId) {
    state = state.when(
      initial: () => state,
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) {
            // Find the image to remove (for validation)
            images.firstWhere(
              (img) => img.id == imageId,
              orElse: () => throw StateError('Image not found'),
            );

            // Remove from state
            final newImages = images
                .where((attachedImage) => attachedImage.id != imageId)
                .toList();

            // If this is a new entry (no entryId), delete the image from server immediately
            if (entryId == null) {
              _deleteImageFromServer(imageId);
            } else {
              // For existing entries, track the image for deletion after saving
              _deletedImageIds.add(imageId);
            }

            return EntryEditorState.editing(
              title: title,
              content: content,
              tags: tags,
              privacy: privacy,
              isCommentable: isCommentable,
              isVotable: isVotable,
              inLive: inLive,
              isShared: isShared,
              isDraft: isDraft,
              images: newImages,
              entryId: entryId,
              hasUnsavedChanges: true,
              themeName: themeName,
              isAnonymous: isAnonymous,
            );
          },
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the list of images.
  void updateImages(List<AttachedImage> images) {
    state = state.when(
      initial: () =>
          EntryEditorState.editing(images: images, hasUnsavedChanges: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            oldImages,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: true,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          EntryEditorState.editing(images: images, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Upload images and add them to the entry.
  Future<void> uploadImages(List<File> files) async {
    if (files.isEmpty) return;

    _logger.info('Starting upload of ${files.length} images');

    // Store the original editing data before changing state
    final originalEditingData = state.maybeWhen(
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => (
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            hasUnsavedChanges: hasUnsavedChanges,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      orElse: () => null,
    );

    // Update state to show uploading
    state = state.when(
      initial: () => const EntryEditorState.publishing(isUploadingImages: true),
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => const EntryEditorState.publishing(isUploadingImages: true),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) =>
          const EntryEditorState.publishing(isUploadingImages: true),
      error: (message, canRetry) => state,
    );

    try {
      final uploadedImages = await _imageUploadService.uploadImages(
        files,
        onProgress: (progress) {
          state = EntryEditorState.publishing(
            isUploadingImages: true,
            uploadProgress: progress,
          );
        },
      );

      // Process uploaded images and create AttachedImage objects
      final attachedImages = <AttachedImage>[];

      for (int i = 0; i < uploadedImages.length; i++) {
        final image = uploadedImages[i];
        if (image != null && image.id != null) {
          // Check if image is still processing
          if (image.processing == true) {
            final attachedImage = AttachedImage.processing(
              id: image.id!,
              image: image,
            );
            attachedImages.add(attachedImage);

            // Start polling for this image
            _startImagePolling(image.id!);
          } else {
            attachedImages.add(
              AttachedImage.ready(id: image.id!, image: image),
            );
          }
        }
      }

      // Return to editing state with uploaded images
      if (originalEditingData != null) {
        final updatedImages = [
          ...originalEditingData.images,
          ...attachedImages,
        ];
        state = EntryEditorState.editing(
          title: originalEditingData.title,
          content: originalEditingData.content,
          tags: originalEditingData.tags,
          privacy: originalEditingData.privacy,
          isCommentable: originalEditingData.isCommentable,
          isVotable: originalEditingData.isVotable,
          inLive: originalEditingData.inLive,
          isShared: originalEditingData.isShared,
          isDraft: originalEditingData.isDraft,
          images: updatedImages,
          entryId: originalEditingData.entryId,
          hasUnsavedChanges: originalEditingData.hasUnsavedChanges,
          themeName: originalEditingData.themeName,
          isAnonymous: originalEditingData.isAnonymous,
        );
        _logger.info('Successfully uploaded ${attachedImages.length} images');
      } else {
        // If we weren't in editing state, create a new editing state with the uploaded images
        state = EntryEditorState.editing(images: attachedImages);
        _logger.info(
          'Successfully uploaded ${attachedImages.length} images to new entry',
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to upload images', e, stackTrace);
      state = EntryEditorState.error(
        message: 'Failed to upload images: ${e.toString()}',
        canRetry: true,
      );
    }
  }

  /// Publish or save the entry.
  ///
  /// [isDraft] Whether to save as draft (true) or publish (false)
  Future<void> publishEntry({bool isDraft = false}) async {
    final currentState = state;

    // Get current editing state
    final editingData = currentState.when(
      initial: () => null,
      loading: () => null,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => (
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => null,
      success: (entry) => null,
      preview: (entry) => null,
      error: (message, canRetry) => null,
    );

    if (editingData == null) return;

    // Validate required fields
    if (editingData.content.trim().isEmpty) {
      state = EntryEditorState.error(
        message: 'Content is required',
        canRetry: false,
      );
      return;
    }

    _logger.info('Publishing entry (draft: $isDraft)');

    try {
      // Check if there are any new images that need to be uploaded
      final hasNewImages = editingData.images.isNotEmpty;

      if (hasNewImages) {
        // Start with image upload phase
        state = const EntryEditorState.publishing(
          isUploadingImages: true,
          uploadProgress: 0.0,
        );

        // Upload images first
        await _uploadImagesForPublishing(editingData.images);
      }

      // Switch to publishing phase
      state = const EntryEditorState.publishing(
        isUploadingImages: false,
        uploadProgress: 0.0,
      );

      MwEntry? result;

      if (editingData.entryId != null) {
        // Update existing entry
        result = await _updateExistingEntry(editingData, isDraft);
      } else {
        // Create new entry
        result = await _createNewEntry(editingData, isDraft);
      }

      if (result != null) {
        _logger.info('Successfully published entry ${result.id}');

        // Delete tracked images for existing entries
        if (editingData.entryId != null) {
          await _deleteTrackedImages();
        }

        state = EntryEditorState.success(entry: result);
      } else {
        throw Exception('Failed to publish entry - no data returned');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to publish entry', e, stackTrace);
      state = EntryEditorState.error(
        message: 'Failed to publish entry: ${e.toString()}',
        canRetry: true,
      );
    }
  }

  /// Upload images for publishing with progress tracking.
  Future<void> _uploadImagesForPublishing(List<AttachedImage> images) async {
    // This is a placeholder for image upload progress tracking
    // In a real implementation, you would track the upload progress of each image
    // and update the state accordingly

    for (int i = 0; i < images.length; i++) {
      // Simulate upload progress
      final progress = (i + 1) / images.length;
      state = EntryEditorState.publishing(
        isUploadingImages: true,
        uploadProgress: progress,
      );

      // Small delay to show progress
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Create a new entry.
  Future<MwEntry?> _createNewEntry(
    ({
      String title,
      String content,
      List<String> tags,
      String privacy,
      bool isCommentable,
      bool isVotable,
      bool inLive,
      bool isShared,
      bool isDraft,
      List<AttachedImage> images,
      int? entryId,
      String? themeName,
      bool isAnonymous,
    })
    editingData,
    bool isDraft,
  ) async {
    if (editingData.themeName != null) {
      // Create theme entry
      final response = await _themesApi.themesNameTlogPost(
        name: editingData.themeName!,
        content: editingData.content,
        privacy: editingData.privacy,
        title: editingData.title,
        images: editingData.images.isNotEmpty
            ? BuiltSet<int>(editingData.images.map((img) => img.id).toList())
            : null,
        tags: editingData.tags.isNotEmpty
            ? BuiltSet<String>(editingData.tags)
            : null,
        isCommentable: editingData.isCommentable,
        isVotable: editingData.isVotable,
        inLive: editingData.inLive,
        isShared: editingData.isShared,
        isDraft: isDraft,
        isAnonymous: editingData.isAnonymous,
      );

      return response.data;
    } else {
      // Create personal entry
      final response = await _meApi.meTlogPost(
        content: editingData.content,
        privacy: editingData.privacy,
        title: editingData.title,
        images: editingData.images.isNotEmpty
            ? BuiltSet<int>(editingData.images.map((img) => img.id).toList())
            : null,
        tags: editingData.tags.isNotEmpty
            ? BuiltSet<String>(editingData.tags)
            : null,
        isCommentable: editingData.isCommentable,
        isVotable: editingData.isVotable,
        inLive: editingData.inLive,
        isShared: editingData.isShared,
        isDraft: isDraft,
      );

      return response.data;
    }
  }

  /// Update an existing entry.
  Future<MwEntry?> _updateExistingEntry(
    ({
      String title,
      String content,
      List<String> tags,
      String privacy,
      bool isCommentable,
      bool isVotable,
      bool inLive,
      bool isShared,
      bool isDraft,
      List<AttachedImage> images,
      int? entryId,
      String? themeName,
      bool isAnonymous,
    })
    editingData,
    bool isDraft,
  ) async {
    if (editingData.entryId == null) return null;

    final response = await _entriesApi.entriesIdPut(
      id: editingData.entryId!,
      content: editingData.content,
      privacy: editingData.privacy,
      title: editingData.title,
      images: editingData.images.isNotEmpty
          ? BuiltSet<int>(editingData.images)
          : null,
      tags: editingData.tags.isNotEmpty
          ? BuiltSet<String>(editingData.tags)
          : null,
      isCommentable: editingData.isCommentable,
      isVotable: editingData.isVotable,
      inLive: editingData.inLive,
      isShared: editingData.isShared,
    );

    return response.data;
  }

  /// Save the current state as a draft.
  Future<void> saveDraft() async {
    await publishEntry(isDraft: true);
  }

  /// Preview the entry by creating a mock entry object from current draft data.
  ///
  /// This method creates a preview state without actually saving the entry to the server.
  /// The preview shows how the entry will look when published.
  Future<void> previewEntry() async {
    final currentState = state;

    // Store the current editing state as backup before creating preview
    _previewBackup = currentState;

    // Get current editing state
    final editingData = currentState.when(
      initial: () => null,
      loading: () => null,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => (
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images,
            entryId: entryId,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => null,
      success: (entry) => null,
      preview: (entry) => null,
      error: (message, canRetry) => null,
    );

    if (editingData == null) return;

    // Validate required fields
    if (editingData.content.trim().isEmpty) {
      state = EntryEditorState.error(
        message: 'Content is required for preview',
        canRetry: false,
      );
      return;
    }

    _logger.info('Creating preview of entry');

    try {
      // Create a mock entry object for preview without saving to server
      final mockEntry = _createMockEntryForPreview(editingData);

      _logger.info('Successfully created preview');
      state = EntryEditorState.preview(entry: mockEntry);
    } catch (e, stackTrace) {
      _logger.severe('Failed to create preview', e, stackTrace);
      state = EntryEditorState.error(
        message: 'Failed to create preview: ${e.toString()}',
        canRetry: true,
      );
    }
  }

  /// Create a mock entry object for preview purposes.
  MwEntry _createMockEntryForPreview(
    ({
      String title,
      String content,
      List<String> tags,
      String privacy,
      bool isCommentable,
      bool isVotable,
      bool inLive,
      bool isShared,
      bool isDraft,
      List<AttachedImage> images,
      int? entryId,
      String? themeName,
      bool isAnonymous,
    })
    editingData,
  ) {
    // Create a mock entry with current draft data
    // Note: This is a simplified mock - in a real implementation you might want to
    // create a more complete mock with proper user data, timestamps, etc.
    return MwEntry(
      (b) => b
        ..id =
            null // No ID since it's not saved yet
        ..title = editingData.title.isEmpty ? null : editingData.title
        ..content = editingData.content
        ..tags = editingData.tags.isNotEmpty
            ? ListBuilder<String>(editingData.tags)
            : null
        ..privacy = _parsePrivacyEnum(editingData.privacy)
        ..isCommentable = editingData.isCommentable
        ..inLive = editingData.inLive
        ..isShared = editingData.isShared
        ..isAnonymous = editingData.isAnonymous
        ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000.0
        ..commentCount = 0
        ..favoriteCount = 0
        ..isFavorited = false
        ..isWatching = false
        ..isPinned = false
        ..hasCut = false
        ..wordCount = editingData.content.split(' ').length,
      // Note: Images would need to be handled separately if they exist
      // For now, we'll leave images as null in the mock
    );
  }

  /// Parse privacy string to enum.
  MwEntryPrivacyEnum? _parsePrivacyEnum(String privacy) {
    switch (privacy) {
      case 'all':
        return MwEntryPrivacyEnum.all;
      case 'registered':
        return MwEntryPrivacyEnum.registered;
      case 'invited':
        return MwEntryPrivacyEnum.invited;
      case 'followers':
        return MwEntryPrivacyEnum.followers;
      case 'some':
        return MwEntryPrivacyEnum.some;
      case 'me':
        return MwEntryPrivacyEnum.me;
      default:
        return MwEntryPrivacyEnum.all;
    }
  }

  /// Reset the editor to initial state.
  void reset() {
    _isInitialized = false;
    if (_entryId != null) {
      _loadExistingEntry();
    } else {
      state = EntryEditorState.editing(themeName: _themeName);
    }
  }

  /// Reset from preview state back to editing state.
  void resetFromPreview() {
    final currentState = state;

    // Check if we're in preview state and have a backup
    final isPreview = currentState.maybeWhen(
      preview: (entry) => true,
      orElse: () => false,
    );

    if (isPreview && _previewBackup != null) {
      // Restore the original editing state from backup
      state = _previewBackup!;
      _previewBackup = null; // Clear the backup
    } else {
      // Fallback to normal reset if not in preview state or no backup
      reset();
    }
  }

  /// Clear any error state and return to editing.
  void clearError() {
    final currentState = state;
    if (currentState.maybeWhen(
      error: (message, canRetry) => true,
      orElse: () => false,
    )) {
      if (_entryId != null) {
        _loadExistingEntry();
      } else {
        state = EntryEditorState.editing(themeName: _themeName);
      }
    }
  }

  /// Retry the last failed operation.
  Future<void> retryLastOperation() async {
    final currentState = state;

    currentState.when(
      initial: () {},
      loading: () {},
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) {},
      publishing: (isUploadingImages, uploadProgress) {},
      success: (entry) {},
      preview: (entry) {},
      error: (message, canRetry) async {
        if (canRetry) {
          // Try to republish the entry
          await publishEntry();
        }
      },
    );
  }

  /// Check if the current state has unsaved changes.
  bool get hasUnsavedChanges {
    return state.maybeWhen(
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => hasUnsavedChanges,
      orElse: () => false,
    );
  }

  /// Get the current entry ID if editing an existing entry.
  int? get entryId => _entryId;

  /// Check if this is editing an existing entry.
  bool get isEditingExisting => _entryId != null;

  /// Update the status of a specific image.
  void updateImageStatus(int imageId, AttachedImage newStatus) {
    state = state.when(
      initial: () => state,
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) => EntryEditorState.editing(
            title: title,
            content: content,
            tags: tags,
            privacy: privacy,
            isCommentable: isCommentable,
            isVotable: isVotable,
            inLive: inLive,
            isShared: isShared,
            isDraft: isDraft,
            images: images
                .map((img) => img.id == imageId ? newStatus : img)
                .toList(),
            entryId: entryId,
            hasUnsavedChanges: hasUnsavedChanges,
            themeName: themeName,
            isAnonymous: isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => state,
      error: (message, canRetry) => state,
    );
  }

  /// Reorder images in the list.
  void reorderImages(int oldIndex, int newIndex) {
    state = state.when(
      initial: () => state,
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) {
            final newImages = List<AttachedImage>.from(images);
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = newImages.removeAt(oldIndex);
            newImages.insert(newIndex, item);

            return EntryEditorState.editing(
              title: title,
              content: content,
              tags: tags,
              privacy: privacy,
              isCommentable: isCommentable,
              isVotable: isVotable,
              inLive: inLive,
              isShared: isShared,
              isDraft: isDraft,
              images: newImages,
              entryId: entryId,
              hasUnsavedChanges: true,
              themeName: themeName,
              isAnonymous: isAnonymous,
            );
          },
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => state,
      error: (message, canRetry) => state,
    );
  }

  /// Start polling for an image's processing status.
  void _startImagePolling(int imageId) {
    _imagePollingService.startPolling(
      imageId: imageId,
      onUpdate: (image) {
        // Update the image status in state
        final newStatus = image.processing == true
            ? AttachedImage.processing(id: imageId, image: image)
            : AttachedImage.ready(id: imageId, image: image);
        updateImageStatus(imageId, newStatus);
      },
      onComplete: (image) {
        // Mark image as ready
        final readyStatus = AttachedImage.ready(id: imageId, image: image);
        updateImageStatus(imageId, readyStatus);
        _logger.info('Image $imageId processing completed');
      },
      onError: (error) {
        // Mark image as failed
        final currentState = state;
        final currentImage = currentState.maybeWhen(
          editing:
              (
                title,
                content,
                tags,
                privacy,
                isCommentable,
                isVotable,
                inLive,
                isShared,
                isDraft,
                images,
                entryId,
                hasUnsavedChanges,
                themeName,
                isAnonymous,
              ) {
                return images.firstWhere(
                  (img) => img.id == imageId,
                  orElse: () => throw StateError('Image not found'),
                );
              },
          orElse: () => throw StateError('Not in editing state'),
        );

        final failedStatus = AttachedImage.failed(
          id: imageId,
          image: currentImage.image,
          errorMessage: error,
        );
        updateImageStatus(imageId, failedStatus);
        _logger.warning('Image $imageId polling failed: $error');
      },
    );
  }

  /// Insert image markdown into content at current cursor position.
  void insertImageMarkdown(int imageId, String imageUrl) {
    state = state.when(
      initial: () => state,
      loading: () => state,
      editing:
          (
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isDraft,
            images,
            entryId,
            hasUnsavedChanges,
            themeName,
            isAnonymous,
          ) {
            // Insert image markdown after current paragraph
            final imageMarkdown = '\n\n![Image]($imageUrl)\n\n';
            final newContent = content + imageMarkdown;

            return EntryEditorState.editing(
              title: title,
              content: newContent,
              tags: tags,
              privacy: privacy,
              isCommentable: isCommentable,
              isVotable: isVotable,
              inLive: inLive,
              isShared: isShared,
              isDraft: isDraft,
              images: images,
              entryId: entryId,
              hasUnsavedChanges: true,
              themeName: themeName,
              isAnonymous: isAnonymous,
            );
          },
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => state,
      error: (message, canRetry) => state,
    );
  }

  /// Delete an image from the server.
  Future<void> _deleteImageFromServer(int imageId) async {
    try {
      _logger.info('Deleting image $imageId from server');
      // Note: The API doesn't seem to have a delete endpoint for images
      // This would need to be implemented in the API
      // For now, we'll just log the deletion
      _logger.info(
        'Image $imageId marked for deletion (API endpoint not available)',
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to delete image $imageId from server',
        e,
        stackTrace,
      );
    }
  }

  /// Delete all tracked images from the server.
  Future<void> _deleteTrackedImages() async {
    if (_deletedImageIds.isEmpty) return;

    _logger.info(
      'Deleting ${_deletedImageIds.length} tracked images from server',
    );

    for (final imageId in _deletedImageIds) {
      await _deleteImageFromServer(imageId);
    }

    _deletedImageIds.clear();
  }

  @override
  void dispose() {
    _imagePollingService.stopAllPolling();
    super.dispose();
  }
}
