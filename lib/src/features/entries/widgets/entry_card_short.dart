import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../../../core/theme/spacing.dart';

/// A widget that displays a single entry in short format for the entry feed.
/// 
/// This widget shows:
/// - Author's avatar and name
/// - Entry title and content snippet
/// - Stats (comments, votes, favorites)
/// - Optional entry image
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
    final theme = Theme.of(context);
    
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MindwellSpacing.sm,
        vertical: MindwellSpacing.xs,
      ),
      child: InkWell(
        onTap: onTap ?? () => _navigateToEntryDetail(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: EdgeInsets.all(MindwellSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, theme),
              SizedBox(height: MindwellSpacing.sm),
              _buildContent(context, theme),
              if (showImage && _hasImage()) ...[
                SizedBox(height: MindwellSpacing.sm),
                _buildImage(context),
              ],
              SizedBox(height: MindwellSpacing.sm),
              _buildFooter(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header with author info and timestamp
  Widget _buildHeader(BuildContext context, ThemeData theme) {
    final author = entry.author;
    final authorName = author?.showName ?? author?.name ?? 'Anonymous';
    final timestamp = _formatTimestamp(entry.createdAt);
    
    return Row(
      children: [
        GestureDetector(
          onTap: () => _navigateToAuthorProfile(context, author),
          child: CachedAvatar(
            imageUrl: author?.avatar?.x42,
            size: 32.0,
            fallbackText: _getInitials(authorName),
          ),
        ),
        SizedBox(width: MindwellSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _navigateToAuthorProfile(context, author),
                child: Text(
                  authorName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                timestamp,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (entry.isPinned == true)
          Icon(
            Icons.push_pin,
            size: 16.0,
            color: theme.colorScheme.primary,
          ),
      ],
    );
  }

  /// Builds the content section with title and snippet
  Widget _buildContent(BuildContext context, ThemeData theme) {
    final title = entry.title ?? entry.cutTitle ?? '';
    final content = entry.cutContent ?? entry.content ?? '';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: MindwellSpacing.xs),
        ],
        if (content.isNotEmpty)
          Text(
            _stripHtml(content),
            style: theme.textTheme.bodyMedium,
            maxLines: maxContentLines,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  /// Builds the entry image if available
  Widget _buildImage(BuildContext context) {
    final images = entry.images ?? entry.insertedImages;
    if (images == null || images.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final firstImage = images.first;
    final imageUrl = firstImage.medium?.url ?? firstImage.small?.url ?? firstImage.thumbnail?.url;
    
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
  }

  /// Builds the footer with stats and actions
  Widget _buildFooter(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        _buildStat(
          context,
          theme,
          Icons.chat_bubble_outline,
          entry.commentCount ?? 0,
        ),
        SizedBox(width: MindwellSpacing.md),
        _buildStat(
          context,
          theme,
          Icons.favorite_outline,
          entry.favoriteCount ?? 0,
          isActive: entry.isFavorited == true,
        ),
        SizedBox(width: MindwellSpacing.md),
        if (entry.rating != null)
          _buildRating(context, theme),
        const Spacer(),
        if (entry.tags != null && entry.tags!.isNotEmpty)
          _buildTags(context, theme),
      ],
    );
  }

  /// Builds a stat item (comments, favorites, etc.)
  Widget _buildStat(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    int count, {
    bool isActive = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.0,
          color: isActive 
              ? theme.colorScheme.primary 
              : theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4.0),
        Text(
          _formatCount(count),
          style: theme.textTheme.bodySmall?.copyWith(
            color: isActive 
                ? theme.colorScheme.primary 
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Builds the rating display
  Widget _buildRating(BuildContext context, ThemeData theme) {
    final rating = entry.rating;
    if (rating == null) return const SizedBox.shrink();
    
    final score = rating.rating?.round() ?? 0;
    final color = score > 0 
        ? Colors.green 
        : score < 0 
            ? Colors.red 
            : theme.colorScheme.onSurfaceVariant;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.trending_up,
          size: 16.0,
          color: color,
        ),
        const SizedBox(width: 4.0),
        Text(
          score > 0 ? '+$score' : score.toString(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// Builds the tags display
  Widget _buildTags(BuildContext context, ThemeData theme) {
    final tags = entry.tags;
    if (tags == null || tags.isEmpty) return const SizedBox.shrink();
    
    final displayTags = tags.take(2).toList();
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: displayTags.map((tag) {
        return Container(
          margin: const EdgeInsets.only(left: 4.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
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
      }).toList(),
    );
  }

  /// Navigates to the entry detail screen
  void _navigateToEntryDetail(BuildContext context) {
    if (entry.id != null) {
      context.push('/entries/${entry.id}');
    }
  }

  /// Checks if the entry has any images
  bool _hasImage() {
    final images = entry.images ?? entry.insertedImages;
    return images != null && images.isNotEmpty && 
           (images.first.medium?.url != null || 
            images.first.small?.url != null || 
            images.first.thumbnail?.url != null);
  }

  /// Formats the timestamp for display
  String _formatTimestamp(double? timestamp) {
    if (timestamp == null) return '';
    
    final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).round());
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

  /// Strips HTML tags from content
  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
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
