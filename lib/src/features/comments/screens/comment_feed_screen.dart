import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../widgets/comment_feed_list.dart';

/// Screen that displays a feed of comments by a specific user.
///
/// This screen:
/// - Shows comments from a specific user in a paginated list
/// - Uses [PlatformAppBar] with a localized title
/// - Displays the [CommentFeedList] widget
/// - Is typically navigated to from a user's profile
class CommentFeedScreen extends ConsumerWidget {
  /// The username to fetch comments for
  final String username;

  const CommentFeedScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.commentsByUser(username) ?? 'Comments by @$username',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Find the Scaffold that has a drawer (could be an ancestor)
            final scaffoldWithDrawer = context
                .findAncestorStateOfType<ScaffoldState>();
            if (scaffoldWithDrawer != null) {
              scaffoldWithDrawer.openDrawer();
            }
          },
          tooltip: l10n?.settings ?? 'Menu',
        ),
      ),
      body: CommentFeedList(
        username: username,
        enablePullToRefresh: true,
        enableInfiniteScroll: true,
      ),
    );
  }
}
