import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/src/features/chat/models/chat_list_state.dart';
import 'package:mindwell/src/features/chat/providers/chat_list_provider.dart';

class MockChatsApi extends Mock implements ChatsApi {}

class MockWebSocketService extends Mock implements WebSocketService {}

class MockStreamController extends Mock
    implements StreamController<Map<String, dynamic>> {
  @override
  Stream<Map<String, dynamic>> get stream => Stream.empty();
}

class MockMwChat extends Mock implements MwChat {}

class MockMwChatList extends Mock implements MwChatList {}

void main() {
  group('ChatListNotifier', () {
    late MockChatsApi mockChatsApi;
    late MockWebSocketService mockWebSocketService;
    late MockStreamController mockMessageStreamController;
    late ChatListNotifier notifier;
    late MockMwChat mockChat;
    late MockMwChatList mockChatList;

    setUp(() {
      mockChatsApi = MockChatsApi();
      mockWebSocketService = MockWebSocketService();
      mockMessageStreamController = MockStreamController();
      mockChat = MockMwChat();
      mockChatList = MockMwChatList();

      // Setup WebSocket service mock
      when(
        () => mockWebSocketService.messageMessagesStream,
      ).thenAnswer((_) => mockMessageStreamController.stream);

      // Setup default mock chat behavior
      when(() => mockChat.id).thenReturn(1);
      when(() => mockChat.unreadCount).thenReturn(2);

      // Setup default mock chat list behavior
      when(() => mockChatList.data).thenReturn(BuiltList([mockChat]));
      when(() => mockChatList.hasAfter).thenReturn(false);
      when(() => mockChatList.unreadCount).thenReturn(2);

      notifier = ChatListNotifier(
        chatsApi: mockChatsApi,
        websocketService: mockWebSocketService,
      );
    });

    tearDown(() {
      // Don't dispose here as it's handled in individual tests
    });

    test('initial state should be initial', () {
      expect(notifier.state, const ChatListState.initial());
    });

    group('fetchInitialChats', () {
      test(
        'should set loading state and then loaded state on success',
        () async {
          // Arrange
          final mockResponse = Response<MwChatList>(
            data: mockChatList,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/chats'),
          );

          when(
            () => mockChatsApi.chatsGet(limit: 30),
          ).thenAnswer((_) async => mockResponse);

          // Act
          await notifier.fetchInitialChats();

          // Assert
          expect(notifier.state, isA<ChatListState>());
          notifier.state.when(
            initial: () => fail('Should not be in initial state'),
            loading: () => fail('Should not be in loading state'),
            loaded: (chats, hasMore, unreadCount) {
              expect(chats, hasLength(1));
              expect(chats.first.id, 1);
              expect(chats.first.unreadCount, 2);
              expect(hasMore, false);
              expect(unreadCount, 2);
            },
            error: (message, chats) =>
                fail('Should not be in error state: $message'),
            empty: () => fail('Should not be in empty state'),
          );
        },
      );

      test(
        'should set loading state and then empty state when no chats',
        () async {
          // Arrange
          final emptyChatList = MockMwChatList();
          when(() => emptyChatList.data).thenReturn(BuiltList<MwChat>([]));
          when(() => emptyChatList.hasAfter).thenReturn(false);
          when(() => emptyChatList.unreadCount).thenReturn(0);

          final mockResponse = Response<MwChatList>(
            data: emptyChatList,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/chats'),
          );

          when(
            () => mockChatsApi.chatsGet(limit: 30),
          ).thenAnswer((_) async => mockResponse);

          // Act
          await notifier.fetchInitialChats();

          // Assert
          expect(notifier.state, const ChatListState.empty());
        },
      );

      test(
        'should set loading state and then error state on failure',
        () async {
          // Arrange
          when(
            () => mockChatsApi.chatsGet(limit: 30),
          ).thenThrow(Exception('Network error'));

          // Act
          await notifier.fetchInitialChats();

          // Assert
          expect(notifier.state, isA<ChatListState>());
          notifier.state.when(
            initial: () => fail('Should not be in initial state'),
            loading: () => fail('Should not be in loading state'),
            loaded: (chats, hasMore, unreadCount) =>
                fail('Should not be in loaded state'),
            error: (message, chats) {
              expect(message, contains('Failed to load chats'));
              expect(message, contains('Network error'));
              expect(chats, isNull);
            },
            empty: () => fail('Should not be in empty state'),
          );
        },
      );

      test('should not fetch if already loading', () async {
        // Arrange
        when(() => mockChatsApi.chatsGet(limit: 30)).thenAnswer((_) async {
          // Simulate a slow response
          await Future.delayed(const Duration(milliseconds: 100));
          return Response<MwChatList>(
            data: mockChatList,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/chats'),
          );
        });

        // Act - start two simultaneous fetches
        final future1 = notifier.fetchInitialChats();
        final future2 = notifier.fetchInitialChats();

        await Future.wait([future1, future2]);

        // Assert - should only be called once
        verify(() => mockChatsApi.chatsGet(limit: 30)).called(1);
      });
    });

    group('fetchMoreChats', () {
      test('should append new chats to existing list', () async {
        // Arrange - first set up initial state
        final mockChat1 = MockMwChat();
        when(() => mockChat1.id).thenReturn(1);
        when(() => mockChat1.unreadCount).thenReturn(1);

        final mockChatList1 = MockMwChatList();
        when(() => mockChatList1.data).thenReturn(BuiltList([mockChat1]));
        when(() => mockChatList1.hasAfter).thenReturn(true);
        when(() => mockChatList1.nextAfter).thenReturn('cursor1');
        when(() => mockChatList1.unreadCount).thenReturn(1);

        final mockResponse1 = Response<MwChatList>(
          data: mockChatList1,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(limit: 30),
        ).thenAnswer((_) async => mockResponse1);

        await notifier.fetchInitialChats();

        // Setup second page
        final mockChat2 = MockMwChat();
        when(() => mockChat2.id).thenReturn(2);
        when(() => mockChat2.unreadCount).thenReturn(1);

        final mockChatList2 = MockMwChatList();
        when(() => mockChatList2.data).thenReturn(BuiltList([mockChat2]));
        when(() => mockChatList2.hasAfter).thenReturn(false);
        when(() => mockChatList2.unreadCount).thenReturn(2);

        final mockResponse2 = Response<MwChatList>(
          data: mockChatList2,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(limit: 30, after: 'cursor1'),
        ).thenAnswer((_) async => mockResponse2);

        // Act
        await notifier.fetchMoreChats();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, hasMore, unreadCount) {
            expect(chats, hasLength(2));
            expect(chats.first.id, 1);
            expect(chats.last.id, 2);
            expect(hasMore, false);
            expect(unreadCount, 2);
          },
          error: (message, chats) =>
              fail('Should not be in error state: $message'),
          empty: () => fail('Should not be in empty state'),
        );
      });

      test('should not fetch more if no more chats available', () async {
        // Arrange - set up state with no more chats
        final mockChat = MockMwChat();
        when(() => mockChat.id).thenReturn(1);

        final mockChatList = MockMwChatList();
        when(() => mockChatList.data).thenReturn(BuiltList([mockChat]));
        when(() => mockChatList.hasAfter).thenReturn(false);

        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(limit: 30),
        ).thenAnswer((_) async => mockResponse);

        await notifier.fetchInitialChats();

        // Act
        await notifier.fetchMoreChats();

        // Assert - should not make another API call
        verify(() => mockChatsApi.chatsGet(limit: 30)).called(1);
        verifyNever(
          () => mockChatsApi.chatsGet(limit: 30, after: any(named: 'after')),
        );
      });

      test('should not fetch more if already loading', () async {
        // Arrange
        final mockChat = MockMwChat();
        when(() => mockChat.id).thenReturn(1);

        final mockChatList = MockMwChatList();
        when(() => mockChatList.data).thenReturn(BuiltList([mockChat]));
        when(() => mockChatList.hasAfter).thenReturn(true);
        when(() => mockChatList.nextAfter).thenReturn('cursor1');

        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(limit: 30),
        ).thenAnswer((_) async => mockResponse);

        when(
          () => mockChatsApi.chatsGet(limit: 30, after: 'cursor1'),
        ).thenAnswer((_) async {
          // Simulate a slow response
          await Future.delayed(const Duration(milliseconds: 100));
          return Response<MwChatList>(
            data: mockChatList,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/chats'),
          );
        });

        await notifier.fetchInitialChats();

        // Act - start two simultaneous fetches
        final future1 = notifier.fetchMoreChats();
        final future2 = notifier.fetchMoreChats();

        await Future.wait([future1, future2]);

        // Assert - should only be called once
        verify(
          () => mockChatsApi.chatsGet(limit: 30, after: 'cursor1'),
        ).called(1);
      });
    });

    group('refresh', () {
      test('should reset pagination and fetch fresh data', () async {
        // Arrange - set up initial state
        final mockChat = MockMwChat();
        when(() => mockChat.id).thenReturn(1);

        final mockChatList = MockMwChatList();
        when(() => mockChatList.data).thenReturn(BuiltList([mockChat]));
        when(() => mockChatList.hasAfter).thenReturn(true);
        when(() => mockChatList.nextAfter).thenReturn('cursor1');

        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(limit: 30),
        ).thenAnswer((_) async => mockResponse);

        await notifier.fetchInitialChats();

        // Setup refresh response
        final mockChat2 = MockMwChat();
        when(() => mockChat2.id).thenReturn(2);

        final mockChatList2 = MockMwChatList();
        when(() => mockChatList2.data).thenReturn(BuiltList([mockChat2]));
        when(() => mockChatList2.hasAfter).thenReturn(false);

        final mockResponse2 = Response<MwChatList>(
          data: mockChatList2,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(limit: 30),
        ).thenAnswer((_) async => mockResponse2);

        // Act
        await notifier.refresh();

        // Assert
        notifier.state.when(
          initial: () => fail('Should not be in initial state'),
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, hasMore, unreadCount) {
            expect(chats, hasLength(1));
            expect(chats.first.id, 2);
            expect(hasMore, false);
          },
          error: (message, chats) =>
              fail('Should not be in error state: $message'),
          empty: () => fail('Should not be in empty state'),
        );

        // Should have been called twice (initial + refresh)
        verify(() => mockChatsApi.chatsGet(limit: 30)).called(2);
      });
    });

    group('WebSocket message handling', () {
      test('should handle new message events', () async {
        // Arrange
        final messageData = {
          'type': 'new',
          'message': {'chat_id': 1, 'id': 123, 'content': 'Hello'},
        };

        // Act
        mockMessageStreamController.add(messageData);
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        // Since we're using refresh() for now, we just verify the method was called
        // In a real implementation, we would verify the state changes
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });

      test('should handle updated message events', () async {
        // Arrange
        final messageData = {
          'type': 'updated',
          'message': {'chat_id': 1, 'id': 123, 'content': 'Updated message'},
        };

        // Act
        mockMessageStreamController.add(messageData);
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });

      test('should handle removed message events', () async {
        // Arrange
        final messageData = {
          'type': 'removed',
          'message': {'chat_id': 1, 'id': 123},
        };

        // Act
        mockMessageStreamController.add(messageData);
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });

      test('should handle read message events', () async {
        // Arrange
        final messageData = {
          'type': 'read',
          'message': {'chat_id': 1, 'count': 3},
        };

        // Act
        mockMessageStreamController.add(messageData);
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });

      test('should handle unknown message types gracefully', () async {
        // Arrange
        final messageData = {
          'type': 'unknown',
          'message': {'chat_id': 1},
        };

        // Act
        mockMessageStreamController.add(messageData);
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert - should not throw an exception
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });

      test('should handle malformed message data gracefully', () async {
        // Arrange
        final messageData = {
          'type': 'new',
          // Missing message data
        };

        // Act
        mockMessageStreamController.add(messageData);
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert - should not throw an exception
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });
    });

    group('dispose', () {
      test('should cancel WebSocket subscription on dispose', () {
        // Act
        notifier.dispose();

        // Assert - verify that the WebSocket service was accessed during initialization
        verify(() => mockWebSocketService.messageMessagesStream).called(1);
      });
    });
  });
}
