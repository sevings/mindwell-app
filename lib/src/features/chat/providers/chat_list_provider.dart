import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../models/chat_list_state.dart';
import '../../../core/api/api_provider.dart';
import '../../../core/providers/websocket_provider.dart';

/// Provider for the chat list state
final chatListProvider = StateNotifierProvider<ChatListNotifier, ChatListState>(
  (ref) => ChatListNotifier(ref),
);

/// Notifier for managing chat list state and operations
class ChatListNotifier extends StateNotifier<ChatListState> {
  final Ref _ref;
  static const int _pageSize = 20;
  StreamSubscription<Map<String, dynamic>>? _websocketSubscription;
  bool _isRefreshing = false;

  ChatListNotifier(this._ref) : super(const ChatListState.loading()) {
    _loadInitialChats();
    _setupWebSocketListener();
  }

  /// Loads the initial list of chats
  Future<void> _loadInitialChats() async {
    try {
      state = const ChatListState.loading();

      final chatsApi = _ref.read(chatsApiProvider);
      final response = await chatsApi.chatsGet(
        limit: _pageSize,
        after: null,
        before: null,
      );

      final chatList = response.data;
      final chats = chatList?.data?.toList() ?? [];
      final hasMore = chatList?.hasAfter == true;

      state = ChatListState.loaded(chats: chats, hasMore: hasMore);
    } catch (e) {
      state = ChatListState.error('Failed to load chats: ${e.toString()}');
    }
  }

  /// Refreshes the chat list
  Future<void> refresh() async {
    _isRefreshing = true;
    await _loadInitialChats();
    _isRefreshing = false;
  }

  /// Loads more chats for pagination
  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ChatListLoaded ||
        currentState.isFetchingMore ||
        !currentState.hasMore) {
      return;
    }

    try {
      // Set fetching more state
      state = currentState.copyWith(isFetchingMore: true);

      final chatsApi = _ref.read(chatsApiProvider);
      final lastChat = currentState.chats.last;
      final lastChatId = lastChat.id?.toString();

      final response = await chatsApi.chatsGet(
        limit: _pageSize,
        after: lastChatId,
        before: null,
      );

      final chatList = response.data;
      final newChats = chatList?.data?.toList() ?? [];
      final hasMore = chatList?.hasAfter == true;

      state = ChatListState.loaded(
        chats: [...currentState.chats, ...newChats],
        hasMore: hasMore,
      );
    } catch (e) {
      // Revert to previous state on error
      state = currentState.copyWith(isFetchingMore: false);
    }
  }

  /// Updates a specific chat in the list
  void updateChat(MwChat updatedChat) {
    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    final chats = List<MwChat>.from(currentState.chats);
    final index = chats.indexWhere((chat) => chat.id == updatedChat.id);

    if (index != -1) {
      chats[index] = updatedChat;
      // Move updated chat to top
      final updatedChatItem = chats.removeAt(index);
      chats.insert(0, updatedChatItem);

      state = currentState.copyWith(chats: chats);
    }
  }

  /// Adds a new chat to the list
  void addChat(MwChat newChat) {
    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    final chats = List<MwChat>.from(currentState.chats);
    // Check if chat already exists
    final existingIndex = chats.indexWhere((chat) => chat.id == newChat.id);

    if (existingIndex != -1) {
      // Update existing chat
      chats[existingIndex] = newChat;
      // Move to top
      final updatedChat = chats.removeAt(existingIndex);
      chats.insert(0, updatedChat);
    } else {
      // Add new chat to top
      chats.insert(0, newChat);
    }

    state = currentState.copyWith(chats: chats);
  }

  /// Removes a chat from the list
  void removeChat(int chatId) {
    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    final chats = currentState.chats
        .where((chat) => chat.id != chatId)
        .toList();
    state = currentState.copyWith(chats: chats);
  }

  /// Sets up WebSocket listener for real-time updates
  void _setupWebSocketListener() {
    final websocketService = _ref.read(websocketServiceProvider);
    _websocketSubscription = websocketService.messageMessagesStream.listen(
      _handleWebSocketMessage,
    );
  }

  /// Handles incoming WebSocket messages
  void _handleWebSocketMessage(Map<String, dynamic> message) {
    // Prevent race conditions by not processing WebSocket events during refresh
    if (_isRefreshing) return;

    final action = message['action'] as String?;
    if (action == null) return;

    switch (action) {
      case 'new':
        _handleNewMessage(message);
        break;
      case 'updated':
        _handleUpdatedMessage(message);
        break;
      case 'removed':
        _handleRemovedMessage(message);
        break;
      case 'read':
        _handleReadMessage(message);
        break;
    }
  }

  /// Handles new message events
  void _handleNewMessage(Map<String, dynamic> message) async {
    final chatId = message['chat_id'] as int?;
    if (chatId == null) return;

    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    // Check if chat already exists in the list
    final existingChatIndex = currentState.chats.indexWhere(
      (chat) => chat.id == chatId,
    );

    if (existingChatIndex != -1) {
      // Update existing chat and move to top
      final updatedChat = currentState.chats[existingChatIndex];
      final chats = List<MwChat>.from(currentState.chats);
      chats.removeAt(existingChatIndex);
      chats.insert(0, updatedChat);
      state = currentState.copyWith(chats: chats);
    } else {
      // Fetch chat details from API and add to top
      try {
        final chatsApi = _ref.read(chatsApiProvider);
        final response = await chatsApi.chatsGet(
          limit: 1,
          after: null,
          before: null,
        );
        final chatList = response.data;
        final newChats = chatList?.data?.toList() ?? [];

        if (newChats.isNotEmpty) {
          final newChat = newChats.first;
          final chats = List<MwChat>.from(currentState.chats);
          chats.insert(0, newChat);
          state = currentState.copyWith(chats: chats);
        }
      } catch (e) {
        // Silently fail - the chat will be loaded on next refresh
      }
    }
  }

  /// Handles updated message events
  void _handleUpdatedMessage(Map<String, dynamic> message) {
    final chatId = message['chat_id'] as int?;
    if (chatId == null) return;

    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    final chats = List<MwChat>.from(currentState.chats);
    final index = chats.indexWhere((chat) => chat.id == chatId);

    if (index != -1) {
      // Update the last message of the corresponding chat
      final chat = chats[index];
      final updatedLastMessage = MwMessage(
        (b) => b
          ..id = message['id'] as int?
          ..content = message['content'] as String?
          ..editContent = message['edit_content'] as String?
          ..createdAt = message['created_at'] as double?,
      );

      final updatedChat = chat.rebuild(
        (b) => b..lastMessage.replace(updatedLastMessage),
      );
      chats[index] = updatedChat;
      state = currentState.copyWith(chats: chats);
    }
  }

  /// Handles removed message events
  void _handleRemovedMessage(Map<String, dynamic> message) {
    final chatId = message['chat_id'] as int?;
    if (chatId == null) return;

    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    final chats = List<MwChat>.from(currentState.chats);
    final index = chats.indexWhere((chat) => chat.id == chatId);

    if (index != -1) {
      final chat = chats[index];
      // If it was the last message, we need to fetch the new last message
      // For now, we'll just clear the last message
      final updatedChat = chat.rebuild((b) => b..lastMessage = null);
      chats[index] = updatedChat;
      state = currentState.copyWith(chats: chats);
    }
  }

  /// Handles read message events
  void _handleReadMessage(Map<String, dynamic> message) {
    final chatId = message['chat_id'] as int?;
    if (chatId == null) return;

    final currentState = state;
    if (currentState is! ChatListLoaded) return;

    final chats = List<MwChat>.from(currentState.chats);
    final index = chats.indexWhere((chat) => chat.id == chatId);

    if (index != -1) {
      // Update the unread count of the corresponding chat
      final chat = chats[index];
      final updatedChat = chat.rebuild((b) => b..unreadCount = 0);
      chats[index] = updatedChat;
      state = currentState.copyWith(chats: chats);
    }
  }

  @override
  void dispose() {
    _websocketSubscription?.cancel();
    super.dispose();
  }
}
