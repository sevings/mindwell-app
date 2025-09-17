import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/chat/models/cached_message.dart';
import 'package:mindwell/src/features/chat/services/offline_message_service.dart';

void main() {
  group('OfflineMessageService', () {
    late OfflineMessageService service;

    setUpAll(() async {
      Hive.init('test_temp');
      Hive.registerAdapter(CachedMessageAdapter());
    });

    setUp(() async {
      service = OfflineMessageService();
      await service.initialize();
    });

    tearDown(() async {
      await service.clearAllCache();
      await service.dispose();
    });

    tearDownAll(() async {
      // Close all boxes first
      await Hive.close();
      // Then delete the test directory
      final testDir = Directory('test_temp');
      if (await testDir.exists()) {
        await testDir.delete(recursive: true);
      }
    });

    group('cacheMessages', () {
      test('should cache messages for a specific chat', () async {
        // Arrange
        const chatUsername = 'test_user';
        final messages = [
          MwMessage(
            (b) => b
              ..id = 1
              ..content = 'Hello'
              ..createdAt =
                  DateTime.now()
                      .subtract(const Duration(seconds: 1))
                      .millisecondsSinceEpoch /
                  1000
              ..read = false,
          ),
          MwMessage(
            (b) => b
              ..id = 2
              ..content = 'World'
              ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
              ..read = true,
          ),
        ];

        // Act
        await service.cacheMessages(chatUsername, messages);

        // Assert
        final cachedMessages = service.getCachedMessages(chatUsername);
        expect(cachedMessages, hasLength(2));
        expect(cachedMessages[0].content, 'World'); // Newest first
        expect(cachedMessages[1].content, 'Hello'); // Oldest second
      });

      test('should handle empty message list', () async {
        // Arrange
        const chatUsername = 'test_user';
        const messages = <MwMessage>[];

        // Act
        await service.cacheMessages(chatUsername, messages);

        // Assert
        final cachedMessages = service.getCachedMessages(chatUsername);
        expect(cachedMessages, isEmpty);
      });
    });

    group('getCachedMessages', () {
      test('should return empty list for non-existent chat', () {
        // Act
        final messages = service.getCachedMessages('non_existent');

        // Assert
        expect(messages, isEmpty);
      });

      test(
        'should return messages sorted by creation time (newest first)',
        () async {
          // Arrange
          const chatUsername = 'test_user';
          final now = DateTime.now();
          final messages = [
            MwMessage(
              (b) => b
                ..id = 1
                ..content = 'First'
                ..createdAt =
                    now
                        .subtract(const Duration(hours: 1))
                        .millisecondsSinceEpoch /
                    1000
                ..read = false,
            ),
            MwMessage(
              (b) => b
                ..id = 2
                ..content = 'Second'
                ..createdAt = now.millisecondsSinceEpoch / 1000
                ..read = false,
            ),
          ];

          await service.cacheMessages(chatUsername, messages);

          // Act
          final cachedMessages = service.getCachedMessages(chatUsername);

          // Assert
          expect(cachedMessages, hasLength(2));
          expect(cachedMessages[0].content, 'Second'); // Newest first
          expect(cachedMessages[1].content, 'First');
        },
      );
    });

    group('queueMessage', () {
      test('should queue a message for offline sending', () async {
        // Arrange
        const chatUsername = 'test_user';
        const content = 'Queued message';

        // Act
        await service.queueMessage(chatUsername, content);

        // Assert
        final queuedMessages = service.getQueuedMessages();
        expect(queuedMessages, hasLength(1));
        expect(queuedMessages[0]['chatUsername'], chatUsername);
        expect(queuedMessages[0]['content'], content);
        expect(queuedMessages[0]['uid'], isA<int>());
      });
    });

    group('getQueuedMessages', () {
      test('should return empty list when no messages are queued', () {
        // Act
        final queuedMessages = service.getQueuedMessages();

        // Assert
        expect(queuedMessages, isEmpty);
      });

      test('should return all queued messages', () async {
        // Arrange
        await service.queueMessage('user1', 'Message 1');
        await service.queueMessage('user2', 'Message 2');

        // Act
        final queuedMessages = service.getQueuedMessages();

        // Assert
        expect(queuedMessages, hasLength(2));
      });
    });

    group('removeQueuedMessage', () {
      test('should remove a queued message', () async {
        // Arrange
        const chatUsername = 'test_user';
        const content = 'Test message';
        await service.queueMessage(chatUsername, content);

        final queuedMessages = service.getQueuedMessages();
        final uid = queuedMessages[0]['uid'] as int;

        // Act
        await service.removeQueuedMessage(chatUsername, uid);

        // Assert
        final remainingQueuedMessages = service.getQueuedMessages();
        expect(remainingQueuedMessages, isEmpty);
      });
    });

    group('markMessagesAsRead', () {
      test('should mark messages as read locally', () async {
        // Arrange
        const chatUsername = 'test_user';
        const messageIds = [1, 2, 3];

        // Act
        await service.markMessagesAsRead(chatUsername, messageIds);

        // Assert
        final readMessageIds = service.getReadMessageIds(chatUsername);
        expect(readMessageIds, containsAll(messageIds));
      });
    });

    group('getReadMessageIds', () {
      test('should return empty set for non-existent chat', () {
        // Act
        final readMessageIds = service.getReadMessageIds('non_existent');

        // Assert
        expect(readMessageIds, isEmpty);
      });

      test('should return read message IDs for specific chat', () async {
        // Arrange
        const chatUsername = 'test_user';
        const messageIds = [1, 2, 3];
        await service.markMessagesAsRead(chatUsername, messageIds);

        // Act
        final readMessageIds = service.getReadMessageIds(chatUsername);

        // Assert
        expect(readMessageIds, containsAll(messageIds));
      });
    });

    group('clearChatCache', () {
      test('should clear cache for specific chat', () async {
        // Arrange
        const chatUsername = 'test_user';
        final messages = [
          MwMessage(
            (b) => b
              ..id = 1
              ..content = 'Test'
              ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
              ..read = false,
          ),
        ];
        await service.cacheMessages(chatUsername, messages);
        await service.markMessagesAsRead(chatUsername, [1]);

        // Act
        await service.clearChatCache(chatUsername);

        // Assert
        final cachedMessages = service.getCachedMessages(chatUsername);
        final readMessageIds = service.getReadMessageIds(chatUsername);
        expect(cachedMessages, isEmpty);
        expect(readMessageIds, isEmpty);
      });
    });

    group('clearAllCache', () {
      test('should clear all cached data', () async {
        // Arrange
        await service.cacheMessages('user1', []);
        await service.cacheMessages('user2', []);
        await service.queueMessage('user1', 'Test');
        await service.markMessagesAsRead('user1', [1]);

        // Act
        await service.clearAllCache();

        // Assert
        expect(service.getCachedMessages('user1'), isEmpty);
        expect(service.getCachedMessages('user2'), isEmpty);
        expect(service.getQueuedMessages(), isEmpty);
        expect(service.getReadMessageIds('user1'), isEmpty);
      });
    });
  });
}
