import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/src/features/chat/models/chat_messages_state.dart';
import 'package:mindwell/src/features/chat/providers/chat_messages_provider.dart';

class MockChatsApi extends Mock implements ChatsApi {}

class MockWebSocketService extends Mock implements WebSocketService {
  @override
  Stream<Map<String, dynamic>> get messageMessagesStream => Stream.empty();
}

void main() {
  group('ChatMessagesNotifier', () {
    late MockChatsApi mockChatsApi;
    late MockWebSocketService mockWebSocketService;
    late ChatMessagesNotifier notifier;

    const testUsername = 'testuser';
    const testMessageId = 123;
    const testChatId = 456;

    setUp(() {
      mockChatsApi = MockChatsApi();
      mockWebSocketService = MockWebSocketService();

      notifier = ChatMessagesNotifier(
        username: testUsername,
        chatsApi: mockChatsApi,
        websocketService: mockWebSocketService,
      );
    });

    tearDown(() {
      notifier.dispose();
    });

    group('fetchInitialMessages', () {
      test('should fetch initial messages successfully', () async {
        // Arrange
        final mockMessage = MwMessage(
          (b) => b
            ..id = testMessageId
            ..chatId = testChatId
            ..content = 'Test message'
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
            ..read = false,
        );

        final mockMessageList = MwMessageList(
          (b) => b
            ..data = ListBuilder<MwMessage>([mockMessage])
            ..hasAfter = false
            ..nextAfter = null,
        );

        final mockResponse = Response<MwMessageList>(
          data: mockMessageList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockChatsApi.chatsNameMessagesGet(
            name: testUsername,
            limit: 30,
            after: null,
            before: null,
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.fetchInitialMessages();

        // Assert
        expect(notifier.state, isA<ChatMessagesLoaded>());
        final loadedState = notifier.state as ChatMessagesLoaded;
        expect(loadedState.messages, hasLength(1));
        expect(loadedState.messages.first.id, equals(testMessageId));
        expect(loadedState.messages.first.content, equals('Test message'));
        expect(loadedState.hasMore, isFalse);
      });

      test('should handle empty message list', () async {
        // Arrange
        final mockMessageList = MwMessageList(
          (b) => b
            ..data = ListBuilder<MwMessage>(<MwMessage>[])
            ..hasAfter = false
            ..nextAfter = null,
        );

        final mockResponse = Response<MwMessageList>(
          data: mockMessageList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockChatsApi.chatsNameMessagesGet(
            name: testUsername,
            limit: 30,
            after: null,
            before: null,
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.fetchInitialMessages();

        // Assert
        expect(notifier.state, isA<ChatMessagesLoaded>());
        final loadedState = notifier.state as ChatMessagesLoaded;
        expect(loadedState.messages, isEmpty);
        expect(loadedState.hasMore, isFalse);
      });

      test('should handle API error', () async {
        // Arrange
        when(
          () => mockChatsApi.chatsNameMessagesGet(
            name: testUsername,
            limit: 30,
            after: null,
            before: null,
          ),
        ).thenThrow(Exception('API Error'));

        // Act
        await notifier.fetchInitialMessages();

        // Assert
        expect(notifier.state, isA<ChatMessagesError>());
        final errorState = notifier.state as ChatMessagesError;
        expect(errorState.message, contains('Failed to load messages'));
      });
    });

    group('sendMessage', () {
      test('should send message with optimistic update', () async {
        // Arrange
        const messageText = 'Hello, world!';
        final mockSentMessage = MwMessage(
          (b) => b
            ..id = testMessageId
            ..chatId = testChatId
            ..content = messageText
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
            ..read = false,
        );

        final mockResponse = Response<MwMessage>(
          data: mockSentMessage,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockChatsApi.chatsNameMessagesPost(
            name: testUsername,
            content: messageText,
            uid: any(named: 'uid'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Set initial state
        notifier.state = const ChatMessagesState.loaded(
          messages: [],
          messageStatus: {},
        );

        // Act
        await notifier.sendMessage(messageText);

        // Assert
        expect(notifier.state, isA<ChatMessagesLoaded>());
        final loadedState = notifier.state as ChatMessagesLoaded;
        expect(loadedState.messages, hasLength(1));
        expect(loadedState.messages.first.content, equals(messageText));
        expect(
          loadedState.messageStatus[testMessageId],
          equals(MessageStatus.sent),
        );
        expect(loadedState.isSending, isFalse);
      });

      test('should handle send message failure', () async {
        // Arrange
        const messageText = 'Hello, world!';

        when(
          () => mockChatsApi.chatsNameMessagesPost(
            name: testUsername,
            content: messageText,
            uid: any(named: 'uid'),
          ),
        ).thenThrow(Exception('Send failed'));

        // Set initial state
        notifier.state = const ChatMessagesState.loaded(
          messages: [],
          messageStatus: {},
        );

        // Act
        await notifier.sendMessage(messageText);

        // Assert
        expect(notifier.state, isA<ChatMessagesLoaded>());
        final loadedState = notifier.state as ChatMessagesLoaded;
        expect(loadedState.messages, hasLength(1));
        expect(loadedState.messages.first.content, equals(messageText));
        expect(loadedState.messageStatus[-1], equals(MessageStatus.failed));
        expect(loadedState.isSending, isFalse);
      });

      test('should not send empty message', () async {
        // Arrange
        when(
          () => mockChatsApi.chatsNameMessagesPost(
            name: testUsername,
            content: any(named: 'content'),
            uid: any(named: 'uid'),
          ),
        ).thenAnswer((_) async => throw Exception('Should not be called'));

        // Set initial state
        notifier.state = const ChatMessagesState.loaded(
          messages: [],
          messageStatus: {},
        );

        // Act
        await notifier.sendMessage('');
        await notifier.sendMessage('   ');

        // Assert
        verifyNever(
          () => mockChatsApi.chatsNameMessagesPost(
            name: any(named: 'name'),
            content: any(named: 'content'),
            uid: any(named: 'uid'),
          ),
        );
      });
    });

    group('markAsRead', () {
      test('should mark messages as read successfully', () async {
        // Arrange
        final mockResponse = Response<MwNotificationsReadPut200Response>(
          data: MwNotificationsReadPut200Response(),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockChatsApi.chatsNameReadPut(
            name: testUsername,
            message: any(named: 'message'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Set initial state
        final testMessage = MwMessage(
          (b) => b
            ..id = testMessageId
            ..content = 'Test message'
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
        );

        notifier.state = ChatMessagesState.loaded(
          messages: [testMessage],
          messageStatus: {},
        );

        // Act
        await notifier.markAsRead();

        // Assert
        verify(
          () => mockChatsApi.chatsNameReadPut(
            name: testUsername,
            message: testMessageId,
          ),
        ).called(1);
      });

      test('should handle mark as read failure', () async {
        // Arrange
        when(
          () => mockChatsApi.chatsNameReadPut(
            name: testUsername,
            message: any(named: 'message'),
          ),
        ).thenThrow(Exception('Mark as read failed'));

        // Set initial state
        notifier.state = const ChatMessagesState.loaded(
          messages: [],
          messageStatus: {},
        );

        // Act
        await notifier.markAsRead();

        // Assert
        // Should not change state on error
        expect(notifier.state, isA<ChatMessagesLoaded>());
      });
    });

    group('refresh', () {
      test('should reset pagination and fetch fresh data', () async {
        // Arrange
        final mockMessage = MwMessage(
          (b) => b
            ..id = testMessageId
            ..content = 'Refreshed message'
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
        );

        final mockMessageList = MwMessageList(
          (b) => b
            ..data = ListBuilder<MwMessage>([mockMessage])
            ..hasAfter = false
            ..nextAfter = null,
        );

        final mockResponse = Response<MwMessageList>(
          data: mockMessageList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );

        when(
          () => mockChatsApi.chatsNameMessagesGet(
            name: testUsername,
            limit: 30,
            after: null,
            before: null,
          ),
        ).thenAnswer((_) async => mockResponse);

        // Set initial state
        notifier.state = const ChatMessagesState.loaded(
          messages: [],
          messageStatus: {},
          hasMore: true,
        );

        // Act
        await notifier.refresh();

        // Assert
        expect(notifier.state, isA<ChatMessagesLoaded>());
        final loadedState = notifier.state as ChatMessagesLoaded;
        expect(loadedState.messages, hasLength(1));
        expect(loadedState.messages.first.content, equals('Refreshed message'));
      });
    });
  });
}
