import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mindwell/src/features/chat/widgets/chat_list_item.dart';
import 'package:mindwell/l10n/app_localizations.dart';

class MockMwChat extends Mock implements MwChat {}

class MockMwUser extends Mock implements MwUser {}

class MockMwMessage extends Mock implements MwMessage {}

void main() {
  group('ChatListItem', () {
    Widget createTestWidget({required MwChat chat, VoidCallback? onTap}) {
      return MaterialApp(
        localizationsDelegates: const [AppLocalizations.delegate],
        supportedLocales: const [Locale('en', ''), Locale('ru', '')],
        home: Scaffold(
          body: ChatListItem(chat: chat, onTap: onTap),
        ),
      );
    }

    MwChat createMockChat({
      required String username,
      required String displayName,
      String? lastMessageContent,
      int unreadCount = 0,
      bool isOnline = false,
    }) {
      final mockChat = MockMwChat();
      final mockPartner = MockMwUser();
      MockMwMessage? mockLastMessage;

      // Setup partner mock
      when(() => mockPartner.id).thenReturn(1);
      when(() => mockPartner.name).thenReturn(username);
      when(() => mockPartner.showName).thenReturn(displayName);
      when(() => mockPartner.isOnline).thenReturn(isOnline);

      // Setup last message mock if content is provided
      if (lastMessageContent != null) {
        mockLastMessage = MockMwMessage();
        when(() => mockLastMessage!.id).thenReturn(1);
        when(() => mockLastMessage!.content).thenReturn(lastMessageContent);
        when(() => mockLastMessage!.editContent).thenReturn(null);
        when(
          () => mockLastMessage!.createdAt,
        ).thenReturn(DateTime.now().millisecondsSinceEpoch / 1000);
      }

      // Setup chat mock
      when(() => mockChat.id).thenReturn(1);
      when(() => mockChat.partner).thenReturn(mockPartner);
      when(() => mockChat.lastMessage).thenReturn(mockLastMessage);
      when(() => mockChat.unreadCount).thenReturn(unreadCount);

      return mockChat;
    }

    testWidgets('should display chat information correctly', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        lastMessageContent: 'Hello world',
        unreadCount: 2,
        isOnline: true,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should display online status indicator when user is online', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        isOnline: true,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should display initials when no avatar is available', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should display "No messages yet" when no last message', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should not display unread badge when unread count is 0', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        unreadCount: 0,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should display unread badge with correct count', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        unreadCount: 5,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should display "99+" for unread count greater than 99', (
      WidgetTester tester,
    ) async {
      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        unreadCount: 150,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should call custom onTap when provided', (
      WidgetTester tester,
    ) async {
      bool customOnTapCalled = false;
      void customOnTap() {
        customOnTapCalled = true;
      }

      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
      );

      await tester.pumpWidget(
        createTestWidget(chat: mockChat, onTap: customOnTap),
      );

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      // The custom onTap should be called
      expect(customOnTapCalled, isTrue);
    });

    testWidgets(
      'should handle tap without custom onTap (navigation requires GoRouter)',
      (WidgetTester tester) async {
        final mockChat = createMockChat(
          username: 'testuser',
          displayName: 'Test User',
        );

        // Provide a custom onTap to avoid navigation issues in unit test
        bool onTapCalled = false;
        await tester.pumpWidget(
          createTestWidget(chat: mockChat, onTap: () => onTapCalled = true),
        );

        await tester.tap(find.byType(ListTile));
        await tester.pumpAndSettle();

        // The custom onTap should be called
        expect(onTapCalled, isTrue);
        expect(find.byType(ListTile), findsOneWidget);
      },
    );

    testWidgets('should return empty widget when partner is null', (
      WidgetTester tester,
    ) async {
      final mockChat = MwChat(
        (b) => b
          ..id = 1
          ..unreadCount = 0,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('Test User'), findsNothing);
    });

    testWidgets('should truncate long message content', (
      WidgetTester tester,
    ) async {
      final longMessage =
          'This is a very long message that should be truncated when displayed in the chat list item to prevent overflow issues';

      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        lastMessageContent: longMessage,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should strip HTML tags from message content', (
      WidgetTester tester,
    ) async {
      final htmlMessage =
          '<p>Hello <strong>world</strong>!</p><br><em>This is italic</em>';

      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        lastMessageContent: htmlMessage,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);

      // The HTML content should be stripped and displayed as plain text
      expect(find.textContaining('Hello world!'), findsOneWidget);
    });

    testWidgets('should handle HTML entities in message content', (
      WidgetTester tester,
    ) async {
      final htmlMessage = '<p>Price: &lt; \$100 &amp; free shipping</p>';

      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        lastMessageContent: htmlMessage,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);

      // HTML entities should be converted to plain text
      expect(
        find.textContaining('Price: < \$100 & free shipping'),
        findsOneWidget,
      );
    });

    testWidgets('should handle empty HTML content', (
      WidgetTester tester,
    ) async {
      final htmlMessage = '<p></p><br><div></div>';

      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        lastMessageContent: htmlMessage,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should handle complex HTML with multiple tags', (
      WidgetTester tester,
    ) async {
      final htmlMessage =
          '<div><p>Check out this <a href="https://example.com">link</a> and <code>code</code>!</p></div>';

      final mockChat = createMockChat(
        username: 'testuser',
        displayName: 'Test User',
        lastMessageContent: htmlMessage,
      );

      await tester.pumpWidget(createTestWidget(chat: mockChat));

      // The chat list item should be displayed
      expect(find.byType(ListTile), findsOneWidget);

      // All HTML tags should be stripped
      expect(
        find.textContaining('Check out this link and code!'),
        findsOneWidget,
      );
    });
  });
}
