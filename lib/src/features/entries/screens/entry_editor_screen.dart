import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/entry_editor_provider.dart';
import '../models/entry_editor_state.dart';
import '../widgets/image_manager.dart';
import '../widgets/tag_manager.dart';
import '../widgets/entry_settings_bottom_sheet.dart';

/// Screen for creating and editing entries.
/// 
/// This screen provides a rich text editor with a title field and various
/// entry settings. It supports both creating new entries and editing existing ones.
class EntryEditorScreen extends ConsumerStatefulWidget {
  /// The ID of the entry being edited, or null for new entries.
  final int? entryId;

  /// The name of the theme for theme entries, or null for personal entries.
  final String? themeName;

  const EntryEditorScreen({
    super.key,
    this.entryId,
    this.themeName,
  });

  @override
  ConsumerState<EntryEditorScreen> createState() => _EntryEditorScreenState();
}

class _EntryEditorScreenState extends ConsumerState<EntryEditorScreen> {
  late final QuillController _quillController;
  late final TextEditingController _titleController;
  late final FocusNode _titleFocusNode;
  late final FocusNode _contentFocusNode;

  @override
  void initState() {
    super.initState();
    _quillController = QuillController.basic();
    _titleController = TextEditingController();
    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();
    
    // Listen to content changes
    _quillController.addListener(_onContentChanged);
  }

  void _onContentChanged() {
    final content = _quillController.document.toPlainText();
    ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).updateContent(content);
  }

  @override
  void dispose() {
    _quillController.removeListener(_onContentChanged);
    _quillController.dispose();
    _titleController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  /// Preview the entry by saving it as a draft and navigating to preview.
  Future<void> _previewEntry() async {
    try {
      await ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).previewEntry();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create preview: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Publish the entry.
  Future<void> _publishEntry() async {
    try {
      await ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).publishEntry();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to publish entry: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)));
    
    // Listen to state changes and update controllers
    ref.listen<EntryEditorState>(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)), (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges, themeName, isAnonymous) {
          // Update title controller if it's different
          if (_titleController.text != title) {
            _titleController.text = title;
          }
          
          // Update quill controller if content is different
          final currentContent = _quillController.document.toPlainText();
          if (currentContent != content) {
            _quillController.document = Document()..insert(0, content);
          }
        },
        publishing: (isUploadingImages, uploadProgress) {},
        success: (entry) {
          // Show success message and navigate
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n?.entryPublished ?? 'Entry published successfully!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          
          // Navigate back to entry detail or feed after successful publish
          if (widget.entryId != null) {
            // Editing existing entry - go back to the entry
            context.go('/entries/${widget.entryId}');
          } else {
            // New entry - go to the newly created entry
            context.go('/entries/${entry.id}');
          }
        },
        preview: (entry) {
          // Show success message and navigate to preview
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n?.previewCreated ?? 'Preview created successfully!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          
          // Navigate to the entry detail screen to show the preview
          context.go('/entries/${entry.id}?preview=true');
        },
        error: (message, canRetry) {
          // Show error snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              action: canRetry
                  ? SnackBarAction(
                      label: l10n?.retry ?? 'Retry',
                      textColor: Colors.white,
                      onPressed: () {
                        ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).clearError();
                      },
                    )
                  : null,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.entryId != null 
              ? (l10n?.editEntry ?? 'Edit Entry')
              : (l10n?.newEntry ?? 'New Entry'),
        ),
        backgroundColor: const Color(0xFFFF5E3A),
        foregroundColor: Colors.white,
        actions: [
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              showEntrySettingsBottomSheet(
                context: context,
                entryId: widget.entryId,
                isThemeEntry: widget.themeName != null,
              );
            },
            tooltip: l10n?.settings ?? 'Settings',
          ),
          // Preview button
          entryState.maybeWhen(
            editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges, themeName, isAnonymous) {
              return IconButton(
                icon: const Icon(Icons.preview),
                onPressed: title.trim().isNotEmpty && content.trim().isNotEmpty ? () {
                  _previewEntry();
                } : null,
                tooltip: l10n?.preview ?? 'Preview',
              );
            },
            orElse: () => IconButton(
              icon: const Icon(Icons.preview),
              onPressed: null,
              tooltip: l10n?.preview ?? 'Preview',
            ),
          ),
          // Publish button
          entryState.maybeWhen(
            editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges, themeName, isAnonymous) {
              final canPublish = title.trim().isNotEmpty && content.trim().isNotEmpty;
              return TextButton(
                onPressed: canPublish ? () {
                  _publishEntry();
                } : null,
                child: Text(
                  l10n?.publish ?? 'Publish',
                  style: TextStyle(
                    color: canPublish ? Colors.white : Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            publishing: (isUploadingImages, uploadProgress) => TextButton(
              onPressed: null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.publishing ?? 'Publishing...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            orElse: () => TextButton(
              onPressed: null,
              child: Text(
                l10n?.publish ?? 'Publish',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: entryState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges, themeName, isAnonymous) => _buildEditingContent(),
        publishing: (isUploadingImages, uploadProgress) => _buildPublishingContent(uploadProgress),
        success: (entry) => _buildSuccessContent(),
        preview: (entry) => _buildPreviewContent(),
        error: (message, canRetry) => _buildErrorContent(message, canRetry),
      ),
    );
  }

  Widget _buildEditingContent() {
    final entryState = ref.watch(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)));
    
    return entryState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges, themeName, isAnonymous) => 
        _buildEditingForm(tags, images),
      publishing: (isUploadingImages, uploadProgress) => _buildPublishingContent(uploadProgress),
      success: (entry) => const Center(child: CircularProgressIndicator()),
      preview: (entry) => const Center(child: CircularProgressIndicator()),
      error: (message, canRetry) => _buildErrorContent(message, canRetry),
    );
  }

  Widget _buildEditingForm(List<String> tags, List<int> images) {
    final l10n = AppLocalizations.of(context);
    
    return Column(
      children: [
        // Title field
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _titleController,
            focusNode: _titleFocusNode,
            decoration: InputDecoration(
              hintText: l10n?.entryTitle ?? 'Entry title',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
            onChanged: (value) {
              ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).updateTitle(value);
            },
          ),
        ),
        
        // Tag manager
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TagManager(
            tags: tags,
            onRemoveTag: (tag) {
              final currentTags = List<String>.from(tags);
              currentTags.remove(tag);
              ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).updateTags(currentTags);
            },
            onAddTag: (tag) {
              final currentTags = List<String>.from(tags);
              currentTags.add(tag);
              ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).updateTags(currentTags);
            },
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Image manager
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ImageManager(
            imageIds: images,
            onRemoveImage: (imageId) {
              ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).removeImage(imageId);
            },
            onAddImages: (files) {
              ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).uploadImages(files);
            },
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Rich text editor
        Expanded(
          child: Column(
            children: [
              // Quill toolbar
              QuillSimpleToolbar(
                controller: _quillController,
              ),
              
              // Quill editor
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: QuillEditor.basic(
                    controller: _quillController,
                    focusNode: _contentFocusNode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPublishingContent(double uploadProgress) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)));
    
    return entryState.maybeWhen(
      publishing: (isUploadingImages, progress) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              isUploadingImages 
                  ? (l10n?.uploadingImages ?? 'Uploading images...')
                  : (l10n?.publishing ?? 'Publishing...'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (progress > 0) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              l10n?.pleaseWait ?? 'Please wait...',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildSuccessContent() {
    final l10n = AppLocalizations.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 64,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.entryPublished ?? 'Entry Published!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.redirecting ?? 'Redirecting...',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewContent() {
    final l10n = AppLocalizations.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.visibility,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.previewCreated ?? 'Preview Created!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.redirectingToPreview ?? 'Redirecting to preview...',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorContent(String message, bool canRetry) {
    final l10n = AppLocalizations.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.error ?? 'Error',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (canRetry) ...[
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(entryEditorProvider((entryId: widget.entryId, themeName: widget.themeName)).notifier).retryLastOperation();
                },
                icon: const Icon(Icons.refresh),
                label: Text(l10n?.retry ?? 'Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5E3A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: Text(l10n?.goBack ?? 'Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
