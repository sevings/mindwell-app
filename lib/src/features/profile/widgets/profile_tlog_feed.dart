import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../../entries/widgets/entry_card_full.dart';
import '../providers/profile_provider.dart';

/// A widget that displays a user's entry feed for the desktop layout.
/// 
/// This widget:
/// - Displays a list of entries from the user's tlog
/// - Supports infinite scrolling to load more entries
/// - Uses EntryCardFull widgets to display each entry
/// - Shows loading indicators and handles empty states
/// - Implements pull-to-refresh functionality
class ProfileTlogFeed extends ConsumerStatefulWidget {
  /// The username of the user whose tlog to display
  final String username;
  
  /// Whether to enable pull-to-refresh
  final bool enablePullToRefresh;
  
  /// Whether to enable infinite scrolling
  final bool enableInfiniteScroll;
  
  /// The number of entries to load before the end to trigger loading more
  final int loadMoreThreshold;

  const ProfileTlogFeed({
    super.key,
    required this.username,
    this.enablePullToRefresh = true,
    this.enableInfiniteScroll = true,
    this.loadMoreThreshold = 3,
  });

  @override
  ConsumerState<ProfileTlogFeed> createState() => _ProfileTlogFeedState();
}

class _ProfileTlogFeedState extends ConsumerState<ProfileTlogFeed> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    
    // Set up infinite scrolling
    if (widget.enableInfiniteScroll) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      await ref.read(profileProvider(widget.username).notifier).fetchNextTlogPage();
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
    await ref.read(profileProvider(widget.username).notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider(widget.username));
    
    return profileState.when(
      initial: () => _buildLoadingState(),
      loading: () => _buildLoadingState(),
      loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) => 
          _buildLoadedState(entries, hasMoreEntries),
      error: (message) => _buildErrorState(message),
    );
  }

  /// Builds the loading state with skeleton loaders
  Widget _buildLoadingState() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: MindwellSpacing.sm),
      itemCount: 5, // Show 5 skeleton items
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  /// Builds the loaded state with actual entries
  Widget _buildLoadedState(List<MwEntry> entries, bool hasMoreEntries) {
    Widget content = ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: MindwellSpacing.sm),
      itemCount: entries.length + (hasMoreEntries ? 1 : 0), // +1 for loading indicator
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
  Widget _buildErrorState(String message) {
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
                ref.read(profileProvider(widget.username).notifier).fetchProfileData();
              },
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a skeleton card for loading state
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
}
