import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/api/api_provider.dart';
import 'comment_complain_dialog.dart';

/// A context menu widget for comments that provides various actions based on user permissions.
///
/// This widget displays a popup menu with different options depending on the user's rights
/// for the specific comment. Actions include edit, delete, and complain.
class CommentContextMenu extends ConsumerStatefulWidget {
  /// The comment to show context menu for
  final MwComment comment;

  /// Callback when edit action is triggered
  final VoidCallback? onEdit;

  /// Callback when delete action is triggered (optional, for backward compatibility)
  final VoidCallback? onDelete;

  /// Whether the menu is currently loading (for optimistic UI)
  final bool isLoading;

  const CommentContextMenu({
    super.key,
    required this.comment,
    this.onEdit,
    this.onDelete,
    this.isLoading = false,
  });

  @override
  ConsumerState<CommentContextMenu> createState() => _CommentContextMenuState();
}

class _CommentContextMenuState extends ConsumerState<CommentContextMenu> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rights = widget.comment.rights;

    if (rights == null) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      onSelected: (value) => _handleAction(context, value),
      itemBuilder: (context) => _buildMenuItems(context, l10n, rights),
      icon: (widget.isLoading || _isDeleting)
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          : const Icon(Icons.more_vert),
      tooltip: l10n?.commentActions ?? 'Comment Actions',
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(
    BuildContext context,
    AppLocalizations? l10n,
    MwCommentRights rights,
  ) {
    final items = <PopupMenuEntry<String>>[];

    // Edit action
    if (rights.edit == true) {
      items.add(
        PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit, size: 20),
              const SizedBox(width: 12),
              Text(l10n?.edit ?? 'Edit'),
            ],
          ),
        ),
      );
    }

    // Delete action
    if (rights.delete == true) {
      items.add(
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete,
                size: 20,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.delete ?? 'Delete',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      );
    }

    // Complain action
    if (rights.complain == true) {
      items.add(
        PopupMenuItem<String>(
          value: 'complain',
          child: Row(
            children: [
              Icon(
                Icons.report,
                size: 20,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.complain ?? 'Complain',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  void _handleAction(BuildContext context, String action) {
    switch (action) {
      case 'edit':
        widget.onEdit?.call();
        break;
      case 'delete':
        _showDeleteConfirmation(context);
        break;
      case 'complain':
        _showComplainDialog(context);
        break;
    }
  }

  void _showComplainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CommentComplainDialog(
        comment: widget.comment,
        onComplaintSubmitted: () {
          // Optionally refresh comment data or show additional feedback
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.delete ?? 'Delete'),
        content: Text(
          l10n?.confirmDeleteComment ??
              'Are you sure you want to delete this comment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.goBack ?? 'Cancel'),
          ),
          TextButton(
            onPressed: _isDeleting
                ? null
                : () {
                    Navigator.of(context).pop();
                    _deleteComment(context);
                  },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: _isDeleting
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.error,
                      ),
                    ),
                  )
                : Text(l10n?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteComment(BuildContext context) async {
    if (widget.comment.id == null) return;

    // Capture context-dependent objects before async operation
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);

    setState(() {
      _isDeleting = true;
    });

    try {
      final commentsApi = ref.read(commentsApiProvider);

      // Make the API call to delete the comment
      await commentsApi.commentsIdDelete(id: widget.comment.id!);

      if (mounted) {
        // Show success message
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              l10n?.commentDeleted ?? 'Comment deleted successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Call the optional callback for backward compatibility
        widget.onDelete?.call();
      }
    } catch (e) {
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              l10n?.failedToDeleteComment ??
                  'Failed to delete comment. Please try again.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }
}
