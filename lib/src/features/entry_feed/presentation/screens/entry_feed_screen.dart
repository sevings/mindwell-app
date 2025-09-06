import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/entry.dart';
import '../providers/entry_feed_providers.dart';
import '../widgets/entry_feed.dart';
import '../widgets/feed_settings_sheet.dart';

class EntryFeedScreen extends ConsumerStatefulWidget {
  final List<FeedType> availableTabs;
  final String? profileUsername;

  const EntryFeedScreen({
    super.key,
    this.availableTabs = const [
      FeedType.live,
      FeedType.best,
      FeedType.followings,
    ],
    this.profileUsername,
  });

  /// Creates a main feed screen with Live, Best, and Followings tabs
  static EntryFeedScreen main() {
    return const EntryFeedScreen(
      availableTabs: [
        FeedType.live,
        FeedType.best,
        FeedType.followings,
      ],
    );
  }

  /// Creates a profile feed screen for a specific user
  static EntryFeedScreen profile(String username) {
    return EntryFeedScreen(
      availableTabs: const [FeedType.profile],
      profileUsername: username,
    );
  }

  /// Creates a single-tab screen for a specific feed type
  static EntryFeedScreen single(FeedType feedType, {String? username}) {
    return EntryFeedScreen(
      availableTabs: [feedType],
      profileUsername: username,
    );
  }

  @override
  ConsumerState<EntryFeedScreen> createState() => _EntryFeedScreenState();
}

class _EntryFeedScreenState extends ConsumerState<EntryFeedScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final Map<FeedType, ScrollController> _scrollControllers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.availableTabs.length,
      vsync: this,
    );

    // Initialize scroll controllers for each tab
    for (final feedType in widget.availableTabs) {
      _scrollControllers[feedType] = ScrollController();
    }

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final currentFeedType = widget.availableTabs[_tabController.index];
        ref.read(currentFeedTypeProvider.notifier).state = currentFeedType;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(_getScreenTitle()),
              floating: true,
              pinned: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // TODO: Implement search functionality
                    _showSearchDialog();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    _showSettingsSheet();
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: widget.availableTabs.length > 3,
                tabs: widget.availableTabs.map((feedType) {
                  return Tab(
                    text: _getFeedTypeLabel(feedType),
                    icon: Icon(_getFeedTypeIcon(feedType)),
                  );
                }).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: widget.availableTabs.map((feedType) {
            return EntryFeed(
              feedType: feedType,
              username: feedType == FeedType.profile ? widget.profileUsername : null,
              controller: _scrollControllers[feedType],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  String _getScreenTitle() {
    if (widget.profileUsername != null) {
      return '@${widget.profileUsername}';
    }
    return 'MindWell';
  }

  String _getFeedTypeLabel(FeedType feedType) {
    return switch (feedType) {
      FeedType.live => 'Live',
      FeedType.best => 'Best',
      FeedType.followings => 'Following',
      FeedType.profile => 'Posts',
    };
  }

  IconData _getFeedTypeIcon(FeedType feedType) {
    return switch (feedType) {
      FeedType.live => Icons.explore,
      FeedType.best => Icons.star,
      FeedType.followings => Icons.people,
      FeedType.profile => Icons.person,
    };
  }

  Widget? _buildFloatingActionButton() {
    // Only show FAB on main feed screens, not on profile
    if (widget.profileUsername != null) {
      return null;
    }

    return FloatingActionButton.extended(
      onPressed: _onCreateEntry,
      icon: const Icon(Icons.add),
      label: const Text('New Entry'),
    );
  }

  void _onCreateEntry() {
    // TODO: Navigate to create entry screen
    // context.go('/entries/create');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Create entry functionality coming soon!'),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search entries...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search functionality coming soon!'),
                ),
              );
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showSettingsSheet() {
    final currentFeedType = widget.availableTabs[_tabController.index];
    final currentSettings = ref.read(feedSettingsProvider(currentFeedType));

    showFeedSettingsSheet(
      context: context,
      currentSettings: currentSettings,
      onSettingsChanged: (newSettings) {
        // Update the settings
        ref.read(feedSettingsProvider(currentFeedType).notifier).state = newSettings;

        // Get the appropriate feed provider and update it
        final provider = ref.read(feedProviderSelector((currentFeedType, widget.profileUsername)));
        ref.read(provider.notifier).updateSettings(newSettings);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

