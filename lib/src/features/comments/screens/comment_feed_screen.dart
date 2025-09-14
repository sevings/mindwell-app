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

  const CommentFeedScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.commentsByUser(username) ?? 'Comments by @$username',
        ),
        automaticallyImplyLeading: true,
      ),
      body: CommentFeedList(
        username: username,
        enablePullToRefresh: true,
        enableInfiniteScroll: true,
      ),
    );
  }
}
