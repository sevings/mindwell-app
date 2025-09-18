import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../config/config.dart';
import 'entry_complain_dialog.dart';

/// A context menu widget for entries that provides various actions based on user permissions.
///
/// This widget displays a popup menu with different options depending on the user's rights
/// for the specific entry. Actions include pin, follow, edit, delete, complain, share, and copy link.
class EntryContextMenu extends StatelessWidget {
  /// The entry to show context menu for
  final MwEntry entry;

  /// Callback when pin action is triggered
  final VoidCallback? onPin;

  /// Callback when unpin action is triggered
  final VoidCallback? onUnpin;

  /// Callback when follow action is triggered
  final VoidCallback? onFollow;

  /// Callback when unfollow action is triggered
  final VoidCallback? onUnfollow;

  /// Callback when edit action is triggered
  final VoidCallback? onEdit;

  /// Callback when delete action is triggered
  final VoidCallback? onDelete;

  /// Callback when complain action is triggered
  final VoidCallback? onComplain;

  /// Callback when share action is triggered
  final VoidCallback? onShare;

  /// Callback when copy link action is triggered
  final VoidCallback? onCopyLink;

  /// Whether the menu is currently loading (for optimistic UI)
  final bool isLoading;

  const EntryContextMenu({
    super.key,
    required this.entry,
    this.onPin,
    this.onUnpin,
    this.onFollow,
    this.onUnfollow,
    this.onEdit,
    this.onDelete,
    this.onComplain,
    this.onShare,
    this.onCopyLink,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rights = entry.rights;

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
      tooltip: l10n?.entryActions ?? 'Entry Actions',
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(
    BuildContext context,
    AppLocalizations? l10n,
    MwEntryRights rights,
  ) {
    final items = <PopupMenuEntry<String>>[];

    // Pin/Unpin action
    if (rights.pin == true) {
      items.add(
        PopupMenuItem<String>(
          value: entry.isPinned == true ? 'unpin' : 'pin',
          child: Row(
            children: [
              Icon(
                entry.isPinned == true
                    ? Icons.push_pin
                    : Icons.push_pin_outlined,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                entry.isPinned == true
                    ? (l10n?.unpin ?? 'Unpin')
                    : (l10n?.pin ?? 'Pin'),
              ),
            ],
          ),
        ),
      );
    }

    // Follow/Unfollow action
    items.add(
      PopupMenuItem<String>(
        value: entry.isWatching == true ? 'unfollow' : 'follow',
        child: Row(
          children: [
            Icon(
              entry.isWatching == true
                  ? Icons.visibility_off
                  : Icons.visibility,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              entry.isWatching == true
                  ? (l10n?.unfollow ?? 'Unfollow')
                  : (l10n?.follow ?? 'Follow'),
            ),
          ],
        ),
      ),
    );

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

    // Share action
    items.add(
      PopupMenuItem<String>(
        value: 'share',
        child: Row(
          children: [
            const Icon(Icons.share, size: 20),
            const SizedBox(width: 12),
            Text(l10n?.share ?? 'Share'),
          ],
        ),
      ),
    );

    // Copy link action
    items.add(
      PopupMenuItem<String>(
        value: 'copyLink',
        child: Row(
          children: [
            const Icon(Icons.link, size: 20),
            const SizedBox(width: 12),
            Text(l10n?.copyLink ?? 'Copy Link'),
          ],
        ),
      ),
    );

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
      case 'pin':
        onPin?.call();
        break;
      case 'unpin':
        onUnpin?.call();
        break;
      case 'follow':
        onFollow?.call();
        break;
      case 'unfollow':
        onUnfollow?.call();
        break;
      case 'edit':
        onEdit?.call();
        break;
      case 'delete':
        onDelete?.call();
        break;
      case 'complain':
        _showComplainDialog(context);
        break;
      case 'share':
        onShare?.call();
        break;
      case 'copyLink':
        _copyLinkToClipboard(context);
        break;
    }
  }

  void _showComplainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EntryComplainDialog(
        entry: entry,
        onComplaintSubmitted: () {
          // Optionally refresh entry data or show additional feedback
        },
      ),
    );
  }

  void _copyLinkToClipboard(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Construct the actual entry URL using the config baseUrl and entry ID
    final entryUrl = '${Config.baseUrl}/entries/${entry.id}';

    Clipboard.setData(ClipboardData(text: entryUrl));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.linkCopied ?? 'Link copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
