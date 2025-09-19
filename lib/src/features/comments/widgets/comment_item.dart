import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/html_content.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/widgets/images/cached_image.dart';
import 'comment_context_menu.dart';
import '../providers/comment_interactions_provider.dart';

/// A widget that displays a single comment with author information, content, and voting options.
///
/// This widget is designed to be reusable across different screens that need to display comments,
/// such as the entry detail screen, comment list screen, or user profile screen.
class CommentItem extends ConsumerStatefulWidget {
  /// The comment to display
  final MwComment comment;

  /// Whether to show voting buttons
  final bool showVoting;

  /// Whether to show the entry title (useful in comment list contexts)
  final bool showEntryTitle;

  /// The entry title to display (if showEntryTitle is true)
  final String? entryTitle;

  /// Callback when the comment is tapped
  final VoidCallback? onTap;

  /// Callback when the author is tapped
  final VoidCallback? onAuthorTap;

  /// Callback when upvote is tapped
  final void Function(MwComment comment)? onUpvote;

  /// Callback when downvote is tapped
  final void Function(MwComment comment)? onDownvote;

  /// Whether the comment is currently being voted on (for optimistic UI)
  final bool isVoting;

  /// Custom padding for the comment
  final EdgeInsetsGeometry? padding;

  /// Custom margin for the comment
  final EdgeInsetsGeometry? margin;

  /// Callback when edit action is triggered from context menu
  final VoidCallback? onEdit;

  /// Callback when delete action is triggered from context menu
  final VoidCallback? onDelete;

  /// Whether to show context menu on long press
  final bool showContextMenu;

  const CommentItem({
    super.key,
    required this.comment,
    this.showVoting = true,
    this.showEntryTitle = false,
    this.entryTitle,
    this.onTap,
    this.onAuthorTap,
    this.onUpvote,
    this.onDownvote,
    this.isVoting = false,
    this.padding,
    this.margin,
    this.onEdit,
    this.onDelete,
    this.showContextMenu = false,
  });

  @override
  ConsumerState<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends ConsumerState<CommentItem> {
  late MwComment _currentComment;
  bool _isVoting = false;

  @override
  void initState() {
    super.initState();
    _currentComment = widget.comment;
  }

  @override
  void didUpdateWidget(CommentItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.comment != widget.comment) {
      _currentComment = widget.comment;
    }
  }

  @override
  Widget build(BuildContext context) {
    final author = _currentComment.author;
    if (author == null) return const SizedBox.shrink();

    return Container(
      margin: widget.margin ?? const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: widget.padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: _buildHeader(context, author)),
                    if (widget.showContextMenu) ...[
                      const SizedBox(width: 8),
                      CommentContextMenu(
                        comment: _currentComment,
                        onEdit: widget.onEdit,
                        onDelete: widget.onDelete,
                      ),
                    ],
                  ],
                ),
                if (widget.showEntryTitle && widget.entryTitle != null) ...[
                  const SizedBox(height: 8),
                  _buildEntryTitle(context),
                ],
                const SizedBox(height: 12),
                _buildContent(context),
                if (widget.showVoting && _currentComment.rating != null) ...[
                  const SizedBox(height: 12),
                  _buildVoteButton(context),
                ],
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
          onTap:
              widget.onAuthorTap ??
              () => _navigateToAuthorProfile(context, author),
          child: CachedAvatar(
            imageUrl: _getAvatarUrl(author.avatar),
            size: 32,
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
                onTap:
                    widget.onAuthorTap ??
                    () => _navigateToAuthorProfile(context, author),
                child: Text(
                  author.name ?? 'Unknown',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              if (_currentComment.createdAt != null) ...[
                const SizedBox(height: 2),
                Text(
                  _formatTimestamp(_currentComment.createdAt!),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEntryTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.article_outlined,
            size: 14,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              widget.entryTitle!,
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

  Widget _buildContent(BuildContext context) {
    final content = _currentComment.content ?? _currentComment.editContent;
    if (content == null || content.isEmpty) {
      return Text(
        'Comment deleted',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontStyle: FontStyle.italic,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    return HtmlContent(
      html: content,
      textStyle: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontSize: 14, height: 1.4),
    );
  }

  /// Builds the vote button with fire icon
  Widget _buildVoteButton(BuildContext context) {
    final rating = _currentComment.rating!;
    final upVotes = rating.upCount ?? 0;
    final downVotes = rating.downCount ?? 0;
    final netVotes = upVotes - downVotes;
    final userVote = rating.vote;
    final hasVoted = userVote != null && userVote != 0;
    final isUpvoted = userVote == 1;
    final canVote = _currentComment.rights?.vote == true;

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

    return AbsorbPointer(
      absorbing: !canVote,
      child: GestureDetector(
        onTap: canVote ? () => _handleVote(context, isUpvoted) : null,
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
              if (_isVoting || widget.isVoting) ...[
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
      ),
    );
  }

  /// Handles voting on the comment
  Future<void> _handleVote(
    BuildContext context,
    bool isCurrentlyUpvoted,
  ) async {
    if (_currentComment.id == null) return;

    // If callbacks are provided, use them instead of internal voting logic
    if (widget.onUpvote != null || widget.onDownvote != null) {
      if (isCurrentlyUpvoted) {
        widget.onDownvote?.call(_currentComment);
      } else {
        widget.onUpvote?.call(_currentComment);
      }
      return;
    }

    // Check if user has permission to vote
    final canVote = _currentComment.rights?.vote == true;

    if (!canVote) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'У вас нет права голосовать за этот комментарий',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return;
    }

    final interactionsNotifier = ref.read(commentInteractionsProvider);

    setState(() {
      _isVoting = true;
    });

    try {
      MwRating? updatedRating;
      if (isCurrentlyUpvoted) {
        // Remove vote
        updatedRating = await interactionsNotifier.removeVote(
          _currentComment.id!,
        );
      } else {
        // Add upvote
        updatedRating = await interactionsNotifier.voteComment(
          _currentComment.id!,
          true,
        );
      }

      // Update the comment with the new rating
      if (updatedRating != null && mounted) {
        setState(() {
          _currentComment = _currentComment.rebuild(
            (b) => b.rating = updatedRating!.toBuilder(),
          );
        });
      }
    } catch (e) {
      // Show error message to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Ошибка при голосовании'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isVoting = false;
        });
      }
    }
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

  /// Navigates to the author's profile screen
  void _navigateToAuthorProfile(BuildContext context, MwUser author) {
    if (author.name != null && author.name!.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(author.name!)}');
    }
  }
}
