import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/buttons/button_size.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/buttons/secondary_button.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../providers/profile_provider.dart';

/// A collapsible header widget for the user profile screen.
/// 
/// This widget displays the user's cover image, avatar, name, and action buttons.
/// It's designed to be placed inside a SliverAppBar's flexibleSpace and will
/// animate smoothly as the user scrolls.
class ProfileHeader extends ConsumerWidget {
  /// The username of the profile being displayed
  final String username;

  const ProfileHeader({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider(username));
    final l10n = AppLocalizations.of(context);
    
    // Handle case where localizations are not available
    if (l10n == null) {
      return _buildLoadingHeader(context);
    }

    return profileState.when(
      initial: () => _buildLoadingHeader(context),
      loading: () => _buildLoadingHeader(context),
      loaded: (user, badges, images, tags, calendarData) => 
          _buildLoadedHeader(context, l10n, user, ref),
      error: (message) => _buildErrorHeader(context, l10n, message),
    );
  }

  /// Builds the header when profile data is loaded
  Widget _buildLoadedHeader(
    BuildContext context,
    AppLocalizations l10n,
    MwProfile user,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCollapsed = constraints.maxHeight < 250;
        
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface.withValues(alpha: 0.1),
                colorScheme.surface.withValues(alpha: 0.9),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Cover image with parallax effect
              if (user.cover != null) _buildCoverImage(user.cover!, isCollapsed),
              
              // Content overlay with stronger gradient when collapsed
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isCollapsed
                          ? [
                              Colors.transparent,
                              colorScheme.surface.withValues(alpha: 0.9),
                            ]
                          : [
                              Colors.transparent,
                              colorScheme.surface.withValues(alpha: 0.6),
                              colorScheme.surface.withValues(alpha: 0.8),
                            ],
                    ),
                  ),
                ),
              ),
              
              // Main content
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: isCollapsed ? 8.0 : 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar and basic info - smaller when collapsed
                        _buildAvatarAndInfo(context, user, isCollapsed),
                        
                        if (!isCollapsed) ...[
                          const SizedBox(height: 16),
                          
                          // User stats - hide when collapsed
                          _buildUserStats(context, l10n, user),
                          
                          const SizedBox(height: 16),
                        ],
                        
                        // Action buttons - always visible but smaller when collapsed
                        _buildActionButtons(context, l10n, user, ref, isCollapsed),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the cover image with parallax effect
  Widget _buildCoverImage(MwCover cover, bool isCollapsed) {
    return Positioned.fill(
      child: CachedImage(
        imageUrl: cover.x1920 ?? cover.x318 ?? '',
        fit: BoxFit.cover,
        useSkeletonLoader: true,
        errorWidget: Container(
          color: Colors.grey[300],
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 48,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the avatar and user information section
  Widget _buildAvatarAndInfo(
    BuildContext context,
    MwProfile user,
    bool isCollapsed,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        // Avatar
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.surface,
              width: 3.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CachedAvatar(
            imageUrl: user.avatar?.x124 ?? user.avatar?.x92 ?? user.avatar?.x42,
            size: isCollapsed ? 60.0 : 80.0,
            fallbackIcon: Icons.person,
          ),
        ),
        
        const SizedBox(width: 16),
        
        // User info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display name
              Text(
                user.showName ?? user.name ?? '',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Username
              Text(
                '@${user.name ?? ''}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Online status
              _buildOnlineStatus(context, user),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the online status indicator
  Widget _buildOnlineStatus(BuildContext context, MwProfile user) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    
    if (l10n == null) {
      return const SizedBox.shrink();
    }

    if (user.isOnline == true) {
      return Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            l10n.online,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Text(
      l10n.offline,
      style: theme.textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Builds the user statistics section (entries, comments, favorited, followings, followers, invited)
  Widget _buildUserStats(
    BuildContext context,
    AppLocalizations l10n,
    MwProfile user,
  ) {
    final theme = Theme.of(context);
    final counts = user.counts;

    // Only show stats if we have count data
    if (counts == null) {
      return const SizedBox.shrink();
    }

    // Create a list of all available stats
    final stats = <Widget>[];
    
    // Entries count
    if (counts.entries != null && counts.entries! > 0) {
      stats.add(_buildStatItem(
        context,
        theme,
        l10n,
        counts.entries.toString(),
        l10n.entries,
        () => _navigateToEntries(context, user.name),
      ));
    }
    
    // Comments count
    if (counts.comments != null && counts.comments! > 0) {
      stats.add(_buildStatItem(
        context,
        theme,
        l10n,
        counts.comments.toString(),
        l10n.comments,
        () => _navigateToComments(context, user.name),
      ));
    }
    
    // Favorites count
    if (counts.favorites != null && counts.favorites! > 0) {
      stats.add(_buildStatItem(
        context,
        theme,
        l10n,
        counts.favorites.toString(),
        l10n.favorited,
        () => _navigateToFavorited(context, user.name),
      ));
    }
    
    // Following count
    if (counts.followings != null && counts.followings! > 0) {
      stats.add(_buildStatItem(
        context,
        theme,
        l10n,
        counts.followings.toString(),
        l10n.following,
        () => _navigateToFollowing(context, user.name),
      ));
    }
    
    // Followers count
    if (counts.followers != null && counts.followers! > 0) {
      stats.add(_buildStatItem(
        context,
        theme,
        l10n,
        counts.followers.toString(),
        l10n.followers,
        () => _navigateToFollowers(context, user.name),
      ));
    }
    
    // Invited count
    if (counts.invited != null && counts.invited! > 0) {
      stats.add(_buildStatItem(
        context,
        theme,
        l10n,
        counts.invited.toString(),
        l10n.invited,
        () => _navigateToInvited(context, user.name),
      ));
    }

    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    // Layout stats in rows based on screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        
        if (screenWidth < 540) {
          // Single row for small screens
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: stats,
          );
        } else {
          // Two rows for larger screens
          final firstRowStats = stats.take((stats.length / 2).ceil()).toList();
          final secondRowStats = stats.skip((stats.length / 2).ceil()).toList();
          
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: firstRowStats.expand((stat) => [stat, const SizedBox(width: 16)]).take(firstRowStats.length * 2 - 1).toList(),
              ),
              if (secondRowStats.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: secondRowStats.expand((stat) => [stat, const SizedBox(width: 16)]).take(secondRowStats.length * 2 - 1).toList(),
                ),
              ],
            ],
          );
        }
      },
    );
  }

  /// Builds a single statistic item
  Widget _buildStatItem(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    String count,
    String label,
    VoidCallback onTap,
  ) {
    final colorScheme = theme.colorScheme;

    return Semantics(
      label: '$count $label',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Text(
                count,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the user's entries list
  void _navigateToEntries(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      // TODO: Navigate to user's entries feed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigate to entries - not yet implemented'),
        ),
      );
    }
  }

  /// Navigates to the user's comments list
  void _navigateToComments(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      // TODO: Navigate to user's comments
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigate to comments - not yet implemented'),
        ),
      );
    }
  }

  /// Navigates to the user's favorited entries list
  void _navigateToFavorited(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      // TODO: Navigate to user's favorited entries
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigate to favorited - not yet implemented'),
        ),
      );
    }
  }

  /// Navigates to the user's invited list
  void _navigateToInvited(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      // TODO: Navigate to user's invited users
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Navigate to invited - not yet implemented'),
        ),
      );
    }
  }

  /// Navigates to the user's followers list
  void _navigateToFollowers(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/followers');
    }
  }

  /// Navigates to the user's following list
  void _navigateToFollowing(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/following');
    }
  }

  /// Builds the action buttons
  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n,
    MwProfile user,
    WidgetRef ref,
    bool isCollapsed,
  ) {
    // Determine which buttons to show based on user relationship
    final relations = user.relations;
    final isFollowing = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.followed;
    final isBlocked = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.ignored;
    final canMessage = relations?.isOpenForMe == true;
    final isHiddenFromLive = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.hidden;

    if (isCollapsed) {
      // Compact layout when collapsed - show only essential buttons
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Follow/Unfollow button
          if (!isBlocked)
            isFollowing
                ? IconButton(
                    icon: const Icon(Icons.person_remove_outlined),
                    onPressed: () => _handleUnfollow(ref),
                    tooltip: l10n.unfollowUser,
                  )
                : IconButton(
                    icon: const Icon(Icons.person_add_outlined),
                    onPressed: () => _handleFollow(ref),
                    tooltip: l10n.followUser,
                  ),
          
          // Message button
          if (canMessage && !isBlocked)
            IconButton(
              icon: const Icon(Icons.message_outlined),
              onPressed: () => _handleMessage(context, user),
              tooltip: l10n.messageUser,
            ),
          
          // More options button (popup menu)
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onSelected: (value) => _handleMenuAction(context, ref, value),
            itemBuilder: (context) => _buildPopupMenuItems(l10n, isFollowing, isBlocked, isHiddenFromLive),
          ),
        ],
      );
    } else {
      // Full layout when expanded
      return Row(
        children: [
          // Follow/Unfollow button
          if (!isBlocked) ...[
            Expanded(
              child: isFollowing
                  ? SecondaryButton(
                      text: l10n.unfollowUser,
                      onPressed: () => _handleUnfollow(ref),
                      size: ButtonSize.small,
                    )
                  : PrimaryButton(
                      text: l10n.followUser,
                      onPressed: () => _handleFollow(ref),
                      size: ButtonSize.small,
                    ),
            ),
            const SizedBox(width: 12),
          ],
          
          // Message button
          if (canMessage && !isBlocked) ...[
            Expanded(
              child: SecondaryButton(
                text: l10n.messageUser,
                onPressed: () => _handleMessage(context, user),
                size: ButtonSize.small,
                icon: Icons.message_outlined,
              ),
            ),
            const SizedBox(width: 12),
          ],
          
        // More options button (popup menu)
        SizedBox(
          width: 48,
          height: 36,
          child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onSelected: (value) => _handleMenuAction(context, ref, value),
              itemBuilder: (context) => _buildPopupMenuItems(l10n, isFollowing, isBlocked, isHiddenFromLive),
            ),
          ),
        ],
      );
    }
  }

  /// Builds the popup menu items
  List<PopupMenuEntry<String>> _buildPopupMenuItems(
    AppLocalizations l10n,
    bool isFollowing,
    bool isBlocked,
    bool isHiddenFromLive,
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
            Text(l10n.unfollowUser),
          ],
        ),
      ));
    }

    // Hide from Live / Unhide from Live
    items.add(PopupMenuItem<String>(
      value: isHiddenFromLive ? 'unhide_from_live' : 'hide_from_live',
      child: Row(
        children: [
          Icon(
            isHiddenFromLive ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(isHiddenFromLive ? 'Unhide from Live' : 'Hide from Live'),
        ],
      ),
    ));

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
            isBlocked ? l10n.unblockUser : l10n.blockUser,
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

  /// Handles popup menu actions
  void _handleMenuAction(BuildContext context, WidgetRef ref, String action) {
    switch (action) {
      case 'unfollow':
        _handleUnfollow(ref);
        break;
      case 'hide_from_live':
        _handleHideFromLive(ref);
        break;
      case 'unhide_from_live':
        _handleUnhideFromLive(ref);
        break;
      case 'block':
        _handleBlock(ref);
        break;
      case 'unblock':
        _handleUnblock(ref);
        break;
      case 'complain':
        _handleComplain(context);
        break;
    }
  }

  /// Builds the loading state header
  Widget _buildLoadingHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  // Skeleton avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Skeleton text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 150,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 16,
                          width: 100,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Skeleton buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the error state header
  Widget _buildErrorHeader(
    BuildContext context,
    AppLocalizations l10n,
    String message,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: colorScheme.onErrorContainer,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles follow action
  void _handleFollow(WidgetRef ref) {
    ref.read(profileProvider(username).notifier).followUser();
  }

  /// Handles unfollow action
  void _handleUnfollow(WidgetRef ref) {
    ref.read(profileProvider(username).notifier).unfollowUser();
  }

  /// Handles block action
  void _handleBlock(WidgetRef ref) {
    ref.read(profileProvider(username).notifier).blockUser();
  }

  /// Handles unblock action
  void _handleUnblock(WidgetRef ref) {
    ref.read(profileProvider(username).notifier).unblockUser();
  }

  /// Handles message action
  void _handleMessage(BuildContext context, MwProfile user) {
    // TODO: Implement navigation to chat/message screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message functionality not yet implemented'),
      ),
    );
  }

  /// Handles hide from live action
  void _handleHideFromLive(WidgetRef ref) {
    ref.read(profileProvider(username).notifier).hideFromLive();
  }

  /// Handles unhide from live action
  void _handleUnhideFromLive(WidgetRef ref) {
    ref.read(profileProvider(username).notifier).unhideFromLive();
  }

  /// Handles complain action
  void _handleComplain(BuildContext context) {
    // TODO: Implement complain functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Complain functionality not yet implemented'),
      ),
    );
  }
}
