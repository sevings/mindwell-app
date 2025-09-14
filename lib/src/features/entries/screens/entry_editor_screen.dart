import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/entry_editor_provider.dart';
import '../models/entry_editor_state.dart';
import '../widgets/image_manager.dart';
import '../widgets/tag_manager.dart';

/// Screen for creating and editing entries.
/// 
/// This screen provides a rich text editor with a title field and various
/// entry settings. It supports both creating new entries and editing existing ones.
class EntryEditorScreen extends ConsumerStatefulWidget {
  /// The ID of the entry being edited, or null for new entries.
  final int? entryId;

  const EntryEditorScreen({
    super.key,
    this.entryId,
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
    ref.read(entryEditorProvider(widget.entryId).notifier).updateContent(content);
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(entryEditorProvider(widget.entryId));
    
    // Listen to state changes and update controllers
    ref.listen<EntryEditorState>(entryEditorProvider(widget.entryId), (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) {
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
          // Navigate back to entry detail or feed after successful publish
          if (widget.entryId != null) {
            context.go('/entries/${widget.entryId}');
          } else {
            context.go('/entries/${entry.id}');
          }
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
                        ref.read(entryEditorProvider(widget.entryId).notifier).clearError();
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
          // Preview button
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              // TODO: Implement preview functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n?.preview ?? 'Preview'),
                ),
              );
            },
          ),
          // Publish button
          TextButton(
            onPressed: entryState.maybeWhen(
              editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) {
                return title.trim().isNotEmpty && content.trim().isNotEmpty;
              },
              orElse: () => false,
            ) ? () {
              ref.read(entryEditorProvider(widget.entryId).notifier).publishEntry();
            } : null,
            child: Text(
              l10n?.publish ?? 'Publish',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: entryState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => _buildEditingContent(),
        publishing: (isUploadingImages, uploadProgress) => _buildPublishingContent(uploadProgress),
        success: (entry) => const Center(child: CircularProgressIndicator()),
        error: (message, canRetry) => _buildErrorContent(message, canRetry),
      ),
    );
  }

  Widget _buildEditingContent() {
    final entryState = ref.watch(entryEditorProvider(widget.entryId));
    
    return entryState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
      editing: (title, content, tags, privacy, isCommentable, isVotable, inLive, isShared, isDraft, images, entryId, hasUnsavedChanges) => 
        _buildEditingForm(tags, images),
      publishing: (isUploadingImages, uploadProgress) => _buildPublishingContent(uploadProgress),
      success: (entry) => const Center(child: CircularProgressIndicator()),
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
              ref.read(entryEditorProvider(widget.entryId).notifier).updateTitle(value);
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
              ref.read(entryEditorProvider(widget.entryId).notifier).updateTags(currentTags);
            },
            onAddTag: (tag) {
              final currentTags = List<String>.from(tags);
              currentTags.add(tag);
              ref.read(entryEditorProvider(widget.entryId).notifier).updateTags(currentTags);
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
              ref.read(entryEditorProvider(widget.entryId).notifier).removeImage(imageId);
            },
            onAddImages: (files) {
              ref.read(entryEditorProvider(widget.entryId).notifier).uploadImages(files);
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
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            l10n?.publishing ?? 'Publishing...',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (uploadProgress > 0) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(value: uploadProgress),
            const SizedBox(height: 8),
            Text(
              '${(uploadProgress * 100).toInt()}%',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorContent(String message, bool canRetry) {
    final l10n = AppLocalizations.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          if (canRetry)
            ElevatedButton(
              onPressed: () {
                ref.read(entryEditorProvider(widget.entryId).notifier).clearError();
              },
              child: Text(l10n?.retry ?? 'Retry'),
            ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(l10n?.goBack ?? 'Go Back'),
          ),
        ],
      ),
    );
  }
}
