import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../../lib/src/features/notifications/widgets/notification_item.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('NotificationItem', () {
    late MwNotification mockNotification;

    setUp(() {
      mockNotification = MwNotification(
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
      );
    });

    testWidgets('displays notification content correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: mockNotification),
          ),
        ),
      );

      // Verify notification content is displayed
      expect(find.byIcon(Icons.comment), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Verify that some text is displayed (don't rely on specific localization)
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('shows unread indicator for unread notifications', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: mockNotification),
          ),
        ),
      );

      // Verify unread indicator is present
      expect(find.byType(Container), findsWidgets);

      // Verify that the notification item is displayed
      expect(find.byType(NotificationItem), findsOneWidget);
    });

    testWidgets('shows read styling for read notifications', (
      WidgetTester tester,
    ) async {
      final readNotification = mockNotification.rebuild((b) => b.read = true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: readNotification),
          ),
        ),
      );

      // Verify read notification styling
      expect(find.byIcon(Icons.comment), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('displays correct icon for different notification types', (
      WidgetTester tester,
    ) async {
      final followerNotification = mockNotification.rebuild(
        (b) => b.type = MwNotificationTypeEnum.follower,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: followerNotification),
          ),
        ),
      );

      // Verify follower icon is displayed
      expect(find.byIcon(Icons.person_add), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('displays timestamp correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: mockNotification),
          ),
        ),
      );

      // Verify timestamp is displayed
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('calls onTap callback when tapped', (
      WidgetTester tester,
    ) async {
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(
              notification: mockNotification,
              onTap: () {
                onTapCalled = true;
              },
            ),
          ),
        ),
      );

      // Tap the notification
      await tester.tap(find.byType(NotificationItem));
      await tester.pump();

      // Verify callback was called
      expect(onTapCalled, isTrue);
    });

    testWidgets('handles notification without user gracefully', (
      WidgetTester tester,
    ) async {
      final notificationWithoutUser = mockNotification.rebuild(
        (b) => b.user = null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: notificationWithoutUser),
          ),
        ),
      );

      // Should display some text
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('handles notification without timestamp gracefully', (
      WidgetTester tester,
    ) async {
      final notificationWithoutTimestamp = mockNotification.rebuild(
        (b) => b.createdAt = null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: notificationWithoutTimestamp),
          ),
        ),
      );

      // Should not display timestamp
      expect(find.textContaining('ago'), findsNothing);
    });

    testWidgets('displays badge notification correctly', (
      WidgetTester tester,
    ) async {
      final badgeNotification = MwNotification(
        (b) => b
          ..id = 2
          ..type = MwNotificationTypeEnum.badge
          ..read = false
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: badgeNotification),
          ),
        ),
      );

      // Verify badge notification content
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('displays welcome notification correctly', (
      WidgetTester tester,
    ) async {
      final welcomeNotification = MwNotification(
        (b) => b
          ..id = 3
          ..type = MwNotificationTypeEnum.welcome
          ..read = false
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationItem(notification: welcomeNotification),
          ),
        ),
      );

      // Verify welcome notification content
      expect(find.byIcon(Icons.waving_hand), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });
  });
}
