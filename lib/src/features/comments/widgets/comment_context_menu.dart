import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';

/// A context menu widget for comments that provides various actions based on user permissions.
/// 
/// This widget displays a popup menu with different options depending on the user's rights
/// for the specific comment. Actions include edit, delete, vote, and complain.
class CommentContextMenu extends StatelessWidget {
  /// The comment to show context menu for
  final MwComment comment;
  
  /// Callback when edit action is triggered
  final VoidCallback? onEdit;
  
  /// Callback when delete action is triggered
  final VoidCallback? onDelete;
  
  /// Callback when upvote action is triggered
  final VoidCallback? onUpvote;
  
  /// Callback when downvote action is triggered
  final VoidCallback? onDownvote;
  
  /// Callback when complain action is triggered
  final VoidCallback? onComplain;
  
  /// Whether the menu is currently loading (for optimistic UI)
  final bool isLoading;

  const CommentContextMenu({
    super.key,
    required this.comment,
    this.onEdit,
    this.onDelete,
    this.onUpvote,
    this.onDownvote,
    this.onComplain,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rights = comment.rights;
    
    if (rights == null) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      onSelected: (value) => _handleAction(context, value),
      itemBuilder: (context) => _buildMenuItems(context, l10n, rights),
      icon: isLoading 
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

    // Vote actions
    if (rights.vote == true) {
      items.addAll([
        PopupMenuItem<String>(
          value: 'upvote',
          child: Row(
            children: [
              const Icon(Icons.thumb_up_outlined, size: 20),
              const SizedBox(width: 12),
              Text(l10n?.upvote ?? 'Upvote'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'downvote',
          child: Row(
            children: [
              const Icon(Icons.thumb_down_outlined, size: 20),
              const SizedBox(width: 12),
              Text(l10n?.downvote ?? 'Downvote'),
            ],
          ),
        ),
      ]);
    }

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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
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
        onEdit?.call();
        break;
      case 'delete':
        _showDeleteConfirmation(context);
        break;
      case 'upvote':
        onUpvote?.call();
        break;
      case 'downvote':
        onDownvote?.call();
        break;
      case 'complain':
        onComplain?.call();
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.delete ?? 'Delete'),
        content: Text(l10n?.confirmDeleteComment ?? 'Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.goBack ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }
}
