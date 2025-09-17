import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/models/connection_status.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/models/auth_state.dart';
import '../providers/chat_messages_provider.dart';
import '../models/chat_messages_state.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

/// Screen that displays messages for a specific chat conversation.
///
/// Shows a real-time list of messages with the ability to send new messages,
/// load older messages via pagination, and handle message interactions.
class ChatMessagesScreen extends ConsumerStatefulWidget {
  /// The username of the chat partner
  final String username;

  const ChatMessagesScreen({super.key, required this.username});

  @override
  ConsumerState<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends ConsumerState<ChatMessagesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isInitialized = false;
  List<int> _previousMessageIds = [];
  final Set<int> _newMessageIds = {};
  Timer? _newMessageTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _newMessageTimer?.cancel();
    super.dispose();
  }

  /// Handles scroll events for pagination
  void _onScroll() {
    if (_scrollController.position.pixels <= 200) {
      // Load more messages when near the top
      ref
          .read(chatMessagesProvider(widget.username).notifier)
          .fetchMoreMessages();
    }
  }

  /// Initializes the chat messages
  void _initializeChat() {
    if (!_isInitialized) {
      _isInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(chatMessagesProvider(widget.username).notifier)
            .fetchInitialMessages();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final chatState = ref.watch(chatMessagesProvider(widget.username));

    // Initialize chat on first build
    _initializeChat();

    return Scaffold(
      appBar: _buildAppBar(context, l10n, theme, authState),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: chatState.when(
              loading: () => _buildLoadingState(l10n, theme),
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
                  ) => _buildMessagesList(
                    theme,
                    messages,
                    messageStatus,
                    isFetchingMore,
                    hasMore,
                    connectionStatus,
                  ),
              error: (error) => _buildErrorState(l10n, theme, error),
            ),
          ),
          // Message input
          chatState.when(
            loading: () => const SizedBox.shrink(),
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
                ) => MessageInput(
                  onSendMessage: _sendMessage,
                  isDisabled: isSending,
                  placeholder: 'Type a message...',
                ),
            error: (error) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  /// Builds the app bar with partner information
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    AuthState authState,
  ) {
    return PlatformAppBar(
      title: Text(
        widget.username,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
      elevation: 0,
      automaticallyImplyLeading: true,
      showHamburgerMenu: false,
      actions: [
        // Profile navigation button
        IconButton(
          onPressed: () => _navigateToProfile(),
          icon: const Icon(Icons.person_outline),
          tooltip: 'View profile',
        ),
      ],
    );
  }

  /// Builds the loading state
  Widget _buildLoadingState(AppLocalizations? l10n, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Loading messages...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the messages list
  Widget _buildMessagesList(
    ThemeData theme,
    List<MwMessage> messages,
    Map<int, MessageStatus> messageStatus,
    bool isFetchingMore,
    bool hasMore,
    ConnectionStatus connectionStatus,
  ) {
    if (messages.isEmpty) {
      return _buildEmptyState(theme);
    }

    // Track new messages for animations and accessibility announcements
    _trackNewMessages(messages);

    return Column(
      children: [
        // Loading indicator for pagination
        if (isFetchingMore)
          Container(
            padding: const EdgeInsets.all(16),
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 2,
            ),
          ),
        // Messages list
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true, // Show newest messages at bottom
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isFromCurrentUser = _isFromCurrentUser(message);
              final status = messageStatus[message.id];
              final isNewMessage = _newMessageIds.contains(message.id);

              return MessageBubble(
                message: message,
                isFromCurrentUser: isFromCurrentUser,
                messageStatus: status,
                chatUsername: widget.username,
                isNewMessage: isNewMessage,
                onLongPress: () => _showMessageContextMenu(message),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the empty state when no messages are available
  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Start the conversation by sending a message',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the error state
  Widget _buildErrorState(
    AppLocalizations? l10n,
    ThemeData theme,
    String error,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              l10n?.somethingWentWrong ?? 'Something went wrong',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref
                  .read(chatMessagesProvider(widget.username).notifier)
                  .refresh(),
              child: Text(l10n?.retry ?? 'Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Sends a message
  void _sendMessage(String text) {
    ref.read(chatMessagesProvider(widget.username).notifier).sendMessage(text);
  }

  /// Checks if a message is from the current user
  bool _isFromCurrentUser(MwMessage message) {
    final authState = ref.read(authProvider);
    return authState.when(
      authenticated: (user, authSource) => message.author?.name == user.name,
      initial: () => false,
      loading: () => false,
      unauthenticated: () => false,
      error: (message) => false,
    );
  }

  /// Shows context menu for a message
  void _showMessageContextMenu(MwMessage message) {
    final isFromCurrentUser = _isFromCurrentUser(message);

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isFromCurrentUser) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(message);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () {
                Navigator.pop(context);
                _reportMessage(message);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Edits a message
  void _editMessage(MwMessage message) {
    // TODO: Implement message editing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message editing not implemented yet')),
    );
  }

  /// Deletes a message
  void _deleteMessage(MwMessage message) {
    // TODO: Implement message deletion
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message deletion not implemented yet')),
    );
  }

  /// Reports a message
  void _reportMessage(MwMessage message) {
    // TODO: Implement message reporting
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message reporting not implemented yet')),
    );
  }

  /// Navigates to the partner's profile
  void _navigateToProfile() {
    context.push('/users/${widget.username}');
  }

  /// Tracks new messages for animations and accessibility announcements
  void _trackNewMessages(List<MwMessage> messages) {
    final currentMessageIds = messages.map((msg) => msg.id ?? 0).toList();

    // Find new messages that weren't in the previous list
    final newIds = currentMessageIds
        .where((id) => !_previousMessageIds.contains(id))
        .toSet();

    if (newIds.isNotEmpty) {
      _newMessageIds.addAll(newIds);

      // Announce new messages for screen readers
      _announceNewMessages(newIds, messages);

      // Clear the new message IDs after a delay to prevent re-animating
      _newMessageTimer?.cancel();
      _newMessageTimer = Timer(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _newMessageIds.clear();
          });
        }
      });
    }

    _previousMessageIds = currentMessageIds;
  }

  /// Announces new messages to screen readers
  void _announceNewMessages(Set<int> newMessageIds, List<MwMessage> messages) {
    final newMessages = messages
        .where((msg) => newMessageIds.contains(msg.id ?? 0))
        .toList();

    for (final message in newMessages) {
      final isFromCurrentUser = _isFromCurrentUser(message);
      final sender = isFromCurrentUser
          ? 'You'
          : (message.author?.name ?? 'Unknown');
      final content = message.content ?? '';

      // Announce the new message
      SemanticsService.announce('$sender: $content', TextDirection.ltr);
    }
  }
}
