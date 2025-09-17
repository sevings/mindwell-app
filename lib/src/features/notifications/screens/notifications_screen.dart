import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../providers/notification_list_provider.dart';
import '../widgets/notification_item.dart';

/// Screen that displays a list of user notifications.
///
/// This screen features:
/// - A [PlatformAppBar] with title and "Mark All as Read" action
/// - A [ListView] of [NotificationItem] widgets
/// - Pull-to-refresh functionality
/// - Infinite scrolling for pagination
/// - Empty state and error state handling
/// - Real-time updates via WebSocket
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Set up infinite scrolling
    _scrollController.addListener(_onScroll);

    // Fetch initial notifications
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationListProvider.notifier).fetchInitialNotifications();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle scroll events for infinite scrolling.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more notifications when near the bottom
      ref.read(notificationListProvider.notifier).fetchMoreNotifications();
    }
  }

  /// Handle pull-to-refresh.
  Future<void> _onRefresh() async {
    await ref.read(notificationListProvider.notifier).refresh();
  }

  /// Handle marking all notifications as read.
  Future<void> _markAllAsRead() async {
    await ref.read(notificationListProvider.notifier).markAllAsRead();
  }

  /// Handle marking a specific notification as read.
  Future<void> _markAsRead(int notificationId) async {
    await ref
        .read(notificationListProvider.notifier)
        .markAsRead(notificationId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.notifications ?? 'Notifications',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: false,
        showHamburgerMenu: false,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(notificationListProvider);

              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                loaded: (notifications, unreadCount, hasMore) {
                  if (unreadCount > 0) {
                    return IconButton(
                      icon: const Icon(Icons.done_all),
                      onPressed: _markAllAsRead,
                      tooltip: l10n?.markAllAsRead ?? 'Mark all as read',
                    );
                  }
                  return const SizedBox.shrink();
                },
                error: (message, notifications) {
                  if (notifications.isNotEmpty) {
                    return IconButton(
                      icon: const Icon(Icons.done_all),
                      onPressed: _markAllAsRead,
                      tooltip: l10n?.markAllAsRead ?? 'Mark all as read',
                    );
                  }
                  return const SizedBox.shrink();
                },
                empty: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(notificationListProvider);

          return state.when(
            initial: () => _buildLoadingState(l10n, theme, colorScheme),
            loading: () => _buildLoadingState(l10n, theme, colorScheme),
            loaded: (notifications, unreadCount, hasMore) {
              if (notifications.isEmpty) {
                return _buildEmptyState(l10n, theme, colorScheme);
              }
              return _buildLoadedState(
                notifications,
                unreadCount,
                hasMore,
                l10n,
                theme,
                colorScheme,
              );
            },
            error: (message, notifications) {
              if (notifications.isEmpty) {
                return _buildErrorState(message, l10n, theme, colorScheme);
              }
              return _buildLoadedState(
                notifications,
                0, // Don't show unread count in error state
                false,
                l10n,
                theme,
                colorScheme,
                errorMessage: message,
              );
            },
            empty: () => _buildEmptyState(l10n, theme, colorScheme),
          );
        },
      ),
    );
  }

  /// Build the loading state.
  Widget _buildLoadingState(
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: MindwellSpacing.md),
          Text(
            l10n?.loadingNotifications ?? 'Loading notifications...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the empty state.
  Widget _buildEmptyState(
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: MindwellSpacing.md),
          Text(
            l10n?.noNotifications ?? 'No notifications',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          Text(
            l10n?.noNotificationsSubtitle ??
                'You\'ll see notifications here when you receive them',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build the error state.
  Widget _buildErrorState(
    String message,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: MindwellSpacing.md),
          Text(
            l10n?.error ?? 'Error',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MindwellSpacing.lg),
          ElevatedButton(
            onPressed: () {
              ref.read(notificationListProvider.notifier).refresh();
            },
            child: Text(l10n?.retry ?? 'Retry'),
          ),
        ],
      ),
    );
  }

  /// Build the loaded state with notifications list.
  Widget _buildLoadedState(
    List notifications,
    int unreadCount,
    bool hasMore,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme, {
    String? errorMessage,
  }) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        children: [
          // Error banner if there's an error message
          if (errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(MindwellSpacing.sm),
              color: colorScheme.errorContainer,
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: colorScheme.onErrorContainer,
                    size: 16,
                  ),
                  const SizedBox(width: MindwellSpacing.sm),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(notificationListProvider.notifier).refresh();
                    },
                    child: Text(
                      l10n?.retry ?? 'Retry',
                      style: TextStyle(color: colorScheme.onErrorContainer),
                    ),
                  ),
                ],
              ),
            ),

          // Notifications list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: notifications.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == notifications.length) {
                  // Loading indicator for infinite scroll
                  return const Padding(
                    padding: EdgeInsets.all(MindwellSpacing.md),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final notification = notifications[index];
                return NotificationItem(
                  notification: notification,
                  onTap: () => _markAsRead(notification.id ?? 0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
