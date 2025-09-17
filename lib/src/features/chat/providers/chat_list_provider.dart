import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/providers/websocket_provider.dart';
import '../../../core/services/websocket_service.dart';
import '../models/chat_list_state.dart';

/// Provider for the ChatListNotifier that manages the state of the chat list.
final chatListProvider = StateNotifierProvider<ChatListNotifier, ChatListState>(
  (ref) {
    final chatsApi = ref.read(chatsApiProvider);
    final websocketService = ref.read(websocketServiceProvider);

    return ChatListNotifier(
      chatsApi: chatsApi,
      websocketService: websocketService,
    );
  },
);

/// Notifier that manages the state and logic for fetching and managing chat list.
///
/// This class handles:
/// - Fetching initial chat list from API
/// - Implementing infinite scrolling with pagination
/// - Pull-to-refresh functionality
/// - Real-time updates via WebSocket messages
/// - Error handling and offline support
class ChatListNotifier extends StateNotifier<ChatListState> {
  final ChatsApi _chatsApi;
  final WebSocketService _websocketService;
  final Logger _logger = Logger('ChatListNotifier');

  String? _nextAfter;
  bool _isLoadingMore = false;
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  ChatListNotifier({
    required ChatsApi chatsApi,
    required WebSocketService websocketService,
  }) : _chatsApi = chatsApi,
       _websocketService = websocketService,
       super(const ChatListState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by setting up WebSocket message listening.
  void _initialize() {
    _logger.info('Initializing ChatListNotifier');

    // Listen to WebSocket messages for real-time updates
    _messageSubscription = _websocketService.messageMessagesStream.listen(
      _handleWebSocketMessage,
      onError: (error) {
        _logger.warning('WebSocket message error: $error');
      },
    );
  }

  /// Fetch the initial chat list from the API.
  Future<void> fetchInitialChats() async {
    if (state.when(
      initial: () => false,
      loading: () => true,
      loaded: (chats, hasMore, unreadCount) => false,
      error: (message, chats) => false,
      empty: () => false,
    )) {
      return; // Prevent multiple simultaneous loads
    }

    _logger.info('Fetching initial chat list');
    state = const ChatListState.loading();

    try {
      final response = await _chatsApi.chatsGet(limit: 30);
      final chatList = response.data;

      if (chatList == null) {
        _logger.warning('Received null chat list from API');
        state = const ChatListState.empty();
        return;
      }

      final chats = chatList.data?.toList() ?? [];
      _nextAfter = chatList.nextAfter;

      _logger.info('Fetched ${chats.length} chats from API');

      if (chats.isEmpty) {
        state = const ChatListState.empty();
      } else {
        state = ChatListState.loaded(
          chats: chats,
          hasMore: chatList.hasAfter ?? false,
          unreadCount: chatList.unreadCount ?? 0,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch initial chats', e, stackTrace);
      state = ChatListState.error(
        message: 'Failed to load chats: ${e.toString()}',
      );
    }
  }

  /// Fetch more chats for infinite scrolling.
  ///
  /// This method appends new chats to the existing list.
  Future<void> fetchMoreChats() async {
    if (_isLoadingMore) return;

    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (chats, hasMore, unreadCount) =>
          (chats: chats, hasMore: hasMore, unreadCount: unreadCount),
      error: (message, chats) => null,
      empty: () => null,
    );

    if (currentState == null || !currentState.hasMore) return;

    _isLoadingMore = true;
    _logger.info('Fetching more chats');

    try {
      final response = await _chatsApi.chatsGet(limit: 30, after: _nextAfter);
      final chatList = response.data;

      if (chatList != null) {
        final newChats = chatList.data?.toList() ?? [];
        _nextAfter = chatList.nextAfter;

        final allChats = [...currentState.chats, ...newChats];

        _logger.info('Fetched ${newChats.length} more chats');
        state = ChatListState.loaded(
          chats: allChats,
          hasMore: chatList.hasAfter ?? false,
          unreadCount: chatList.unreadCount ?? currentState.unreadCount,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch more chats', e, stackTrace);
      // Don't change state on error - user can retry
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Refresh the chat list by fetching fresh data.
  ///
  /// This method is called for pull-to-refresh functionality.
  Future<void> refresh() async {
    _logger.info('Refreshing chat list');

    // Reset pagination
    _nextAfter = null;

    // Fetch fresh data
    await fetchInitialChats();
  }

  /// Handle incoming WebSocket messages for real-time updates.
  ///
  /// This method processes different types of message events:
  /// - new: A new message was received
  /// - updated: A message was updated
  /// - removed: A message was removed
  /// - read: Messages were marked as read
  void _handleWebSocketMessage(Map<String, dynamic> messageData) {
    try {
      final eventType = messageData['type'] as String?;
      final message = messageData['message'] as Map<String, dynamic>?;

      if (message == null) {
        _logger.warning('Received WebSocket message without message data');
        return;
      }

      final chatId = message['chat_id'] as int?;
      if (chatId == null) {
        _logger.warning('Received WebSocket message without chat_id');
        return;
      }

      _logger.fine('Processing WebSocket message: $eventType for chat $chatId');

      switch (eventType) {
        case 'new':
          _handleNewMessage(message, chatId);
          break;
        case 'updated':
          _handleUpdatedMessage(message, chatId);
          break;
        case 'removed':
          _handleRemovedMessage(message, chatId);
          break;
        case 'read':
          _handleReadMessages(message, chatId);
          break;
        default:
          _logger.warning('Unknown WebSocket message type: $eventType');
      }
    } catch (e, stackTrace) {
      _logger.severe('Error handling WebSocket message', e, stackTrace);
    }
  }

  /// Handle a new message event.
  ///
  /// For now, we'll refresh the chat list to get the latest data.
  /// This ensures we have the most up-to-date information from the server.
  void _handleNewMessage(Map<String, dynamic> messageData, int chatId) {
    _logger.info(
      'New message received for chat $chatId, refreshing chat list...',
    );
    refresh();
  }

  /// Handle an updated message event.
  ///
  /// For now, we'll refresh the chat list to get the latest data.
  void _handleUpdatedMessage(Map<String, dynamic> messageData, int chatId) {
    _logger.info('Message updated in chat $chatId, refreshing chat list...');
    refresh();
  }

  /// Handle a removed message event.
  ///
  /// For now, we'll refresh the chat list to get the latest data.
  void _handleRemovedMessage(Map<String, dynamic> messageData, int chatId) {
    _logger.info('Message removed from chat $chatId, refreshing chat list...');
    refresh();
  }

  /// Handle a read messages event.
  ///
  /// For now, we'll refresh the chat list to get the latest data.
  void _handleReadMessages(Map<String, dynamic> messageData, int chatId) {
    _logger.info(
      'Messages marked as read in chat $chatId, refreshing chat list...',
    );
    refresh();
  }

  @override
  void dispose() {
    _logger.info('Disposing ChatListNotifier');
    _messageSubscription?.cancel();
    super.dispose();
  }
}
