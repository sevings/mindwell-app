import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/services/image_upload_service.dart';
import '../models/entry_editor_state.dart';

/// Provider for the EntryEditorNotifier that manages the state of entry editing.
/// 
/// Takes an optional [entryId] as a parameter to create separate providers for each entry.
/// If [entryId] is null, it's for creating a new entry.
final entryEditorProvider = StateNotifierProvider.family<EntryEditorNotifier, EntryEditorState, int?>(
  (ref, entryId) {
    final entriesApi = ref.read(entriesApiProvider);
    final meApi = ref.read(meApiProvider);
    final imageUploadService = ref.read(imageUploadServiceProvider);
    
    return EntryEditorNotifier(
      entryId: entryId,
      entriesApi: entriesApi,
      meApi: meApi,
      imageUploadService: imageUploadService,
    );
  },
);

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
  final EntriesApi _entriesApi;
  final MeApi _meApi;
  final ImageUploadService _imageUploadService;
  final Logger _logger = Logger('EntryEditorNotifier');
  
  bool _isInitialized = false;

  EntryEditorNotifier({
    required int? entryId,
    required EntriesApi entriesApi,
    required MeApi meApi,
    required ImageUploadService imageUploadService,
  })  : _entryId = entryId,
        _entriesApi = entriesApi,
        _meApi = meApi,
        _imageUploadService = imageUploadService,
        super(const EntryEditorState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by loading existing entry data if editing.
  Future<void> _initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    if (_entryId != null) {
      await _loadExistingEntry();
    } else {
      // Start with empty editing state for new entry
      state = const EntryEditorState.editing();
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
        images: entry.images?.map((img) => img.id ?? 0).where((id) => id > 0).toList() ?? [],
        entryId: _entryId,
        hasUnsavedChanges: false,
      );
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to load entry $_entryId for editing', e, stackTrace);
      state = EntryEditorState.error(
        message: 'Failed to load entry: ${e.toString()}',
        canRetry: true,
      );
    }
  }

  /// Update the entry title.
  void updateTitle(String title) {
    state = state.when(
      initial: () => EntryEditorState.editing(title: title, hasUnsavedChanges: true),
      loading: () => state,
      editing: (oldTitle, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(title: title, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the entry content.
  void updateContent(String content) {
    state = state.when(
      initial: () => EntryEditorState.editing(content: content, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, oldContent, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(content: content, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the entry tags.
  void updateTags(List<String> tags) {
    state = state.when(
      initial: () => EntryEditorState.editing(tags: tags, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, oldTags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(tags: tags, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the privacy setting.
  void updatePrivacy(String privacy) {
    state = state.when(
      initial: () => EntryEditorState.editing(privacy: privacy, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, oldPrivacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(privacy: privacy, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the commentable setting.
  void updateIsCommentable(bool isCommentable) {
    state = state.when(
      initial: () => EntryEditorState.editing(isCommentable: isCommentable, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, oldIsCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(isCommentable: isCommentable, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the votable setting.
  void updateIsVotable(bool isVotable) {
    state = state.when(
      initial: () => EntryEditorState.editing(isVotable: isVotable, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, oldIsVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(isVotable: isVotable, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the live feed setting.
  void updateInLive(bool inLive) {
    state = state.when(
      initial: () => EntryEditorState.editing(inLive: inLive, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, oldInLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(inLive: inLive, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the shared setting.
  void updateIsShared(bool isShared) {
    state = state.when(
      initial: () => EntryEditorState.editing(isShared: isShared, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, oldIsShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(isShared: isShared, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the draft setting.
  void updateIsDraft(bool isDraft) {
    state = state.when(
      initial: () => EntryEditorState.editing(isDraft: isDraft, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, oldIsDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(isDraft: isDraft, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Add an image to the entry.
  void addImage(int imageId) {
    state = state.when(
      initial: () => EntryEditorState.editing(images: [imageId], hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
          title: title,
          content: content,
          tags: tags,
          privacy: privacy,
          isCommentable: isCommentable,
          isVotable: isVotable,
          inLive: inLive,
          isShared: isShared,
          isDraft: isDraft,
          images: [...images, imageId],
          entryId: entryId,
          hasUnsavedChanges: true,
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(images: [imageId], hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Remove an image from the entry.
  void removeImage(int imageId) {
    state = state.when(
      initial: () => state,
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
          title: title,
          content: content,
          tags: tags,
          privacy: privacy,
          isCommentable: isCommentable,
          isVotable: isVotable,
          inLive: inLive,
          isShared: isShared,
          isDraft: isDraft,
          images: images.where((id) => id != imageId).toList(),
          entryId: entryId,
          hasUnsavedChanges: true,
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Update the list of images.
  void updateImages(List<int> images) {
    state = state.when(
      initial: () => EntryEditorState.editing(images: images, hasUnsavedChanges: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, oldImages, entryId, hasUnsavedChanges) => 
        EntryEditorState.editing(
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
        ),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => EntryEditorState.editing(images: images, hasUnsavedChanges: true),
      error: (message, canRetry) => state,
    );
  }

  /// Upload images and add them to the entry.
  Future<void> uploadImages(List<File> files) async {
    if (files.isEmpty) return;
    
    _logger.info('Starting upload of ${files.length} images');
    
    // Update state to show uploading
    state = state.when(
      initial: () => const EntryEditorState.publishing(isUploadingImages: true),
      loading: () => state,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        const EntryEditorState.publishing(isUploadingImages: true),
      publishing: (isUploadingImages, uploadProgress) => state,
      success: (entry) => state,
      preview: (entry) => const EntryEditorState.publishing(isUploadingImages: true),
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
      
      // Filter out failed uploads (null values)
      final successfulUploads = uploadedImages
          .where((image) => image != null)
          .map((image) => image!.id!)
          .toList();
      
      if (successfulUploads.isNotEmpty) {
        // Add uploaded images to current images
        final currentState = state;
        final currentImages = currentState.maybeWhen(
          editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => images,
          orElse: () => <int>[],
        );
        
        updateImages([...currentImages, ...successfulUploads]);
        _logger.info('Successfully uploaded ${successfulUploads.length} images');
      }
      
      // Return to editing state
      final currentState = state;
      final editingData = currentState.maybeWhen(
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
          (title: title, content: content, tags: tags, privacy: privacy, isCommentable: isCommentable, isVotable: isVotable, inLive: inLive, isShared: isShared, isDraft: isDraft, images: images, entryId: entryId, hasUnsavedChanges: hasUnsavedChanges),
        orElse: () => null,
      );
      
      if (editingData != null) {
        state = EntryEditorState.editing(
          title: editingData.title,
          content: editingData.content,
          tags: editingData.tags,
          privacy: editingData.privacy,
          isCommentable: editingData.isCommentable,
          isVotable: editingData.isVotable,
          inLive: editingData.inLive,
          isShared: editingData.isShared,
          isDraft: editingData.isDraft,
          images: editingData.images,
          entryId: editingData.entryId,
          hasUnsavedChanges: editingData.hasUnsavedChanges,
        );
      } else {
        state = const EntryEditorState.editing();
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
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        (title: title, content: content, tags: tags, privacy: privacy, isCommentable: isCommentable, isVotable: isVotable, inLive: inLive, isShared: isShared, isDraft: isDraft, images: images, entryId: entryId),
      publishing: (isUploadingImages, uploadProgress) => null,
      success: (entry) => null,
      preview: (entry) => null,
      error: (message, canRetry) => null,
    );
    
    if (editingData == null) return;
    
    // Validate required fields
    if (editingData.title.trim().isEmpty) {
      state = EntryEditorState.error(
        message: 'Title is required',
        canRetry: false,
      );
      return;
    }
    
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
        state = const EntryEditorState.publishing(isUploadingImages: true, uploadProgress: 0.0);
        
        // Upload images first
        await _uploadImagesForPublishing(editingData.images);
      }
      
      // Switch to publishing phase
      state = const EntryEditorState.publishing(isUploadingImages: false, uploadProgress: 0.0);
      
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
  Future<void> _uploadImagesForPublishing(List<int> imageIds) async {
    // This is a placeholder for image upload progress tracking
    // In a real implementation, you would track the upload progress of each image
    // and update the state accordingly
    
    for (int i = 0; i < imageIds.length; i++) {
      // Simulate upload progress
      final progress = (i + 1) / imageIds.length;
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
    ({String title, String content, List<String> tags, String privacy, bool isCommentable, bool isVotable, bool inLive, bool isShared, bool isDraft, List<int> images, int? entryId}) editingData, 
    bool isDraft
  ) async {
    final response = await _meApi.meTlogPost(
      content: editingData.content,
      privacy: editingData.privacy,
      title: editingData.title,
      images: editingData.images.isNotEmpty ? BuiltSet<int>(editingData.images) : null,
      tags: editingData.tags.isNotEmpty ? BuiltSet<String>(editingData.tags) : null,
      isCommentable: editingData.isCommentable,
      isVotable: editingData.isVotable,
      inLive: editingData.inLive,
      isShared: editingData.isShared,
      isDraft: isDraft,
    );
    
    return response.data;
  }

  /// Update an existing entry.
  Future<MwEntry?> _updateExistingEntry(
    ({String title, String content, List<String> tags, String privacy, bool isCommentable, bool isVotable, bool inLive, bool isShared, bool isDraft, List<int> images, int? entryId}) editingData, 
    bool isDraft
  ) async {
    if (editingData.entryId == null) return null;
    
    final response = await _entriesApi.entriesIdPut(
      id: editingData.entryId!,
      content: editingData.content,
      privacy: editingData.privacy,
      title: editingData.title,
      images: editingData.images.isNotEmpty ? BuiltSet<int>(editingData.images) : null,
      tags: editingData.tags.isNotEmpty ? BuiltSet<String>(editingData.tags) : null,
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

  /// Preview the entry by saving it as a draft.
  /// 
  /// This method saves the current entry as a draft and returns the created entry
  /// for preview purposes. The entry can then be viewed in the entry detail screen.
  Future<void> previewEntry() async {
    final currentState = state;
    
    // Get current editing state
    final editingData = currentState.when(
      initial: () => null,
      loading: () => null,
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        (title: title, content: content, tags: tags, privacy: privacy, isCommentable: isCommentable, isVotable: isVotable, inLive: inLive, isShared: isShared, isDraft: isDraft, images: images, entryId: entryId),
      publishing: (isUploadingImages, uploadProgress) => null,
      success: (entry) => null,
      preview: (entry) => null,
      error: (message, canRetry) => null,
    );
    
    if (editingData == null) return;
    
    // Validate required fields
    if (editingData.title.trim().isEmpty) {
      state = EntryEditorState.error(
        message: 'Title is required for preview',
        canRetry: false,
      );
      return;
    }
    
    if (editingData.content.trim().isEmpty) {
      state = EntryEditorState.error(
        message: 'Content is required for preview',
        canRetry: false,
      );
      return;
    }
    
    _logger.info('Creating preview of entry');
    
    try {
      // Check if there are any new images that need to be uploaded
      final hasNewImages = editingData.images.isNotEmpty;
      
      if (hasNewImages) {
        // Start with image upload phase
        state = const EntryEditorState.publishing(isUploadingImages: true, uploadProgress: 0.0);
        
        // Upload images first
        await _uploadImagesForPublishing(editingData.images);
      }
      
      // Switch to publishing phase
      state = const EntryEditorState.publishing(isUploadingImages: false, uploadProgress: 0.0);
      
      MwEntry? result;
      
      if (editingData.entryId != null) {
        // Update existing entry as draft for preview
        result = await _updateExistingEntry(editingData, true);
      } else {
        // Create new entry as draft for preview
        result = await _createNewEntry(editingData, true);
      }
      
      if (result != null) {
        _logger.info('Successfully created preview for entry ${result.id}');
        state = EntryEditorState.preview(entry: result);
      } else {
        throw Exception('Failed to create preview - no data returned');
      }
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to create preview', e, stackTrace);
      state = EntryEditorState.error(
        message: 'Failed to create preview: ${e.toString()}',
        canRetry: true,
      );
    }
  }

  /// Reset the editor to initial state.
  void reset() {
    if (_entryId != null) {
      _loadExistingEntry();
    } else {
      state = const EntryEditorState.editing();
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
        state = const EntryEditorState.editing();
      }
    }
  }

  /// Retry the last failed operation.
  Future<void> retryLastOperation() async {
    final currentState = state;
    
    currentState.when(
      initial: () {},
      loading: () {},
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) {},
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
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => hasUnsavedChanges,
      orElse: () => false,
    );
  }

  /// Get the current entry ID if editing an existing entry.
  int? get entryId => _entryId;

  /// Check if this is editing an existing entry.
  bool get isEditingExisting => _entryId != null;
}
