import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/images/cached_image.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

/// A card-based profile header widget that fills the screen width.
///
/// This widget displays the user's cover image with 3:1 aspect ratio,
/// avatar overlapping the image and white section, user stats in a grid,
/// and action buttons. It's designed to be placed at the top of the screen.
class ProfileHeaderCard extends ConsumerStatefulWidget {
  /// The username of the profile being displayed
  final String username;

  const ProfileHeaderCard({super.key, required this.username});

  @override
  ConsumerState<ProfileHeaderCard> createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends ConsumerState<ProfileHeaderCard> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider(widget.username));
    final l10n = AppLocalizations.of(context);

    // Handle case where localizations are not available
    if (l10n == null) {
      return _buildLoadingCard(context);
    }

    return profileState.when(
      initial: () => _buildLoadingCard(context),
      loading: () => _buildLoadingCard(context),
      loaded:
          (user, badges, images, tags, calendarData, entries, hasMoreEntries) =>
              _buildLoadedCard(context, l10n, user, ref),
      error: (message) => _buildErrorCard(context, l10n, message),
    );
  }

  /// Builds the card when profile data is loaded
  Widget _buildLoadedCard(
    BuildContext context,
    AppLocalizations l10n,
    MwProfile user,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      color: colorScheme
          .surfaceContainer, // Use theme's surface container color to match other cards
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Header image section with 3:1 aspect ratio
          _buildHeaderImageSection(context, user, ref),

          // White section with avatar, name, status and stats
          _buildWhiteSection(context, l10n, user, ref),
        ],
      ),
    );
  }

  /// Builds the header image section with 3:1 aspect ratio
  Widget _buildHeaderImageSection(
    BuildContext context,
    MwProfile user,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Check if this is the user's own profile
    final authState = ref.watch(authProvider);
    final isOwnProfile = authState.maybeWhen(
      authenticated: (authUser, _) => authUser.id == user.id,
      orElse: () => false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate height for 3:1 aspect ratio
        final imageHeight = constraints.maxWidth / 3;

        return SizedBox(
          width: double.infinity,
          height: imageHeight,
          child: Stack(
            children: [
              // Cover image
              if (user.cover != null)
                Positioned.fill(
                  child: CachedImage(
                    imageUrl: user.cover!.x1920 ?? user.cover!.x318 ?? '',
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
                )
              else
                Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

              // Tappable overlay for own profile cover
              if (isOwnProfile && user.cover != null)
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _handleCoverImageTap(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
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

  /// Builds the white section with avatar, name, status and stats
  Widget _buildWhiteSection(
    BuildContext context,
    AppLocalizations l10n,
    MwProfile user,
    WidgetRef ref,
  ) {
    // Check if this is the user's own profile
    final authState = ref.watch(authProvider);
    final isOwnProfile = authState.maybeWhen(
      authenticated: (authUser, _) => authUser.id == user.id,
      orElse: () => false,
    );

    return Column(
      children: [
        // Avatar overlapping the image and white section
        Transform.translate(
          offset: const Offset(0, -40), // Move avatar up to overlap
          child: _buildAvatar(context, user, ref, isOwnProfile),
        ),

        // Name and online status
        _buildNameAndStatus(context, user),

        const SizedBox(height: 16),

        // User stats in grid layout
        _buildUserStatsGrid(context, l10n, user),

        const SizedBox(height: 16),
      ],
    );
  }

  /// Builds the avatar with tappable overlay for own profile
  Widget _buildAvatar(
    BuildContext context,
    MwProfile user,
    WidgetRef ref,
    bool isOwnProfile,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colorScheme
              .surfaceContainer, // Use theme's surface container color for avatar border
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
      child: Stack(
        children: [
          CachedAvatar(
            imageUrl: user.avatar?.x124 ?? user.avatar?.x92 ?? user.avatar?.x42,
            size: 124.0,
            fallbackIcon: Icons.person,
          ),
          // Tappable overlay for own profile
          if (isOwnProfile)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _handleAvatarTap(),
                  borderRadius: BorderRadius.circular(62.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.0),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds the name and online status section
  Widget _buildNameAndStatus(BuildContext context, MwProfile user) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Display name
        Text(
          user.showName ?? user.name ?? '',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 4),

        // Online status
        _buildOnlineStatus(context, user),
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
        mainAxisAlignment: MainAxisAlignment.center,
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
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Text(
      l10n.offline,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Builds the user statistics in a grid layout
  Widget _buildUserStatsGrid(
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
      stats.add(
        _buildStatItem(
          context,
          theme,
          l10n,
          counts.entries.toString(),
          l10n.entries,
          () => _navigateToEntries(context, user.name),
        ),
      );
    }

    // Comments count
    if (counts.comments != null && counts.comments! > 0) {
      stats.add(
        _buildStatItem(
          context,
          theme,
          l10n,
          counts.comments.toString(),
          l10n.comments,
          () => _navigateToComments(context, user.name),
        ),
      );
    }

    // Favorites count
    if (counts.favorites != null && counts.favorites! > 0) {
      stats.add(
        _buildStatItem(
          context,
          theme,
          l10n,
          counts.favorites.toString(),
          l10n.favorited,
          () => _navigateToFavorited(context, user.name),
        ),
      );
    }

    // Following count
    if (counts.followings != null && counts.followings! > 0) {
      stats.add(
        _buildStatItem(
          context,
          theme,
          l10n,
          counts.followings.toString(),
          l10n.following,
          () => _navigateToFollowing(context, user.name),
        ),
      );
    }

    // Followers count
    if (counts.followers != null && counts.followers! > 0) {
      stats.add(
        _buildStatItem(
          context,
          theme,
          l10n,
          counts.followers.toString(),
          l10n.followers,
          () => _navigateToFollowers(context, user.name),
        ),
      );
    }

    // Invited count
    if (counts.invited != null && counts.invited! > 0) {
      stats.add(
        _buildStatItem(
          context,
          theme,
          l10n,
          counts.invited.toString(),
          l10n.invited,
          () => _navigateToInvited(context, user.name),
        ),
      );
    }

    if (stats.isEmpty) {
      return const SizedBox.shrink();
    }

    // Layout stats distributed across the full width
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: stats.map((stat) => Expanded(child: stat)).toList(),
        );
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Text(
                count,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the loading state card
  Widget _buildLoadingCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      color: colorScheme
          .surfaceContainer, // Use theme's surface container color to match other cards
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Loading header image
          LayoutBuilder(
            builder: (context, constraints) {
              final imageHeight = constraints.maxWidth / 3;
              return Container(
                width: double.infinity,
                height: imageHeight,
                color: colorScheme.surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),

          // Loading white section
          Column(
            children: [
              Transform.translate(
                offset: const Offset(0, -40),
                child: Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              // Loading stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => Column(
                    children: [
                      Container(
                        height: 20,
                        width: 30,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the error state card
  Widget _buildErrorCard(
    BuildContext context,
    AppLocalizations l10n,
    String message,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        color: colorScheme.errorContainer,
        padding: const EdgeInsets.all(32.0),
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
    );
  }

  // Navigation methods
  void _navigateToEntries(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/entries');
    }
  }

  void _navigateToComments(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/comments');
    }
  }

  void _navigateToFavorited(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/favorites');
    }
  }

  void _navigateToInvited(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/invited');
    }
  }

  void _navigateToFollowers(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/followers');
    }
  }

  void _navigateToFollowing(BuildContext context, String? username) {
    if (username != null && username.isNotEmpty) {
      context.go('/users/${Uri.encodeComponent(username)}/following');
    }
  }

  /// Handles avatar tap to change avatar image
  Future<void> _handleAvatarTap() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        await ref
            .read(profileProvider(widget.username).notifier)
            .updateAvatar(file);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: const Text('Avatar updated')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error updating avatar'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Handles cover image tap to change cover image
  Future<void> _handleCoverImageTap() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        await ref
            .read(profileProvider(widget.username).notifier)
            .updateCover(file);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: const Text('Cover updated')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error updating cover'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
