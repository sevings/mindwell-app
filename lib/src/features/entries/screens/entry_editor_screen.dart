import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../providers/entry_editor_provider.dart';
import '../models/entry_editor_state.dart';
import '../widgets/image_manager.dart';
import '../widgets/tag_manager.dart';
import '../widgets/entry_settings_bottom_sheet.dart';
import '../widgets/markdown_toolbar.dart';
import '../utils/markdown_converter.dart';

/// Screen for creating and editing entries.
///
/// This screen provides a rich text editor with a title field and various
/// entry settings. It supports both creating new entries and editing existing ones.
class EntryEditorScreen extends ConsumerStatefulWidget {
  /// The ID of the entry being edited, or null for new entries.
  final int? entryId;

  /// The name of the theme for theme entries, or null for personal entries.
  final String? themeName;

  const EntryEditorScreen({super.key, this.entryId, this.themeName});

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

    // Reset provider if it's in success or preview state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = ref.read(
        entryEditorProvider((
          entryId: widget.entryId,
          themeName: widget.themeName,
        )),
      );
      if (currentState.maybeWhen(
        success: (entry) => true,
        preview: (entry) => true,
        orElse: () => false,
      )) {
        ref
            .read(
              entryEditorProvider((
                entryId: widget.entryId,
                themeName: widget.themeName,
              )).notifier,
            )
            .reset();
      }
    });
  }

  void _onContentChanged() {
    // Convert Quill document to markdown format
    final markdownContent = MarkdownConverter.documentToMarkdown(
      _quillController.document,
    );
    ref
        .read(
          entryEditorProvider((
            entryId: widget.entryId,
            themeName: widget.themeName,
          )).notifier,
        )
        .updateContent(markdownContent);
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
      await ref
          .read(
            entryEditorProvider((
              entryId: widget.entryId,
              themeName: widget.themeName,
            )).notifier,
          )
          .previewEntry();
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
      await ref
          .read(
            entryEditorProvider((
              entryId: widget.entryId,
              themeName: widget.themeName,
            )).notifier,
          )
          .publishEntry();
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

  /// Show inline preview of the draft entry.
  void _showInlinePreview() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _DraftPreviewDialog(
        entryId: widget.entryId,
        themeName: widget.themeName,
      ),
    ).then((_) {
      // Reset the provider state when dialog is closed to return to editing mode
      ref
          .read(
            entryEditorProvider((
              entryId: widget.entryId,
              themeName: widget.themeName,
            )).notifier,
          )
          .resetFromPreview();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final entryState = ref.watch(
      entryEditorProvider((
        entryId: widget.entryId,
        themeName: widget.themeName,
      )),
    );

    // Listen to state changes and update controllers
    ref.listen<EntryEditorState>(
      entryEditorProvider((
        entryId: widget.entryId,
        themeName: widget.themeName,
      )),
      (previous, next) {
        next.when(
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
              ) {
                // Update title controller if it's different
                if (_titleController.text != title) {
                  _titleController.text = title;
                }

                // Update quill controller if content is different
                final currentContent = MarkdownConverter.documentToMarkdown(
                  _quillController.document,
                );
                if (currentContent != content) {
                  // Convert markdown content back to Quill document
                  _quillController.document =
                      MarkdownConverter.markdownToDocument(content);
                }
              },
          publishing: (isUploadingImages, uploadProgress) {},
          success: (entry) {
            // Show success message and navigate
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l10n?.entryPublished ?? 'Entry published successfully!',
                ),
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
              if (entry.id != null) {
                context.go('/entries/${entry.id}');
              } else {
                // If entry ID is null, go back to feed
                context.go('/feed/live');
              }
            }
          },
          preview: (entry) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l10n?.previewCreated ?? 'Preview created successfully!',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );

            // Show inline preview instead of navigating
            _showInlinePreview();
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
                          ref
                              .read(
                                entryEditorProvider((
                                  entryId: widget.entryId,
                                  themeName: widget.themeName,
                                )).notifier,
                              )
                              .clearError();
                        },
                      )
                    : null,
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          widget.entryId != null
              ? (l10n?.editEntry ?? 'Edit Entry')
              : (l10n?.newEntry ?? 'New Entry'),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Find the Scaffold that has a drawer (could be an ancestor)
            final scaffoldWithDrawer = context
                .findAncestorStateOfType<ScaffoldState>();
            if (scaffoldWithDrawer != null) {
              scaffoldWithDrawer.openDrawer();
            }
          },
          tooltip: l10n?.settings ?? 'Menu',
        ),
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
                  return IconButton(
                    icon: const Icon(Icons.preview),
                    onPressed: content.trim().isNotEmpty
                        ? () {
                            _previewEntry();
                          }
                        : null,
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
                  final canPublish = content.trim().isNotEmpty;
                  return TextButton(
                    onPressed: canPublish
                        ? () {
                            _publishEntry();
                          }
                        : null,
                    child: Text(
                      l10n?.publish ?? 'Publish',
                      style: TextStyle(
                        color: canPublish
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withValues(alpha: 0.6),
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
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.publishing ?? 'Publishing...',
                    style: TextStyle(
                      color: colorScheme.onSurface,
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
                style: TextStyle(
                  color: colorScheme.onSurface,
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
            ) => _buildEditingContent(),
        publishing: (isUploadingImages, uploadProgress) =>
            _buildPublishingContent(uploadProgress),
        success: (entry) => _buildSuccessContent(),
        preview: (entry) => _buildPreviewContent(),
        error: (message, canRetry) => _buildErrorContent(message, canRetry),
      ),
    );
  }

  Widget _buildEditingContent() {
    final entryState = ref.watch(
      entryEditorProvider((
        entryId: widget.entryId,
        themeName: widget.themeName,
      )),
    );

    return entryState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
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
          ) => _buildEditingForm(tags, images),
      publishing: (isUploadingImages, uploadProgress) =>
          _buildPublishingContent(uploadProgress),
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
              ref
                  .read(
                    entryEditorProvider((
                      entryId: widget.entryId,
                      themeName: widget.themeName,
                    )).notifier,
                  )
                  .updateTitle(value);
            },
          ),
        ),

        // Rich text editor
        Expanded(
          child: Column(
            children: [
              // Markdown toolbar
              MarkdownToolbar(controller: _quillController),

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

        // Image manager
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ImageManager(
            imageIds: images,
            onRemoveImage: (imageId) {
              ref
                  .read(
                    entryEditorProvider((
                      entryId: widget.entryId,
                      themeName: widget.themeName,
                    )).notifier,
                  )
                  .removeImage(imageId);
            },
            onAddImages: (files) {
              ref
                  .read(
                    entryEditorProvider((
                      entryId: widget.entryId,
                      themeName: widget.themeName,
                    )).notifier,
                  )
                  .uploadImages(files);
            },
          ),
        ),

        const SizedBox(height: 16),

        // Tag manager
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TagManager(
            tags: tags,
            onRemoveTag: (tag) {
              final currentTags = List<String>.from(tags);
              currentTags.remove(tag);
              ref
                  .read(
                    entryEditorProvider((
                      entryId: widget.entryId,
                      themeName: widget.themeName,
                    )).notifier,
                  )
                  .updateTags(currentTags);
            },
            onAddTag: (tag) {
              final currentTags = List<String>.from(tags);
              currentTags.add(tag);
              ref
                  .read(
                    entryEditorProvider((
                      entryId: widget.entryId,
                      themeName: widget.themeName,
                    )).notifier,
                  )
                  .updateTags(currentTags);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPublishingContent(double uploadProgress) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(
      entryEditorProvider((
        entryId: widget.entryId,
        themeName: widget.themeName,
      )),
    );

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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              style: const TextStyle(fontSize: 14, color: Colors.grey),
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
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
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
              style: const TextStyle(fontSize: 16, color: Colors.grey),
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
            const Icon(Icons.visibility, size: 64, color: Colors.blue),
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
              style: const TextStyle(fontSize: 16, color: Colors.grey),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              l10n?.error ?? 'Error',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (canRetry) ...[
              ElevatedButton.icon(
                onPressed: () {
                  ref
                      .read(
                        entryEditorProvider((
                          entryId: widget.entryId,
                          themeName: widget.themeName,
                        )).notifier,
                      )
                      .retryLastOperation();
                },
                icon: const Icon(Icons.refresh),
                label: Text(l10n?.retry ?? 'Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
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

/// Dialog that shows a preview of the draft entry.
class _DraftPreviewDialog extends ConsumerWidget {
  final int? entryId;
  final String? themeName;

  const _DraftPreviewDialog({required this.entryId, required this.themeName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(
      entryEditorProvider((entryId: entryId, themeName: themeName)),
    );

    return entryState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
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
          ) => _buildPreviewContent(
            context,
            l10n,
            title,
            content,
            tags,
            privacy,
            isCommentable,
            isVotable,
            inLive,
            isShared,
            isAnonymous,
          ),
      publishing: (isUploadingImages, uploadProgress) =>
          const Center(child: CircularProgressIndicator()),
      success: (entry) => const Center(child: CircularProgressIndicator()),
      preview: (entry) => _buildPreviewFromEntry(context, l10n, entry),
      error: (message, canRetry) => _buildErrorContent(context, l10n, message),
    );
  }

  Widget _buildPreviewContent(
    BuildContext context,
    AppLocalizations? l10n,
    String title,
    String content,
    List<String> tags,
    String privacy,
    bool isCommentable,
    bool isVotable,
    bool inLive,
    bool isShared,
    bool isAnonymous,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        child: SizedBox(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.visibility,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n?.preview ?? 'Preview',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: colorScheme.onSurface),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      if (title.isNotEmpty) ...[
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Author info with draft indicator
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.person, color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isAnonymous
                                      ? (l10n?.anonymous ?? 'Anonymous')
                                      : 'You',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    l10n?.thisIsDraft ?? 'This is a draft',
                                    style: TextStyle(
                                      color: Colors.orange.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Content
                      if (content.isNotEmpty) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            content,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Tags
                      if (tags.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: tags
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    '#$tag',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Settings info
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.entrySettings ?? 'Entry Settings',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildSettingRow(
                              l10n?.privacy ?? 'Privacy',
                              _getPrivacyText(privacy, l10n),
                            ),
                            _buildSettingRow(
                              l10n?.comments ?? 'Comments',
                              isCommentable
                                  ? (l10n?.enabled ?? 'Enabled')
                                  : (l10n?.disabled ?? 'Disabled'),
                            ),
                            _buildSettingRow(
                              l10n?.liveFeed ?? 'Live Feed',
                              inLive
                                  ? (l10n?.enabled ?? 'Enabled')
                                  : (l10n?.disabled ?? 'Disabled'),
                            ),
                            _buildSettingRow(
                              l10n?.sharing ?? 'Sharing',
                              isShared
                                  ? (l10n?.enabled ?? 'Enabled')
                                  : (l10n?.disabled ?? 'Disabled'),
                            ),
                            if (isAnonymous)
                              _buildSettingRow(
                                l10n?.anonymous ?? 'Anonymous',
                                l10n?.enabled ?? 'Enabled',
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Comments section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.orange.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l10n?.comments ?? 'Comments',
                                  style: TextStyle(
                                    color: Colors.orange.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n?.entryNotPublishedYet ??
                                  'This entry is not published yet',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewFromEntry(
    BuildContext context,
    AppLocalizations? l10n,
    MwEntry entry,
  ) {
    return _buildPreviewContent(
      context,
      l10n,
      entry.title ?? '',
      entry.content ?? '',
      entry.tags?.toList() ?? [],
      entry.privacy?.name ?? 'all',
      entry.isCommentable ?? true,
      true, // Voting is always enabled in the API
      entry.inLive ?? true,
      entry.isShared ?? false,
      entry.isAnonymous ?? false,
    );
  }

  Widget _buildErrorContent(
    BuildContext context,
    AppLocalizations? l10n,
    String message,
  ) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.error ?? 'Error',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n?.close ?? 'Close'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _getPrivacyText(String privacy, AppLocalizations? l10n) {
    switch (privacy) {
      case 'all':
        return l10n?.privacyAll ?? 'All';
      case 'registered':
        return l10n?.privacyRegistered ?? 'Registered';
      case 'invited':
        return l10n?.privacyInvited ?? 'Invited';
      case 'followers':
        return l10n?.privacyFollowers ?? 'Followers';
      case 'some':
        return l10n?.privacySome ?? 'Some';
      case 'me':
        return l10n?.privacyMe ?? 'Me';
      default:
        return l10n?.privacyAll ?? 'All';
    }
  }
}
