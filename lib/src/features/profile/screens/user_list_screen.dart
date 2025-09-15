import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../models/user_list_state.dart';
import '../providers/user_list_provider.dart';
import '../widgets/user_card.dart';

/// A screen that displays a list of users in a responsive grid layout.
/// 
/// This screen supports different types of user lists (followers, following, invited, users)
/// and provides a consistent UI for displaying user information in a card-based layout.
/// 
/// ## Features:
/// - Responsive grid layout that adapts to screen size
/// - Pull-to-refresh functionality
/// - Infinite scrolling for pagination
/// - Loading states with skeleton placeholders
/// - Error handling with retry options
/// - Empty state handling
/// 
/// ## Usage Examples:
/// 
/// ```dart
/// // Navigate to followers list
/// context.go('/users/john_doe/followers');
/// 
/// // Navigate to following list
/// context.go('/users/john_doe/following');
/// 
/// // Navigate to invited users list
/// context.go('/users/john_doe/invited');
/// ```
class UserListScreen extends ConsumerStatefulWidget {
  /// The type of user list to display
  final UserListType type;
  
  /// The username for which to display the user list
  final String username;

  const UserListScreen({
    super.key,
    required this.type,
    required this.username,
  });

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

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

  /// Handles scroll events to implement infinite scrolling
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreUsers();
    }
  }

  /// Loads more users for pagination
  Future<void> _loadMoreUsers() async {
    if (_isLoadingMore) return;
    
    setState(() {
      _isLoadingMore = true;
    });

    try {
      await ref.read(userListProvider((type: widget.type, username: widget.username))
          .notifier).fetchNextPage();
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  /// Refreshes the user list
  Future<void> _refreshUsers() async {
    await ref.read(userListProvider((type: widget.type, username: widget.username))
        .notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final userListState = ref.watch(userListProvider((type: widget.type, username: widget.username)));
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(l10n)),
        centerTitle: true,
        actions: [
          // Refresh button
          IconButton(
            onPressed: _refreshUsers,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: userListState.when(
        initial: () => _buildLoadingScreen(context),
        loading: () => _buildLoadingScreen(context),
        loaded: (users, hasMore, nextAfter, nextBefore) => 
            _buildLoadedScreen(context, l10n, users, hasMore),
        error: (message) => _buildErrorScreen(context, l10n, message),
      ),
    );
  }

  /// Builds the screen when user list data is loaded
  Widget _buildLoadedScreen(
    BuildContext context,
    AppLocalizations? l10n,
    List<dynamic> users,
    bool hasMore,
  ) {
    if (users.isEmpty) {
      return _buildEmptyScreen(context, l10n);
    }

    return RefreshIndicator(
      onRefresh: _refreshUsers,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // User grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildUserGrid(context, users),
            ),
          ),
          
          // Loading more indicator
          if (_isLoadingMore || hasMore)
            SliverToBoxAdapter(
              child: _buildLoadingMoreIndicator(context),
            ),
        ],
      ),
    );
  }

  /// Builds the responsive user grid
  Widget _buildUserGrid(BuildContext context, List<dynamic> users) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        
        // Determine number of columns based on screen width breakpoints
        int columns;
        if (screenWidth < 540) {
          columns = 1; // Single column for mobile
        } else if (screenWidth < 1200) {
          columns = 2; // Two columns for tablets
        } else {
          columns = 3; // Three columns for desktop
        }

        return StaggeredGrid.count(
          crossAxisCount: columns,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: users.map((user) => 
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: UserCard(
                user: user,
                onTap: () => _navigateToUserProfile(user.name),
                onEntriesTap: () => _navigateToUserEntries(user.name),
                onFollowersTap: () => _navigateToUserFollowers(user.name),
              ),
            ),
          ).toList(),
        );
      },
    );
  }

  /// Builds the loading state screen
  Widget _buildLoadingScreen(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildLoadingGrid(context),
          ),
        ),
      ],
    );
  }

  /// Builds the loading grid with skeleton placeholders
  Widget _buildLoadingGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        
        // Determine number of columns based on screen width breakpoints
        int columns;
        if (screenWidth < 540) {
          columns = 1;
        } else if (screenWidth < 1200) {
          columns = 2;
        } else {
          columns = 3;
        }

        return StaggeredGrid.count(
          crossAxisCount: columns,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: List.generate(6, (index) => 
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: _buildSkeletonUserCard(),
            ),
          ),
        );
      },
    );
  }

  /// Builds a skeleton user card for loading state
  Widget _buildSkeletonUserCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image skeleton
          SkeletonLoader(
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
          
          // Content skeleton
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar and info skeleton
                Row(
                  children: [
                    SkeletonLoader(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
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
                
                const SizedBox(height: 8),
                
                // Stats skeleton
                Row(
                  children: [
                    SkeletonLoader(
                      child: Container(
                        height: 32,
                        width: 60,
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
                        width: 60,
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
          ),
        ],
      ),
    );
  }

  /// Builds the error state screen
  Widget _buildErrorScreen(
    BuildContext context,
    AppLocalizations? l10n,
    String message,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.somethingWentWrong ?? 'Something went wrong',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _refreshUsers,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the empty state screen
  Widget _buildEmptyScreen(BuildContext context, AppLocalizations? l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      onRefresh: _refreshUsers,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getEmptyStateTitle(l10n),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getEmptyStateMessage(l10n),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _refreshUsers,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the loading more indicator
  Widget _buildLoadingMoreIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: _isLoadingMore
            ? const CircularProgressIndicator()
            : const SizedBox.shrink(),
      ),
    );
  }

  /// Gets the appropriate app bar title based on the list type
  String _getAppBarTitle(AppLocalizations? l10n) {
    switch (widget.type) {
      case UserListType.followers:
        return l10n?.privacyFollowers ?? 'Followers';
      case UserListType.following:
        return 'Following'; // TODO: Add to localization
      case UserListType.invited:
        return 'Invited Users'; // TODO: Add to localization
      case UserListType.users:
        return 'Users'; // TODO: Add to localization
    }
  }

  /// Gets the appropriate empty state title based on the list type
  String _getEmptyStateTitle(AppLocalizations? l10n) {
    switch (widget.type) {
      case UserListType.followers:
        return 'No Followers'; // TODO: Add to localization
      case UserListType.following:
        return 'Not Following Anyone'; // TODO: Add to localization
      case UserListType.invited:
        return 'No Invited Users'; // TODO: Add to localization
      case UserListType.users:
        return 'No Users Found'; // TODO: Add to localization
    }
  }

  /// Gets the appropriate empty state message based on the list type
  String _getEmptyStateMessage(AppLocalizations? l10n) {
    switch (widget.type) {
      case UserListType.followers:
        return 'This user doesn\'t have any followers yet.'; // TODO: Add to localization
      case UserListType.following:
        return 'This user is not following anyone yet.'; // TODO: Add to localization
      case UserListType.invited:
        return 'This user hasn\'t invited anyone yet.'; // TODO: Add to localization
      case UserListType.users:
        return 'No users match your criteria.'; // TODO: Add to localization
    }
  }

  /// Navigates to a user's profile
  void _navigateToUserProfile(String? username) {
    if (username != null) {
      context.go('/users/$username');
    }
  }

  /// Navigates to a user's entries
  void _navigateToUserEntries(String? username) {
    if (username != null) {
      context.go('/users/$username/entries');
    }
  }

  /// Navigates to a user's followers
  void _navigateToUserFollowers(String? username) {
    if (username != null) {
      context.go('/users/$username/followers');
    }
  }
}
