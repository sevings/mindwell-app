import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import '../../../core/theme/spacing.dart';
import 'entry_widget_base.dart';

/// A widget that displays a single entry in short format for the entry feed.
///
/// This widget shows:
/// - Author's avatar and name
/// - Entry title and content snippet (using cutContent/cutTitle when available)
/// - Stats (favorites, votes)
/// - First entry image only
/// - No tags displayed
///
/// Tapping the card navigates to the entry detail screen.
class EntryCardShort extends StatelessWidget {
  /// The entry to display
  final MwEntry entry;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether to show the entry image
  final bool showImage;

  /// Maximum number of lines for the content snippet
  final int maxContentLines;

  const EntryCardShort({
    super.key,
    required this.entry,
    this.onTap,
    this.showImage = true,
    this.maxContentLines = 3,
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
          vertical: MindwellSpacing.xs,
        ),
        contentPadding: EdgeInsets.all(MindwellSpacing.sm),
        headerSpacing: MindwellSpacing.sm,
        contentSpacing: MindwellSpacing.sm,
        footerSpacing: MindwellSpacing.sm,
        avatarSize: 42.0,
        avatarSpacing: MindwellSpacing.sm,
        showImages: showImage,
        showTags: false, // Hide tags in short format
        showCommentButton: true,
        showShareButton: false,
        useCutContent: true, // Use cutContent/cutTitle when available
        titleMaxLines: 1000, // No limit since content is truncated server-side
        contentMaxLines:
            1000, // No limit since content is truncated server-side
        maxImages: 1, // Show only first image
        maxTags: 0,
        titleSpacing: MindwellSpacing.xs,
        pinnedStyle: PinnedStyle.simple,
        imageDisplayStyle: ImageDisplayStyle.single,
        tagDisplayStyle: TagDisplayStyle.row,
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
