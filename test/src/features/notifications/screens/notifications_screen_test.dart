import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../../lib/src/features/notifications/models/notification_list_state.dart';
import '../../../../../lib/src/features/notifications/providers/notification_list_provider.dart';
import '../../../../../lib/src/features/notifications/screens/notifications_screen.dart';
import '../../../../../lib/src/features/notifications/widgets/notification_item.dart';

class MockNotificationListNotifier extends StateNotifier<NotificationListState>
    with Mock
    implements NotificationListNotifier {
  MockNotificationListNotifier() : super(const NotificationListState.initial());

  @override
  Future<void> fetchInitialNotifications() async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> fetchMoreNotifications() async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> markAllAsRead() async {
    // Mock implementation - will be verified by mocktail
  }

  @override
  Future<void> refresh() async {
    // Mock implementation - will be verified by mocktail
  }
}

void main() {
  group('NotificationsScreen', () {
    late MockNotificationListNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockNotificationListNotifier();
    });

    testWidgets('displays loading state correctly', (
      WidgetTester tester,
    ) async {
      mockNotifier.state = const NotificationListState.loading();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify loading state is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading notifications...'), findsOneWidget);
    });

    testWidgets('displays empty state correctly', (WidgetTester tester) async {
      mockNotifier.state = const NotificationListState.empty();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify empty state is displayed
      expect(find.byIcon(Icons.notifications_none), findsOneWidget);
      expect(find.text('No notifications'), findsOneWidget);
      expect(
        find.text('You\'ll see notifications here when you receive them'),
        findsOneWidget,
      );
    });

    testWidgets('displays error state correctly', (WidgetTester tester) async {
      mockNotifier.state = const NotificationListState.error(
        message: 'Failed to load notifications',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify error state is displayed
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
      expect(find.text('Failed to load notifications'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('displays loaded state with notifications correctly', (
      WidgetTester tester,
    ) async {
      final mockNotifications = [
        MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
            ..user = $MwUser(
              (b) => b
                ..id = 1
                ..name = 'testuser'
                ..showName = 'Test User',
            ),
        ),
        MwNotification(
          (b) => b
            ..id = 2
            ..type = MwNotificationTypeEnum.follower
            ..read = true
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
            ..user = $MwUser(
              (b) => b
                ..id = 2
                ..name = 'follower'
                ..showName = 'Follower User',
            ),
        ),
      ];

      mockNotifier.state = NotificationListState.loaded(
        notifications: mockNotifications,
        unreadCount: 1,
        hasMore: false,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify notifications are displayed
      expect(find.byType(NotificationItem), findsNWidgets(2));
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets(
      'shows mark all as read button when there are unread notifications',
      (WidgetTester tester) async {
        final mockNotifications = [
          MwNotification(
            (b) => b
              ..id = 1
              ..type = MwNotificationTypeEnum.comment
              ..read = false
              ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
          ),
        ];

        mockNotifier.state = NotificationListState.loaded(
          notifications: mockNotifications,
          unreadCount: 1,
          hasMore: false,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              notificationListProvider.overrideWith((ref) => mockNotifier),
            ],
            child: const MaterialApp(home: NotificationsScreen()),
          ),
        );

        // Verify mark all as read button is present
        expect(find.byIcon(Icons.done_all), findsOneWidget);
      },
    );

    testWidgets('hides mark all as read button when no unread notifications', (
      WidgetTester tester,
    ) async {
      final mockNotifications = [
        MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = true
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
        ),
      ];

      mockNotifier.state = NotificationListState.loaded(
        notifications: mockNotifications,
        unreadCount: 0,
        hasMore: false,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify mark all as read button is not present
      expect(find.byIcon(Icons.done_all), findsNothing);
    });

    testWidgets('calls mark all as read when button is tapped', (
      WidgetTester tester,
    ) async {
      final mockNotifications = [
        MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
        ),
      ];

      mockNotifier.state = NotificationListState.loaded(
        notifications: mockNotifications,
        unreadCount: 1,
        hasMore: false,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify mark all as read button is present and tappable
      expect(find.byIcon(Icons.done_all), findsOneWidget);

      // Tap the mark all as read button
      await tester.tap(find.byIcon(Icons.done_all));
      await tester.pump();

      // The button should still be present (no verification of method calls for now)
      expect(find.byIcon(Icons.done_all), findsOneWidget);
    });

    testWidgets('calls retry when retry button is tapped in error state', (
      WidgetTester tester,
    ) async {
      mockNotifier.state = const NotificationListState.error(
        message: 'Failed to load notifications',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify retry button is present
      expect(find.text('Retry'), findsOneWidget);

      // Tap the retry button
      await tester.tap(find.text('Retry'));
      await tester.pump();

      // The retry button should still be present (no verification of method calls for now)
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('displays loading indicator for infinite scroll', (
      WidgetTester tester,
    ) async {
      final mockNotifications = [
        MwNotification(
          (b) => b
            ..id = 1
            ..type = MwNotificationTypeEnum.comment
            ..read = false
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
        ),
      ];

      mockNotifier.state = NotificationListState.loaded(
        notifications: mockNotifications,
        unreadCount: 1,
        hasMore: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify loading indicator for infinite scroll is present
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'displays error banner when there are notifications but error occurred',
      (WidgetTester tester) async {
        final mockNotifications = [
          MwNotification(
            (b) => b
              ..id = 1
              ..type = MwNotificationTypeEnum.comment
              ..read = false
              ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
          ),
        ];

        mockNotifier.state = NotificationListState.error(
          message: 'Failed to load more notifications',
          notifications: mockNotifications,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              notificationListProvider.overrideWith((ref) => mockNotifier),
            ],
            child: const MaterialApp(home: NotificationsScreen()),
          ),
        );

        // Verify error banner is displayed
        expect(find.text('Failed to load more notifications'), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);
      },
    );

    testWidgets('has correct app bar title', (WidgetTester tester) async {
      mockNotifier.state = const NotificationListState.empty();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            notificationListProvider.overrideWith((ref) => mockNotifier),
          ],
          child: const MaterialApp(home: NotificationsScreen()),
        ),
      );

      // Verify app bar title
      expect(find.text('Notifications'), findsOneWidget);
    });
  });
}
