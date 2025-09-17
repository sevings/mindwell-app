import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/chat/widgets/message_bubble.dart';
import 'package:mindwell/src/features/chat/models/chat_messages_state.dart';

void main() {
  group('MessageBubble', () {
    late MwMessage testMessage;

    setUp(() {
      testMessage = MwMessage(
        (b) => b
          ..id = 1
          ..chatId = 1
          ..author = null
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..read = false
          ..content = 'Test message content'
          ..editContent = null
          ..rights = null,
      );
    });

    testWidgets('displays message content correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage, 
                isFromCurrentUser: false,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test message content'), findsOneWidget);
    });

    testWidgets('displays sent message with correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage,
                isFromCurrentUser: true,
                messageStatus: MessageStatus.sent,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      // Check that the message bubble exists
      expect(find.text('Test message content'), findsOneWidget);

      // Check that status indicator is shown for sent messages
      expect(find.byIcon(Icons.done), findsOneWidget);
    });

    testWidgets('displays received message with avatar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage, 
                isFromCurrentUser: false,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      // Check that avatar is shown for received messages
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('shows sending status indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage,
                isFromCurrentUser: true,
                messageStatus: MessageStatus.sending,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('shows failed status indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage,
                isFromCurrentUser: true,
                messageStatus: MessageStatus.failed,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('shows read status indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage,
                isFromCurrentUser: true,
                messageStatus: MessageStatus.read,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.done_all), findsOneWidget);
    });

    testWidgets('calls onLongPress when long pressed', (
      WidgetTester tester,
    ) async {
      bool longPressCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage,
                isFromCurrentUser: false,
                onLongPress: () => longPressCalled = true,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Test message content'));
      expect(longPressCalled, isTrue);
    });

    testWidgets('displays timestamp correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: testMessage, 
                isFromCurrentUser: false,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      // Should display some form of timestamp
      expect(find.textContaining('now'), findsOneWidget);
    });

    testWidgets('handles empty message content', (WidgetTester tester) async {
      final emptyMessage = MwMessage(
        (b) => b
          ..id = 2
          ..chatId = 1
          ..author = null
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..read = false
          ..content = ''
          ..editContent = null
          ..rights = null,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: emptyMessage,
                isFromCurrentUser: false,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      // Should not crash with empty content
      expect(find.byType(MessageBubble), findsOneWidget);
    });

    testWidgets('handles null message content', (WidgetTester tester) async {
      final nullMessage = MwMessage(
        (b) => b
          ..id = 3
          ..chatId = 1
          ..author = null
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..read = false
          ..content = null
          ..editContent = null
          ..rights = null,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MessageBubble(
                message: nullMessage, 
                isFromCurrentUser: false,
                chatUsername: 'testuser',
              ),
            ),
          ),
        ),
      );

      // Should not crash with null content
      expect(find.byType(MessageBubble), findsOneWidget);
    });
  });
}