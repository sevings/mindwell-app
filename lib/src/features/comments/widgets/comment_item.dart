import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/images/cached_image.dart';

/// A widget that displays a single comment with author information, content, and voting options.
/// 
/// This widget is designed to be reusable across different screens that need to display comments,
/// such as the entry detail screen, comment list screen, or user profile screen.
class CommentItem extends StatelessWidget {
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
  final VoidCallback? onUpvote;
  
  /// Callback when downvote is tapped
  final VoidCallback? onDownvote;
  
  /// Whether the comment is currently being voted on (for optimistic UI)
  final bool isVoting;
  
  /// Custom padding for the comment
  final EdgeInsetsGeometry? padding;
  
  /// Custom margin for the comment
  final EdgeInsetsGeometry? margin;

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
  });

  @override
  Widget build(BuildContext context) {
    final author = comment.author;
    if (author == null) return const SizedBox.shrink();

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, author),
                if (showEntryTitle && entryTitle != null) ...[
                  const SizedBox(height: 8),
                  _buildEntryTitle(context),
                ],
                const SizedBox(height: 12),
                _buildContent(context),
                if (showVoting && comment.rating != null) ...[
                  const SizedBox(height: 12),
                  _buildVotingSection(context),
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
          onTap: onAuthorTap,
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
                onTap: onAuthorTap,
                child: Text(
                  author.name ?? 'Unknown',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
      ],
    );
  }

  Widget _buildEntryTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
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

  Widget _buildContent(BuildContext context) {
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

    return Html(
      data: content,
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(14),
          lineHeight: const LineHeight(1.4),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        "p": Style(
          margin: Margins.only(bottom: 8),
        ),
        "a": Style(
          color: Theme.of(context).colorScheme.primary,
          textDecoration: TextDecoration.underline,
        ),
        "strong": Style(
          fontWeight: FontWeight.bold,
        ),
        "em": Style(
          fontStyle: FontStyle.italic,
        ),
        "code": Style(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
          fontFamily: 'monospace',
        ),
        "pre": Style(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          padding: HtmlPaddings.all(8),
          fontFamily: 'monospace',
          whiteSpace: WhiteSpace.pre,
        ),
      },
    );
  }

  Widget _buildVotingSection(BuildContext context) {
    final rating = comment.rating!;
    final upvotes = rating.upCount ?? 0;
    final downvotes = rating.downCount ?? 0;

    return Row(
      children: [
        // Upvote button
        IconButton(
          onPressed: isVoting ? null : onUpvote,
          icon: Icon(
            Icons.thumb_up_outlined,
            size: 16,
            color: isVoting 
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.onSurface,
          ),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          padding: EdgeInsets.zero,
          tooltip: AppLocalizations.of(context)?.upvote ?? 'Upvote',
        ),
        Text(
          upvotes.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isVoting 
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 8),
        // Downvote button
        IconButton(
          onPressed: isVoting ? null : onDownvote,
          icon: Icon(
            Icons.thumb_down_outlined,
            size: 16,
            color: isVoting 
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.onSurface,
          ),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          padding: EdgeInsets.zero,
          tooltip: AppLocalizations.of(context)?.downvote ?? 'Downvote',
        ),
        Text(
          downvotes.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isVoting 
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (isVoting) ...[
          const SizedBox(width: 8),
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
}
