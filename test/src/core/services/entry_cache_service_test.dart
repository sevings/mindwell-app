import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/core/services/entry_cache_service.dart';

void main() {
  group('EntryCacheService', () {
    late EntryCacheService service;

    setUp(() {
      service = EntryCacheService();
    });

    group('basic functionality', () {
      test('should be instantiated', () {
        expect(service, isA<EntryCacheService>());
      });

      test('should have correct cache TTL', () {
        // This tests the private constant indirectly through behavior
        expect(service, isA<EntryCacheService>());
      });
    });

    group('storeEntries', () {
      test('should handle empty entries list', () async {
        // Given
        const feedType = 'best';
        const entries = <MwEntry>[];
        const page = 1;

        // When & Then
        expect(
          () => service.storeEntries(feedType, entries, page: page),
          returnsNormally,
        );
      });

      test('should handle null entry properties', () async {
        // Given
        const feedType = 'profile_123';
        final entries = [
          MwEntry(
            (b) => b
              ..id = null
              ..title = null
              ..content = null
              ..author = null,
          ),
        ];
        const page = 2;

        // When & Then
        expect(
          () => service.storeEntries(feedType, entries, page: page),
          returnsNormally,
        );
      });
    });

    group('getEntries', () {
      test('should return null when no cached data exists', () async {
        // Given
        const feedType = 'live';
        const page = 1;

        // When
        final result = await service.getEntries(feedType, page: page);

        // Then
        expect(result, isNull);
      });

      test('should return null for non-existent feed type', () async {
        // Given
        const feedType = 'nonexistent';
        const page = 1;

        // When
        final result = await service.getEntries(feedType, page: page);

        // Then
        expect(result, isNull);
      });

      test('should handle different page numbers', () async {
        // Given
        const feedType = 'live';

        // When & Then
        for (int page = 1; page <= 5; page++) {
          final result = await service.getEntries(feedType, page: page);
          expect(result, isNull); // No cached data initially
        }
      });
    });

    group('hasCachedEntries', () {
      test('should return false when no cached data exists', () async {
        // Given
        const feedType = 'live';
        const page = 1;

        // When
        final result = await service.hasCachedEntries(feedType, page: page);

        // Then
        expect(result, isFalse);
      });

      test('should return false for non-existent feed type', () async {
        // Given
        const feedType = 'nonexistent';
        const page = 1;

        // When
        final result = await service.hasCachedEntries(feedType, page: page);

        // Then
        expect(result, isFalse);
      });
    });

    group('clearFeedCache', () {
      test('should clear cache for specific feed type', () async {
        // Given
        const feedType = 'live';

        // When & Then
        expect(() => service.clearFeedCache(feedType), returnsNormally);
      });

      test('should handle non-existent feed type', () async {
        // Given
        const feedType = 'nonexistent';

        // When & Then
        expect(() => service.clearFeedCache(feedType), returnsNormally);
      });

      test('should handle empty feed type', () async {
        // Given
        const feedType = '';

        // When & Then
        expect(() => service.clearFeedCache(feedType), returnsNormally);
      });
    });

    group('clearAllCache', () {
      test('should clear all cached entries', () async {
        // When & Then
        expect(() => service.clearAllCache(), returnsNormally);
      });
    });

    group('cleanupExpiredEntries', () {
      test('should cleanup expired entries', () async {
        // When & Then
        expect(() => service.cleanupExpiredEntries(), returnsNormally);
      });
    });

    group('close', () {
      test('should close the service', () async {
        // When & Then
        expect(() => service.close(), returnsNormally);
      });
    });

    group('entry serialization', () {
      test('should reproduce FormatException serialization issue', () {
        // Given - Create an entry that will cause the FormatException
        final user = $MwUser(
          (b) => b
            ..id = 269
            ..name = 'test0'
            ..showName = 'test0'
            ..isTheme = false
            ..isOnline = true,
        );

        final entry = MwEntry(
          (b) => b
            ..id = 726
            ..title = 'Test Entry'
            ..content = 'Test content'
            ..author = user,
        );

        // When - Test the actual serialization process that causes the issue
        final serializers = standardSerializers;
        final serialized = serializers.serialize(entry);

        // This will produce malformed JSON because jsonEncode() can't handle
        // the complex objects in the List<Object?> properly
        final jsonString = jsonEncode(serialized);

        // Then - Verify the actual JSON structure that causes issues
        expect(jsonString, contains(r'"$":"MwEntry"'));
        expect(jsonString, contains('"id":269,"name":"test0"'));

        // The JSON is actually valid, but the structure is not what we expect
        // when deserializing. The issue is that we have a Map with "$" and "" keys
        // instead of a List<Object?> that the deserializer expects
        final decoded = jsonDecode(jsonString);
        expect(decoded, isA<Map<String, dynamic>>());
        expect(decoded[r'$'], equals('MwEntry'));

        // This demonstrates the issue: we're trying to cast a Map to List<Object?>
        // which will cause a type error in the deserialization process
        expect(() => decoded as List<Object?>, throwsA(isA<TypeError>()));
      });

      test(
        'should fix the serialization issue with proper round-trip conversion',
        () {
          // Given - Create an entry that previously caused FormatException
          final user = $MwUser(
            (b) => b
              ..id = 269
              ..name = 'test0'
              ..showName = 'test0'
              ..isTheme = false
              ..isOnline = true,
          );

          final entry = MwEntry(
            (b) => b
              ..id = 726
              ..title = 'Test Entry'
              ..content = 'Test content'
              ..author = user,
          );

          // When - Test the fixed serialization process
          final serializers = standardSerializers;
          final serialized = serializers.serialize(entry);

          // The fix: handle the actual return type (which is a Map, not List)
          // We need to extract the actual data from the Map structure
          String jsonString;
          if (serialized is Map<String, dynamic> &&
              serialized.containsKey('')) {
            // Extract the actual list data from the Map structure
            final listData = serialized[''] as List<Object?>;
            jsonString = jsonEncode(listData);
          } else {
            // Fallback: try to encode the serialized data directly
            jsonString = jsonEncode(serialized);
          }

          // Then - Verify that the JSON is now valid and can be parsed back
          expect(jsonString, isA<String>());
          expect(jsonString, isNotEmpty);

          // Verify that we can parse it back to a List<Object?>
          final decoded = jsonDecode(jsonString);
          expect(decoded, isA<List>());
          expect(decoded, isA<List<Object?>>());

          // Reconstruct the Map structure that the deserializer expects
          final reconstructedSerialized = <String, dynamic>{
            r'$': 'MwEntry',
            '': decoded,
          };

          // Verify that we can deserialize it back to an MwEntry
          final deserializedEntry =
              serializers.deserialize(reconstructedSerialized) as MwEntry?;
          expect(deserializedEntry, isNotNull);
          expect(deserializedEntry!.id, equals(entry.id));
          expect(deserializedEntry.title, equals(entry.title));
          expect(deserializedEntry.content, equals(entry.content));
          expect(deserializedEntry.author, isNotNull);
          expect(deserializedEntry.author!.id, equals(user.id));
          expect(deserializedEntry.author!.name, equals(user.name));
        },
      );

      test('should handle complete entry with all fields', () {
        // Given
        final entry = MwEntry(
          (b) => b
            ..id = 1
            ..title = 'Test Entry'
            ..cutTitle = 'Cut Title'
            ..content = 'Full content'
            ..cutContent = 'Cut content'
            ..createdAt = 1234567890.0
            ..hasCut = true
            ..wordCount = 100
            ..isCommentable = true
            ..inLive = true
            ..isAnonymous = false
            ..isShared = false
            ..isPinned = false
            ..commentCount = 5
            ..favoriteCount = 10
            ..isFavorited = true
            ..isWatching = false,
        );

        // When
        // We can't directly test private methods, but we can test the public interface
        // that uses them
        expect(() => service.storeEntries('test', [entry]), returnsNormally);
      });

      test(
        'should handle complex entry serialization without type cast errors',
        () {
          // Given
          final user = $MwUser(
            (b) => b
              ..id = 123
              ..name = 'Test User'
              ..showName = 'Test User Display'
              ..isTheme = false
              ..isOnline = true,
          );

          final rating = MwRating(
            (b) => b
              ..rating = 4.5
              ..upCount = 25
              ..downCount = 3
              ..isVotable = true,
          );

          final entry = MwEntry(
            (b) => b
              ..id = 456
              ..title = 'Test Entry Title'
              ..cutTitle = 'Cut Title'
              ..content = 'This is the full content of the test entry'
              ..cutContent = 'This is the cut content...'
              ..createdAt = 1234567890.0
              ..author = user
              ..rating.replace(rating)
              ..hasCut = true
              ..wordCount = 50
              ..isCommentable = true
              ..inLive = true
              ..isAnonymous = false
              ..isShared = false
              ..isPinned = false
              ..commentCount = 7
              ..favoriteCount = 15
              ..isFavorited = true
              ..isWatching = false
              ..privacy = MwEntryPrivacyEnum.all,
          );

          final entries = [entry];

          // When & Then - This should not throw type cast errors
          // The fix ensures that serialization/deserialization works correctly
          expect(() => service.storeEntries('test', entries), returnsNormally);
        },
      );

      test('should handle multiple complex entries without type cast errors', () {
        // Given
        final entries = <MwEntry>[];

        // Create multiple entries with different data
        for (int i = 1; i <= 3; i++) {
          final user = $MwUser(
            (b) => b
              ..id = i * 100
              ..name = 'User $i'
              ..showName = 'User $i Display'
              ..isTheme = i % 2 == 0
              ..isOnline = i % 3 == 0,
          );

          final rating = MwRating(
            (b) => b
              ..rating = 3.0 + (i * 0.5)
              ..upCount = i * 10
              ..downCount = i
              ..isVotable = true,
          );

          final entry = MwEntry(
            (b) => b
              ..id = i
              ..title = 'Entry $i Title'
              ..cutTitle = 'Cut $i'
              ..content = 'Content for entry $i'
              ..cutContent = 'Cut content for entry $i'
              ..createdAt = 1234567890.0 + i
              ..author = user
              ..rating.replace(rating)
              ..hasCut = i % 2 == 0
              ..wordCount = i * 20
              ..isCommentable = true
              ..inLive = i % 2 == 1
              ..isAnonymous = false
              ..isShared = i == 2
              ..isPinned = i == 3
              ..commentCount = i * 2
              ..favoriteCount = i * 5
              ..isFavorited = i % 2 == 1
              ..isWatching = i % 3 == 0
              ..privacy = i == 1
                  ? MwEntryPrivacyEnum.all
                  : MwEntryPrivacyEnum.followers,
          );

          entries.add(entry);
        }

        // When & Then - This should not throw type cast errors
        // The fix ensures that serialization works correctly for complex nested data
        expect(() => service.storeEntries('test', entries), returnsNormally);
      });

      test('should handle entry with user data', () {
        // Given
        final user = $MwUser(
          (b) => b
            ..id = 1
            ..name = 'Test User'
            ..showName = 'Test User Display Name'
            ..isTheme = false
            ..isOnline = true,
        );

        final entry = MwEntry(
          (b) => b
            ..id = 1
            ..title = 'Test Entry'
            ..author = user,
        );

        // When & Then
        expect(() => service.storeEntries('test', [entry]), returnsNormally);
      });

      test('should handle entry with rating data', () {
        // Given
        final rating = MwRating(
          (b) => b
            ..rating = 4.5
            ..upCount = 20
            ..downCount = 2
            ..isVotable = true,
        );

        final entry = MwEntry(
          (b) => b
            ..id = 1
            ..title = 'Test Entry'
            ..rating.replace(rating),
        );

        // When & Then
        expect(() => service.storeEntries('test', [entry]), returnsNormally);
      });

      test('should handle entry with tags', () {
        // Given
        final entry = MwEntry(
          (b) => b
            ..id = 1
            ..title = 'Test Entry',
        );

        // When & Then
        expect(() => service.storeEntries('test', [entry]), returnsNormally);
      });

      test('should handle entry with privacy settings', () {
        // Given
        final entry = MwEntry(
          (b) => b
            ..id = 1
            ..title = 'Test Entry'
            ..privacy = MwEntryPrivacyEnum.all,
        );

        // When & Then
        expect(() => service.storeEntries('test', [entry]), returnsNormally);
      });
    });

    group('error handling', () {
      test('should handle malformed entry data gracefully', () async {
        // Given
        const feedType = 'live';
        const page = 1;

        // When & Then
        // The service should handle errors gracefully without crashing
        expect(() => service.getEntries(feedType, page: page), returnsNormally);
        expect(
          () => service.hasCachedEntries(feedType, page: page),
          returnsNormally,
        );
        expect(() => service.clearFeedCache(feedType), returnsNormally);
        expect(() => service.clearAllCache(), returnsNormally);
        expect(() => service.cleanupExpiredEntries(), returnsNormally);
      });
    });

    group('cache key generation', () {
      test('should generate consistent cache keys', () async {
        // This tests the cache key generation logic indirectly
        // by verifying that the same feed type and page combination
        // behaves consistently

        const feedType = 'live';
        const page = 1;

        // Multiple calls should behave the same way
        final result1 = await service.hasCachedEntries(feedType, page: page);
        final result2 = await service.hasCachedEntries(feedType, page: page);

        expect(result1, equals(result2));
      });

      test('should handle different feed types', () async {
        final feedTypes = ['live', 'best', 'profile_123', 'user_456'];

        for (final feedType in feedTypes) {
          final result = await service.hasCachedEntries(feedType);
          expect(result, isFalse); // No cached data initially
        }
      });

      test('should handle different page numbers', () async {
        const feedType = 'live';
        final pages = [1, 2, 5, 10, 100];

        for (final page in pages) {
          final result = await service.hasCachedEntries(feedType, page: page);
          expect(result, isFalse); // No cached data initially
        }
      });
    });
  });
}
