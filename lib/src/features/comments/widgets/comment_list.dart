import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import 'comment_item.dart';

/// A widget that displays a list of comments with pagination support.
///
/// This widget handles:
/// - Displaying a list of comments using CommentItem widgets
/// - Loading states with skeleton placeholders
/// - Empty states when no comments are available
/// - Pagination with "Load More" functionality
/// - Error states with retry options
class CommentList extends StatelessWidget {
  /// The list of comments to display
  final List<MwComment> comments;

  /// Whether more comments are available to load
  final bool hasMore;

  /// Whether comments are currently being loaded
  final bool isLoading;

  /// Whether there was an error loading comments
  final bool hasError;

  /// The error message (if hasError is true)
  final String? errorMessage;

  /// Whether to show voting buttons on comments
  final bool showVoting;

  /// Whether to show entry titles (useful in comment list contexts)
  final bool showEntryTitles;

  /// Map of entry IDs to entry titles (if showEntryTitles is true)
  final Map<int, String>? entryTitles;

  /// Callback when a comment is tapped
  final void Function(MwComment comment)? onCommentTap;

  /// Callback when an author is tapped
  final void Function(MwUser author)? onAuthorTap;

  /// Callback when upvote is tapped
  final void Function(MwComment comment)? onUpvote;

  /// Callback when downvote is tapped
  final void Function(MwComment comment)? onDownvote;

  /// Callback when "Load More" is tapped
  final VoidCallback? onLoadMore;

  /// Callback when retry is tapped (for error states)
  final VoidCallback? onRetry;

  /// Custom padding for the list
  final EdgeInsetsGeometry? padding;

  /// Whether to show a separator between comments
  final bool showSeparator;

  /// The separator widget (if showSeparator is true)
  final Widget? separator;

  /// Callback when edit action is triggered from context menu
  final void Function(MwComment comment)? onEditComment;

  /// Callback when delete action is triggered from context menu
  final void Function(MwComment comment)? onDeleteComment;

  /// Callback when complain action is triggered from context menu
  final void Function(MwComment comment)? onComplainComment;

  /// Whether to show context menu on comments
  final bool showContextMenu;

  const CommentList({
    super.key,
    required this.comments,
    this.hasMore = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.showVoting = true,
    this.showEntryTitles = false,
    this.entryTitles,
    this.onCommentTap,
    this.onAuthorTap,
    this.onUpvote,
    this.onDownvote,
    this.onLoadMore,
    this.onRetry,
    this.padding,
    this.showSeparator = false,
    this.separator,
    this.onEditComment,
    this.onDeleteComment,
    this.onComplainComment,
    this.showContextMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty && !isLoading && !hasError) {
      return _buildEmptyState(context);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (comments.isNotEmpty) ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: padding,
              itemCount: comments.length,
              separatorBuilder: showSeparator
                  ? (context, index) => separator ?? const SizedBox(height: 8)
                  : (context, index) => const SizedBox.shrink(),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return CommentItem(
                  comment: comment,
                  showVoting: showVoting,
                  showEntryTitle: showEntryTitles,
                  entryTitle: _getEntryTitle(comment.entryId),
                  onTap: onCommentTap != null
                      ? () => onCommentTap!(comment)
                      : null,
                  onAuthorTap: onAuthorTap != null && comment.author != null
                      ? () => onAuthorTap!(comment.author!)
                      : null,
                  onUpvote: onUpvote != null ? () => onUpvote!(comment) : null,
                  onDownvote: onDownvote != null
                      ? () => onDownvote!(comment)
                      : null,
                  onEdit: onEditComment != null
                      ? () => onEditComment!(comment)
                      : null,
                  onDelete: onDeleteComment != null
                      ? () => onDeleteComment!(comment)
                      : null,
                  showContextMenu: showContextMenu,
                );
              },
            ),
            if (hasMore || isLoading) ...[
              const SizedBox(height: 16),
              _buildLoadMoreSection(context),
            ],
          ],
          if (isLoading && comments.isEmpty) ...[_buildLoadingState(context)],
          if (hasError) ...[_buildErrorState(context)],
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.comment_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.noComments ?? 'No comments yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first to share your thoughts!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(
          3, // Show 3 skeleton comments
          (index) => _buildSkeletonComment(context),
        ),
      ),
    );
  }

  Widget _buildSkeletonComment(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SkeletonAvatar(size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoader(
                      child: Container(
                        height: 16,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SkeletonLoader(
                      child: Container(
                        height: 14,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const SkeletonText(lines: 2),
          const SizedBox(height: 12),
          Row(
            children: [
              SkeletonLoader(
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SkeletonLoader(
                child: Container(
                  height: 14,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SkeletonLoader(
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SkeletonLoader(
                child: Container(
                  height: 14,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n?.loadingComments ?? 'Loading comments...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (hasMore) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            onPressed: onLoadMore,
            child: Text(l10n?.loadMoreComments ?? 'Load more comments'),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load comments',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: Text('Retry')),
          ],
        ),
      ),
    );
  }

  String? _getEntryTitle(int? entryId) {
    if (entryId == null || entryTitles == null) return null;
    return entryTitles![entryId];
  }
}
