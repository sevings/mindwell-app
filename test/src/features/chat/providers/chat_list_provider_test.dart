import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/chat/models/chat_list_state.dart';
import 'package:mindwell/src/features/chat/providers/chat_list_provider.dart';
import 'package:mindwell/src/core/api/api_provider.dart';

class MockChatsApi extends Mock implements ChatsApi {}

class MockMwChat extends Mock implements MwChat {}

class MockMwChatList extends Mock implements MwChatList {}

void main() {
  group('ChatListNotifier', () {
    late MockChatsApi mockChatsApi;
    late ChatListNotifier notifier;
    late MockMwChat mockChat;
    late MockMwChatList mockChatList;
    late ProviderContainer container;

    setUp(() {
      mockChatsApi = MockChatsApi();
      mockChat = MockMwChat();
      mockChatList = MockMwChatList();

      // Setup default mock chat behavior
      when(() => mockChat.id).thenReturn(1);
      when(() => mockChat.unreadCount).thenReturn(2);

      // Setup default mock chat list behavior
      when(() => mockChatList.data).thenReturn(BuiltList([mockChat]));
      when(() => mockChatList.hasAfter).thenReturn(false);

      // Setup default API response
      final mockResponse = Response<MwChatList>(
        data: mockChatList,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/chats'),
      );

      when(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).thenAnswer((_) async => mockResponse);

      // Create container with mocked API
      container = ProviderContainer(
        overrides: [chatsApiProvider.overrideWithValue(mockChatsApi)],
      );

      notifier = container.read(chatListProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state should be loaded after automatic fetch', () {
      expect(notifier.state, isA<ChatListLoaded>());
    });

    group('refresh', () {
      test('should load chats successfully', () async {
        // Arrange
        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await notifier.refresh();

        // Assert
        expect(notifier.state, isA<ChatListLoaded>());
        notifier.state.when(
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, isFetchingMore, hasMore) {
            expect(chats, hasLength(1));
            expect(chats.first.id, 1);
            expect(hasMore, false);
            expect(isFetchingMore, false);
          },
          error: (message) => fail('Should not be in error state: $message'),
        );
      });

      test('should handle error state', () async {
        // Arrange
        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenThrow(Exception('Network error'));

        // Act
        await notifier.refresh();

        // Assert
        expect(notifier.state, isA<ChatListError>());
        notifier.state.when(
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, isFetchingMore, hasMore) =>
              fail('Should not be in loaded state'),
          error: (message) {
            expect(message, contains('Failed to load chats'));
            expect(message, contains('Network error'));
          },
        );
      });
    });

    group('loadMore', () {
      test('should append new chats to existing list', () async {
        // Arrange - first set up initial state
        final mockChat1 = MockMwChat();
        when(() => mockChat1.id).thenReturn(1);
        when(() => mockChat1.unreadCount).thenReturn(1);

        final mockChatList1 = MockMwChatList();
        when(() => mockChatList1.data).thenReturn(BuiltList([mockChat1]));
        when(() => mockChatList1.hasAfter).thenReturn(true);

        final mockResponse1 = Response<MwChatList>(
          data: mockChatList1,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse1);

        await notifier.refresh();

        // Setup second page
        final mockChat2 = MockMwChat();
        when(() => mockChat2.id).thenReturn(2);
        when(() => mockChat2.unreadCount).thenReturn(1);

        final mockChatList2 = MockMwChatList();
        when(() => mockChatList2.data).thenReturn(BuiltList([mockChat2]));
        when(() => mockChatList2.hasAfter).thenReturn(false);

        final mockResponse2 = Response<MwChatList>(
          data: mockChatList2,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: '1',
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse2);

        // Act
        await notifier.loadMore();

        // Assert
        notifier.state.when(
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, isFetchingMore, hasMore) {
            expect(chats, hasLength(2));
            expect(chats.first.id, 1);
            expect(chats.last.id, 2);
            expect(hasMore, false);
            expect(isFetchingMore, false);
          },
          error: (message) => fail('Should not be in error state: $message'),
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
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await notifier.refresh();

        // Clear the verification to only count loadMore calls
        clearInteractions(mockChatsApi);

        // Act
        await notifier.loadMore();

        // Assert - should not make another API call for loadMore
        verifyNever(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        );
      });
    });

    group('updateChat', () {
      test('should update existing chat and move to top', () async {
        // Arrange - set up initial state
        final mockChat1 = MockMwChat();
        when(() => mockChat1.id).thenReturn(1);
        when(() => mockChat1.unreadCount).thenReturn(1);

        final mockChat2 = MockMwChat();
        when(() => mockChat2.id).thenReturn(2);
        when(() => mockChat2.unreadCount).thenReturn(1);

        final mockChatList = MockMwChatList();
        when(
          () => mockChatList.data,
        ).thenReturn(BuiltList([mockChat1, mockChat2]));
        when(() => mockChatList.hasAfter).thenReturn(false);

        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await notifier.refresh();

        // Create updated chat
        final updatedChat = MockMwChat();
        when(() => updatedChat.id).thenReturn(2);
        when(() => updatedChat.unreadCount).thenReturn(5);

        // Act
        notifier.updateChat(updatedChat);

        // Assert
        notifier.state.when(
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, isFetchingMore, hasMore) {
            expect(chats, hasLength(2));
            expect(chats.first.id, 2); // Updated chat should be first
            expect(chats.last.id, 1);
          },
          error: (message) => fail('Should not be in error state: $message'),
        );
      });
    });

    group('addChat', () {
      test('should add new chat to top of list', () async {
        // Arrange - set up initial state
        final mockChat1 = MockMwChat();
        when(() => mockChat1.id).thenReturn(1);
        when(() => mockChat1.unreadCount).thenReturn(1);

        final mockChatList = MockMwChatList();
        when(() => mockChatList.data).thenReturn(BuiltList([mockChat1]));
        when(() => mockChatList.hasAfter).thenReturn(false);

        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await notifier.refresh();

        // Create new chat
        final newChat = MockMwChat();
        when(() => newChat.id).thenReturn(3);
        when(() => newChat.unreadCount).thenReturn(2);

        // Act
        notifier.addChat(newChat);

        // Assert
        notifier.state.when(
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, isFetchingMore, hasMore) {
            expect(chats, hasLength(2));
            expect(chats.first.id, 3); // New chat should be first
            expect(chats.last.id, 1);
          },
          error: (message) => fail('Should not be in error state: $message'),
        );
      });
    });

    group('removeChat', () {
      test('should remove chat from list', () async {
        // Arrange - set up initial state
        final mockChat1 = MockMwChat();
        when(() => mockChat1.id).thenReturn(1);
        when(() => mockChat1.unreadCount).thenReturn(1);

        final mockChat2 = MockMwChat();
        when(() => mockChat2.id).thenReturn(2);
        when(() => mockChat2.unreadCount).thenReturn(1);

        final mockChatList = MockMwChatList();
        when(
          () => mockChatList.data,
        ).thenReturn(BuiltList([mockChat1, mockChat2]));
        when(() => mockChatList.hasAfter).thenReturn(false);

        final mockResponse = Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        );

        when(
          () => mockChatsApi.chatsGet(
            limit: any(named: 'limit'),
            after: any(named: 'after'),
            before: any(named: 'before'),
          ),
        ).thenAnswer((_) async => mockResponse);

        await notifier.refresh();

        // Act
        notifier.removeChat(1);

        // Assert
        notifier.state.when(
          loading: () => fail('Should not be in loading state'),
          loaded: (chats, isFetchingMore, hasMore) {
            expect(chats, hasLength(1));
            expect(chats.first.id, 2);
          },
          error: (message) => fail('Should not be in error state: $message'),
        );
      });
    });
  });
}
