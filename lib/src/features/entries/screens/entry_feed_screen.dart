import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/feed_type.dart';
import '../models/feed_tab_config.dart';
import '../providers/entry_feed_provider.dart';
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
  /// The specific feed type to display. If null, shows all feed types in tabs.
  final FeedType? feedType;
  
  /// Optional tag filter to show only entries with this tag
  final String? tagFilter;
  
  /// Optional username for profile feed type
  final String? username;
  
  const EntryFeedScreen({super.key, this.feedType, this.tagFilter, this.username});

  @override
  ConsumerState<EntryFeedScreen> createState() => _EntryFeedScreenState();
}

class _EntryFeedScreenState extends ConsumerState<EntryFeedScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  // Available feed types for the tabs (used when no specific feed type is provided)
  final List<FeedType> _feedTypes = [
    FeedType.live,
    FeedType.best,
    FeedType.friends,
  ];

  @override
  void initState() {
    super.initState();
    
    // Determine tab configuration based on feed type
    final tabConfigs = _getTabConfigurations();
    final tabLength = tabConfigs.isNotEmpty ? tabConfigs.length : _feedTypes.length;
    
    _tabController = TabController(
      length: tabLength,
      vsync: this,
    );
    
    // If a specific feed type is provided, set the initial tab
    if (widget.feedType != null) {
      if (tabConfigs.isNotEmpty) {
        // For specific feed types with tab configurations, start at index 0
        _tabController.index = 0;
      } else {
        // For feed types without specific tab configurations, use the feed types index
        final index = _feedTypes.indexOf(widget.feedType!);
        if (index != -1 && index < tabLength) {
          _tabController.index = index;
        }
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Get tab configurations based on the current feed type
  List<FeedTabConfig> _getTabConfigurations() {
    if (widget.feedType != null) {
      // For specific feed types, use their dedicated tab configurations
      switch (widget.feedType!) {
        case FeedType.live:
          return FeedTabConfigs.live;
        case FeedType.best:
          return FeedTabConfigs.best;
        case FeedType.friends:
          return FeedTabConfigs.subscriptions;
        default:
          return [];
      }
    } else {
      // For the main feed screen, return empty list to use default feed types
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    // Check if we're within a shell route (HomeScreen) by looking for a Scaffold ancestor
    final scaffoldAncestor = context.findAncestorWidgetOfExactType<Scaffold>();
    final isWithinShellRoute = scaffoldAncestor != null;
    
    // Get tab configurations for the current feed type
    final tabConfigs = _getTabConfigurations();
    
    // If a specific feed type is provided, show that feed with its specific tabs
    if (widget.feedType != null && tabConfigs.isNotEmpty) {
      return _buildSingleFeedViewWithTabs(context, l10n, isWithinShellRoute, tabConfigs);
    } else if (widget.feedType != null) {
      // If no specific tabs are configured, show single feed view
      return _buildSingleFeedView(context, l10n, isWithinShellRoute);
    }
    
    // For the main feed screen, show the default tabbed view
    
    // Get the current user ID for profile feeds in the main tabbed view
    String? currentUserFeedParameter;
    if (_feedTypes.contains(FeedType.profile)) {
      final authState = ref.read(authProvider);
      authState.maybeWhen(
        authenticated: (user) => currentUserFeedParameter = user.id?.toString(),
        orElse: () => currentUserFeedParameter = null,
      );
    }
    
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
                // Menu button for refresh option
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
                          Text(l10n?.refresh ?? 'Refresh'),
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
              key: ValueKey('${feedType.name}_${_tabController.index}_${widget.tagFilter ?? 'no_tag'}_${widget.username ?? 'no_user'}'),
              feedType: feedType,
              feedParameter: (feedType == FeedType.profile || feedType == FeedType.favorites) 
            ? (widget.username ?? currentUserFeedParameter) 
            : null,
              tagFilter: widget.tagFilter,
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
    String baseName;
    switch (feedType) {
      case FeedType.live:
        baseName = l10n?.live ?? 'Live';
        break;
      case FeedType.best:
        baseName = l10n?.best ?? 'Best';
        break;
      case FeedType.friends:
        baseName = l10n?.subscriptions ?? 'Friends';
        break;
      case FeedType.profile:
        baseName = l10n?.myEntries ?? 'Profile';
        break;
      case FeedType.theme:
        baseName = l10n?.themes ?? 'Themes';
        break;
      case FeedType.favorites:
        baseName = 'Favorites'; // TODO: Add to localization
        break;
    }
    
    // Add tag filter to the title if present
    if (widget.tagFilter != null) {
      return '#${widget.tagFilter} - $baseName';
    }
    
    return baseName;
  }

  /// Show the feed settings bottom sheet
  void _showFeedSettings() {
    // Use the actual feed type, not derived from tab index
    final currentFeedType = widget.feedType ?? _feedTypes[_tabController.index];
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
    }
  }

  /// Refresh the current active feed
  void _refreshCurrentFeed() {
    final currentFeedType = widget.feedType ?? _feedTypes[_tabController.index];
    final l10n = AppLocalizations.of(context);
    
    // Get the appropriate provider based on feed type and parameters
    // Use the same logic as the EntryList widgets to ensure we're using the same provider instance
    String? feedParameter;
    
    if (widget.feedType != null) {
      // For specific feed types with tab configurations
      final tabConfigs = _getTabConfigurations();
      if (tabConfigs.isNotEmpty && _tabController.index < tabConfigs.length) {
        // We're in a tabbed view with specific configurations
        final tabConfig = tabConfigs[_tabController.index];
        // Use the same logic as EntryList widgets
        if (currentFeedType == FeedType.profile || currentFeedType == FeedType.favorites) {
          feedParameter = widget.username;
        } else {
          feedParameter = '${widget.username ?? ''}_${tabConfig.value}';
        }
      } else {
        // For single feed view, use the same logic as EntryList widgets
        if (currentFeedType == FeedType.profile || currentFeedType == FeedType.favorites) {
          feedParameter = widget.username;
        } else {
          feedParameter = null;
        }
      }
    } else {
      // For the main feed screen with default tabs, use the same logic as EntryList widgets
      if (currentFeedType == FeedType.profile || currentFeedType == FeedType.favorites) {
        // Get the current user ID for profile feeds in the main tabbed view
        final authState = ref.read(authProvider);
        authState.maybeWhen(
          authenticated: (user) => feedParameter = user.id?.toString(),
          orElse: () => feedParameter = null,
        );
      } else {
        feedParameter = null;
      }
    }
    
    final provider = entryFeedProvider((feedType: currentFeedType, feedParameter: feedParameter));
    
    // Call refresh on the provider
    ref.read(provider.notifier).refresh();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${l10n?.refreshing ?? 'Refreshing'} ${_getFeedTypeDisplayName(currentFeedType, l10n)} ${l10n?.feed ?? 'feed'}...'),
        backgroundColor: const Color(0xFFFF5E3A),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Navigate to the entry editor
  void _navigateToEntryEditor() {
    context.push('/entries/new');
  }

  /// Build a single feed view without tabs for specific feed types
  Widget _buildSingleFeedView(BuildContext context, AppLocalizations? l10n, bool isWithinShellRoute) {
    final feedType = widget.feedType!;
    final feedTitle = _getFeedTypeDisplayName(feedType, l10n);
    
    // Get the current user ID for profile feeds
    String? feedParameter;
    if (feedType == FeedType.profile) {
      final authState = ref.read(authProvider);
      authState.maybeWhen(
        authenticated: (user) => feedParameter = user.id?.toString(),
        orElse: () => feedParameter = null,
      );
    }
    
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
                feedTitle,
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
                        Text(l10n?.refresh ?? 'Refresh'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ];
      },
      body: EntryList(
        key: ValueKey('${feedType.name}_single_${feedParameter ?? 'default'}_${widget.tagFilter ?? 'no_tag'}_${widget.username ?? 'no_user'}'),
        feedType: feedType,
        feedParameter: (feedType == FeedType.profile || feedType == FeedType.favorites) 
            ? (widget.username ?? feedParameter) 
            : null,
        tagFilter: widget.tagFilter,
        enablePullToRefresh: true,
        enableInfiniteScroll: true,
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

  /// Build a single feed view with specific tabs for the feed type
  Widget _buildSingleFeedViewWithTabs(
    BuildContext context, 
    AppLocalizations? l10n, 
    bool isWithinShellRoute,
    List<FeedTabConfig> tabConfigs,
  ) {
    final feedType = widget.feedType!;
    final feedTitle = _getFeedTypeDisplayName(feedType, l10n);
    
    // Get the current user ID for profile feeds
    String? feedParameter;
    if (feedType == FeedType.profile) {
      final authState = ref.read(authProvider);
      authState.maybeWhen(
        authenticated: (user) => feedParameter = user.id?.toString(),
        orElse: () => feedParameter = null,
      );
    }
    
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
                feedTitle,
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
                        Text(l10n?.refresh ?? 'Refresh'),
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
                tabs: tabConfigs.map((tabConfig) {
                  return Tab(
                    text: _getLocalizedTabLabel(tabConfig.label, l10n),
                  );
                }).toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: tabConfigs.map((tabConfig) {
          return EntryList(
            key: ValueKey('${feedType.name}_${tabConfig.value}_${feedParameter ?? 'default'}_${widget.tagFilter ?? 'no_tag'}_${widget.username ?? 'no_user'}'),
            feedType: feedType,
            feedParameter: (feedType == FeedType.profile || feedType == FeedType.favorites) 
                ? (widget.username ?? feedParameter) 
                : '${feedParameter ?? ''}_${tabConfig.value}',
            tagFilter: widget.tagFilter,
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

  /// Get localized tab label
  String _getLocalizedTabLabel(String labelKey, AppLocalizations? l10n) {
    switch (labelKey) {
      case 'invited':
        return l10n?.invited ?? 'Invited';
      case 'waiting':
        return l10n?.waiting ?? 'Waiting';
      case 'discussed':
        return l10n?.discussed ?? 'Discussed';
      case 'week':
        return l10n?.week ?? 'Week';
      case 'month':
        return l10n?.month ?? 'Month';
      case 'year':
        return l10n?.year ?? 'Year';
      case 'friends':
        return l10n?.friends ?? 'Friends';
      case 'watching':
        return l10n?.watching ?? 'Watching';
      case 'entries':
        return l10n?.entries ?? 'Entries';
      case 'replies':
        return l10n?.replies ?? 'Replies';
      default:
        return labelKey;
    }
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
