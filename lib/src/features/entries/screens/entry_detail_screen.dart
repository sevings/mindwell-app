import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../../comments/widgets/comment_list.dart';
import '../../comments/widgets/add_comment_form.dart';
import '../providers/entry_detail_provider.dart';
import '../widgets/entry_context_menu.dart';
import '../widgets/adjacent_entry_navigation.dart';
import 'image_gallery_screen.dart';

/// Screen that displays a single entry in detail with comments and interaction options.
/// 
/// This screen uses a CustomScrollView with SliverAppBar for a modern, collapsible
/// header effect. It displays the full entry content, author information, images,
/// tags, and comments with voting and favoriting capabilities.
class EntryDetailScreen extends ConsumerStatefulWidget {
  /// The ID of the entry to display
  final int entryId;
  
  /// Whether this is a preview mode (showing a draft entry)
  final bool isPreview;

  const EntryDetailScreen({
    super.key,
    required this.entryId,
    this.isPreview = false,
  });

  @override
  ConsumerState<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends ConsumerState<EntryDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      // Load more comments when near bottom
      ref.read(entryDetailProvider(widget.entryId).notifier).loadMoreComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entryState = ref.watch(entryDetailProvider(widget.entryId));

    return Scaffold(
      body: entryState.when(
        initial: () => _buildLoadingState(context),
        loading: () => _buildLoadingState(context),
        loaded: (entry, comments, hasMoreComments, isLoadingComments, adjacentEntries) => 
          _buildLoadedState(context, l10n, entry, comments, hasMoreComments, isLoadingComments, adjacentEntries),
        error: (message, entry) => _buildErrorState(context, l10n, message, entry),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: SkeletonLoader(
              child: Container(
                height: 20,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            background: SkeletonLoader(
              child: Container(
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author info skeleton
                Row(
                  children: [
                    const SkeletonAvatar(size: 40),
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
                const SizedBox(height: 16),
                // Content skeleton
                const SkeletonText(lines: 8),
                const SizedBox(height: 16),
                // Action buttons skeleton
                Row(
                  children: [
                    SkeletonLoader(
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SkeletonLoader(
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadedState(
    BuildContext context,
    AppLocalizations? l10n,
    MwEntry entry,
    List<MwComment> comments,
    bool hasMoreComments,
    bool isLoadingComments,
    MwAdjacentEntries? adjacentEntries,
  ) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: widget.isPreview ? 240.0 : 200.0,
          pinned: true,
          actions: widget.isPreview ? [
            // In preview mode, show a back button instead of context menu
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
              tooltip: 'Back to editor',
            ),
          ] : [
            EntryContextMenu(
              entry: entry,
              onPin: () => _onPinEntry(),
              onUnpin: () => _onUnpinEntry(),
              onFollow: () => _onFollowEntry(),
              onUnfollow: () => _onUnfollowEntry(),
              onEdit: () => _onEditEntry(),
              onDelete: () => _onDeleteEntry(),
              onComplain: () => _onComplainEntry(),
              onShare: () => _onShareEntry(),
              onCopyLink: () => _onCopyLink(),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: widget.isPreview 
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              AppLocalizations.of(context)?.preview ?? 'Preview',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          entry.title ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                : Text(
                    entry.title ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            background: _buildAppBarBackground(entry),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAuthorInfo(entry),
                const SizedBox(height: 16),
                _buildEntryContent(entry),
                const SizedBox(height: 16),
                _buildActionButtons(entry),
                const SizedBox(height: 16),
                AdjacentEntryNavigation(
                  adjacentEntries: adjacentEntries,
                  onPreviousTap: () => _onAdjacentEntryTap(adjacentEntries?.older),
                  onNextTap: () => _onAdjacentEntryTap(adjacentEntries?.newer),
                ),
                const SizedBox(height: 24),
                widget.isPreview 
                    ? _buildPreviewCommentsSection()
                    : _buildCommentsSection(l10n, comments, hasMoreComments, isLoadingComments),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarBackground(MwEntry entry) {
    // If entry has images, use the first one as background
    final images = entry.images;
    if (images != null && images.isNotEmpty) {
      final firstImage = images.first;
      final imageUrl = firstImage.medium?.url ?? 
                      firstImage.small?.url ?? 
                      firstImage.thumbnail?.url ?? 
                      firstImage.large?.url;
      
      if (imageUrl != null) {
        return CachedImage(
          imageUrl: imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      }
    }
    
    // Default gradient background
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF5E3A),
            Color(0xFFFF8A65),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorInfo(MwEntry entry) {
    final author = entry.author;
    if (author == null) return const SizedBox.shrink();

    return Row(
      children: [
        CachedAvatar(
          imageUrl: _getAvatarUrl(author.avatar),
          size: 40,
          fallbackText: author.name?.isNotEmpty == true 
              ? author.name!.substring(0, 1).toUpperCase()
              : '?',
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author.name ?? 'Unknown',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (entry.createdAt != null) ...[
                const SizedBox(height: 2),
                Text(
                  _formatTimestamp(entry.createdAt!),
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

  Widget _buildEntryContent(MwEntry entry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Entry content with HTML rendering
        if (entry.content != null && entry.content!.isNotEmpty) ...[
          Html(
            data: entry.content!,
            style: {
              "body": Style(
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
                fontSize: FontSize(16),
                lineHeight: const LineHeight(1.5),
              ),
              "p": Style(
                margin: Margins.only(bottom: 12),
              ),
              "h1, h2, h3, h4, h5, h6": Style(
                margin: Margins.only(top: 16, bottom: 8),
                fontWeight: FontWeight.bold,
              ),
              "img": Style(
                width: Width(100, Unit.percent),
                height: Height.auto(),
              ),
            },
          ),
          const SizedBox(height: 16),
        ],
        
        // Images gallery
        if (entry.images != null && entry.images!.isNotEmpty) ...[
          _buildImageGallery(entry.images!.toList()),
          const SizedBox(height: 16),
        ],
        
        // Tags
        if (entry.tags != null && entry.tags!.isNotEmpty) ...[
          _buildTags(entry.tags!.toList()),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildImageGallery(List<MwImage> images) {
    if (images.length == 1) {
      final imageUrl = _getImageUrl(images.first);
      if (imageUrl != null) {
        return CachedPostImage(
          imageUrl: imageUrl,
          width: double.infinity,
          aspectRatio: 16 / 9,
          onTap: () => _openImageGallery(images, 0),
        );
      }
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl = _getImageUrl(images[index]);
        if (imageUrl != null) {
          return CachedPostImage(
            imageUrl: imageUrl,
            borderRadius: 8,
            onTap: () => _openImageGallery(images, index),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  String? _getImageUrl(MwImage image) {
    return image.medium?.url ?? 
           image.small?.url ?? 
           image.thumbnail?.url ?? 
           image.large?.url;
  }

  String? _getAvatarUrl(MwAvatar? avatar) {
    if (avatar == null) return null;
    return avatar.x92 ?? avatar.x124 ?? avatar.x42;
  }

  Widget _buildTags(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return GestureDetector(
      onTap: () => _onTagTapped(tag),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '#$tag',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(MwEntry entry) {
    final rating = entry.rating;
    final upvotes = rating?.upCount ?? 0;
    final downvotes = rating?.downCount ?? 0;
    final score = upvotes - downvotes;

    // In preview mode, disable all interactive buttons
    if (widget.isPreview) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.orange.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.visibility,
              color: Colors.orange,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)?.previewMode ?? 'Preview Mode - Interactions Disabled',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        // Vote buttons
        Row(
          children: [
            IconButton(
              onPressed: () => _onVote(true),
              icon: const Icon(Icons.thumb_up_outlined),
              tooltip: AppLocalizations.of(context)?.upvote ?? 'Upvote',
            ),
            Text(
              score.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () => _onVote(false),
              icon: const Icon(Icons.thumb_down_outlined),
              tooltip: AppLocalizations.of(context)?.downvote ?? 'Downvote',
            ),
          ],
        ),
        const SizedBox(width: 16),
        // Favorite button
        IconButton(
          onPressed: _onToggleFavorite,
          icon: const Icon(Icons.favorite_border),
          tooltip: AppLocalizations.of(context)?.favorite ?? 'Favorite',
        ),
        const Spacer(),
        // Comments count
        Row(
          children: [
            const Icon(Icons.comment_outlined, size: 16),
            const SizedBox(width: 4),
            Text(
              entry.commentCount?.toString() ?? '0',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreviewCommentsSection() {
    final l10n = AppLocalizations.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.comment_outlined,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                l10n?.comments ?? 'Comments',
                style: TextStyle(
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n?.previewModeCommentsDisabled ?? 'Comments are disabled in preview mode. Publish the entry to enable comments.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection(
    AppLocalizations? l10n,
    List<MwComment> comments,
    bool hasMoreComments,
    bool isLoadingComments,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n?.comments ?? 'Comments',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Comments list using the new CommentList widget
        CommentList(
          comments: comments,
          hasMore: hasMoreComments,
          isLoading: isLoadingComments,
          showVoting: true,
          showEntryTitles: false, // Not needed in entry detail context
          onCommentTap: (comment) => _onCommentTap(comment),
          onAuthorTap: (author) => _onAuthorTap(author),
          onUpvote: (comment) => _onCommentVote(comment, true),
          onDownvote: (comment) => _onCommentVote(comment, false),
          onLoadMore: _loadMoreComments,
          onEditComment: (comment) => _onEditComment(comment),
          onDeleteComment: (comment) => _onDeleteComment(comment),
          onComplainComment: (comment) => _onComplainComment(comment),
          showContextMenu: true,
        ),
        const SizedBox(height: 16),
        
        // Add comment form - now beneath the comment list
        AddCommentForm(
          entryId: widget.entryId,
          onCommentSubmitted: _onCommentSubmitted,
          onError: _onCommentError,
          compact: true,
        ),
      ],
    );
  }



  Widget _buildErrorState(
    BuildContext context,
    AppLocalizations? l10n,
    String message,
    MwEntry? entry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.somethingWentWrong ?? 'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(entryDetailProvider(widget.entryId).notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
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

  void _onVote(bool isUpvote) {
    ref.read(entryDetailProvider(widget.entryId).notifier).voteEntry(isUpvote);
  }

  void _onToggleFavorite() {
    ref.read(entryDetailProvider(widget.entryId).notifier).toggleFavorite();
  }

  void _onTagTapped(String tag) {
    // Navigate to tag-filtered feed
    context.push('/tags/${Uri.encodeComponent(tag)}');
  }

  void _openImageGallery(List<MwImage> images, int initialIndex) {
    final entryState = ref.read(entryDetailProvider(widget.entryId));
    final entry = entryState.maybeWhen(
      loaded: (entry, _, _, _, _) => entry,
      orElse: () => null,
    );
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageGalleryScreen(
          images: images,
          initialIndex: initialIndex,
          title: entry?.title,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  void _loadMoreComments() {
    ref.read(entryDetailProvider(widget.entryId).notifier).loadMoreComments();
  }

  void _onCommentSubmitted(String content) async {
    // Call the provider to add the comment
    final success = await ref.read(entryDetailProvider(widget.entryId).notifier).addComment(content);
    
    // Check if widget is still mounted before using context
    if (!mounted) return;
    
    final l10n = AppLocalizations.of(context);
    
    if (success) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n?.commentPostedSuccessfully ?? 'Comment posted successfully!'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n?.commentAlreadyExists ?? 'This comment already exists'),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _onCommentError(String error) {
    // Show error message to user
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${l10n?.failedToPostComment ?? 'Failed to post comment'}: $error'),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _onCommentTap(MwComment comment) {
    // In entry detail context, tapping a comment doesn't need to do anything special
    // since we're already viewing the entry. Could be used for highlighting or other features.
  }

  void _onAuthorTap(MwUser author) {
    // TODO: Navigate to user profile
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigate to ${author.name ?? 'Unknown'}\'s profile')),
    );
  }

  void _onCommentVote(MwComment comment, bool isUpvote) {
    if (comment.id != null) {
      ref.read(entryDetailProvider(widget.entryId).notifier).voteComment(comment.id!, isUpvote);
    }
  }

  void _onPinEntry() {
    ref.read(entryDetailProvider(widget.entryId).notifier).pinEntry();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.entryPinned ?? 'Entry pinned'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onUnpinEntry() {
    ref.read(entryDetailProvider(widget.entryId).notifier).unpinEntry();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.entryUnpinned ?? 'Entry unpinned'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onFollowEntry() {
    ref.read(entryDetailProvider(widget.entryId).notifier).followEntry();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.entryFollowed ?? 'Now following this entry'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onUnfollowEntry() {
    ref.read(entryDetailProvider(widget.entryId).notifier).unfollowEntry();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.entryUnfollowed ?? 'No longer following this entry'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onEditEntry() {
    // TODO: Navigate to entry editor
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to entry editor')),
    );
  }

  void _onDeleteEntry() {
    ref.read(entryDetailProvider(widget.entryId).notifier).deleteEntry();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.entryDeleted ?? 'Entry deleted successfully'),
        duration: const Duration(seconds: 2),
      ),
    );
    // TODO: Navigate back or show deleted state
  }

  void _onComplainEntry() {
    ref.read(entryDetailProvider(widget.entryId).notifier).complainEntry();
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.complaintSubmitted ?? 'Complaint submitted successfully'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onShareEntry() {
    // TODO: Implement sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share entry functionality')),
    );
  }

  void _onCopyLink() {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.linkCopied ?? 'Link copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onEditComment(MwComment comment) {
    // TODO: Implement comment editing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit comment functionality')),
    );
  }

  void _onDeleteComment(MwComment comment) {
    if (comment.id != null) {
      ref.read(entryDetailProvider(widget.entryId).notifier).deleteComment(comment.id!);
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n?.commentDeleted ?? 'Comment deleted successfully'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _onComplainComment(MwComment comment) {
    if (comment.id != null) {
      ref.read(entryDetailProvider(widget.entryId).notifier).complainComment(comment.id!);
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n?.complaintSubmitted ?? 'Complaint submitted successfully'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Handle navigation to an adjacent entry.
  void _onAdjacentEntryTap(MwCalendarEntry? entry) {
    if (entry?.id != null) {
      // Navigate to the adjacent entry detail screen
      context.push('/entries/${entry!.id}');
    }
  }
}
