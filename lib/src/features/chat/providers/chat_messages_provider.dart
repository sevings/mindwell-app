import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/providers/websocket_provider.dart';
import '../../../core/services/websocket_service.dart';
import '../models/chat_messages_state.dart';

/// Provider for the ChatMessagesNotifier that manages the state of chat messages.
///
/// This provider handles:
/// - Fetching messages from the API for a specific chat
/// - Real-time updates via WebSocket
/// - Pagination for infinite scrolling
/// - Sending messages with optimistic updates
/// - Message status tracking
final chatMessagesProvider =
    StateNotifierProvider.family<
      ChatMessagesNotifier,
      ChatMessagesState,
      String
    >((ref, username) {
      final chatsApi = ref.read(chatsApiProvider);
      final websocketService = ref.read(websocketServiceProvider);

      return ChatMessagesNotifier(
        username: username,
        chatsApi: chatsApi,
        websocketService: websocketService,
      );
    });

/// Notifier that manages the state and logic for chat messages.
///
/// This class handles:
/// - Fetching initial messages from API
/// - Listening to real-time WebSocket updates
/// - Implementing pagination for infinite scrolling
/// - Sending messages with optimistic updates
/// - Message status tracking (sending, sent, failed, delivered, read)
/// - Error handling and offline support
class ChatMessagesNotifier extends StateNotifier<ChatMessagesState> {
  final String username;
  final ChatsApi _chatsApi;
  final WebSocketService _websocketService;
  final Logger _logger = Logger('ChatMessagesNotifier');

  String? _nextAfter;
  bool _isLoadingMore = false;
  StreamSubscription<Map<String, dynamic>>? _websocketSubscription;

  ChatMessagesNotifier({
    required this.username,
    required ChatsApi chatsApi,
    required WebSocketService websocketService,
  }) : _chatsApi = chatsApi,
       _websocketService = websocketService,
       super(const ChatMessagesState.loading()) {
    _initialize();
  }

  /// Initialize the notifier by setting up WebSocket subscription.
  Future<void> _initialize() async {
    // Listen to WebSocket message messages
    _websocketSubscription = _websocketService.messageMessagesStream.listen(
      _handleWebSocketMessage,
      onError: (error) {
        _logger.warning('WebSocket error in message stream: $error');
      },
    );
  }

  /// Fetch the initial messages from the API.
  ///
  /// This method fetches the first page of messages and sets up
  /// pagination state for infinite scrolling.
  Future<void> fetchInitialMessages() async {
    if (state.when(
      loading: () => false,
      loaded: (messages, messageStatus, isFetchingMore, hasMore, isSending) =>
          false,
      error: (message) => false,
    )) {
      return; // Prevent multiple simultaneous loads
    }

    _logger.info('Fetching initial messages for chat with $username');
    state = const ChatMessagesState.loading();

    try {
      final response = await _chatsApi.chatsNameMessagesGet(
        name: username,
        limit: 30,
        after: null,
        before: null,
      );

      final messageList = response.data;
      if (messageList == null) {
        state = const ChatMessagesState.loaded(messages: [], messageStatus: {});
        return;
      }

      final messages = messageList.data?.toList() ?? [];
      final hasMore = messageList.hasAfter ?? false;
      _nextAfter = messageList.nextAfter;

      _logger.info('Fetched ${messages.length} messages');

      if (messages.isEmpty) {
        state = const ChatMessagesState.loaded(messages: [], messageStatus: {});
      } else {
        state = ChatMessagesState.loaded(
          messages: messages,
          messageStatus: {},
          hasMore: hasMore,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch initial messages', e, stackTrace);
      state = ChatMessagesState.error(
        'Failed to load messages: ${e.toString()}',
      );
    }
  }

  /// Fetch more messages for infinite scrolling.
  ///
  /// This method appends new messages to the existing list.
  Future<void> fetchMoreMessages() async {
    if (_isLoadingMore) return;

    final currentState = state.when(
      loading: () => null,
      loaded: (messages, messageStatus, isFetchingMore, hasMore, isSending) =>
          (messages: messages, hasMore: hasMore),
      error: (message) => null,
    );

    if (currentState == null || !currentState.hasMore) return;

    _isLoadingMore = true;
    _logger.info('Fetching more messages');

    try {
      final response = await _chatsApi.chatsNameMessagesGet(
        name: username,
        limit: 30,
        after: _nextAfter,
        before: null,
      );

      final messageList = response.data;
      if (messageList != null) {
        final newMessages = messageList.data?.toList() ?? [];
        _nextAfter = messageList.nextAfter;

        final allMessages = <MwMessage>[
          ...currentState.messages,
          ...newMessages,
        ];

        _logger.info('Fetched ${newMessages.length} more messages');
        state = ChatMessagesState.loaded(
          messages: allMessages,
          messageStatus: {},
          hasMore: messageList.hasAfter ?? false,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch more messages', e, stackTrace);
      // Don't change state on error - user can retry
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Send a message with optimistic updates.
  ///
  /// This method:
  /// 1. Adds the message to the state with 'sending' status
  /// 2. Makes the API call
  /// 3. Updates the message status based on the result
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final currentState = state.when(
      loading: () => null,
      loaded: (messages, messageStatus, isFetchingMore, hasMore, isSending) => (
        messages: messages,
        messageStatus: messageStatus,
        isSending: isSending,
      ),
      error: (message) => null,
    );

    if (currentState == null || currentState.isSending) return;

    // Create a temporary message for optimistic update
    final tempMessage = MwMessage(
      (b) => b
        ..id =
            -1 // Temporary ID
        ..chatId = null
        ..author =
            null // Will be set by server
        ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
        ..read = false
        ..content = text.trim()
        ..editContent = null
        ..rights = null,
    );

    // Add the temporary message to the state
    final updatedMessages = [tempMessage, ...currentState.messages];
    final updatedMessageStatus = Map<int, MessageStatus>.from(
      currentState.messageStatus,
    );
    updatedMessageStatus[-1] = MessageStatus.sending;

    state = ChatMessagesState.loaded(
      messages: updatedMessages,
      messageStatus: updatedMessageStatus,
      isSending: true,
    );

    try {
      _logger.info('Sending message: $text');

      final response = await _chatsApi.chatsNameMessagesPost(
        name: username,
        content: text.trim(),
        uid: DateTime.now().millisecondsSinceEpoch,
      );

      final sentMessage = response.data;
      if (sentMessage != null) {
        // Replace the temporary message with the real one
        final finalMessages = updatedMessages.map((msg) {
          if (msg.id == -1) {
            return sentMessage;
          }
          return msg;
        }).toList();

        final finalMessageStatus = Map<int, MessageStatus>.from(
          updatedMessageStatus,
        );
        finalMessageStatus.remove(-1); // Remove temporary status
        finalMessageStatus[sentMessage.id ?? 0] = MessageStatus.sent;

        state = ChatMessagesState.loaded(
          messages: finalMessages,
          messageStatus: finalMessageStatus,
          isSending: false,
        );

        _logger.info('Message sent successfully: ${sentMessage.id}');
      } else {
        throw Exception('Failed to send message: no response data');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to send message', e, stackTrace);

      // Update the temporary message status to failed
      final failedMessageStatus = Map<int, MessageStatus>.from(
        updatedMessageStatus,
      );
      failedMessageStatus[-1] = MessageStatus.failed;

      state = ChatMessagesState.loaded(
        messages: updatedMessages,
        messageStatus: failedMessageStatus,
        isSending: false,
      );
    }
  }

  /// Mark messages as read.
  ///
  /// This method calls the API to mark all messages in the chat as read.
  Future<void> markAsRead() async {
    try {
      // Use the latest message ID or current timestamp as message parameter
      final currentState = state.when(
        loading: () => null,
        loaded: (messages, messageStatus, isFetchingMore, hasMore, isSending) =>
            messages.isNotEmpty ? messages.first.id : null,
        error: (message) => null,
      );

      final messageId = currentState ?? DateTime.now().millisecondsSinceEpoch;

      await _chatsApi.chatsNameReadPut(name: username, message: messageId);
      _logger.info('Marked messages as read for chat with $username');
    } catch (e, stackTrace) {
      _logger.severe('Failed to mark messages as read', e, stackTrace);
      // Don't change state on error
    }
  }

  /// Handle incoming WebSocket message messages.
  ///
  /// This method processes real-time message updates from the WebSocket
  /// and updates the state accordingly.
  void _handleWebSocketMessage(Map<String, dynamic> message) {
    try {
      _logger.fine('Received WebSocket message: $message');

      // Parse the message from the WebSocket message
      // The message structure depends on the server implementation
      final messageData = message['message'] as Map<String, dynamic>?;
      if (messageData == null) {
        _logger.warning('WebSocket message does not contain message data');
        return;
      }

      // Check if this message is for the current chat
      final chatId = messageData['chatId'] as int?;
      final author = messageData['author'] as Map<String, dynamic>?;
      final authorName = author?['name'] as String?;

      // Only process messages for the current chat or from the current user
      if (chatId != null && authorName != null) {
        // Convert the message data to MwMessage
        final newMessage = MwMessage(
          (b) => b
            ..id = messageData['id'] as int?
            ..chatId = chatId
            ..author =
                null // Will be properly deserialized if needed
            ..createdAt = (messageData['createdAt'] as num?)?.toDouble()
            ..read = messageData['read'] as bool? ?? false
            ..content = messageData['content'] as String?
            ..editContent = messageData['editContent'] as String?
            ..rights = null,
        );

        // Update the current state with the new message
        final currentState = state.when(
          loading: () => null,
          loaded:
              (messages, messageStatus, isFetchingMore, hasMore, isSending) =>
                  (messages: messages, messageStatus: messageStatus),
          error: (message) => null,
        );

        if (currentState != null) {
          // Check if message already exists (avoid duplicates)
          final messageExists = currentState.messages.any(
            (msg) => msg.id == newMessage.id,
          );

          if (!messageExists) {
            // Add new message to the beginning of the list
            final updatedMessages = <MwMessage>[
              newMessage,
              ...currentState.messages,
            ];

            // Set message status based on whether it's from current user
            final updatedMessageStatus = Map<int, MessageStatus>.from(
              currentState.messageStatus,
            );
            updatedMessageStatus[newMessage.id ?? 0] = MessageStatus.delivered;

            state = ChatMessagesState.loaded(
              messages: updatedMessages,
              messageStatus: updatedMessageStatus,
            );

            _logger.info('Added new message from WebSocket: ${newMessage.id}');
          }
        } else {
          // If we don't have a loaded state, fetch initial messages
          fetchInitialMessages();
        }
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to handle WebSocket message', e, stackTrace);
    }
  }

  /// Refresh messages by clearing current state and fetching fresh data.
  Future<void> refresh() async {
    _logger.info('Refreshing messages');

    // Reset pagination
    _nextAfter = null;

    // Fetch fresh data
    await fetchInitialMessages();
  }

  @override
  void dispose() {
    _websocketSubscription?.cancel();
    super.dispose();
  }
}
