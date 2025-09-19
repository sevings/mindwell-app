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
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.1),
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
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.3),
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
    final upVotes = rating.upCount ?? 0;
    final downVotes = rating.downCount ?? 0;
    final netVotes = upVotes - downVotes;
    final userVote = rating.vote;
    final hasVoted = userVote != null && userVote != 0;
    final isUpvoted = userVote == 1;
    final canVote = comment.rights?.vote == true;

    // Determine button color based on vote status and voting rights
    Color buttonColor;
    Color iconColor;
    if (!canVote) {
      // User doesn't have right to vote - disabled state
      buttonColor = Theme.of(context).colorScheme.surfaceContainerHighest;
      iconColor = Theme.of(
        context,
      ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5);
    } else if (hasVoted && isUpvoted) {
      // User has upvoted - filled with mindwell orange
      buttonColor = const Color(0xFFFF6B35); // Mindwell orange
      iconColor = Colors.white;
    } else {
      // User can vote but hasn't voted or downvoted - outline only
      buttonColor = Colors.transparent;
      iconColor = Theme.of(context).colorScheme.onSurfaceVariant;
    }

    return GestureDetector(
      onTap: (canVote && !isVoting)
          ? () => _handleVote(context, isUpvoted)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.0),
          border: canVote && !hasVoted
              ? Border.all(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  width: 1.0,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.local_fire_department, size: 18.0, color: iconColor),
            const SizedBox(width: 4.0),
            Text(
              netVotes > 0 ? '+$netVotes' : netVotes.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: iconColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isVoting) ...[
              const SizedBox(width: 8.0),
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String? _getAvatarUrl(MwAvatar? avatar) {
    if (avatar == null) return null;
    return avatar.x92 ?? avatar.x124 ?? avatar.x42;
  }

  String _formatTimestamp(double timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      (timestamp * 1000).round(),
    );
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

  /// Handles voting on the comment
  void _handleVote(BuildContext context, bool isCurrentlyUpvoted) {
    if (isCurrentlyUpvoted) {
      onDownvote?.call();
    } else {
      onUpvote?.call();
    }
  }
}
