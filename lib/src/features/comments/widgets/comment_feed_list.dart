import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../providers/comment_feed_provider.dart';
import 'comment_card.dart';

/// A widget that displays a list of comments in a feed format.
/// 
/// This widget:
/// - Watches the [commentFeedProvider] and displays the list of comments
/// - Uses [ListView.builder] for efficient rendering
/// - Implements infinite scrolling by calling [fetchMoreComments] when the user nears the end
/// - Implements pull-to-refresh functionality
/// - Shows [SkeletonLoader] widgets while loading
/// - Handles error and empty states appropriately
class CommentFeedList extends ConsumerStatefulWidget {
  /// The username to fetch comments for
  final String username;
  
  /// Whether to enable pull-to-refresh
  final bool enablePullToRefresh;
  
  /// Whether to enable infinite scrolling
  final bool enableInfiniteScroll;
  
  /// The number of comments to load before the end to trigger loading more
  final int loadMoreThreshold;
  
  /// Custom padding for the list
  final EdgeInsetsGeometry? padding;

  const CommentFeedList({
    super.key,
    required this.username,
    this.enablePullToRefresh = true,
    this.enableInfiniteScroll = true,
    this.loadMoreThreshold = 3,
    this.padding,
  });

  @override
  ConsumerState<CommentFeedList> createState() => _CommentFeedListState();
}

class _CommentFeedListState extends ConsumerState<CommentFeedList> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    
    // Set up infinite scrolling
    if (widget.enableInfiniteScroll) {
      _scrollController.addListener(_onScroll);
    }
    
    // Fetch initial comments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(commentFeedProvider(widget.username).notifier).fetchInitialComments();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CommentFeedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update username if it changed
    if (widget.username != oldWidget.username) {
      // Use Future.microtask to avoid modifying providers during build
      Future.microtask(() {
        if (mounted) {
          ref.read(commentFeedProvider(widget.username).notifier).fetchInitialComments();
        }
      });
    }
  }

  /// Handles scroll events for infinite scrolling
  void _onScroll() {
    if (!widget.enableInfiniteScroll || _isLoadingMore) return;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = maxScroll - currentScroll;
    
    // Trigger loading more when user is near the end
    if (delta < 200) {
      _loadMoreComments();
    }
  }

  /// Loads more comments for infinite scrolling
  Future<void> _loadMoreComments() async {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });
    
    try {
      await ref.read(commentFeedProvider(widget.username).notifier).fetchMoreComments();
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  /// Handles pull-to-refresh
  Future<void> _onRefresh() async {
    await ref.read(commentFeedProvider(widget.username).notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(commentFeedProvider(widget.username));
    
    return feedState.when(
      initial: () => _buildLoadingState(),
      loading: () => _buildLoadingState(),
      loaded: (comments, hasMore, isFetchingMore) => _buildLoadedState(comments, hasMore, isFetchingMore),
      error: (message, comments) => _buildErrorState(message, comments),
      empty: () => _buildEmptyState(),
    );
  }

  /// Builds the loading state with skeleton loaders
  Widget _buildLoadingState() {
    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: MindwellSpacing.sm),
      itemCount: 5, // Show 5 skeleton items
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  /// Builds the loaded state with actual comments
  Widget _buildLoadedState(List<MwComment> comments, bool hasMore, bool isFetchingMore) {
    Widget content = ListView.builder(
      controller: _scrollController,
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: MindwellSpacing.sm),
      itemCount: comments.length + (hasMore ? 1 : 0), // +1 for loading indicator
      itemBuilder: (context, index) {
        if (index >= comments.length) {
          // Show loading indicator at the end
          return _buildLoadingMoreIndicator();
        }
        
        final comment = comments[index];
        return CommentCard(
          key: ValueKey('comment_${comment.id}'),
          comment: comment,
        );
      },
    );

    // Wrap with RefreshIndicator if pull-to-refresh is enabled
    if (widget.enablePullToRefresh) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: content,
      );
    }

    return content;
  }

  /// Builds the error state
  Widget _buildErrorState(String message, List<MwComment>? comments) {
    if (comments != null && comments.isNotEmpty) {
      // Show cached comments with error banner
      return Column(
        children: [
          _buildErrorBanner(message),
          Expanded(
            child: _buildLoadedState(comments, false, false),
          ),
        ],
      );
    }

    // Show full error state
    return Center(
      child: Padding(
        padding: EdgeInsets.all(MindwellSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.0,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: MindwellSpacing.md),
            Text(
              'Ошибка загрузки',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MindwellSpacing.sm),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MindwellSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(commentFeedProvider(widget.username).notifier).fetchInitialComments();
              },
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the empty state
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(MindwellSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.comment_outlined,
              size: 64.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: MindwellSpacing.md),
            Text(
              'Нет комментариев',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MindwellSpacing.sm),
            Text(
              'У этого пользователя пока нет комментариев.\nПопробуйте обновить или зайти позже.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MindwellSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(commentFeedProvider(widget.username).notifier).refresh();
              },
              child: const Text('Обновить'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a skeleton card for loading state
  Widget _buildSkeletonCard() {
    return SkeletonLoader(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MindwellSpacing.sm,
          vertical: MindwellSpacing.sm,
        ),
        padding: EdgeInsets.all(MindwellSpacing.md),
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
            // Header skeleton
            Row(
              children: [
                SkeletonAvatar(size: 40.0),
                SizedBox(width: MindwellSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonText(
                        lines: 1,
                        lineHeight: 16.0,
                        lineWidths: [0.6],
                      ),
                      SizedBox(height: 4.0),
                      SkeletonText(
                        lines: 1,
                        lineHeight: 12.0,
                        lineWidths: [0.4],
                      ),
                    ],
                  ),
                ),
                SkeletonBox(
                  width: 16.0,
                  height: 16.0,
                  borderRadius: 8.0,
                ),
              ],
            ),
            SizedBox(height: MindwellSpacing.md),
            // Entry title skeleton
            SkeletonBox(
              width: 120.0,
              height: 24.0,
              borderRadius: 8.0,
            ),
            SizedBox(height: MindwellSpacing.sm),
            // Content skeleton
            SkeletonText(
              lines: 3,
              lineHeight: 16.0,
              lineSpacing: 4.0,
              lineWidths: [1.0, 0.9, 0.7],
            ),
            SizedBox(height: MindwellSpacing.md),
            // Footer skeleton
            Row(
              children: [
                SkeletonBox(
                  width: 60.0,
                  height: 24.0,
                  borderRadius: 6.0,
                ),
                SizedBox(width: MindwellSpacing.sm),
                SkeletonBox(
                  width: 60.0,
                  height: 24.0,
                  borderRadius: 6.0,
                ),
                const Spacer(),
                SkeletonBox(
                  width: 80.0,
                  height: 16.0,
                  borderRadius: 8.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the loading more indicator at the bottom of the list
  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(MindwellSpacing.md),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SizedBox(width: MindwellSpacing.sm),
            Text(
              'Загрузка...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an error banner for when there are cached comments but an error occurred
  Widget _buildErrorBanner(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(MindwellSpacing.md),
      margin: EdgeInsets.all(MindwellSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_outlined,
            color: Theme.of(context).colorScheme.onErrorContainer,
            size: 20.0,
          ),
          SizedBox(width: MindwellSpacing.sm),
          Expanded(
            child: Text(
              'Показаны сохранённые комментарии. $message',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(commentFeedProvider(widget.username).notifier).refresh();
            },
            child: Text(
              'Обновить',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
