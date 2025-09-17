import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/models/connection_status.dart' as core;
import '../../../core/providers/websocket_provider.dart';
import '../../../core/services/connection_service.dart';
import '../../../core/services/websocket_service.dart';
import '../models/chat_messages_state.dart';
import '../models/message_action.dart';
import '../services/offline_message_service.dart';

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
      final connectionService = ref.read(connectionServiceProvider);
      final offlineMessageServiceAsync = ref.read(
        offlineMessageServiceProvider,
      );

      // Handle the async initialization of OfflineMessageService
      if (offlineMessageServiceAsync.hasValue) {
        return ChatMessagesNotifier(
          username: username,
          chatsApi: chatsApi,
          websocketService: websocketService,
          connectionService: connectionService,
          offlineMessageService: offlineMessageServiceAsync.value!,
        );
      } else {
        // Return a notifier that will handle initialization later
        return ChatMessagesNotifier(
          username: username,
          chatsApi: chatsApi,
          websocketService: websocketService,
          connectionService: connectionService,
          offlineMessageService: null, // Will be set later
        );
      }
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
  final ConnectionService _connectionService;
  OfflineMessageService? _offlineMessageService;
  final Logger _logger = Logger('ChatMessagesNotifier');

  String? _nextBefore;
  bool _isLoadingMore = false;
  StreamSubscription<Map<String, dynamic>>? _websocketSubscription;
  StreamSubscription<core.ConnectionStatus>? _connectionSubscription;
  Timer? _readMarkingTimer;

  ChatMessagesNotifier({
    required this.username,
    required ChatsApi chatsApi,
    required WebSocketService websocketService,
    required ConnectionService connectionService,
    OfflineMessageService? offlineMessageService,
  }) : _chatsApi = chatsApi,
       _websocketService = websocketService,
       _connectionService = connectionService,
       _offlineMessageService = offlineMessageService,
       super(const ChatMessagesState.loading()) {
    _initialize();
  }

  /// Initialize the notifier by setting up WebSocket subscription and connection monitoring.
  Future<void> _initialize() async {
    // Initialize OfflineMessageService if not already available
    if (_offlineMessageService == null) {
      // This is a workaround - in a real app, you'd want to use a proper async provider pattern
      // For now, we'll create a new instance and initialize it
      _offlineMessageService = OfflineMessageService();
      await _offlineMessageService!.initialize();
    }

    // Listen to WebSocket message messages
    _websocketSubscription = _websocketService.messageMessagesStream.listen(
      _handleWebSocketMessage,
      onError: (error) {
        _logger.warning('WebSocket error in message stream: $error');
      },
    );

    // Listen to connection status changes
    _connectionSubscription = _connectionService.statusStream.listen(
      _handleConnectionStatusChange,
      onError: (error) {
        _logger.warning('Connection status error: $error');
      },
    );

    // Load cached messages first
    await _loadCachedMessages();

    // Then fetch fresh messages from API
    await fetchInitialMessages();
  }

  /// Fetch the initial messages from the API.
  ///
  /// This method fetches the first page of messages and sets up
  /// pagination state for infinite scrolling.
  Future<void> fetchInitialMessages() async {
    if (state.when(
      loading: () => false,
      loaded:
          (
            messages,
            messageStatus,
            isFetchingMore,
            hasMore,
            isSending,
            connectionStatus,
            readMessageIds,
            queuedMessages,
          ) => false,
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
      // Reverse messages so newest are at the end (for ListView with reverse: true)
      final orderedMessages = messages.reversed.toList();
      final hasMore = messageList.hasBefore ?? false;
      _nextBefore = messageList.nextBefore;

      _logger.info('Fetched ${messages.length} messages');

      if (orderedMessages.isEmpty) {
        state = ChatMessagesState.loaded(
          messages: [],
          messageStatus: {},
          connectionStatus: _connectionService.currentStatus,
        );
      } else {
        state = ChatMessagesState.loaded(
          messages: orderedMessages,
          messageStatus: {},
          hasMore: hasMore,
          connectionStatus: _connectionService.currentStatus,
        );

        // Cache the fetched messages
        await _offlineMessageService?.cacheMessages(username, orderedMessages);
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
      loaded:
          (
            messages,
            messageStatus,
            isFetchingMore,
            hasMore,
            isSending,
            connectionStatus,
            readMessageIds,
            queuedMessages,
          ) => (messages: messages, hasMore: hasMore),
      error: (message) => null,
    );

    if (currentState == null || !currentState.hasMore) return;

    _isLoadingMore = true;
    _logger.info('Fetching more messages');

    try {
      final response = await _chatsApi.chatsNameMessagesGet(
        name: username,
        limit: 30,
        after: null,
        before: _nextBefore,
      );

      final messageList = response.data;
      if (messageList != null) {
        final newMessages = messageList.data?.toList() ?? [];
        // Reverse new messages so they're in chronological order
        final orderedNewMessages = newMessages.reversed.toList();
        _nextBefore = messageList.nextBefore;

        // Prepend older messages to the beginning of the list
        final allMessages = <MwMessage>[
          ...orderedNewMessages,
          ...currentState.messages,
        ];

        _logger.info('Fetched ${orderedNewMessages.length} more messages');
        state = ChatMessagesState.loaded(
          messages: allMessages,
          messageStatus: {},
          hasMore: messageList.hasBefore ?? false,
          connectionStatus: _connectionService.currentStatus,
        );

        // Cache the new messages
        await _offlineMessageService?.cacheMessages(
          username,
          orderedNewMessages,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch more messages', e, stackTrace);
      // Don't change state on error - user can retry
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Send a message with optimistic updates and offline support.
  ///
  /// This method:
  /// 1. Adds the message to the state with 'sending' status
  /// 2. Makes the API call or queues the message if offline
  /// 3. Updates the message status based on the result
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final currentState = state.when(
      loading: () => null,
      loaded:
          (
            messages,
            messageStatus,
            isFetchingMore,
            hasMore,
            isSending,
            connectionStatus,
            readMessageIds,
            queuedMessages,
          ) => (
            messages: messages,
            messageStatus: messageStatus,
            isSending: isSending,
            connectionStatus: connectionStatus,
            readMessageIds: readMessageIds,
            queuedMessages: queuedMessages,
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

    // Add the temporary message to the end of the state (for ListView with reverse: true)
    final updatedMessages = [...currentState.messages, tempMessage];
    final updatedMessageStatus = Map<int, MessageStatus>.from(
      currentState.messageStatus,
    );
    updatedMessageStatus[-1] = MessageStatus.sending;

    state = ChatMessagesState.loaded(
      messages: updatedMessages,
      messageStatus: updatedMessageStatus,
      isSending: true,
      connectionStatus: currentState.connectionStatus,
      readMessageIds: currentState.readMessageIds,
      queuedMessages: currentState.queuedMessages,
    );

    // Check if we're offline
    if (currentState.connectionStatus == core.ConnectionStatus.disconnected) {
      // Queue the message for later sending
      await _offlineMessageService?.queueMessage(username, text.trim());

      // Update status to failed (will be retried when connection is restored)
      final failedMessageStatus = Map<int, MessageStatus>.from(
        updatedMessageStatus,
      );
      failedMessageStatus[-1] = MessageStatus.failed;

      state = ChatMessagesState.loaded(
        messages: updatedMessages,
        messageStatus: failedMessageStatus,
        isSending: false,
        connectionStatus: currentState.connectionStatus,
        readMessageIds: currentState.readMessageIds,
        queuedMessages: currentState.queuedMessages,
      );

      _logger.info('Message queued for offline sending: $text');
      return;
    }

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
          connectionStatus: currentState.connectionStatus,
          readMessageIds: currentState.readMessageIds,
          queuedMessages: currentState.queuedMessages,
        );

        // Cache the sent message
        await _offlineMessageService?.cacheMessages(username, [sentMessage]);

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
        connectionStatus: currentState.connectionStatus,
        readMessageIds: currentState.readMessageIds,
        queuedMessages: currentState.queuedMessages,
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
        loaded:
            (
              messages,
              messageStatus,
              isFetchingMore,
              hasMore,
              isSending,
              connectionStatus,
              readMessageIds,
              queuedMessages,
            ) => messages.isNotEmpty ? messages.first.id : null,
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
              (
                messages,
                messageStatus,
                isFetchingMore,
                hasMore,
                isSending,
                connectionStatus,
                readMessageIds,
                queuedMessages,
              ) => (messages: messages, messageStatus: messageStatus),
          error: (message) => null,
        );

        if (currentState != null) {
          // Check if message already exists (avoid duplicates)
          final messageExists = currentState.messages.any(
            (msg) => msg.id == newMessage.id,
          );

          if (!messageExists) {
            // Add new message to the end of the list (for ListView with reverse: true)
            final updatedMessages = <MwMessage>[
              ...currentState.messages,
              newMessage,
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

  /// Load cached messages from local storage
  Future<void> _loadCachedMessages() async {
    try {
      final cachedMessages =
          _offlineMessageService?.getCachedMessages(username) ?? [];
      final readMessageIds =
          _offlineMessageService?.getReadMessageIds(username) ?? {};

      if (cachedMessages.isNotEmpty) {
        state = ChatMessagesState.loaded(
          messages: cachedMessages,
          messageStatus: {},
          connectionStatus: _connectionService.currentStatus,
          readMessageIds: readMessageIds,
        );
        _logger.info('Loaded ${cachedMessages.length} cached messages');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to load cached messages', e, stackTrace);
    }
  }

  /// Handle connection status changes
  void _handleConnectionStatusChange(core.ConnectionStatus status) {
    final currentState = state.when(
      loading: () => null,
      loaded:
          (
            messages,
            messageStatus,
            isFetchingMore,
            hasMore,
            isSending,
            connectionStatus,
            readMessageIds,
            queuedMessages,
          ) => (
            messages: messages,
            messageStatus: messageStatus,
            isFetchingMore: isFetchingMore,
            hasMore: hasMore,
            isSending: isSending,
            connectionStatus: connectionStatus,
            readMessageIds: readMessageIds,
            queuedMessages: queuedMessages,
          ),
      error: (message) => null,
    );

    if (currentState != null) {
      state = ChatMessagesState.loaded(
        messages: currentState.messages,
        messageStatus: currentState.messageStatus,
        isFetchingMore: currentState.isFetchingMore,
        hasMore: currentState.hasMore,
        isSending: currentState.isSending,
        connectionStatus: status,
        readMessageIds: currentState.readMessageIds,
        queuedMessages: currentState.queuedMessages,
      );

      // If connection is restored, sync queued messages
      if (status == core.ConnectionStatus.connected) {
        _syncQueuedMessages();
      }
    }
  }

  /// Sync queued messages when connection is restored
  Future<void> _syncQueuedMessages() async {
    try {
      final queuedMessages = _offlineMessageService?.getQueuedMessages() ?? [];
      final chatQueuedMessages = queuedMessages
          .where((msg) => msg['chatUsername'] == username)
          .toList();

      for (final queuedMessage in chatQueuedMessages) {
        try {
          final response = await _chatsApi.chatsNameMessagesPost(
            name: username,
            content: queuedMessage['content'] as String,
            uid: queuedMessage['uid'] as int,
          );

          if (response.data != null) {
            // Remove from queue
            await _offlineMessageService?.removeQueuedMessage(
              username,
              queuedMessage['uid'] as int,
            );
            _logger.info('Synced queued message: ${queuedMessage['uid']}');
          }
        } catch (e) {
          _logger.warning('Failed to sync queued message: $e');
        }
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to sync queued messages', e, stackTrace);
    }
  }

  /// Mark messages as read automatically when they become visible
  void markMessagesAsRead(List<int> messageIds) {
    final currentState = state.when(
      loading: () => null,
      loaded:
          (
            messages,
            messageStatus,
            isFetchingMore,
            hasMore,
            isSending,
            connectionStatus,
            readMessageIds,
            queuedMessages,
          ) => (
            messages: messages,
            messageStatus: messageStatus,
            isFetchingMore: isFetchingMore,
            hasMore: hasMore,
            isSending: isSending,
            connectionStatus: connectionStatus,
            readMessageIds: readMessageIds,
            queuedMessages: queuedMessages,
          ),
      error: (message) => null,
    );

    if (currentState != null) {
      final newReadMessageIds = Set<int>.from(currentState.readMessageIds);
      bool hasNewReadMessages = false;

      for (final messageId in messageIds) {
        if (!newReadMessageIds.contains(messageId)) {
          newReadMessageIds.add(messageId);
          hasNewReadMessages = true;
        }
      }

      if (hasNewReadMessages) {
        state = ChatMessagesState.loaded(
          messages: currentState.messages,
          messageStatus: currentState.messageStatus,
          isFetchingMore: currentState.isFetchingMore,
          hasMore: currentState.hasMore,
          isSending: currentState.isSending,
          connectionStatus: currentState.connectionStatus,
          readMessageIds: newReadMessageIds,
          queuedMessages: currentState.queuedMessages,
        );

        // Mark as read locally
        _offlineMessageService?.markMessagesAsRead(username, messageIds);

        // Mark as read on server if connected
        if (currentState.connectionStatus == core.ConnectionStatus.connected) {
          _markAsReadOnServer();
        }
      }
    }
  }

  /// Mark messages as read on the server
  Future<void> _markAsReadOnServer() async {
    try {
      final currentState = state.when(
        loading: () => null,
        loaded:
            (
              messages,
              messageStatus,
              isFetchingMore,
              hasMore,
              isSending,
              connectionStatus,
              readMessageIds,
              queuedMessages,
            ) => messages.isNotEmpty ? messages.first.id : null,
        error: (message) => null,
      );

      final messageId = currentState ?? DateTime.now().millisecondsSinceEpoch;
      await _chatsApi.chatsNameReadPut(name: username, message: messageId);
      _logger.info('Marked messages as read on server for chat with $username');
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to mark messages as read on server',
        e,
        stackTrace,
      );
    }
  }

  /// Perform a message action (edit, delete, report)
  Future<MessageActionResult> performMessageAction(MessageAction action) async {
    return action.when(
      edit: (messageId, currentContent) =>
          _editMessage(messageId, currentContent),
      delete: (messageId) => _deleteMessage(messageId),
      report: (messageId, reason) => _reportMessage(messageId, reason),
      retry: (messageId, content) => _retryMessage(messageId, content),
    );
  }

  /// Edit a message
  Future<MessageActionResult> _editMessage(
    int messageId,
    String currentContent,
  ) async {
    try {
      // This would typically open an edit dialog and then call the API
      // For now, we'll just return success
      _logger.info('Edit message $messageId requested');
      return const MessageActionResult.success(
        message: 'Message edit requested',
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to edit message', e, stackTrace);
      return MessageActionResult.error(
        error: 'Failed to edit message: ${e.toString()}',
      );
    }
  }

  /// Delete a message
  Future<MessageActionResult> _deleteMessage(int messageId) async {
    try {
      // Call the API to delete the message
      await _chatsApi.messagesIdDelete(id: messageId);

      // Remove from local state
      final currentState = state.when(
        loading: () => null,
        loaded:
            (
              messages,
              messageStatus,
              isFetchingMore,
              hasMore,
              isSending,
              connectionStatus,
              readMessageIds,
              queuedMessages,
            ) => (
              messages: messages,
              messageStatus: messageStatus,
              isFetchingMore: isFetchingMore,
              hasMore: hasMore,
              isSending: isSending,
              connectionStatus: connectionStatus,
              readMessageIds: readMessageIds,
              queuedMessages: queuedMessages,
            ),
        error: (message) => null,
      );

      if (currentState != null) {
        final updatedMessages = currentState.messages
            .where((msg) => msg.id != messageId)
            .toList();

        state = ChatMessagesState.loaded(
          messages: updatedMessages,
          messageStatus: currentState.messageStatus,
          isFetchingMore: currentState.isFetchingMore,
          hasMore: currentState.hasMore,
          isSending: currentState.isSending,
          connectionStatus: currentState.connectionStatus,
          readMessageIds: currentState.readMessageIds,
          queuedMessages: currentState.queuedMessages,
        );
      }

      _logger.info('Deleted message $messageId');
      return const MessageActionResult.success(message: 'Message deleted');
    } catch (e, stackTrace) {
      _logger.severe('Failed to delete message', e, stackTrace);
      return MessageActionResult.error(
        error: 'Failed to delete message: ${e.toString()}',
      );
    }
  }

  /// Report a message
  Future<MessageActionResult> _reportMessage(
    int messageId,
    String? reason,
  ) async {
    try {
      // This would typically call a report API endpoint
      // For now, we'll just log the report
      _logger.info('Reported message $messageId with reason: $reason');
      return const MessageActionResult.success(message: 'Message reported');
    } catch (e, stackTrace) {
      _logger.severe('Failed to report message', e, stackTrace);
      return MessageActionResult.error(
        error: 'Failed to report message: ${e.toString()}',
      );
    }
  }

  /// Retry sending a failed message
  Future<MessageActionResult> _retryMessage(
    int messageId,
    String content,
  ) async {
    try {
      _logger.info('Retrying message $messageId with content: $content');

      // Find the failed message in the current state
      final currentState = state.when(
        loading: () => null,
        loaded:
            (
              messages,
              messageStatus,
              isFetchingMore,
              hasMore,
              isSending,
              connectionStatus,
              readMessageIds,
              queuedMessages,
            ) => (
              messages: messages,
              messageStatus: messageStatus,
              isFetchingMore: isFetchingMore,
              hasMore: hasMore,
              isSending: isSending,
              connectionStatus: connectionStatus,
              readMessageIds: readMessageIds,
              queuedMessages: queuedMessages,
            ),
        error: (message) => null,
      );

      if (currentState == null) {
        return MessageActionResult.error(error: 'No messages loaded to retry');
      }

      // Check if the message exists and is actually failed
      final messageExists = currentState.messages.any(
        (msg) => msg.id == messageId,
      );
      final messageStatus = currentState.messageStatus[messageId];

      if (!messageExists) {
        return MessageActionResult.error(error: 'Message not found');
      }

      if (messageStatus != MessageStatus.failed) {
        return MessageActionResult.error(
          error: 'Message is not in failed state',
        );
      }

      // Remove the failed message from the list
      final updatedMessages = currentState.messages
          .where((msg) => msg.id != messageId)
          .toList();

      final updatedMessageStatus = Map<int, MessageStatus>.from(
        currentState.messageStatus,
      );
      updatedMessageStatus.remove(messageId);

      state = ChatMessagesState.loaded(
        messages: updatedMessages,
        messageStatus: updatedMessageStatus,
        isFetchingMore: currentState.isFetchingMore,
        hasMore: currentState.hasMore,
        isSending: currentState.isSending,
        connectionStatus: currentState.connectionStatus,
        readMessageIds: currentState.readMessageIds,
        queuedMessages: currentState.queuedMessages,
      );

      // Send the message again using the existing sendMessage method
      await sendMessage(content);

      _logger.info('Successfully retried message $messageId');
      return const MessageActionResult.success(
        message: 'Message retry initiated',
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to retry message $messageId', e, stackTrace);
      return MessageActionResult.error(
        error: 'Failed to retry message: ${e.toString()}',
      );
    }
  }

  /// Retry all failed messages in the current chat
  Future<void> retryAllFailedMessages() async {
    try {
      final currentState = state.when(
        loading: () => null,
        loaded:
            (
              messages,
              messageStatus,
              isFetchingMore,
              hasMore,
              isSending,
              connectionStatus,
              readMessageIds,
              queuedMessages,
            ) => (messages: messages, messageStatus: messageStatus),
        error: (message) => null,
      );

      if (currentState == null) {
        _logger.warning('No messages loaded to retry');
        return;
      }

      final failedMessages = currentState.messages.where((msg) {
        final status = currentState.messageStatus[msg.id];
        return status == MessageStatus.failed;
      }).toList();

      if (failedMessages.isEmpty) {
        _logger.info('No failed messages to retry');
        return;
      }

      _logger.info('Retrying ${failedMessages.length} failed messages');

      // Retry each failed message
      for (final message in failedMessages) {
        try {
          await _retryMessage(message.id ?? 0, message.content ?? '');
          // Add a small delay between retries to avoid overwhelming the server
          await Future.delayed(const Duration(milliseconds: 100));
        } catch (e) {
          _logger.warning('Failed to retry message ${message.id}: $e');
        }
      }

      _logger.info('Completed retry of all failed messages');
    } catch (e, stackTrace) {
      _logger.severe('Failed to retry all failed messages', e, stackTrace);
    }
  }

  /// Refresh messages by clearing current state and fetching fresh data.
  Future<void> refresh() async {
    _logger.info('Refreshing messages');

    // Reset pagination
    _nextBefore = null;

    // Fetch fresh data
    await fetchInitialMessages();
  }

  @override
  void dispose() {
    _websocketSubscription?.cancel();
    _connectionSubscription?.cancel();
    _readMarkingTimer?.cancel();
    super.dispose();
  }
}
