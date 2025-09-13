import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';
import '../models/feed_type.dart';
import '../widgets/entry_list.dart';
import '../widgets/feed_settings_bottom_sheet.dart';

/// The main screen for the entry feed with tabbed navigation for different feed types.
/// 
/// This screen features:
/// - A [SliverAppBar] with the app title
/// - A [TabBar] for different feed types (Live, Best, etc.)
/// - A [TabBarView] containing [EntryList] widgets for each feed type
/// - A [FloatingActionButton] to navigate to the entry editor
/// - A menu button to open the [FeedSettingsBottomSheet]
class EntryFeedScreen extends ConsumerStatefulWidget {
  const EntryFeedScreen({super.key});

  @override
  ConsumerState<EntryFeedScreen> createState() => _EntryFeedScreenState();
}

class _EntryFeedScreenState extends ConsumerState<EntryFeedScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  // Available feed types for the tabs
  final List<FeedType> _feedTypes = [
    FeedType.live,
    FeedType.best,
    FeedType.friends,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _feedTypes.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    // Check if we're within a shell route (HomeScreen) by looking for a Scaffold ancestor
    final scaffoldAncestor = context.findAncestorWidgetOfExactType<Scaffold>();
    final isWithinShellRoute = scaffoldAncestor != null;
    
    final content = NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  l10n?.appTitle ?? 'Mindwell',
                  style: const TextStyle(
                    color: Color(0xFFFF5E3A),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                background: Container(
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
                  child: const Center(
                    child: Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              actions: [
                // Settings button
                IconButton(
                  onPressed: _showFeedSettings,
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Color(0xFFFF5E3A),
                  ),
                ),
                // Menu button for additional options
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color(0xFFFF5E3A),
                  ),
                  onSelected: _handleMenuSelection,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'refresh',
                      child: Row(
                        children: [
                          const Icon(Icons.refresh),
                          const SizedBox(width: MindwellSpacing.sm),
                          Text('Refresh'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'my_entries',
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: MindwellSpacing.sm),
                          Text(l10n?.myEntries ?? 'My Entries'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'themes',
                      child: Row(
                        children: [
                          const Icon(Icons.category),
                          const SizedBox(width: MindwellSpacing.sm),
                          Text(l10n?.themes ?? 'Themes'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: const Color(0xFFFF5E3A),
                  indicatorWeight: 3,
                  labelColor: const Color(0xFFFF5E3A),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  tabs: _feedTypes.map((feedType) {
                    return Tab(
                      text: _getFeedTypeDisplayName(feedType, l10n),
                    );
                  }).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _feedTypes.map((feedType) {
            return EntryList(
              key: ValueKey('${feedType.name}_${_tabController.index}'),
              feedType: feedType,
              enablePullToRefresh: true,
              enableInfiniteScroll: true,
            );
          }).toList(),
        ),
      );
    
    // Conditionally wrap with Scaffold based on whether we're within a shell route
    if (isWithinShellRoute) {
      return content;
    } else {
      return Scaffold(
        body: content,
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToEntryEditor,
          backgroundColor: const Color(0xFFFF5E3A),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  /// Get the localized display name for a feed type
  String _getFeedTypeDisplayName(FeedType feedType, AppLocalizations? l10n) {
    switch (feedType) {
      case FeedType.live:
        return l10n?.live ?? 'Live';
      case FeedType.best:
        return l10n?.best ?? 'Best';
      case FeedType.friends:
        return l10n?.subscriptions ?? 'Friends';
      case FeedType.profile:
        return l10n?.myEntries ?? 'Profile';
      case FeedType.theme:
        return l10n?.themes ?? 'Themes';
    }
  }

  /// Show the feed settings bottom sheet
  void _showFeedSettings() {
    final currentFeedType = _feedTypes[_tabController.index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FeedSettingsBottomSheet(
        feedType: currentFeedType,
      ),
    );
  }

  /// Handle menu item selection
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'refresh':
        _refreshCurrentFeed();
        break;
      case 'my_entries':
        _navigateToMyEntries();
        break;
      case 'themes':
        _navigateToThemes();
        break;
    }
  }

  /// Refresh the current active feed
  void _refreshCurrentFeed() {
    final currentFeedType = _feedTypes[_tabController.index];
    // TODO: Implement refresh logic when provider is available
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Refreshing ${_getFeedTypeDisplayName(currentFeedType, AppLocalizations.of(context))} feed...'),
        backgroundColor: const Color(0xFFFF5E3A),
      ),
    );
  }

  /// Navigate to the entry editor
  void _navigateToEntryEditor() {
    context.push('/entries/new');
  }

  /// Navigate to my entries
  void _navigateToMyEntries() {
    context.push('/profile');
  }

  /// Navigate to themes
  void _navigateToThemes() {
    // TODO: Implement themes navigation when available
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Themes feature coming soon!'),
        backgroundColor: Color(0xFFFF5E3A),
      ),
    );
  }
}

/// A custom delegate for the persistent header that contains the TabBar
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}
