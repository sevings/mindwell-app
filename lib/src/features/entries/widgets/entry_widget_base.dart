import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../../../core/widgets/html_content.dart';
import '../../../core/theme/spacing.dart';
import '../providers/entry_interactions_provider.dart';

/// Base widget for displaying entries with configurable display options.
///
/// This widget provides a common foundation for all entry display formats
/// while allowing customization through the EntryDisplayConfig.
class EntryWidgetBase extends ConsumerStatefulWidget {
  /// The entry to display
  final MwEntry entry;

  /// Configuration for how the entry should be displayed
  final EntryDisplayConfig config;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Optional callback when comment button is tapped
  final VoidCallback? onCommentTap;

  const EntryWidgetBase({
    super.key,
    required this.entry,
    required this.config,
    this.onTap,
    this.onCommentTap,
  });

  @override
  ConsumerState<EntryWidgetBase> createState() => _EntryWidgetBaseState();
}

class _EntryWidgetBaseState extends ConsumerState<EntryWidgetBase> {
  late MwEntry _currentEntry;

  @override
  void initState() {
    super.initState();
    _currentEntry = widget.entry;
  }

  @override
  void didUpdateWidget(EntryWidgetBase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry != widget.entry) {
      _currentEntry = widget.entry;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: widget.config.cardMargin,
      child: InkWell(
        onTap: widget.onTap ?? () => _navigateToEntryDetail(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: widget.config.contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, theme),
              SizedBox(height: widget.config.headerSpacing),
              _buildContent(context, theme),
              if (widget.config.showImages && _hasImages()) ...[
                SizedBox(height: widget.config.contentSpacing),
                _buildImages(context),
              ],
              if (widget.config.showTags && _hasTags()) ...[
                SizedBox(height: widget.config.contentSpacing),
                _buildTags(context, theme),
              ],
              SizedBox(height: widget.config.footerSpacing),
              _buildFooter(context, theme, ref),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header with author info and timestamp
  Widget _buildHeader(BuildContext context, ThemeData theme) {
    final author = _currentEntry.author;
    final authorName = author?.showName ?? author?.name ?? 'Anonymous';
    final timestamp = _formatTimestamp(_currentEntry.createdAt);

    return Row(
      children: [
        GestureDetector(
          onTap: () => _navigateToAuthorProfile(context, author),
          child: CachedAvatar(
            imageUrl: author?.avatar?.x42,
            size: widget.config.avatarSize,
            fallbackText: _getInitials(authorName),
          ),
        ),
        SizedBox(width: widget.config.avatarSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _navigateToAuthorProfile(context, author),
                child: Text(
                  authorName,
                  style:
                      widget.config.authorTextStyle?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ) ??
                      theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                timestamp,
                style:
                    widget.config.timestampTextStyle?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ) ??
                    theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        if (_currentEntry.isPinned == true)
          _buildPinnedIndicator(context, theme),
      ],
    );
  }

  /// Builds the pinned indicator
  Widget _buildPinnedIndicator(BuildContext context, ThemeData theme) {
    if (widget.config.pinnedStyle == PinnedStyle.simple) {
      return Icon(Icons.push_pin, size: 16.0, color: theme.colorScheme.primary);
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.push_pin,
              size: 16.0,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 4.0),
            Text(
              'Закреплено',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      );
    }
  }

  /// Builds the content section with title and content
  Widget _buildContent(BuildContext context, ThemeData theme) {
    final title = widget.config.useCutContent
        ? (_currentEntry.cutTitle ?? _currentEntry.title ?? '')
        : (_currentEntry.title ?? _currentEntry.cutTitle ?? '');
    final content = widget.config.useCutContent
        ? (_currentEntry.cutContent ?? _currentEntry.content ?? '')
        : (_currentEntry.content ?? _currentEntry.cutContent ?? '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            _decodeHtmlEntities(title),
            style:
                widget.config.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                ) ??
                theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            maxLines: widget.config.titleMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: widget.config.titleSpacing),
        ],
        if (content.isNotEmpty) ...[
          HtmlContent(html: content, textStyle: widget.config.contentTextStyle),
        ],
      ],
    );
  }

  /// Builds the entry images if available
  Widget _buildImages(BuildContext context) {
    final images = _currentEntry.images ?? _currentEntry.insertedImages;
    if (images == null || images.isEmpty) {
      return const SizedBox.shrink();
    }

    if (widget.config.imageDisplayStyle == ImageDisplayStyle.single) {
      // Show only the first image
      final firstImage = images.first;
      final imageUrl =
          firstImage.medium?.url ??
          firstImage.small?.url ??
          firstImage.thumbnail?.url;

      if (imageUrl == null || imageUrl.isEmpty) {
        return const SizedBox.shrink();
      }

      return ClipRRect(
        key: const Key('entry_image'),
        borderRadius: BorderRadius.circular(8.0),
        child: CachedPostImage(
          imageUrl: imageUrl,
          width: double.infinity,
          aspectRatio: 16 / 9,
          borderRadius: 8.0,
          onTap: () => _navigateToEntryDetail(context),
        ),
      );
    } else {
      // Show multiple images
      final displayImages = images.take(widget.config.maxImages).toList();

      if (displayImages.length == 1) {
        final firstImage = displayImages.first;
        final imageUrl =
            firstImage.medium?.url ??
            firstImage.small?.url ??
            firstImage.thumbnail?.url;

        if (imageUrl == null || imageUrl.isEmpty) {
          return const SizedBox.shrink();
        }

        return ClipRRect(
          key: const Key('entry_images'),
          borderRadius: BorderRadius.circular(8.0),
          child: CachedPostImage(
            imageUrl: imageUrl,
            width: double.infinity,
            aspectRatio: 16 / 9,
            borderRadius: 8.0,
            onTap: () => _navigateToEntryDetail(context),
          ),
        );
      } else {
        return SizedBox(
          key: const Key('entry_images'),
          height: 120.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: displayImages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
            itemBuilder: (context, index) {
              final image = displayImages[index];
              final imageUrl =
                  image.medium?.url ?? image.small?.url ?? image.thumbnail?.url;

              if (imageUrl == null || imageUrl.isEmpty) {
                return const SizedBox.shrink();
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedPostImage(
                  imageUrl: imageUrl,
                  width: 120.0,
                  aspectRatio: 1.0,
                  borderRadius: 8.0,
                  onTap: () => _navigateToEntryDetail(context),
                ),
              );
            },
          ),
        );
      }
    }
  }

  /// Builds the tags display
  Widget _buildTags(BuildContext context, ThemeData theme) {
    final tags = _currentEntry.tags;
    if (tags == null || tags.isEmpty) return const SizedBox.shrink();

    final displayTags = tags.take(widget.config.maxTags).toList();

    if (widget.config.tagDisplayStyle == TagDisplayStyle.wrap) {
      return Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: displayTags
            .map((tag) => _buildTag(context, theme, tag))
            .toList(),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: displayTags
            .map((tag) => _buildTag(context, theme, tag))
            .toList(),
      );
    }
  }

  /// Builds a single tag
  Widget _buildTag(BuildContext context, ThemeData theme, String tag) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        '#$tag',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  /// Builds the footer with stats and actions
  Widget _buildFooter(BuildContext context, ThemeData theme, WidgetRef ref) {
    return Row(
      children: [
        // Vote button (if rating exists)
        if (_currentEntry.rating != null) ...[
          _buildVoteButton(context, theme, ref),
          SizedBox(width: MindwellSpacing.sm),
        ],
        // Favorite button (always show)
        _buildFavoriteButton(context, theme, ref),
        const Spacer(),
        // Comment button (only for entry card widgets, on the right side)
        if (widget.config.showCommentButton) ...[
          _buildCommentButton(context, theme),
          SizedBox(width: MindwellSpacing.sm),
        ],
        if (widget.config.showShareButton)
          _buildActionButton(
            context,
            theme,
            Icons.share_outlined,
            'Поделиться',
          ),
      ],
    );
  }

  /// Builds the vote button with fire icon
  Widget _buildVoteButton(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    final rating = _currentEntry.rating;
    if (rating == null) return const SizedBox.shrink();

    final upVotes = rating.upCount ?? 0;
    final downVotes = rating.downCount ?? 0;
    final netVotes = upVotes - downVotes;
    final userVote = rating.vote;
    final hasVoted = userVote != null && userVote != 0;
    final isUpvoted = userVote == 1;
    final isDownvoted = userVote == -1;
    final canVote = _currentEntry.rights?.vote == true;

    // Determine button color based on vote status and voting rights
    Color buttonColor;
    Color iconColor;
    if (!canVote) {
      // User doesn't have right to vote - disabled state
      buttonColor = theme.colorScheme.surfaceContainerHighest;
      iconColor = theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5);
    } else if (hasVoted) {
      if (isUpvoted) {
        buttonColor = const Color(0xFFFF6B35); // Mindwell orange
        iconColor = Colors.white;
      } else if (isDownvoted) {
        buttonColor = Colors.grey;
        iconColor = Colors.white;
      } else {
        buttonColor = theme.colorScheme.surfaceContainerHighest;
        iconColor = theme.colorScheme.onSurfaceVariant;
      }
    } else {
      buttonColor = theme.colorScheme.surfaceContainerHighest;
      iconColor = theme.colorScheme.onSurfaceVariant;
    }

    return AbsorbPointer(
      absorbing: !canVote,
      child: GestureDetector(
        onTap: canVote ? () => _handleVote(context, ref, isUpvoted) : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department, size: 18.0, color: iconColor),
              const SizedBox(width: 4.0),
              Text(
                netVotes > 0 ? '+$netVotes' : netVotes.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the favorite button
  Widget _buildFavoriteButton(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
  ) {
    final favoriteCount = _currentEntry.favoriteCount ?? 0;
    final isFavorited = _currentEntry.isFavorited == true;

    // Determine button color based on favorite status
    final buttonColor = isFavorited
        ? const Color(0xFFFF6B35) // Mindwell orange
        : theme.colorScheme.surfaceContainerHighest;
    final iconColor = isFavorited
        ? Colors.white
        : theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: () => _handleFavorite(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFavorited ? Icons.bookmark : Icons.bookmark_outline,
              size: 18.0,
              color: iconColor,
            ),
            if (favoriteCount > 0) ...[
              const SizedBox(width: 4.0),
              Text(
                _formatCount(favoriteCount),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds the comment button
  Widget _buildCommentButton(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onTap:
          widget.onCommentTap ??
          () => _navigateToEntryDetailWithComments(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 18.0,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4.0),
            Text(
              _formatCount(_currentEntry.commentCount ?? 0),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an action button
  Widget _buildActionButton(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    String label,
  ) {
    return GestureDetector(
      onTap: () {
        // Handle action (e.g., share entry)
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          icon,
          size: 18.0,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// Handles voting on the entry
  Future<void> _handleVote(
    BuildContext context,
    WidgetRef ref,
    bool isCurrentlyUpvoted,
  ) async {
    if (_currentEntry.id == null) return;

    // Check if user has permission to vote
    final canVote = _currentEntry.rights?.vote == true;

    if (!canVote) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('У вас нет права голосовать за эту запись'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return;
    }

    final interactionsNotifier = ref.read(entryInteractionsProvider);

    try {
      MwRating? updatedRating;
      if (isCurrentlyUpvoted) {
        // Remove vote
        updatedRating = await interactionsNotifier.removeVote(
          _currentEntry.id!,
        );
      } else {
        // Add upvote
        updatedRating = await interactionsNotifier.voteEntry(
          _currentEntry.id!,
          true,
        );
      }

      // Update the entry with the new rating
      if (updatedRating != null && mounted) {
        setState(() {
          _currentEntry = _currentEntry.rebuild(
            (b) => b.rating = updatedRating!.toBuilder(),
          );
        });
      }
    } catch (e) {
      // Show error message to user
      if (context.mounted) {
        String errorMessage = 'Ошибка при голосовании';

        // Provide more specific error messages based on the error type
        if (e.toString().contains('403')) {
          errorMessage = 'У вас нет права голосовать за эту запись';
        } else if (e.toString().contains('401')) {
          errorMessage = 'Необходимо войти в систему для голосования';
        } else if (e.toString().contains('429')) {
          errorMessage = 'Слишком много попыток. Попробуйте позже';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Handles favoriting the entry
  Future<void> _handleFavorite(BuildContext context, WidgetRef ref) async {
    if (_currentEntry.id == null) return;

    final interactionsNotifier = ref.read(entryInteractionsProvider);
    final isCurrentlyFavorited = _currentEntry.isFavorited == true;

    try {
      final updatedFavoriteStatus = await interactionsNotifier.toggleFavorite(
        _currentEntry.id!,
        isCurrentlyFavorited,
      );

      // Update the entry with the new favorite status
      if (updatedFavoriteStatus != null && mounted) {
        setState(() {
          _currentEntry = _currentEntry.rebuild(
            (b) => b
              ..isFavorited = updatedFavoriteStatus.isFavorited
              ..favoriteCount = updatedFavoriteStatus.count,
          );
        });
      }
    } catch (e) {
      // Show error message to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при добавлении в избранное: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Navigates to the entry detail screen
  void _navigateToEntryDetail(BuildContext context) {
    if (_currentEntry.id != null) {
      context.push('/entries/${_currentEntry.id}');
    }
  }

  /// Navigates to the entry detail screen and scrolls to comments
  void _navigateToEntryDetailWithComments(BuildContext context) {
    if (_currentEntry.id != null) {
      context.push('/entries/${_currentEntry.id}?scrollToComments=true');
    }
  }

  /// Checks if the entry has any images
  bool _hasImages() {
    final images = _currentEntry.images ?? _currentEntry.insertedImages;
    return images != null &&
        images.isNotEmpty &&
        images.any(
          (image) =>
              image.medium?.url != null ||
              image.small?.url != null ||
              image.thumbnail?.url != null,
        );
  }

  /// Checks if the entry has any tags
  bool _hasTags() {
    final tags = _currentEntry.tags;
    return tags != null && tags.isNotEmpty;
  }

  /// Formats the timestamp for display
  String _formatTimestamp(double? timestamp) {
    if (timestamp == null) return '';

    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      (timestamp * 1000).round(),
    );
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}д';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}ч';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}м';
    } else {
      return 'сейчас';
    }
  }

  /// Formats count for display (e.g., 1000 -> 1K)
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  /// Decodes HTML entities in text
  String _decodeHtmlEntities(String text) {
    return text
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&apos;', "'")
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&copy;', '©')
        .replaceAll('&reg;', '®')
        .replaceAll('&trade;', '™')
        .replaceAll('&hellip;', '…')
        .replaceAll('&mdash;', '—')
        .replaceAll('&ndash;', '–')
        .replaceAll('&lsquo;', ''')
        .replaceAll('&rsquo;', ''')
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"');
  }

  /// Gets initials from a name
  String _getInitials(String name) {
    if (name.isEmpty) return '?';

    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }

    return (words[0].substring(0, 1) + words[1].substring(0, 1)).toUpperCase();
  }

  /// Navigates to the author's profile screen
  void _navigateToAuthorProfile(BuildContext context, MwUser? author) {
    if (author?.name != null && author!.name!.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(author.name!)}');
    }
  }
}

/// Configuration class for customizing entry display
class EntryDisplayConfig {
  /// Card margin
  final EdgeInsets cardMargin;

  /// Content padding
  final EdgeInsets contentPadding;

  /// Spacing between header and content
  final double headerSpacing;

  /// Spacing between content sections
  final double contentSpacing;

  /// Spacing before footer
  final double footerSpacing;

  /// Avatar size
  final double avatarSize;

  /// Spacing after avatar
  final double avatarSpacing;

  /// Whether to show images
  final bool showImages;

  /// Whether to show tags
  final bool showTags;

  /// Whether to show comment button
  final bool showCommentButton;

  /// Whether to show share button
  final bool showShareButton;

  /// Whether to use cut content/title instead of full content/title
  final bool useCutContent;

  /// Maximum number of lines for title
  final int titleMaxLines;

  /// Maximum number of lines for content
  final int contentMaxLines;

  /// Maximum number of images to show
  final int maxImages;

  /// Maximum number of tags to show
  final int maxTags;

  /// Spacing after title
  final double titleSpacing;

  /// Text style for author name
  final TextStyle? authorTextStyle;

  /// Text style for timestamp
  final TextStyle? timestampTextStyle;

  /// Text style for title
  final TextStyle? titleTextStyle;

  /// Text style for content
  final TextStyle? contentTextStyle;

  /// HTML style for content rendering
  final Map<String, Style>? htmlStyle;

  /// How to display pinned indicator
  final PinnedStyle pinnedStyle;

  /// How to display images
  final ImageDisplayStyle imageDisplayStyle;

  /// How to display tags
  final TagDisplayStyle tagDisplayStyle;

  const EntryDisplayConfig({
    this.cardMargin = const EdgeInsets.symmetric(
      horizontal: MindwellSpacing.sm,
      vertical: MindwellSpacing.xs,
    ),
    this.contentPadding = const EdgeInsets.all(MindwellSpacing.sm),
    this.headerSpacing = MindwellSpacing.sm,
    this.contentSpacing = MindwellSpacing.sm,
    this.footerSpacing = MindwellSpacing.sm,
    this.avatarSize = 42.0,
    this.avatarSpacing = MindwellSpacing.sm,
    this.showImages = true,
    this.showTags = true,
    this.showCommentButton = false,
    this.showShareButton = false,
    this.useCutContent = false,
    this.titleMaxLines =
        1000, // No limit since content is truncated server-side
    this.contentMaxLines =
        1000, // No limit since content is truncated server-side
    this.maxImages = 3,
    this.maxTags = 2,
    this.titleSpacing = MindwellSpacing.xs,
    this.authorTextStyle,
    this.timestampTextStyle,
    this.titleTextStyle,
    this.contentTextStyle,
    this.htmlStyle,
    this.pinnedStyle = PinnedStyle.simple,
    this.imageDisplayStyle = ImageDisplayStyle.multiple,
    this.tagDisplayStyle = TagDisplayStyle.row,
  });
}

/// Style for pinned indicator
enum PinnedStyle { simple, badge }

/// Style for image display
enum ImageDisplayStyle { single, multiple }

/// Style for tag display
enum TagDisplayStyle { row, wrap }
