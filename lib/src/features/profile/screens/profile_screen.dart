import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_edit_dialog.dart';
import '../widgets/info_card.dart';
import '../widgets/badge_card.dart';
import '../widgets/image_card.dart';
import '../widgets/tag_card.dart';
import '../widgets/last_entries_card.dart';
import '../widgets/calendar_card.dart';

/// The main profile screen that displays a user's profile information.
/// 
/// This screen uses a CustomScrollView with a SliverAppBar to create a
/// collapsible header effect. The content is displayed in a responsive
/// grid layout with various profile cards.
class ProfileScreen extends ConsumerWidget {
  /// The username of the profile to display
  final String username;

  const ProfileScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider(username));
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: profileState.when(
        initial: () => _buildLoadingScreen(context),
        loading: () => _buildLoadingScreen(context),
        loaded: (user, badges, images, tags, calendarData, entries, hasMoreEntries) => 
            _buildLoadedScreen(context, l10n, user, badges, images, tags, calendarData, entries, hasMoreEntries, ref),
        error: (message) => _buildErrorScreen(context, l10n, message),
      ),
    );
  }

  /// Builds the screen when profile data is loaded
  Widget _buildLoadedScreen(
    BuildContext context,
    AppLocalizations? l10n,
    MwProfile user,
    List<MwBadge> badges,
    List<MwImage> images,
    List<MwTagListDataInner> tags,
    MwCalendar? calendarData,
    List<MwEntry> entries,
    bool hasMoreEntries,
    WidgetRef ref,
  ) {
    return Scaffold(
      appBar: _buildAppBar(context, l10n, user, ref),
      body: CustomScrollView(
        slivers: [
          // Profile header card at the top
          SliverToBoxAdapter(
            child: ProfileHeaderCard(username: username),
          ),

          // Main content area
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildContentGrid(context, user, badges, images, tags, calendarData),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the app bar with navigation and action buttons
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppLocalizations? l10n,
    MwProfile user,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Check if this is the user's own profile
    final authState = ref.read(authProvider);
    final isOwnProfile = authState.maybeWhen(
      authenticated: (authUser) => authUser.id == user.id,
      orElse: () => false,
    );

    return AppBar(
      title: Text(
        user.showName ?? user.name ?? '',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      leading: _buildLeadingButton(context),
      actions: _buildActionButtons(context, l10n, user, isOwnProfile, ref),
    );
  }

  /// Builds the leading button (back or drawer)
  Widget _buildLeadingButton(BuildContext context) {
    // Check if we can pop (i.e., if there's a previous route)
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    
    if (canPop) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: 'Back',
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
        tooltip: 'Menu',
      );
    }
  }

  /// Builds the action buttons for the app bar
  List<Widget> _buildActionButtons(
    BuildContext context,
    AppLocalizations? l10n,
    MwProfile user,
    bool isOwnProfile,
    WidgetRef ref,
  ) {
    final buttons = <Widget>[];

    if (isOwnProfile) {
      // Own profile - show settings button
      buttons.add(
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => _handleEditProfile(context, user),
          tooltip: l10n?.editProfile ?? 'Edit Profile',
        ),
      );
    } else {
      // Other user's profile - show relationship buttons
      final relations = user.relations;
      final isFollowing = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.followed;
      final isBlocked = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.ignored;
      final canMessage = relations?.isOpenForMe == true;
      final hasFollowRequest = relations?.toMe == MwProfileAllOfRelationsToMeEnum.requested;

      if (hasFollowRequest) {
        // Show allow/deny buttons for follow requests
        buttons.addAll([
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () => _handleAllowFollowRequest(context, ref),
            tooltip: l10n?.allowFollowRequest ?? 'Allow',
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => _handleDenyFollowRequest(context, ref),
            tooltip: l10n?.denyFollowRequest ?? 'Deny',
          ),
        ]);
      } else if (!isBlocked) {
        // Show follow/unfollow button
        buttons.add(
          IconButton(
            icon: Icon(
              isFollowing ? Icons.person_remove_outlined : Icons.person_add_outlined,
            ),
            onPressed: () => isFollowing 
                ? _handleUnfollow(context, ref)
                : _handleFollow(context, ref),
            tooltip: isFollowing 
                ? (l10n?.unfollowUser ?? 'Unfollow')
                : (l10n?.followUser ?? 'Follow'),
          ),
        );

        // Show message button if available
        if (canMessage) {
          buttons.add(
            IconButton(
              icon: const Icon(Icons.message_outlined),
              onPressed: () => _handleMessage(context, user),
              tooltip: l10n?.messageUser ?? 'Message',
            ),
          );
        }
      }

      // Always show more options menu
      buttons.add(
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) => _handleMenuAction(context, value, ref),
          itemBuilder: (context) => _buildPopupMenuItems(l10n, isFollowing, isBlocked),
        ),
      );
    }

    return buttons;
  }

  /// Builds the popup menu items
  List<PopupMenuEntry<String>> _buildPopupMenuItems(
    AppLocalizations? l10n,
    bool isFollowing,
    bool isBlocked,
  ) {
    final items = <PopupMenuEntry<String>>[];

    // Unfollow option (only if following)
    if (isFollowing) {
      items.add(PopupMenuItem<String>(
        value: 'unfollow',
        child: Row(
          children: [
            const Icon(Icons.person_remove_outlined, size: 20),
            const SizedBox(width: 12),
            Text(l10n?.unfollowUser ?? 'Unfollow'),
          ],
        ),
      ));
    }

    // Block / Unblock
    items.add(PopupMenuItem<String>(
      value: isBlocked ? 'unblock' : 'block',
      child: Row(
        children: [
          Icon(
            isBlocked ? Icons.lock_open_outlined : Icons.block_outlined,
            size: 20,
            color: isBlocked ? null : Colors.red,
          ),
          const SizedBox(width: 12),
          Text(
            isBlocked ? (l10n?.unblockUser ?? 'Unblock') : (l10n?.blockUser ?? 'Block'),
            style: TextStyle(
              color: isBlocked ? null : Colors.red,
            ),
          ),
        ],
      ),
    ));

    // Complain option
    items.add(PopupMenuItem<String>(
      value: 'complain',
      child: Row(
        children: [
          const Icon(Icons.report_outlined, size: 20, color: Colors.red),
          const SizedBox(width: 12),
          const Text(
            'Complain',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    ));

    return items;
  }

  /// Builds the responsive content grid
  Widget _buildContentGrid(
    BuildContext context,
    MwProfile user,
    List<MwBadge> badges,
    List<MwImage> images,
    List<MwTagListDataInner> tags,
    MwCalendar? calendarData,
  ) {
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

        // Create list of content cards with staggered grid items
        final List<StaggeredGridTile> staggeredTiles = [];

        // Always show info card - full width
        staggeredTiles.add(
          StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: InfoCard(profile: user),
          ),
        );

        // Add badge card if user has badges - full width
        if (badges.isNotEmpty) {
          staggeredTiles.add(
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: BadgeCard(badges: badges),
            ),
          );
        }

        // Add image card if user has images - full width
        if (images.isNotEmpty) {
          staggeredTiles.add(
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: ImageCard(images: images),
            ),
          );
        }

        // Add tag card if user has tags - full width
        if (tags.isNotEmpty) {
          staggeredTiles.add(
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: TagCard(tags: tags),
            ),
          );
        }

        // Add last entries card if user has entries - full width
        if (calendarData != null) {
          staggeredTiles.add(
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: LastEntriesCard(calendarData: calendarData),
            ),
          );
        }

        // Add calendar card if user has entries - full width
        if (calendarData != null) {
          staggeredTiles.add(
            StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: CalendarCard(
                calendarData: calendarData,
                profile: user,
                onEntryTap: (entry) => _navigateToEntry(context, entry),
                onDayTap: (entries, date) => _showEntriesForDay(context, entries, date),
              ),
            ),
          );
        }

        // If only info card is present and no other content, show empty state
        if (staggeredTiles.length == 1) {
          return _buildEmptyState(context);
        }

        // Build responsive staggered grid
        return StaggeredGrid.count(
          crossAxisCount: columns,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: staggeredTiles,
        );
      },
    );
  }


  /// Builds the loading state screen
  Widget _buildLoadingScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        centerTitle: true,
        leading: _buildLeadingButton(context),
      ),
      body: CustomScrollView(
        slivers: [
          // Loading profile header card
          SliverToBoxAdapter(
            child: ProfileHeaderCard(username: username),
          ),

          // Loading content with staggered grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
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
                        child: SkeletonLoader(
                          child: Container(
                            height: 200 + (index % 3) * 50, // Vary heights for staggered effect
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        centerTitle: true,
        leading: _buildLeadingButton(context),
      ),
      body: Center(
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
                onPressed: () => _handleRefresh(context),
                icon: const Icon(Icons.refresh),
                label: Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the empty state when no content is available
  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No content available',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'This profile is empty',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Handles refresh action
  void _handleRefresh(BuildContext context) {
    // Trigger a refresh of the profile data
    // This will be handled by the provider
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Refreshing...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  /// Navigates to entry detail screen
  void _navigateToEntry(BuildContext context, MwCalendarEntry entry) {
    if (entry.id != null) {
      context.push('/entries/${entry.id}');
    }
  }

  /// Shows entries for a specific day
  void _showEntriesForDay(BuildContext context, List<MwCalendarEntry> entries, DateTime date) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${date.day} ${_getMonthName(date.month, l10n)} ${date.year}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: 300,
          height: entries.length > 5 ? 300 : null,
          child: ListView.builder(
            shrinkWrap: entries.length <= 5,
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                title: Text(
                  entry.title ?? (l10n?.untitledEntry ?? 'Untitled'),
                  style: theme.textTheme.bodyMedium,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _navigateToEntry(context, entry);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.close ?? 'Close'),
          ),
        ],
      ),
    );
  }

  /// Gets the month name in the current locale
  String _getMonthName(int month, AppLocalizations? l10n) {
    if (l10n == null) return '';
    
    switch (month) {
      case 1: return l10n.january;
      case 2: return l10n.february;
      case 3: return l10n.march;
      case 4: return l10n.april;
      case 5: return l10n.may;
      case 6: return l10n.june;
      case 7: return l10n.july;
      case 8: return l10n.august;
      case 9: return l10n.september;
      case 10: return l10n.october;
      case 11: return l10n.november;
      case 12: return l10n.december;
      default: return '';
    }
  }

  // Action handlers
  void _handleEditProfile(BuildContext context, MwProfile user) {
    showDialog(
      context: context,
      builder: (context) => ProfileEditDialog(profile: user),
    );
  }

  void _handleFollow(BuildContext context, WidgetRef ref) {
    ref.read(profileProvider(username).notifier).followUser();
  }

  void _handleUnfollow(BuildContext context, WidgetRef ref) {
    ref.read(profileProvider(username).notifier).unfollowUser();
  }

  void _handleAllowFollowRequest(BuildContext context, WidgetRef ref) {
    ref.read(profileProvider(username).notifier).acceptFollowRequest();
  }

  void _handleDenyFollowRequest(BuildContext context, WidgetRef ref) {
    ref.read(profileProvider(username).notifier).denyFollowRequest();
  }

  void _handleMessage(BuildContext context, MwProfile user) {
    // TODO: Implement navigation to chat/message screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message functionality not yet implemented'),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action, WidgetRef ref) {
    switch (action) {
      case 'unfollow':
        _handleUnfollow(context, ref);
        break;
      case 'block':
        ref.read(profileProvider(username).notifier).blockUser();
        break;
      case 'unblock':
        ref.read(profileProvider(username).notifier).unblockUser();
        break;
      case 'complain':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Complain functionality not yet implemented'),
          ),
        );
        break;
    }
  }
}
