import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/providers/websocket_provider.dart';
import '../../../core/services/websocket_service.dart';
import '../models/notification_list_state.dart';

/// Provider for the NotificationListNotifier that manages the state of notifications.
///
/// This provider handles:
/// - Fetching notifications from the API
/// - Real-time updates via WebSocket
/// - Pagination for infinite scrolling
/// - Marking notifications as read
final notificationListProvider =
    StateNotifierProvider<NotificationListNotifier, NotificationListState>((
      ref,
    ) {
      final notificationsApi = ref.read(notificationsApiProvider);
      final websocketService = ref.read(websocketServiceProvider);

      return NotificationListNotifier(
        notificationsApi: notificationsApi,
        websocketService: websocketService,
      );
    });

/// Notifier that manages the state and logic for the notifications list.
///
/// This class handles:
/// - Fetching initial notifications from API
/// - Listening to real-time WebSocket updates
/// - Implementing pagination for infinite scrolling
/// - Marking notifications as read (individual and all)
/// - Error handling and offline support
class NotificationListNotifier extends StateNotifier<NotificationListState> {
  final NotificationsApi _notificationsApi;
  final WebSocketService _websocketService;
  final Logger _logger = Logger('NotificationListNotifier');

  String? _nextAfter;
  bool _isLoadingMore = false;
  StreamSubscription<Map<String, dynamic>>? _websocketSubscription;

  NotificationListNotifier({
    required NotificationsApi notificationsApi,
    required WebSocketService websocketService,
  }) : _notificationsApi = notificationsApi,
       _websocketService = websocketService,
       super(const NotificationListState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by setting up WebSocket subscription.
  Future<void> _initialize() async {
    // Listen to WebSocket notification messages
    _websocketSubscription = _websocketService.notificationMessagesStream
        .listen(
          _handleWebSocketMessage,
          onError: (error) {
            _logger.warning('WebSocket error in notification stream: $error');
          },
        );
  }

  /// Fetch the initial notifications from the API.
  ///
  /// This method fetches the first page of notifications and sets up
  /// pagination state for infinite scrolling.
  Future<void> fetchInitialNotifications() async {
    if (state.when(
      initial: () => false,
      loading: () => true,
      loaded: (notifications, unreadCount, hasMore) => false,
      error: (message, notifications) => false,
      empty: () => false,
    )) {
      return; // Prevent multiple simultaneous loads
    }

    _logger.info('Fetching initial notifications');
    state = const NotificationListState.loading();

    try {
      final response = await _notificationsApi.notificationsGet(
        limit: 30,
        unread: false, // Get all notifications, not just unread
      );

      final notificationList = response.data;
      if (notificationList == null) {
        state = const NotificationListState.empty();
        return;
      }

      final notifications = notificationList.notifications?.toList() ?? [];
      final unreadCount = notificationList.unreadCount ?? 0;
      final hasMore = notificationList.hasAfter ?? false;
      _nextAfter = notificationList.nextAfter;

      _logger.info(
        'Fetched ${notifications.length} notifications, $unreadCount unread',
      );

      if (notifications.isEmpty) {
        state = const NotificationListState.empty();
      } else {
        state = NotificationListState.loaded(
          notifications: notifications,
          unreadCount: unreadCount,
          hasMore: hasMore,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch initial notifications', e, stackTrace);
      state = NotificationListState.error(
        message: 'Failed to load notifications: ${e.toString()}',
      );
    }
  }

  /// Fetch more notifications for infinite scrolling.
  ///
  /// This method appends new notifications to the existing list.
  Future<void> fetchMoreNotifications() async {
    if (_isLoadingMore) return;

    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (notifications, unreadCount, hasMore) => (
        notifications: notifications,
        unreadCount: unreadCount,
        hasMore: hasMore,
      ),
      error: (message, notifications) => null,
      empty: () => null,
    );

    if (currentState == null || !currentState.hasMore) return;

    _isLoadingMore = true;
    _logger.info('Fetching more notifications');

    try {
      final response = await _notificationsApi.notificationsGet(
        limit: 30,
        after: _nextAfter,
        unread: false,
      );

      final notificationList = response.data;
      if (notificationList != null) {
        final newNotifications = notificationList.notifications?.toList() ?? [];
        _nextAfter = notificationList.nextAfter;

        final allNotifications = [
          ...currentState.notifications,
          ...newNotifications,
        ];

        _logger.info('Fetched ${newNotifications.length} more notifications');
        state = NotificationListState.loaded(
          notifications: allNotifications,
          unreadCount: currentState.unreadCount,
          hasMore: notificationList.hasAfter ?? false,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch more notifications', e, stackTrace);
      // Don't change state on error - user can retry
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Mark a specific notification as read.
  ///
  /// [notificationId] - The ID of the notification to mark as read
  Future<void> markAsRead(int notificationId) async {
    try {
      await _notificationsApi.notificationsReadPut(
        time: DateTime.now().millisecondsSinceEpoch / 1000,
      );

      // Update the notification in the current state
      final currentState = state.when(
        initial: () => null,
        loading: () => null,
        loaded: (notifications, unreadCount, hasMore) => (
          notifications: notifications,
          unreadCount: unreadCount,
          hasMore: hasMore,
        ),
        error: (message, notifications) => null,
        empty: () => null,
      );

      if (currentState != null) {
        final updatedNotifications = currentState.notifications.map((
          notification,
        ) {
          if (notification.id == notificationId && notification.read == false) {
            // Create a new notification with read status updated
            return notification.rebuild((b) => b.read = true);
          }
          return notification;
        }).toList();

        // Calculate new unread count
        final newUnreadCount = updatedNotifications
            .where((n) => n.read != true)
            .length;

        state = NotificationListState.loaded(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount,
          hasMore: currentState.hasMore,
        );

        _logger.info('Marked notification $notificationId as read');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to mark notification as read', e, stackTrace);
      // Don't change state on error
    }
  }

  /// Mark all notifications as read.
  Future<void> markAllAsRead() async {
    try {
      await _notificationsApi.notificationsReadPut(
        time: DateTime.now().millisecondsSinceEpoch / 1000,
      );

      // Update all notifications in the current state
      final currentState = state.when(
        initial: () => null,
        loading: () => null,
        loaded: (notifications, unreadCount, hasMore) => (
          notifications: notifications,
          unreadCount: unreadCount,
          hasMore: hasMore,
        ),
        error: (message, notifications) => null,
        empty: () => null,
      );

      if (currentState != null) {
        final updatedNotifications = currentState.notifications.map((
          notification,
        ) {
          if (notification.read != true) {
            return notification.rebuild((b) => b.read = true);
          }
          return notification;
        }).toList();

        state = NotificationListState.loaded(
          notifications: updatedNotifications,
          unreadCount: 0, // All notifications are now read
          hasMore: currentState.hasMore,
        );

        _logger.info('Marked all notifications as read');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to mark all notifications as read', e, stackTrace);
      // Don't change state on error
    }
  }

  /// Handle incoming WebSocket notification messages.
  ///
  /// This method processes real-time notification updates from the WebSocket
  /// and updates the state accordingly.
  void _handleWebSocketMessage(Map<String, dynamic> message) {
    try {
      _logger.fine('Received WebSocket notification: $message');

      // Parse the notification from the WebSocket message
      // The message structure depends on the server implementation
      // For now, we'll assume it contains notification data
      final notificationData = message['notification'] as Map<String, dynamic>?;
      if (notificationData == null) {
        _logger.warning('WebSocket message does not contain notification data');
        return;
      }

      // Convert the notification data to MwNotification
      // This is a simplified conversion - in practice, you might need
      // a proper deserializer based on your API structure
      final newNotification = MwNotification(
        (b) => b
          ..id = notificationData['id'] as int?
          ..type = _parseNotificationType(notificationData['type'] as String?)
          ..read = notificationData['read'] as bool? ?? false
          ..createdAt = (notificationData['createdAt'] as num?)?.toDouble(),
        // For now, we'll skip parsing complex nested objects from WebSocket
        // as they require proper deserialization
      );

      // Update the current state with the new notification
      final currentState = state.when(
        initial: () => null,
        loading: () => null,
        loaded: (notifications, unreadCount, hasMore) => (
          notifications: notifications,
          unreadCount: unreadCount,
          hasMore: hasMore,
        ),
        error: (message, notifications) => null,
        empty: () => null,
      );

      if (currentState != null) {
        // Add new notification to the beginning of the list
        final updatedNotifications = [
          newNotification,
          ...currentState.notifications,
        ];

        // Update unread count if the new notification is unread
        final newUnreadCount =
            currentState.unreadCount + (newNotification.read == false ? 1 : 0);

        state = NotificationListState.loaded(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount,
          hasMore: currentState.hasMore,
        );

        _logger.info(
          'Added new notification from WebSocket: ${newNotification.id}',
        );
      } else {
        // If we don't have a loaded state, fetch initial notifications
        fetchInitialNotifications();
      }
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to handle WebSocket notification message',
        e,
        stackTrace,
      );
    }
  }

  /// Parse notification type from string.
  MwNotificationTypeEnum? _parseNotificationType(String? typeString) {
    if (typeString == null) return null;

    // Map string values to enum values
    switch (typeString) {
      case 'comment':
        return MwNotificationTypeEnum.comment;
      case 'follower':
        return MwNotificationTypeEnum.follower;
      case 'request':
        return MwNotificationTypeEnum.request;
      case 'accept':
        return MwNotificationTypeEnum.accept;
      case 'invite':
        return MwNotificationTypeEnum.invite;
      case 'welcome':
        return MwNotificationTypeEnum.welcome;
      case 'invited':
        return MwNotificationTypeEnum.invited;
      case 'badge':
        return MwNotificationTypeEnum.badge;
      case 'adm_sent':
        return MwNotificationTypeEnum.admSent;
      case 'adm_received':
        return MwNotificationTypeEnum.admReceived;
      case 'wish_created':
        return MwNotificationTypeEnum.wishCreated;
      case 'wish_received':
        return MwNotificationTypeEnum.wishReceived;
      case 'entry_moved':
        return MwNotificationTypeEnum.entryMoved;
      case 'info':
        return MwNotificationTypeEnum.info;
      default:
        return null;
    }
  }

  /// Refresh notifications by clearing current state and fetching fresh data.
  Future<void> refresh() async {
    _logger.info('Refreshing notifications');

    // Reset pagination
    _nextAfter = null;

    // Fetch fresh data
    await fetchInitialNotifications();
  }

  @override
  void dispose() {
    _websocketSubscription?.cancel();
    super.dispose();
  }
}
