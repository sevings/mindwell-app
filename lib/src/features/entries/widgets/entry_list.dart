import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../models/feed_type.dart';
import '../models/feed_settings.dart';
import '../providers/entry_feed_provider.dart';
import 'entry_card_full.dart';
import 'entry_card_short.dart';

/// A widget that displays a list of entries in different formats.
/// 
/// This widget:
/// - Takes a [FeedType] and displays the correct list format
/// - Watches the [entryFeedProvider] and displays the list of entries
/// - Uses [ListView.builder] for the full format
/// - Uses [MasonryGridView] for the short format (masonry layout)
/// - Implements infinite scrolling by calling [fetchMoreEntries] when the user nears the end
/// - Implements pull-to-refresh
/// - Shows [SkeletonLoader] widgets while loading
class EntryList extends ConsumerStatefulWidget {
  /// The type of feed to display
  final FeedType feedType;
  
  /// Optional parameter for profile/theme feeds (e.g., user ID, theme ID)
  final String? feedParameter;
  
  /// Whether to enable pull-to-refresh
  final bool enablePullToRefresh;
  
  /// Whether to enable infinite scrolling
  final bool enableInfiniteScroll;
  
  /// The number of entries to load before the end to trigger loading more
  final int loadMoreThreshold;

  const EntryList({
    super.key,
    required this.feedType,
    this.feedParameter,
    this.enablePullToRefresh = true,
    this.enableInfiniteScroll = true,
    this.loadMoreThreshold = 3,
  });

  @override
  ConsumerState<EntryList> createState() => _EntryListState();
}

class _EntryListState extends ConsumerState<EntryList> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    
    // Set up infinite scrolling
    if (widget.enableInfiniteScroll) {
      _scrollController.addListener(_onScroll);
    }
    
    // Set feed parameter if provided
    if (widget.feedParameter != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier = ref.read(entryFeedProvider(widget.feedType).notifier);
        notifier.setFeedParameter(widget.feedParameter);
      });
    }
    
    // Fetch initial entries
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(entryFeedProvider(widget.feedType).notifier).fetchInitialEntries();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(EntryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update feed parameter if it changed
    if (widget.feedParameter != oldWidget.feedParameter) {
      final notifier = ref.read(entryFeedProvider(widget.feedType).notifier);
      notifier.setFeedParameter(widget.feedParameter);
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
      _loadMoreEntries();
    }
  }

  /// Loads more entries for infinite scrolling
  Future<void> _loadMoreEntries() async {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });
    
    try {
      await ref.read(entryFeedProvider(widget.feedType).notifier).fetchMoreEntries();
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
    await ref.read(entryFeedProvider(widget.feedType).notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(entryFeedProvider(widget.feedType));
    
    return feedState.when(
      initial: () => _buildLoadingState(),
      loading: () => _buildLoadingState(),
      loaded: (entries, hasMore, settings) => _buildLoadedState(entries, hasMore),
      error: (message, entries) => _buildErrorState(message, entries),
      empty: () => _buildEmptyState(),
    );
  }

  /// Builds the loading state with skeleton loaders
  Widget _buildLoadingState() {
    final feedState = ref.read(entryFeedProvider(widget.feedType));
    
    // Determine display format from feed state (default to full for loading)
    DisplayFormat displayFormat = DisplayFormat.full;
    feedState.when(
      initial: () {},
      loading: () {},
      loaded: (entries, hasMore, settings) => displayFormat = settings.displayFormat,
      error: (message, entries) {},
      empty: () {},
    );
    
    if (displayFormat == DisplayFormat.short) {
      return _buildShortFormatSkeletonGrid();
    } else {
      return _buildFullFormatSkeletonList();
    }
  }

  /// Builds the full format skeleton loading list
  Widget _buildFullFormatSkeletonList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: MindwellSpacing.sm),
      itemCount: 5, // Show 5 skeleton items
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  /// Builds the short format skeleton loading grid
  Widget _buildShortFormatSkeletonGrid() {
    final skeletonCount = _getCrossAxisCount() * 3; // 3 rows of skeletons
    
    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: _getCrossAxisCount(),
      mainAxisSpacing: MindwellSpacing.xs,
      crossAxisSpacing: MindwellSpacing.xs,
      padding: EdgeInsets.symmetric(
        horizontal: MindwellSpacing.sm,
        vertical: MindwellSpacing.sm,
      ),
      itemCount: skeletonCount,
      itemBuilder: (context, index) => _buildSkeletonCardShort(),
    );
  }

  /// Builds the loaded state with actual entries
  Widget _buildLoadedState(List<MwEntry> entries, bool hasMore) {
    final feedState = ref.read(entryFeedProvider(widget.feedType));
    
    // Determine display format from feed state
    DisplayFormat displayFormat = DisplayFormat.full; // default
    feedState.when(
      initial: () {},
      loading: () {},
      loaded: (entries, hasMore, settings) => displayFormat = settings.displayFormat,
      error: (message, entries) {},
      empty: () {},
    );
    
    Widget content;
    
    if (displayFormat == DisplayFormat.short) {
      content = _buildShortFormatGrid(entries, hasMore);
    } else {
      content = _buildFullFormatList(entries, hasMore);
    }

    // Wrap with RefreshIndicator if pull-to-refresh is enabled
    if (widget.enablePullToRefresh) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: content,
      );
    }

    return content;
  }

  /// Builds the full format list view
  Widget _buildFullFormatList(List<MwEntry> entries, bool hasMore) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: MindwellSpacing.sm),
      itemCount: entries.length + (hasMore ? 1 : 0), // +1 for loading indicator
      itemBuilder: (context, index) {
        if (index >= entries.length) {
          // Show loading indicator at the end
          return _buildLoadingMoreIndicator();
        }
        
        final entry = entries[index];
        return EntryCardFull(
          key: ValueKey('entry_${entry.id}'),
          entry: entry,
        );
      },
    );
  }

  /// Builds the short format masonry grid view
  Widget _buildShortFormatGrid(List<MwEntry> entries, bool hasMore) {
    final items = <Widget>[];
    
    // Add entry cards
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      items.add(
        EntryCardShort(
          key: ValueKey('entry_${entry.id}'),
          entry: entry,
        ),
      );
    }
    
    // Add loading indicator if there are more entries
    if (hasMore) {
      items.add(_buildLoadingMoreIndicator());
    }
    
    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: _getCrossAxisCount(),
      mainAxisSpacing: MindwellSpacing.xs,
      crossAxisSpacing: MindwellSpacing.xs,
      padding: EdgeInsets.symmetric(
        horizontal: MindwellSpacing.sm,
        vertical: MindwellSpacing.sm,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }

  /// Determines the number of columns for the masonry grid based on screen width
  int _getCrossAxisCount() {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) return 4; // Large screens
    if (screenWidth > 800) return 3;  // Medium screens
    if (screenWidth > 600) return 2;  // Small tablets
    return 1; // Mobile phones
  }

  /// Builds the error state
  Widget _buildErrorState(String message, List<MwEntry>? entries) {
    if (entries != null && entries.isNotEmpty) {
      // Show cached entries with error banner
      return Column(
        children: [
          _buildErrorBanner(message),
          Expanded(
            child: _buildLoadedState(entries, false),
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
                ref.read(entryFeedProvider(widget.feedType).notifier).fetchInitialEntries();
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
              Icons.article_outlined,
              size: 64.0,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: MindwellSpacing.md),
            Text(
              'Нет записей',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MindwellSpacing.sm),
            Text(
              'В этой ленте пока нет записей.\nПопробуйте обновить или зайти позже.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MindwellSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(entryFeedProvider(widget.feedType).notifier).refresh();
              },
              child: const Text('Обновить'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a skeleton card for loading state (full format)
  Widget _buildSkeletonCard() {
    return SkeletonLoader(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: MindwellSpacing.sm,
          vertical: MindwellSpacing.sm,
        ),
        child: Padding(
          padding: EdgeInsets.all(MindwellSpacing.md),
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
                ],
              ),
              SizedBox(height: MindwellSpacing.md),
              // Content skeleton
              SkeletonText(
                lines: 1,
                lineHeight: 20.0,
                lineWidths: [0.8],
              ),
              SizedBox(height: 8.0),
              SkeletonText(
                lines: 4,
                lineHeight: 16.0,
                lineSpacing: 4.0,
                lineWidths: [1.0, 1.0, 0.9, 0.7],
              ),
              SizedBox(height: MindwellSpacing.md),
              // Footer skeleton
              Row(
                children: [
                  SkeletonBox(
                    width: 80.0,
                    height: 32.0,
                    borderRadius: 16.0,
                  ),
                  SizedBox(width: MindwellSpacing.sm),
                  SkeletonBox(
                    width: 80.0,
                    height: 32.0,
                    borderRadius: 16.0,
                  ),
                  const Spacer(),
                  SkeletonBox(
                    width: 32.0,
                    height: 32.0,
                    borderRadius: 16.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a skeleton card for loading state (short format)
  Widget _buildSkeletonCardShort() {
    return SkeletonLoader(
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(MindwellSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header skeleton
              Row(
                children: [
                  SkeletonAvatar(size: 32.0),
                  SizedBox(width: MindwellSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonText(
                          lines: 1,
                          lineHeight: 14.0,
                          lineWidths: [0.6],
                        ),
                        SizedBox(height: 2.0),
                        SkeletonText(
                          lines: 1,
                          lineHeight: 10.0,
                          lineWidths: [0.4],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MindwellSpacing.sm),
              // Title skeleton
              SkeletonText(
                lines: 1,
                lineHeight: 16.0,
                lineWidths: [0.8],
              ),
              SizedBox(height: 4.0),
              // Content skeleton (shorter for short format)
              SkeletonText(
                lines: 2,
                lineHeight: 14.0,
                lineSpacing: 2.0,
                lineWidths: [1.0, 0.8],
              ),
              SizedBox(height: MindwellSpacing.sm),
              // Optional image skeleton (randomly show)
              if ((DateTime.now().millisecondsSinceEpoch % 3) == 0) ...[
                SkeletonBox(
                  width: double.infinity,
                  height: 120.0,
                  borderRadius: 8.0,
                ),
                SizedBox(height: MindwellSpacing.sm),
              ],
              // Footer skeleton
              Row(
                children: [
                  SkeletonBox(
                    width: 40.0,
                    height: 16.0,
                    borderRadius: 8.0,
                  ),
                  SizedBox(width: MindwellSpacing.sm),
                  SkeletonBox(
                    width: 40.0,
                    height: 16.0,
                    borderRadius: 8.0,
                  ),
                  const Spacer(),
                  SkeletonBox(
                    width: 60.0,
                    height: 16.0,
                    borderRadius: 8.0,
                  ),
                ],
              ),
            ],
          ),
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

  /// Builds an error banner for when there are cached entries but an error occurred
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
              'Показаны сохранённые записи. $message',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(entryFeedProvider(widget.feedType).notifier).refresh();
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
