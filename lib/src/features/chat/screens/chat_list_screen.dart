import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/chat_list_item.dart';
import '../providers/chat_list_provider.dart';

/// Screen that displays a list of chat conversations.
///
/// Shows all active chat conversations with pull-to-refresh and infinite scrolling.
class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  final ScrollController _scrollController = ScrollController();

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

  /// Handles scroll events for infinite scrolling
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more chats when near the bottom
      ref.read(chatListProvider.notifier).loadMore();
    }
  }

  /// Handles pull-to-refresh
  Future<void> _onRefresh() async {
    await ref.read(chatListProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final chatListState = ref.watch(chatListProvider);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App bar
          SliverAppBar(
            title: Text(
              'Chats',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: theme.colorScheme.onSurface,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),

          // Chat list content
          chatListState.when(
            loading: () => _buildLoadingState(l10n, theme),
            loaded: (chats, isFetchingMore, hasMore) =>
                _buildLoadedState(l10n, theme, chats, isFetchingMore, hasMore),
            error: (error) => _buildErrorState(l10n, theme, error),
          ),
        ],
      ),
    );
  }

  /// Builds the loading state
  Widget _buildLoadingState(AppLocalizations l10n, ThemeData theme) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Loading chats...',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the loaded state with chat list
  Widget _buildLoadedState(
    AppLocalizations l10n,
    ThemeData theme,
    List<MwChat> chats,
    bool isFetchingMore,
    bool hasMore,
  ) {
    if (chats.isEmpty) {
      return _buildEmptyState(l10n, theme);
    }

    return SliverFillRemaining(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: chats.length + (isFetchingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == chats.length) {
              // Loading indicator at the bottom
              return _buildLoadingIndicator(theme);
            }

            final chat = chats[index];
            return ChatListItem(chat: chat, onTap: () => _navigateToChat(chat));
          },
        ),
      ),
    );
  }

  /// Builds the empty state when no chats are available
  Widget _buildEmptyState(AppLocalizations l10n, ThemeData theme) {
    return SliverFillRemaining(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 64,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No conversations yet',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start a conversation with someone to see it here',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the error state
  Widget _buildErrorState(
    AppLocalizations l10n,
    ThemeData theme,
    String error,
  ) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.somethingWentWrong,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.read(chatListProvider.notifier).refresh(),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the loading indicator for pagination
  Widget _buildLoadingIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: theme.colorScheme.primary,
        strokeWidth: 2,
      ),
    );
  }

  /// Navigates to a specific chat
  void _navigateToChat(MwChat chat) {
    final partner = chat.partner;
    if (partner?.name != null) {
      // Navigation will be handled by ChatListItem
    }
  }
}
