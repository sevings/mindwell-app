import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:mindwell/src/features/entries/models/entry_editor_state.dart';

/// Service for automatically saving and loading entry drafts.
/// 
/// Uses Hive to store a single entry draft locally. This provides
/// automatic saving functionality for the entry editor to prevent
/// data loss when users navigate away or the app is closed.
class DraftStorageService {
  static const String _boxName = 'entry_drafts';
  static const String _draftKey = 'current_draft';
  
  late Box<String> _box;
  final Logger _logger = Logger('DraftStorageService');

  /// Creates a DraftStorageService with an optional box for testing.
  /// 
  /// [box] Optional box instance for testing. If not provided, will be
  /// initialized when [initialize] is called.
  DraftStorageService({Box<String>? box}) {
    if (box != null) {
      _box = box;
    }
  }

  /// Initialize the draft storage service by opening the Hive box.
  Future<void> initialize() async {
    try {
      if (!_box.isOpen) {
        _box = await Hive.openBox<String>(_boxName);
      }
      _logger.info('Draft storage service initialized');
    } catch (e) {
      _logger.severe('Failed to initialize draft storage service: $e');
      rethrow;
    }
  }

  /// Save an entry draft to local storage.
  /// 
  /// [draft] The entry editor state containing the draft data
  /// 
  /// Only saves if the state is in editing mode and has unsaved changes.
  /// The draft is automatically serialized to JSON for storage.
  Future<void> saveDraft(EntryEditorState draft) async {
    try {
      // Only save if we're in editing state and have unsaved changes
      draft.when(
        initial: () {
          _logger.fine('Skipping draft save - initial state');
        },
        loading: () {
          _logger.fine('Skipping draft save - loading state');
        },
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) {
          if (!hasUnsavedChanges) {
            _logger.fine('Skipping draft save - no unsaved changes');
            return;
          }

          final draftData = _serializeDraft(
            title, content, tags, privacy, isCommentable, isVotable, 
            inLive, isShared, isDraft, images, entryId, hasUnsavedChanges
          );
          if (draftData == null) {
            _logger.warning('Failed to serialize draft data');
            return;
          }

          _box.put(_draftKey, draftData).then((_) {
            _logger.fine('Draft saved successfully');
          }).catchError((e) {
            _logger.warning('Failed to save draft: $e');
          });
        },
        publishing: (isUploadingImages, uploadProgress) {
          _logger.fine('Skipping draft save - publishing state');
        },
        success: (entry) {
          _logger.fine('Skipping draft save - success state');
        },
        preview: (entry) {
          _logger.fine('Skipping draft save - preview state');
        },
        error: (message, canRetry) {
          _logger.fine('Skipping draft save - error state');
        },
      );
    } catch (e) {
      _logger.warning('Failed to save draft: $e');
      // Don't rethrow - draft saving failures shouldn't break the app
    }
  }

  /// Load the saved entry draft from local storage.
  /// 
  /// Returns the draft data as an EntryEditorState if found,
  /// null if no draft exists or if there was an error loading it.
  Future<EntryEditorState?> loadDraft() async {
    try {
      final draftData = _box.get(_draftKey);
      if (draftData == null) {
        _logger.fine('No draft found in storage');
        return null;
      }

      final draft = _deserializeDraft(draftData);
      if (draft == null) {
        _logger.warning('Failed to deserialize draft data, clearing corrupted draft');
        await clearDraft();
        return null;
      }

      _logger.fine('Draft loaded successfully');
      return draft;
    } catch (e) {
      _logger.warning('Failed to load draft: $e');
      return null;
    }
  }

  /// Check if a draft exists in local storage.
  /// 
  /// Returns true if a draft is stored, false otherwise.
  Future<bool> hasDraft() async {
    try {
      return _box.containsKey(_draftKey);
    } catch (e) {
      _logger.warning('Failed to check if draft exists: $e');
      return false;
    }
  }

  /// Clear the saved draft from local storage.
  /// 
  /// This is typically called when:
  /// - The entry is successfully published
  /// - The user explicitly discards the draft
  /// - The draft data is corrupted
  Future<void> clearDraft() async {
    try {
      await _box.delete(_draftKey);
      _logger.fine('Draft cleared successfully');
    } catch (e) {
      _logger.warning('Failed to clear draft: $e');
    }
  }

  /// Get draft metadata for debugging purposes.
  /// 
  /// Returns information about the stored draft including
  /// creation time, size, and basic content info.
  Future<Map<String, dynamic>?> getDraftMetadata() async {
    try {
      final draftData = _box.get(_draftKey);
      if (draftData == null) {
        return null;
      }

      final draft = _deserializeDraft(draftData);
      if (draft == null) {
        return null;
      }

      return draft.when(
        initial: () => null,
        loading: () => null,
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) {
          return {
            'hasTitle': title.isNotEmpty,
            'hasContent': content.isNotEmpty,
            'tagsCount': tags.length,
            'imagesCount': images.length,
            'isDraft': isDraft,
            'hasUnsavedChanges': hasUnsavedChanges,
            'dataSize': draftData.length,
            'createdAt': DateTime.now().toIso8601String(), // We don't store creation time, so use current time
          };
        },
        publishing: (isUploadingImages, uploadProgress) => null,
        success: (entry) => null,
        preview: (entry) => null,
        error: (message, canRetry) => null,
      );
    } catch (e) {
      _logger.warning('Failed to get draft metadata: $e');
      return null;
    }
  }

  /// Close the draft storage service and release resources.
  Future<void> close() async {
    try {
      await _box.close();
      _logger.info('Draft storage service closed');
    } catch (e) {
      _logger.warning('Failed to close draft storage service: $e');
    }
  }

  /// Serialize a draft to JSON string for storage.
  /// 
  /// Returns the JSON string representation or null if serialization fails.
  String? _serializeDraft(
    String title,
    String content,
    List<String> tags,
    String privacy,
    bool isCommentable,
    bool isVotable,
    bool inLive,
    bool isShared,
    bool isDraft,
    List<int> images,
    int? entryId,
    bool hasUnsavedChanges,
  ) {
    try {
      final draftMap = {
        'title': title,
        'content': content,
        'tags': tags,
        'privacy': privacy,
        'isCommentable': isCommentable,
        'isVotable': isVotable,
        'inLive': inLive,
        'isShared': isShared,
        'isDraft': isDraft,
        'images': images,
        'entryId': entryId,
        'hasUnsavedChanges': hasUnsavedChanges,
        'savedAt': DateTime.now().millisecondsSinceEpoch,
      };

      return jsonEncode(draftMap);
    } catch (e) {
      _logger.warning('Failed to serialize draft: $e');
      return null;
    }
  }

  /// Deserialize a draft from JSON string.
  /// 
  /// [draftJson] The JSON string to deserialize
  /// 
  /// Returns the EntryEditorState or null if deserialization fails.
  EntryEditorState? _deserializeDraft(String draftJson) {
    try {
      final draftMap = jsonDecode(draftJson) as Map<String, dynamic>;
      
      return EntryEditorState.editing(
        title: draftMap['title'] as String? ?? '',
        content: draftMap['content'] as String? ?? '',
        tags: (draftMap['tags'] as List<dynamic>?)?.cast<String>() ?? [],
        privacy: draftMap['privacy'] as String? ?? 'all',
        isCommentable: draftMap['isCommentable'] as bool? ?? true,
        isVotable: draftMap['isVotable'] as bool? ?? true,
        inLive: draftMap['inLive'] as bool? ?? true,
        isShared: draftMap['isShared'] as bool? ?? false,
        isDraft: draftMap['isDraft'] as bool? ?? false,
        images: (draftMap['images'] as List<dynamic>?)?.cast<int>() ?? [],
        entryId: draftMap['entryId'] as int?,
        hasUnsavedChanges: draftMap['hasUnsavedChanges'] as bool? ?? false,
      );
    } catch (e) {
      _logger.warning('Failed to deserialize draft: $e');
      return null;
    }
  }
}
