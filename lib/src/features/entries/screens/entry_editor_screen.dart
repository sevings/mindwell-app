import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../providers/entry_editor_provider.dart';
import '../models/entry_editor_state.dart';
import '../models/attached_image.dart';
import '../widgets/image_manager.dart';
import '../widgets/tag_manager.dart';
import '../widgets/entry_settings_bottom_sheet.dart';
import '../widgets/markdown_toolbar.dart';
import '../utils/markdown_converter.dart';
import 'entry_detail_screen.dart';

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

  /// Show image in fullscreen
  void _showImageFullscreen(AttachedImage attachedImage) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            // Fullscreen image
            Center(
              child: InteractiveViewer(
                child: CachedImage(
                  imageUrl:
                      attachedImage.fullUrl ??
                      '/api/v1/images/${attachedImage.id}',
                  fit: BoxFit.contain,
                  errorWidget: Container(
                    color: Colors.black,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                style: IconButton.styleFrom(backgroundColor: Colors.black54),
              ),
            ),

            // Image info
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Image ${attachedImage.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      attachedImage.when(
                        processing: (id, image, isUploading, uploadProgress) =>
                            'Processing...',
                        ready: (id, image) => 'Ready',
                        failed: (id, image, errorMessage) =>
                            'Failed: $errorMessage',
                      ),
                      style: TextStyle(
                        color: attachedImage.when(
                          processing:
                              (id, image, isUploading, uploadProgress) =>
                                  Colors.orange,
                          ready: (id, image) => Colors.green,
                          failed: (id, image, errorMessage) => Colors.red,
                        ),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            // Navigate to entry detail screen with the preview entry data
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EntryDetailScreen(entryData: entry, isPreview: true),
                    fullscreenDialog: true,
                  ),
                )
                .then((_) {
                  // Reset the provider state when preview is closed to return to editing mode
                  ref
                      .read(
                        entryEditorProvider((
                          entryId: widget.entryId,
                          themeName: widget.themeName,
                        )).notifier,
                      )
                      .resetFromPreview();
                });
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

  Widget _buildEditingForm(List<String> tags, List<AttachedImage> images) {
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

        // Bottom section with image manager and tag manager
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image manager
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ImageManager(
                    images: images,
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
                    onReorderImages: (oldIndex, newIndex) {
                      ref
                          .read(
                            entryEditorProvider((
                              entryId: widget.entryId,
                              themeName: widget.themeName,
                            )).notifier,
                          )
                          .reorderImages(oldIndex, newIndex);
                    },
                    onOpenImage: (attachedImage) {
                      _showImageFullscreen(attachedImage);
                    },
                    onInsertImage: (attachedImage) {
                      final imageUrl =
                          attachedImage.fullUrl ??
                          '/api/v1/images/${attachedImage.id}';
                      ref
                          .read(
                            entryEditorProvider((
                              entryId: widget.entryId,
                              themeName: widget.themeName,
                            )).notifier,
                          )
                          .insertImageMarkdown(attachedImage.id, imageUrl);
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
            ),
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
