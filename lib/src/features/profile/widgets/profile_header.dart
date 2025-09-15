import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../src/core/widgets/buttons/button_size.dart';
import '../../../../src/core/widgets/buttons/primary_button.dart';
import '../../../../src/core/widgets/buttons/secondary_button.dart';
import '../../../../src/core/widgets/images/cached_image.dart';
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
        final isCollapsed = constraints.maxHeight < 200;
        
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface,
                colorScheme.surface.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Cover image
              if (user.cover != null) _buildCoverImage(user.cover!),
              
              // Content overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        colorScheme.surface.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Main content
              Positioned.fill(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar and basic info
                        _buildAvatarAndInfo(context, user, isCollapsed),
                        
                        const SizedBox(height: 16),
                        
                        // Action buttons
                        _buildActionButtons(context, l10n, user, ref),
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

  /// Builds the cover image
  Widget _buildCoverImage(MwCover cover) {
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

  /// Builds the action buttons
  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n,
    MwProfile user,
    WidgetRef ref,
  ) {
    // Determine which buttons to show based on user relationship
    final relations = user.relations;
    final isFollowing = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.followed;
    final isBlocked = relations?.fromMe == MwProfileAllOfRelationsFromMeEnum.ignored;
    final canMessage = relations?.isOpenForMe == true;

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
        
        // Block/Unblock button
        Expanded(
          child: isBlocked
              ? SecondaryButton(
                  text: l10n.unblockUser,
                  onPressed: () => _handleUnblock(ref),
                  size: ButtonSize.small,
                )
              : SecondaryButton(
                  text: l10n.blockUser,
                  onPressed: () => _handleBlock(ref),
                  size: ButtonSize.small,
                ),
        ),
      ],
    );
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
}
