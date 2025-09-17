import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:go_router/go_router.dart';

import 'package:mindwell/src/features/chat/screens/chat_list_screen.dart';
import 'package:mindwell/src/features/chat/widgets/chat_list_shimmer.dart';
import 'package:mindwell/src/features/chat/widgets/chat_list_item.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/providers/websocket_provider.dart';
import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/l10n/app_localizations.dart';

class MockChatsApi extends Mock implements ChatsApi {}

class MockMwChat extends Mock implements MwChat {}

class MockMwChatList extends Mock implements MwChatList {}

class MockMwUser extends Mock implements MwUser {}

class MockWebSocketService extends Mock implements WebSocketService {}

void main() {
  group('ChatListScreen', () {
    late MockChatsApi mockChatsApi;
    late MockWebSocketService mockWebSocketService;
    late MockMwChat mockChat;
    late MockMwChatList mockChatList;
    late MockMwUser mockPartner;
    late ProviderContainer container;

    setUp(() {
      mockChatsApi = MockChatsApi();
      mockWebSocketService = MockWebSocketService();
      mockChat = MockMwChat();
      mockChatList = MockMwChatList();
      mockPartner = MockMwUser();

      // Setup default mock partner behavior
      when(() => mockPartner.name).thenReturn('testuser');
      when(() => mockPartner.showName).thenReturn('Test User');
      when(() => mockPartner.isOnline).thenReturn(false);

      // Setup default mock chat behavior
      when(() => mockChat.id).thenReturn(1);
      when(() => mockChat.unreadCount).thenReturn(2);
      when(() => mockChat.partner).thenReturn(mockPartner);

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

      // Setup WebSocket service mock
      when(
        () => mockWebSocketService.messageMessagesStream,
      ).thenAnswer((_) => Stream.empty());

      // Create container with mocked dependencies
      container = ProviderContainer(
        overrides: [
          chatsApiProvider.overrideWithValue(mockChatsApi),
          websocketServiceProvider.overrideWithValue(mockWebSocketService),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    Widget createTestWidget() {
      return UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('ru', '')],
          routerConfig: GoRouter(
            initialLocation: '/chats',
            routes: [
              GoRoute(
                path: '/chats',
                builder: (context, state) => const ChatListScreen(),
              ),
              GoRoute(
                path: '/chats/:username',
                builder: (context, state) => const Scaffold(
                  body: Center(child: Text('Chat Messages Screen')),
                ),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('should display loading state initially', (
      WidgetTester tester,
    ) async {
      // Create a new container that will start in loading state
      final loadingContainer = ProviderContainer(
        overrides: [
          chatsApiProvider.overrideWithValue(mockChatsApi),
          websocketServiceProvider.overrideWithValue(mockWebSocketService),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: loadingContainer,
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', ''), Locale('ru', '')],
            home: const ChatListScreen(),
          ),
        ),
      );

      // The loading state shows a shimmer, not a CircularProgressIndicator
      expect(find.byType(ChatListShimmer), findsOneWidget);

      loadingContainer.dispose();
    });

    testWidgets('should display empty state when no chats', (
      WidgetTester tester,
    ) async {
      // Setup empty chat list
      final emptyChatList = MockMwChatList();
      when(() => emptyChatList.data).thenReturn(BuiltList([]));
      when(() => emptyChatList.hasAfter).thenReturn(false);

      final emptyResponse = Response<MwChatList>(
        data: emptyChatList,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/chats'),
      );

      when(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).thenAnswer((_) async => emptyResponse);

      await tester.pumpWidget(createTestWidget());

      // Wait for localization to load
      await tester.pumpAndSettle();

      expect(find.text('No conversations yet'), findsOneWidget);
      expect(
        find.text('Start a conversation with someone to see it here'),
        findsOneWidget,
      );
    });

    testWidgets('should display chat list when chats are available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for localization to load
      await tester.pumpAndSettle();

      // The chat list should be displayed - look for ChatListItem which contains ListTile
      expect(find.byType(ChatListItem), findsOneWidget);
    });

    testWidgets('should navigate to chat messages when chat item is tapped', (
      WidgetTester tester,
    ) async {
      // Ensure the API mock is properly set up for this test
      when(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).thenAnswer(
        (_) async => Response<MwChatList>(
          data: mockChatList,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/chats'),
        ),
      );

      await tester.pumpWidget(createTestWidget());

      // Wait for localization to load
      await tester.pumpAndSettle();

      // Find and tap the chat list item
      final chatListItem = find.byType(ChatListItem);
      expect(chatListItem, findsOneWidget);

      await tester.tap(chatListItem);
      await tester.pumpAndSettle();

      // After navigation, we should be on the chat messages screen
      expect(find.text('Chat Messages Screen'), findsOneWidget);
    });

    testWidgets('should display error state when there is an error', (
      WidgetTester tester,
    ) async {
      // Setup API to throw error
      when(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).thenThrow(Exception('Network error'));

      await tester.pumpWidget(createTestWidget());

      // Wait for localization to load
      await tester.pumpAndSettle();

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(
        find.text('Failed to load chats: Exception: Network error'),
        findsOneWidget,
      );
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should call refresh when retry button is tapped', (
      WidgetTester tester,
    ) async {
      // Setup API to throw error initially
      when(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).thenThrow(Exception('Network error'));

      await tester.pumpWidget(createTestWidget());

      // Wait for localization to load
      await tester.pumpAndSettle();

      final retryButton = find.text('Retry');
      expect(retryButton, findsOneWidget);

      // Setup API to return success on retry
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

      await tester.tap(retryButton);
      await tester.pumpAndSettle();

      // Verify that the API was called again (retry)
      verify(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).called(greaterThan(1));
    });

    testWidgets('should call refresh when pull to refresh is triggered', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Wait for localization to load
      await tester.pumpAndSettle();

      // Find the RefreshIndicator and trigger pull to refresh
      final refreshIndicator = find.byType(RefreshIndicator);
      expect(refreshIndicator, findsOneWidget);

      // Simulate pull to refresh
      await tester.drag(find.byType(RefreshIndicator), const Offset(0, 500));
      await tester.pumpAndSettle();

      // Verify that the API was called again (refresh)
      verify(
        () => mockChatsApi.chatsGet(
          limit: any(named: 'limit'),
          after: any(named: 'after'),
          before: any(named: 'before'),
        ),
      ).called(greaterThan(1));
    });
  });
}
