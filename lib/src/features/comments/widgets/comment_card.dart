import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/widgets/images/cached_image.dart';

/// A widget that displays a single comment within a feed context.
/// 
/// This widget is specifically designed for comment feeds and provides:
/// - Author information with avatar and name
/// - Entry title context
/// - Comment content snippet
/// - Voting buttons
/// - Navigation to entry detail and profile screens
class CommentCard extends StatelessWidget {
  /// The comment to display
  final MwComment comment;
  
  /// The title of the entry this comment belongs to
  final String? entryTitle;
  
  /// Callback when upvote is tapped
  final VoidCallback? onUpvote;
  
  /// Callback when downvote is tapped
  final VoidCallback? onDownvote;
  
  /// Whether the comment is currently being voted on (for optimistic UI)
  final bool isVoting;
  
  /// Custom padding for the card
  final EdgeInsetsGeometry? padding;
  
  /// Custom margin for the card
  final EdgeInsetsGeometry? margin;

  const CommentCard({
    super.key,
    required this.comment,
    this.entryTitle,
    this.onUpvote,
    this.onDownvote,
    this.isVoting = false,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final author = comment.author;
    if (author == null) return const SizedBox.shrink();

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToEntryDetail(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, author),
                if (entryTitle != null) ...[
                  const SizedBox(height: 8),
                  _buildEntryTitle(context),
                ],
                const SizedBox(height: 12),
                _buildContentSnippet(context),
                const SizedBox(height: 12),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MwUser author) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _navigateToProfile(context, author),
          child: CachedAvatar(
            imageUrl: _getAvatarUrl(author.avatar),
            size: 40,
            fallbackText: author.name?.isNotEmpty == true 
                ? author.name!.substring(0, 1).toUpperCase()
                : '?',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _navigateToProfile(context, author),
                child: Text(
                  author.name ?? 'Unknown',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              if (comment.createdAt != null) ...[
                const SizedBox(height: 2),
                Text(
                  _formatTimestamp(comment.createdAt!),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildEntryTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.article_outlined,
            size: 16,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              entryTitle!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSnippet(BuildContext context) {
    final content = comment.content ?? comment.editContent;
    if (content == null || content.isEmpty) {
      return Text(
        'Comment deleted',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    // Strip HTML tags for snippet display and limit length
    final plainText = _stripHtmlTags(content);
    final snippet = plainText.length > 150 
        ? '${plainText.substring(0, 150)}...' 
        : plainText;

    return Text(
      snippet,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        if (comment.rating != null) ...[
          _buildVotingSection(context),
          const Spacer(),
        ],
        // Comment indicator
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.comment_outlined,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              'Comment',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVotingSection(BuildContext context) {
    final rating = comment.rating!;
    final upvotes = rating.upCount ?? 0;
    final downvotes = rating.downCount ?? 0;

    return Row(
      children: [
        // Upvote button
        GestureDetector(
          onTap: isVoting ? null : onUpvote,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.thumb_up_outlined,
                  size: 14,
                  color: isVoting 
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onSurface,
                ),
                if (upvotes > 0) ...[
                  const SizedBox(width: 4),
                  Text(
                    upvotes.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isVoting 
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Downvote button
        GestureDetector(
          onTap: isVoting ? null : onDownvote,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.thumb_down_outlined,
                  size: 14,
                  color: isVoting 
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onSurface,
                ),
                if (downvotes > 0) ...[
                  const SizedBox(width: 4),
                  Text(
                    downvotes.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isVoting 
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (isVoting) ...[
          const SizedBox(width: 8),
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  String? _getAvatarUrl(MwAvatar? avatar) {
    if (avatar == null) return null;
    return avatar.x92 ?? avatar.x124 ?? avatar.x42;
  }

  String _formatTimestamp(double timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).round());
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, y').format(date);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String _stripHtmlTags(String html) {
    // Simple HTML tag removal for snippet display
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .trim();
  }

  void _navigateToEntryDetail(BuildContext context) {
    final entryId = comment.entryId;
    if (entryId != null) {
      context.go('/entries/$entryId');
    }
  }

  void _navigateToProfile(BuildContext context, MwUser user) {
    final username = user.name;
    if (username != null && username.isNotEmpty) {
      // Navigate to user profile - this route will be implemented in future tasks
      // For now, we'll use a placeholder navigation
      context.go('/profile');
    }
  }
}
