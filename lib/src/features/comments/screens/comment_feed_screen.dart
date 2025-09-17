import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
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

    return Column(
      children: [
        // Custom app bar for this screen
        Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                tooltip: 'Back',
              ),

              // Title
              Expanded(
                child: Text(
                  l10n?.commentsByUser(username) ?? 'Comments by @$username',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Spacer for symmetry
              const SizedBox(width: 48),
            ],
          ),
        ),

        // Content
        Expanded(
          child: CommentFeedList(
            username: username,
            enablePullToRefresh: true,
            enableInfiniteScroll: true,
          ),
        ),
      ],
    );
  }
}
