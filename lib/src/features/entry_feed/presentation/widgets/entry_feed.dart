import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../domain/entities/entry.dart';
import '../../domain/entities/entry_feed_state.dart';
import '../providers/entry_feed_providers.dart';
import 'entry_card_short.dart';
import 'entry_card_full.dart';

class EntryFeed extends ConsumerStatefulWidget {
  final FeedType feedType;
  final String? username;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  const EntryFeed({
    super.key,
    required this.feedType,
    this.username,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
  });

  @override
  ConsumerState<EntryFeed> createState() => _EntryFeedState();
}

class _EntryFeedState extends ConsumerState<EntryFeed> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
    
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _loadInitialData() {
    final provider = _getFeedProvider();
    ref.read(provider.notifier).loadFeed();
  }

  StateNotifierProvider<EntryFeedNotifier, EntryFeedState> _getFeedProvider() {
    return ref.read(feedProviderSelector((widget.feedType, widget.username)));
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const threshold = 200; // Load more when 200px from bottom

    if (currentScroll >= (maxScroll - threshold)) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });

    final provider = _getFeedProvider();
    await ref.read(provider.notifier).loadMore();

    if (mounted) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    final provider = _getFeedProvider();
    await ref.read(provider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final provider = _getFeedProvider();
    final feedState = ref.watch(provider);
    final settings = ref.watch(feedSettingsProvider(widget.feedType));

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: feedState.when(
        loading: () => _buildLoadingState(),
        loaded: (entries, isFetchingMore, hasMore, settings, currentPage) =>
            _buildLoadedState(entries, isFetchingMore, hasMore, settings),
        error: (message, previousEntries, settings) =>
            _buildErrorState(message, previousEntries, settings),
      ),
    );
  }

  Widget _buildLoadingState() {
    return CustomScrollView(
      controller: _scrollController,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      slivers: [
        SliverToBoxAdapter(
          child: _buildShimmerLoading(),
        ),
      ],
    );
  }

  Widget _buildLoadedState(
    List<Entry> entries,
    bool isFetchingMore,
    bool hasMore,
    FeedSettings settings,
  ) {
    if (entries.isEmpty) {
      return _buildEmptyState();
    }

    return CustomScrollView(
      controller: _scrollController,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      slivers: [
        if (settings.displayFormat == DisplayFormat.short)
          _buildMasonryGrid(entries)
        else
          _buildSingleColumnList(entries),
        
        // Loading more indicator
        if (isFetchingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        
        // Bottom padding
        const SliverToBoxAdapter(
          child: SizedBox(height: 80), // Account for FAB
        ),
      ],
    );
  }

  Widget _buildErrorState(
    String message,
    List<Entry>? previousEntries,
    FeedSettings? settings,
  ) {
    // If we have previous entries, show them with an error banner
    if (previousEntries != null && previousEntries.isNotEmpty) {
      return CustomScrollView(
        controller: _scrollController,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        slivers: [
          // Error banner
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.errorContainer,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onRefresh,
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Previous entries
          if (settings?.displayFormat == DisplayFormat.short)
            _buildMasonryGrid(previousEntries)
          else
            _buildSingleColumnList(previousEntries),
        ],
      );
    }

    // Full error state
    return CustomScrollView(
      controller: _scrollController,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'Oops! Something went wrong',
                  style: Theme.of(context).textTheme.headlineSmall,
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
                FilledButton(
                  onPressed: _onRefresh,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return CustomScrollView(
      controller: _scrollController,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No entries yet',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  _getEmptyStateMessage(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getEmptyStateMessage() {
    return switch (widget.feedType) {
      FeedType.live => 'Be the first to share your thoughts!',
      FeedType.best => 'No highly-rated entries found.',
      FeedType.followings => 'Follow some users to see their entries here.',
      FeedType.profile => 'This user hasn\'t posted any entries yet.',
    };
  }

  Widget _buildMasonryGrid(List<Entry> entries) {
    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return _buildEntryCard(entry, isShort: true);
      },
    );
  }

  Widget _buildSingleColumnList(List<Entry> entries) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final entry = entries[index];
          return _buildEntryCard(entry, isShort: false);
        },
        childCount: entries.length,
      ),
    );
  }

  Widget _buildEntryCard(Entry entry, {required bool isShort}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (50 * (entry.id % 10))),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: isShort
          ? EntryCardShort(
              entry: entry,
              onTap: () => _onEntryTap(entry),
              onAuthorTap: () => _onAuthorTap(entry.author),
              onVote: () => _onVote(entry),
              onBookmark: () => _onBookmark(entry),
            )
          : EntryCardFull(
              entry: entry,
              onTap: () => _onEntryTap(entry),
              onAuthorTap: () => _onAuthorTap(entry.author),
              onVote: () => _onVote(entry),
              onBookmark: () => _onBookmark(entry),
            ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildShimmerCard(),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author row
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Title
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            
            // Content lines
            Container(
              width: double.infinity,
              height: 14,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 14,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEntryTap(Entry entry) {
    // TODO: Navigate to entry detail screen
    // context.go('/entries/${entry.id}');
    print('Entry tapped: ${entry.id}');
  }

  void _onAuthorTap(User author) {
    // TODO: Navigate to author profile screen
    // context.go('/users/${author.name}');
    print('Author tapped: ${author.name}');
  }

  void _onVote(Entry entry) {
    final provider = _getFeedProvider();
    // TODO: Implement voting functionality
    print('Vote entry: ${entry.id}');
  }

  void _onBookmark(Entry entry) {
    final provider = _getFeedProvider();
    // TODO: Implement bookmark functionality
    print('Bookmark entry: ${entry.id}');
  }
}