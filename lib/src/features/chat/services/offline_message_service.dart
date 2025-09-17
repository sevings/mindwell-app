import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../models/cached_message.dart';

/// Service for handling offline message operations
class OfflineMessageService {
  static const String _messagesBoxName = 'chat_messages';
  static const String _queuedMessagesBoxName = 'queued_messages';
  static const String _readStatusBoxName = 'read_status';

  final Logger _logger = Logger('OfflineMessageService');
  late Box<CachedMessage> _messagesBox;
  late Box<String> _queuedMessagesBox;
  late Box<String> _readStatusBox;

  /// Initialize the service and open Hive boxes
  Future<void> initialize() async {
    _messagesBox = await Hive.openBox<CachedMessage>(_messagesBoxName);
    _queuedMessagesBox = await Hive.openBox<String>(_queuedMessagesBoxName);
    _readStatusBox = await Hive.openBox<String>(_readStatusBoxName);
    _logger.info('OfflineMessageService initialized');
  }

  /// Cache messages for a specific chat
  Future<void> cacheMessages(
    String chatUsername,
    List<MwMessage> messages,
  ) async {
    try {
      final cachedMessages = messages
          .map((msg) => CachedMessage.fromMwMessage(msg, chatUsername))
          .toList();

      // Store messages with chat username as key prefix
      for (final cachedMessage in cachedMessages) {
        final key = '${chatUsername}_${cachedMessage.id}';
        await _messagesBox.put(key, cachedMessage);
      }

      _logger.info('Cached ${messages.length} messages for chat $chatUsername');
    } catch (e, stackTrace) {
      _logger.severe('Failed to cache messages', e, stackTrace);
    }
  }

  /// Get cached messages for a specific chat
  List<MwMessage> getCachedMessages(String chatUsername) {
    try {
      final cachedMessages = _messagesBox.values
          .where((msg) => msg.chatUsername == chatUsername)
          .toList();

      // Sort by creation time (newest first)
      cachedMessages.sort(
        (a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0),
      );

      return cachedMessages.map((msg) => msg.toMwMessage()).toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to get cached messages', e, stackTrace);
      return [];
    }
  }

  /// Queue a message for sending when connection is restored
  Future<void> queueMessage(String chatUsername, String content) async {
    try {
      final queuedMessage = {
        'chatUsername': chatUsername,
        'content': content,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'uid': DateTime.now().millisecondsSinceEpoch,
      };

      final key = '${chatUsername}_${queuedMessage['uid']}';
      await _queuedMessagesBox.put(key, jsonEncode(queuedMessage));

      _logger.info('Queued message for chat $chatUsername');
    } catch (e, stackTrace) {
      _logger.severe('Failed to queue message', e, stackTrace);
    }
  }

  /// Get all queued messages
  List<Map<String, dynamic>> getQueuedMessages() {
    try {
      return _queuedMessagesBox.values
          .map((json) => jsonDecode(json) as Map<String, dynamic>)
          .toList();
    } catch (e, stackTrace) {
      _logger.severe('Failed to get queued messages', e, stackTrace);
      return [];
    }
  }

  /// Remove a queued message after successful sending
  Future<void> removeQueuedMessage(String chatUsername, int uid) async {
    try {
      final key = '${chatUsername}_$uid';
      await _queuedMessagesBox.delete(key);
      _logger.info('Removed queued message for chat $chatUsername');
    } catch (e, stackTrace) {
      _logger.severe('Failed to remove queued message', e, stackTrace);
    }
  }

  /// Mark messages as read locally
  Future<void> markMessagesAsRead(
    String chatUsername,
    List<int> messageIds,
  ) async {
    try {
      for (final messageId in messageIds) {
        final key = '${chatUsername}_$messageId';
        await _readStatusBox.put(key, 'read');
      }
      _logger.info(
        'Marked ${messageIds.length} messages as read for chat $chatUsername',
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to mark messages as read', e, stackTrace);
    }
  }

  /// Get read status for messages
  Set<int> getReadMessageIds(String chatUsername) {
    try {
      return _readStatusBox.keys
          .where((key) => key.toString().startsWith('${chatUsername}_'))
          .map((key) => int.tryParse(key.toString().split('_').last) ?? 0)
          .where((id) => id > 0)
          .toSet();
    } catch (e, stackTrace) {
      _logger.severe('Failed to get read message IDs', e, stackTrace);
      return {};
    }
  }

  /// Clear cache for a specific chat
  Future<void> clearChatCache(String chatUsername) async {
    try {
      // Clear cached messages
      final messageKeys = _messagesBox.keys
          .where((key) => key.toString().startsWith('${chatUsername}_'))
          .toList();
      await _messagesBox.deleteAll(messageKeys);

      // Clear read status
      final readKeys = _readStatusBox.keys
          .where((key) => key.toString().startsWith('${chatUsername}_'))
          .toList();
      await _readStatusBox.deleteAll(readKeys);

      _logger.info('Cleared cache for chat $chatUsername');
    } catch (e, stackTrace) {
      _logger.severe('Failed to clear chat cache', e, stackTrace);
    }
  }

  /// Clear all cached data
  Future<void> clearAllCache() async {
    try {
      await _messagesBox.clear();
      await _queuedMessagesBox.clear();
      await _readStatusBox.clear();
      _logger.info('Cleared all cached data');
    } catch (e, stackTrace) {
      _logger.severe('Failed to clear all cache', e, stackTrace);
    }
  }

  /// Close all boxes
  Future<void> dispose() async {
    await _messagesBox.close();
    await _queuedMessagesBox.close();
    await _readStatusBox.close();
  }
}

/// Provider for the OfflineMessageService
final offlineMessageServiceProvider = Provider<OfflineMessageService>((ref) {
  final service = OfflineMessageService();
  service.initialize();
  return service;
});
