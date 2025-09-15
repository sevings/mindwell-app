import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/loaders/skeleton_loader.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header_card.dart';
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
            _buildLoadedScreen(context, l10n, user, badges, images, tags, calendarData, entries, hasMoreEntries),
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
  ) {
    return CustomScrollView(
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
    );
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
              child: CalendarCard(calendarData: calendarData),
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
    return CustomScrollView(
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
        title: Text('Profile'),
        centerTitle: true,
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
}
