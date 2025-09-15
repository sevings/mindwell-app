import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../../../core/theme/spacing.dart';

/// A widget that displays a single entry in full format for the entry feed.
/// 
/// This widget shows:
/// - Author's avatar and name
/// - Entry title and full content (with more lines)
/// - Stats (comments, votes, favorites)
/// - Entry images (if any)
/// - Tags
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
    final theme = Theme.of(context);
    
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MindwellSpacing.sm,
        vertical: MindwellSpacing.sm,
      ),
      child: InkWell(
        onTap: onTap ?? () => _navigateToEntryDetail(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: EdgeInsets.all(MindwellSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, theme),
              SizedBox(height: MindwellSpacing.md),
              _buildContent(context, theme),
              if (showImages && _hasImages()) ...[
                SizedBox(height: MindwellSpacing.md),
                _buildImages(context),
              ],
              SizedBox(height: MindwellSpacing.md),
              _buildTags(context, theme),
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
            size: 40.0,
            fallbackText: _getInitials(authorName),
          ),
        ),
        SizedBox(width: MindwellSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _navigateToAuthorProfile(context, author),
                child: Text(
                  authorName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                timestamp,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (entry.isPinned == true)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
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
          ),
      ],
    );
  }

  /// Builds the content section with title and content
  Widget _buildContent(BuildContext context, ThemeData theme) {
    final title = entry.title ?? entry.cutTitle ?? '';
    final content = entry.cutContent ?? entry.content ?? '';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: MindwellSpacing.md),
        ],
        if (content.isNotEmpty)
          Text(
            _stripHtml(content),
            style: theme.textTheme.bodyLarge,
            maxLines: maxContentLines,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  /// Builds the entry images if available
  Widget _buildImages(BuildContext context) {
    final images = entry.images ?? entry.insertedImages;
    if (images == null || images.isEmpty) {
      return const SizedBox.shrink();
    }
    
    // Show up to 3 images in a row
    final displayImages = images.take(3).toList();
    
    if (displayImages.length == 1) {
      final firstImage = displayImages.first;
      final imageUrl = firstImage.medium?.url ?? firstImage.small?.url ?? firstImage.thumbnail?.url;
      
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
            final imageUrl = image.medium?.url ?? image.small?.url ?? image.thumbnail?.url;
            
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

  /// Builds the tags display
  Widget _buildTags(BuildContext context, ThemeData theme) {
    final tags = entry.tags;
    if (tags == null || tags.isEmpty) return const SizedBox.shrink();
    
    // Show more tags in full format
    final displayTags = tags.take(5).toList();
    
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: displayTags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            '#$tag',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds the footer with stats and actions
  Widget _buildFooter(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        Flexible(
          child: _buildStat(
            context,
            theme,
            Icons.chat_bubble_outline,
            entry.commentCount ?? 0,
            'Комментарии',
          ),
        ),
        SizedBox(width: MindwellSpacing.sm),
        Flexible(
          child: _buildStat(
            context,
            theme,
            Icons.favorite_outline,
            entry.favoriteCount ?? 0,
            'Избранное',
            isActive: entry.isFavorited == true,
          ),
        ),
        SizedBox(width: MindwellSpacing.sm),
        if (entry.rating != null)
          Flexible(
            child: _buildRating(context, theme),
          ),
        const Spacer(),
        _buildActionButton(
          context,
          theme,
          Icons.share_outlined,
          'Поделиться',
        ),
      ],
    );
  }

  /// Builds a stat item (comments, favorites, etc.)
  Widget _buildStat(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    int count,
    String label, {
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle stat interaction (e.g., show comments, toggle favorite)
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isActive 
              ? theme.colorScheme.primaryContainer 
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.0,
              color: isActive 
                  ? theme.colorScheme.onPrimaryContainer 
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4.0),
            Flexible(
              child: Text(
                _formatCount(count),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isActive 
                      ? theme.colorScheme.onPrimaryContainer 
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
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
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up,
            size: 18.0,
            color: color,
          ),
          const SizedBox(width: 4.0),
          Flexible(
            child: Text(
              score > 0 ? '+$score' : score.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
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
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
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

  /// Navigates to the entry detail screen
  void _navigateToEntryDetail(BuildContext context) {
    if (entry.id != null) {
      context.push('/entries/${entry.id}');
    }
  }

  /// Checks if the entry has any images
  bool _hasImages() {
    final images = entry.images ?? entry.insertedImages;
    return images != null && images.isNotEmpty && 
           images.any((image) => 
             image.medium?.url != null || 
             image.small?.url != null || 
             image.thumbnail?.url != null);
  }

  /// Formats the timestamp for display
  String _formatTimestamp(double? timestamp) {
    if (timestamp == null) return '';
    
    final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).round());
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} дней назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} часов назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} минут назад';
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
