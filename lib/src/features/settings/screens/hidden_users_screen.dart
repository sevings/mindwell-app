import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../providers/hidden_users_provider.dart';

/// A screen that displays the list of hidden users with options to unhide them.
///
/// This screen provides a native look and feel on both Android and iOS,
/// showing hidden users with their avatars, names, and online status.
/// Users can tap on a profile to view it or use the unhide button to remove them from the hidden list.
///
/// ## Features:
/// - Displays hidden users in a compact list format
/// - Shows user avatar, name, and online status
/// - Allows navigation to user profiles
/// - Provides unhide functionality with confirmation
/// - Includes explanation text about hiding behavior
/// - Pull-to-refresh functionality
/// - Loading and error states
/// - Empty state handling
class HiddenUsersScreen extends ConsumerStatefulWidget {
  const HiddenUsersScreen({super.key});

  @override
  ConsumerState<HiddenUsersScreen> createState() => _HiddenUsersScreenState();
}

class _HiddenUsersScreenState extends ConsumerState<HiddenUsersScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initialize the hidden users list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hiddenUsersProvider.notifier).init();
    });
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

    final currentState = ref.read(hiddenUsersProvider);
    bool hasMore = false;

    currentState.when(
      initial: () {},
      loading: () {},
      loaded: (users, hasMoreValue, nextAfter, nextBefore) {
        hasMore = hasMoreValue;
      },
      error: (message) {},
    );

    if (!hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      await ref.read(hiddenUsersProvider.notifier).fetchNextPage();
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  /// Refreshes the hidden users list
  Future<void> _refreshUsers() async {
    await ref.read(hiddenUsersProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.hiddenProfiles ?? 'Hidden Profiles',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _refreshUsers,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final hiddenUsersState = ref.watch(hiddenUsersProvider);

          return hiddenUsersState.when(
            initial: () => _buildLoadingScreen(context),
            loading: () => _buildLoadingScreen(context),
            loaded: (users, hasMore, nextAfter, nextBefore) =>
                _buildLoadedScreen(context, l10n, users, hasMore),
            error: (message) => _buildErrorScreen(context, l10n, message),
          );
        },
      ),
    );
  }

  /// Builds the screen when hidden users data is loaded
  Widget _buildLoadedScreen(
    BuildContext context,
    AppLocalizations? l10n,
    List<MwFriend> users,
    bool hasMore,
  ) {
    return Column(
      children: [
        // Explanation text
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          child: Text(
            l10n?.hiddenProfilesExplanation ??
                'You don\'t see their entries in \'live\' and \'best\' feeds, but they can see your entries and comments as always.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Users list
        Expanded(
          child: users.isEmpty
              ? _buildEmptyScreen(context, l10n)
              : RefreshIndicator(
                  onRefresh: _refreshUsers,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: users.length + (hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == users.length) {
                        return _buildLoadingMoreIndicator(context);
                      }

                      final user = users[index];
                      return _buildUserListItem(context, l10n, user);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  /// Builds a list item for a hidden user
  Widget _buildUserListItem(
    BuildContext context,
    AppLocalizations? l10n,
    MwFriend user,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () => _navigateToUserProfile(user.name),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // User avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.surfaceContainerHighest,
                backgroundImage: user.avatar?.x92 != null
                    ? CachedNetworkImageProvider(user.avatar!.x92!)
                    : null,
                child: user.avatar?.x92 == null
                    ? Icon(
                        Icons.person,
                        size: 24,
                        color: colorScheme.onSurfaceVariant,
                      )
                    : null,
              ),

              const SizedBox(width: 16),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User name
                    Text(
                      user.showName ?? user.name ?? 'Unknown User',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Online status
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: user.isOnline == true
                                ? Colors.green
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user.isOnline == true
                              ? (l10n?.online ?? 'Online')
                              : _formatLastSeen(user.lastSeenAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Unhide button
              IconButton(
                onPressed: () => _showUnhideConfirmation(context, l10n, user),
                icon: const Icon(Icons.visibility),
                tooltip: l10n?.unhideUser ?? 'Unhide',
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the loading state screen
  Widget _buildLoadingScreen(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: 5,
      itemBuilder: (context, index) => _buildSkeletonListItem(),
    );
  }

  /// Builds a skeleton list item for loading state
  Widget _buildSkeletonListItem() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Avatar skeleton
            SkeletonLoader(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Info skeleton
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(
                    child: Container(
                      height: 16,
                      width: 120,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLoader(
                    child: Container(
                      height: 12,
                      width: 80,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Button skeleton
            SkeletonLoader(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
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
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
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
              label: Text(l10n?.tryAgain ?? 'Try Again'),
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
                      Icons.visibility_off_outlined,
                      size: 64,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n?.noHiddenUsers ?? 'No Hidden Users',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n?.noHiddenUsersMessage ??
                          'You haven\'t hidden any users yet.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: _refreshUsers,
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n?.refresh ?? 'Refresh'),
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

  /// Shows confirmation dialog before unhiding a user
  void _showUnhideConfirmation(
    BuildContext context,
    AppLocalizations? l10n,
    MwFriend user,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.unhideUser ?? 'Unhide User'),
        content: Text(
          (l10n?.unhideUserConfirmation.toString() ?? '')
                  .replaceAll(
                    '{username}',
                    user.showName ?? user.name ?? 'Unknown User',
                  )
                  .isNotEmpty
              ? (l10n?.unhideUserConfirmation.toString() ?? '').replaceAll(
                  '{username}',
                  user.showName ?? user.name ?? 'Unknown User',
                )
              : 'Are you sure you want to unhide ${user.showName ?? user.name ?? 'this user'}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _unhideUser(user.name);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(l10n?.unhideUser ?? 'Unhide'),
          ),
        ],
      ),
    );
  }

  /// Unhides a user
  Future<void> _unhideUser(String? username) async {
    if (username == null) return;

    try {
      await ref.read(hiddenUsersProvider.notifier).unhideUser(username);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              (AppLocalizations.of(context)?.userUnhidden.toString() ?? '')
                      .replaceAll('{username}', username)
                      .isNotEmpty
                  ? (AppLocalizations.of(context)?.userUnhidden.toString() ??
                            '')
                        .replaceAll('{username}', username)
                  : 'User $username has been unhidden',
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.unhideUserError ??
                  'Failed to unhide user',
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Navigates to a user's profile
  void _navigateToUserProfile(String? username) {
    if (username != null) {
      context.go('/users/$username');
    }
  }

  /// Formats the last seen timestamp
  String _formatLastSeen(double? lastSeenAt) {
    if (lastSeenAt == null) return 'Offline';

    final lastSeen = DateTime.fromMillisecondsSinceEpoch(
      (lastSeenAt * 1000).round(),
    );
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${lastSeen.day}/${lastSeen.month}/${lastSeen.year}';
    }
  }
}
