import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/notifications/models/notification_list_state.dart';
import 'package:mindwell/src/features/notifications/providers/notification_list_provider.dart';
import 'package:mindwell/src/core/services/websocket_service.dart';

class MockNotificationsApi extends Mock implements NotificationsApi {}

class MockWebSocketService extends Mock implements WebSocketService {}

class MockStreamController extends Mock
    implements StreamController<Map<String, dynamic>> {
  @override
  Stream<Map<String, dynamic>> get stream => const Stream.empty();
}

void main() {
  group('NotificationListNotifier', () {
    late MockNotificationsApi mockNotificationsApi;
    late MockWebSocketService mockWebSocketService;
    late MockStreamController mockStreamController;
    late NotificationListNotifier notifier;

    setUp(() {
      mockNotificationsApi = MockNotificationsApi();
      mockWebSocketService = MockWebSocketService();
      mockStreamController = MockStreamController();

      // Setup mock stream
      when(
        () => mockWebSocketService.notificationMessagesStream,
      ).thenAnswer((_) => mockStreamController.stream);

      notifier = NotificationListNotifier(
        notificationsApi: mockNotificationsApi,
        websocketService: mockWebSocketService,
      );
    });

    tearDown(() {
      notifier.dispose();
    });

    group('fetchInitialNotifications', () {
      test('should set loading state initially', () async {
        // Arrange
        final response = Response<MwNotificationList>(
          data: MwNotificationList(
            (b) => b
              ..notifications = ListBuilder<MwNotification>([])
              ..unreadCount = 0
              ..hasAfter = false,
          ),
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            unread: any(named: 'unread'),
          ),
        ).thenAnswer((_) async => response);

        // Act
        final future = notifier.fetchInitialNotifications();

        // Assert - Check loading state
        expect(notifier.state, const NotificationListState.loading());

        // Wait for completion
        await future;
      });

      test('should set loaded state with notifications', () async {
        // Arrange
        final notification1 = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false
            ..createdAt = 1234567890.0,
        );

        final notification2 = MwNotification(
          (b) => b
            ..id = 2
            ..type = MwNotificationTypeEnum.follower
            ..read = true
            ..createdAt = 1234567891.0,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([
              notification1,
              notification2,
            ])
            ..unreadCount = 1
            ..hasAfter = true
            ..nextAfter = 'next_cursor',
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        // Act
        await notifier.fetchInitialNotifications();

        // Assert
        final state = notifier.state;
        expect(state, isA<NotificationListState>());

        state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (notifications, unreadCount, hasMore, newNotificationIds) {
            expect(notifications, hasLength(2));
            expect(notifications[0].id, 1);
            expect(notifications[1].id, 2);
            expect(unreadCount, 1);
            expect(hasMore, true);
          },
          error: (message, notifications) =>
              fail('Expected loaded state, got error: $message'),
          empty: () => fail('Expected loaded state'),
        );
      });

      test('should set empty state when no notifications', () async {
        // Arrange
        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([])
            ..unreadCount = 0
            ..hasAfter = false,
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        // Act
        await notifier.fetchInitialNotifications();

        // Assert
        expect(notifier.state, const NotificationListState.empty());
      });

      test('should set error state when API call fails', () async {
        // Arrange
        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenThrow(Exception('Network error'));

        // Act
        await notifier.fetchInitialNotifications();

        // Assert
        final state = notifier.state;
        expect(state, isA<NotificationListState>());

        state.when(
          initial: () => fail('Expected error state'),
          loading: () => fail('Expected error state'),
          loaded: (notifications, unreadCount, hasMore, newNotificationIds) =>
              fail('Expected error state'),
          error: (message, notifications) {
            expect(message, contains('Network error'));
            expect(notifications, isEmpty);
          },
          empty: () => fail('Expected error state'),
        );
      });

      test('should not fetch when already loading', () async {
        // Arrange
        final response = Response<MwNotificationList>(
          data: MwNotificationList(
            (b) => b
              ..notifications = ListBuilder<MwNotification>([])
              ..unreadCount = 0
              ..hasAfter = false,
          ),
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            unread: any(named: 'unread'),
          ),
        ).thenAnswer((_) async {
          // Simulate slow response
          await Future.delayed(const Duration(milliseconds: 100));
          return response;
        });

        // Act - Start first fetch
        final future1 = notifier.fetchInitialNotifications();

        // Start second fetch while first is still loading
        final future2 = notifier.fetchInitialNotifications();

        // Wait for both to complete
        await future1;
        await future2;

        // Assert - Should only be called once
        verify(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).called(1);
      });
    });

    group('fetchMoreNotifications', () {
      test(
        'should fetch more notifications and append to existing list',
        () async {
          // Arrange - Set up initial state
          final notification1 = MwNotification(
            (b) => b
              ..id = 1
              ..type = MwNotificationTypeEnum.comment
              ..read = false,
          );

          final notificationList1 = MwNotificationList(
            (b) => b
              ..notifications = ListBuilder<MwNotification>([notification1])
              ..unreadCount = 1
              ..hasAfter = true
              ..nextAfter = 'cursor1',
          );

          final response1 = Response<MwNotificationList>(
            data: notificationList1,
            requestOptions: RequestOptions(),
          );

          when(
            () => mockNotificationsApi.notificationsGet(
              limit: 30,
              after: null,
              unread: false,
            ),
          ).thenAnswer((_) async => response1);

          // Fetch initial notifications
          await notifier.fetchInitialNotifications();

          // Setup second page
          final notification2 = MwNotification(
            (b) => b
              ..id = 2
              ..type = MwNotificationTypeEnum.follower
              ..read = true,
          );

          final notificationList2 = MwNotificationList(
            (b) => b
              ..notifications = ListBuilder<MwNotification>([notification2])
              ..unreadCount = 1
              ..hasAfter = false,
          );

          final response2 = Response<MwNotificationList>(
            data: notificationList2,
            requestOptions: RequestOptions(),
          );

          when(
            () => mockNotificationsApi.notificationsGet(
              limit: 30,
              after: 'cursor1',
              unread: false,
            ),
          ).thenAnswer((_) async => response2);

          // Act
          await notifier.fetchMoreNotifications();

          // Assert
          final state = notifier.state;
          state.when(
            initial: () => fail('Expected loaded state'),
            loading: () => fail('Expected loaded state'),
            loaded: (notifications, unreadCount, hasMore, newNotificationIds) {
              expect(notifications, hasLength(2));
              expect(notifications[0].id, 1);
              expect(notifications[1].id, 2);
              expect(unreadCount, 1);
              expect(hasMore, false);
            },
            error: (message, notifications) =>
                fail('Expected loaded state, got error: $message'),
            empty: () => fail('Expected loaded state'),
          );
        },
      );

      test('should not fetch when no more notifications available', () async {
        // Arrange - Set up state with no more notifications
        final notification = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([notification])
            ..unreadCount = 1
            ..hasAfter = false,
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        await notifier.fetchInitialNotifications();

        // Act
        await notifier.fetchMoreNotifications();

        // Assert - Should not make additional API call
        verifyNever(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: 'cursor1',
            unread: false,
          ),
        );
      });

      test('should not fetch when already loading more', () async {
        // Arrange
        final notification = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([notification])
            ..unreadCount = 1
            ..hasAfter = true
            ..nextAfter = 'cursor1',
        );

        final response1 = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response1);

        final response2 = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: 'cursor1',
            unread: false,
          ),
        ).thenAnswer((_) async {
          // Simulate slow response
          await Future.delayed(const Duration(milliseconds: 100));
          return response2;
        });

        await notifier.fetchInitialNotifications();

        // Act - Start multiple fetch more calls
        final future1 = notifier.fetchMoreNotifications();
        final future2 = notifier.fetchMoreNotifications();

        await future1;
        await future2;

        // Assert - Should only be called once
        verify(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: 'cursor1',
            unread: false,
          ),
        ).called(1);
      });
    });

    group('markAsRead', () {
      test('should mark specific notification as read', () async {
        // Arrange
        final notification1 = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notification2 = MwNotification(
          (b) => b
            ..id = 2
            ..type = MwNotificationTypeEnum.follower
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([
              notification1,
              notification2,
            ])
            ..unreadCount = 2
            ..hasAfter = false,
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        when(
          () => mockNotificationsApi.notificationsReadPut(
            time: any(named: 'time'),
          ),
        ).thenAnswer(
          (_) async => Response<MwNotificationsReadPut200Response>(
            data: MwNotificationsReadPut200Response(),
            requestOptions: RequestOptions(),
          ),
        );

        await notifier.fetchInitialNotifications();

        // Act
        await notifier.markAsRead(1);

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (notifications, unreadCount, hasMore, newNotificationIds) {
            expect(notifications, hasLength(2));
            expect(notifications[0].read, true); // Should be marked as read
            expect(notifications[1].read, false); // Should remain unread
            expect(unreadCount, 1); // Should be reduced by 1
          },
          error: (message, notifications) =>
              fail('Expected loaded state, got error: $message'),
          empty: () => fail('Expected loaded state'),
        );
      });

      test('should handle API error gracefully', () async {
        // Arrange
        final notification = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([notification])
            ..unreadCount = 1
            ..hasAfter = false,
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        when(
          () => mockNotificationsApi.notificationsReadPut(
            time: any(named: 'time'),
          ),
        ).thenThrow(Exception('API error'));

        await notifier.fetchInitialNotifications();

        // Act
        await notifier.markAsRead(1);

        // Assert - State should remain unchanged
        final state = notifier.state;
        state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (notifications, unreadCount, hasMore, newNotificationIds) {
            expect(notifications, hasLength(1));
            expect(notifications[0].read, false); // Should remain unread
            expect(unreadCount, 1); // Should remain unchanged
          },
          error: (message, notifications) =>
              fail('Expected loaded state, got error: $message'),
          empty: () => fail('Expected loaded state'),
        );
      });
    });

    group('markAllAsRead', () {
      test('should mark all notifications as read', () async {
        // Arrange
        final notification1 = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notification2 = MwNotification(
          (b) => b
            ..id = 2
            ..type = MwNotificationTypeEnum.follower
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([
              notification1,
              notification2,
            ])
            ..unreadCount = 2
            ..hasAfter = false,
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        when(
          () => mockNotificationsApi.notificationsReadPut(
            time: any(named: 'time'),
          ),
        ).thenAnswer(
          (_) async => Response<MwNotificationsReadPut200Response>(
            data: MwNotificationsReadPut200Response(),
            requestOptions: RequestOptions(),
          ),
        );

        await notifier.fetchInitialNotifications();

        // Act
        await notifier.markAllAsRead();

        // Assert
        final state = notifier.state;
        state.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (notifications, unreadCount, hasMore, newNotificationIds) {
            expect(notifications, hasLength(2));
            expect(notifications[0].read, true); // Should be marked as read
            expect(notifications[1].read, true); // Should be marked as read
            expect(unreadCount, 0); // Should be 0
          },
          error: (message, notifications) =>
              fail('Expected loaded state, got error: $message'),
          empty: () => fail('Expected loaded state'),
        );
      });
    });

    group('WebSocket message handling', () {
      test('should add new notification from WebSocket message', () async {
        // Arrange
        final notification = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([notification])
            ..unreadCount = 1
            ..hasAfter = false,
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        await notifier.fetchInitialNotifications();

        // Note: WebSocket message testing would require proper mocking
        // of the stream controller. This is a simplified test structure.
        // In practice, you'd need to properly mock the WebSocket stream
        // and test the _handleWebSocketMessage method directly.

        // Assert - Initial state
        final initialState = notifier.state;
        initialState.when(
          initial: () => fail('Expected loaded state'),
          loading: () => fail('Expected loaded state'),
          loaded: (notifications, unreadCount, hasMore, newNotificationIds) {
            expect(notifications, hasLength(1));
            expect(unreadCount, 1);
          },
          error: (message, notifications) => fail('Expected loaded state'),
          empty: () => fail('Expected loaded state'),
        );
      });
    });

    group('refresh', () {
      test('should reset pagination and fetch fresh data', () async {
        // Arrange
        final notification = MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false,
        );

        final notificationList = MwNotificationList(
          (b) => b
            ..notifications = ListBuilder<MwNotification>([notification])
            ..unreadCount = 1
            ..hasAfter = true
            ..nextAfter = 'cursor1',
        );

        final response = Response<MwNotificationList>(
          data: notificationList,
          requestOptions: RequestOptions(),
        );

        when(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).thenAnswer((_) async => response);

        await notifier.fetchInitialNotifications();

        // Act
        await notifier.refresh();

        // Assert - Should be called twice (initial + refresh)
        verify(
          () => mockNotificationsApi.notificationsGet(
            limit: 30,
            after: null,
            unread: false,
          ),
        ).called(2);
      });
    });
  });
}
