import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../models/chat_list_state.dart';
import '../../../core/api/api_provider.dart';

/// Provider for the chat list state
final chatListProvider = StateNotifierProvider<ChatListNotifier, ChatListState>(
  (ref) => ChatListNotifier(ref),
);

/// Notifier for managing chat list state and operations
class ChatListNotifier extends StateNotifier<ChatListState> {
  final Ref _ref;
  static const int _pageSize = 20;

  ChatListNotifier(this._ref) : super(const ChatListState.loading()) {
    _loadInitialChats();
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
    await _loadInitialChats();
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
}
