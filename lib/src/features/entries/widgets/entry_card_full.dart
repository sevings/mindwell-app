import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import '../../../core/theme/spacing.dart';
import 'entry_widget_base.dart';

/// A widget that displays a single entry in full format for the entry feed.
///
/// This widget shows:
/// - Author's avatar and name
/// - Entry title and full content (with HTML rendering)
/// - Stats (favorites, votes)
/// - Entry images (if any)
/// - Tags
/// - Comment button that navigates to entry detail
///
/// Tapping the card navigates to the entry detail screen.
class EntryCardFull extends StatelessWidget {
  /// The entry to display
  final MwEntry entry;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether to show the entry images
  final bool showImages;

  /// Maximum number of lines for the content snippet
  final int maxContentLines;

  const EntryCardFull({
    super.key,
    required this.entry,
    this.onTap,
    this.showImages = true,
    this.maxContentLines = 8,
  });

  @override
  Widget build(BuildContext context) {
    return EntryWidgetBase(
      entry: entry,
      onTap: onTap,
      onCommentTap: () => _navigateToEntryDetail(context),
      config: EntryDisplayConfig(
        cardMargin: EdgeInsets.symmetric(
          horizontal: MindwellSpacing.sm,
          vertical: MindwellSpacing.sm,
        ),
        contentPadding: EdgeInsets.all(MindwellSpacing.md),
        headerSpacing: MindwellSpacing.md,
        contentSpacing: MindwellSpacing.md,
        footerSpacing: MindwellSpacing.sm,
        avatarSize: 42.0,
        avatarSpacing: MindwellSpacing.md,
        showImages: showImages,
        showTags: true,
        showCommentButton: true,
        showShareButton: true,
        useCutContent: false,
        titleMaxLines: 1000, // No limit since content is truncated server-side
        contentMaxLines:
            1000, // No limit since content is truncated server-side
        maxImages: 3,
        maxTags: 5,
        titleSpacing: MindwellSpacing.md,
        pinnedStyle: PinnedStyle.badge,
        imageDisplayStyle: ImageDisplayStyle.multiple,
        tagDisplayStyle: TagDisplayStyle.wrap,
      ),
    );
  }

  /// Navigates to the entry detail screen
  void _navigateToEntryDetail(BuildContext context) {
    if (entry.id != null) {
      context.push('/entries/${entry.id}');
    }
  }
}
