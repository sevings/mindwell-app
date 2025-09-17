import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/src/core/services/connection_service.dart';
import 'package:mindwell/src/core/models/connection_status.dart' as core;
import 'package:mindwell/src/features/chat/models/chat_messages_state.dart';
import 'package:mindwell/src/features/chat/providers/chat_messages_provider.dart';
import 'package:mindwell/src/features/chat/services/offline_message_service.dart';

class MockChatsApi extends Mock implements ChatsApi {}

class MockWebSocketService extends Mock implements WebSocketService {
  @override
  Stream<Map<String, dynamic>> get messageMessagesStream => Stream.empty();
}

class MockConnectionService extends Mock implements ConnectionService {
  @override
  Stream<core.ConnectionStatus> get statusStream =>
      Stream.value(core.ConnectionStatus.connected);

  @override
  core.ConnectionStatus get currentStatus => core.ConnectionStatus.connected;
}

class MockOfflineMessageService extends Mock implements OfflineMessageService {
  @override
  List<MwMessage> getCachedMessages(String chatUsername) => [];

  @override
  List<Map<String, dynamic>> getQueuedMessages() => [];

  @override
  Future<void> cacheMessages(
    String chatUsername,
    List<MwMessage> messages,
  ) async {}

  @override
  Future<void> queueMessage(String chatUsername, String content) async {}

  @override
  Future<void> removeQueuedMessage(String chatUsername, int messageId) async {}

  @override
  Future<void> markMessagesAsRead(
    String chatUsername,
    List<int> messageIds,
  ) async {}

  @override
  Set<int> getReadMessageIds(String chatUsername) => {};
}

void main() {
  group('ChatMessagesNotifier', () {
    late MockChatsApi mockChatsApi;
    late MockWebSocketService mockWebSocketService;
    late MockConnectionService mockConnectionService;
    late MockOfflineMessageService mockOfflineMessageService;
    late ChatMessagesNotifier notifier;

    const testUsername = 'testuser';
    const testMessageId = 123;
    const testChatId = 456;

    setUp(() {
      mockChatsApi = MockChatsApi();
      mockWebSocketService = MockWebSocketService();
      mockConnectionService = MockConnectionService();
      mockOfflineMessageService = MockOfflineMessageService();

      notifier = ChatMessagesNotifier(
        username: testUsername,
        chatsApi: mockChatsApi,
        websocketService: mockWebSocketService,
        connectionService: mockConnectionService,
        offlineMessageService: mockOfflineMessageService,
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
            ..hasBefore = false
            ..nextBefore = null,
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

      test('should order messages correctly with newest at the end', () async {
        // Arrange
        final olderMessage = MwMessage(
          (b) => b
            ..id = 1
            ..chatId = testChatId
            ..content = 'Older message'
            ..createdAt =
                DateTime.now()
                    .subtract(const Duration(hours: 1))
                    .millisecondsSinceEpoch /
                1000
            ..read = false,
        );

        final newerMessage = MwMessage(
          (b) => b
            ..id = 2
            ..chatId = testChatId
            ..content = 'Newer message'
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
            ..read = false,
        );

        // API returns messages in reverse chronological order (newest first)
        final mockMessageList = MwMessageList(
          (b) => b
            ..data = ListBuilder<MwMessage>([newerMessage, olderMessage])
            ..hasBefore = false
            ..nextBefore = null,
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
        expect(loadedState.messages, hasLength(2));
        // After reversing, older message should be first, newer message should be last
        expect(loadedState.messages.first.content, equals('Older message'));
        expect(loadedState.messages.last.content, equals('Newer message'));
      });

      test('should handle empty message list', () async {
        // Arrange
        final mockMessageList = MwMessageList(
          (b) => b
            ..data = ListBuilder<MwMessage>(<MwMessage>[])
            ..hasBefore = false
            ..nextBefore = null,
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

    group('fetchMoreMessages', () {
      test('should fetch more messages using before parameter', () async {
        // Arrange
        final olderMessage = MwMessage(
          (b) => b
            ..id = 1
            ..chatId = testChatId
            ..content = 'Older message'
            ..createdAt =
                DateTime.now()
                    .subtract(const Duration(hours: 1))
                    .millisecondsSinceEpoch /
                1000
            ..read = false,
        );

        final newerMessage = MwMessage(
          (b) => b
            ..id = 2
            ..chatId = testChatId
            ..content = 'Newer message'
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
            ..read = false,
        );

        final mockMessageList = MwMessageList(
          (b) => b
            ..data = ListBuilder<MwMessage>([olderMessage])
            ..hasBefore = false
            ..nextBefore = null,
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
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Set initial state with newer message
        notifier.state = ChatMessagesState.loaded(
          messages: [newerMessage],
          messageStatus: {},
          hasMore: true,
        );

        // Act
        await notifier.fetchMoreMessages();

        // Assert
        expect(notifier.state, isA<ChatMessagesLoaded>());
        final loadedState = notifier.state as ChatMessagesLoaded;
        expect(loadedState.messages, hasLength(2));
        // Older message should be first (for ListView with reverse: true)
        expect(loadedState.messages.first.content, equals('Older message'));
        expect(loadedState.messages.last.content, equals('Newer message'));
        expect(loadedState.hasMore, isFalse);
      });

      test('should not fetch more messages when hasMore is false', () async {
        // Arrange
        final testMessage = MwMessage(
          (b) => b
            ..id = testMessageId
            ..content = 'Test message'
            ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000,
        );

        // Set initial state with hasMore = false
        notifier.state = ChatMessagesState.loaded(
          messages: [testMessage],
          messageStatus: {},
          hasMore: false,
        );

        // Clear any previous calls from initialization
        clearInteractions(mockChatsApi);

        // Act
        await notifier.fetchMoreMessages();

        // Assert
        verifyNever(
          () => mockChatsApi.chatsNameMessagesGet(
            name: any(named: 'name'),
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        );
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
            ..hasBefore = false
            ..nextBefore = null,
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
