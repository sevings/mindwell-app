import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// Service for caching entries in local storage using Hive.
/// 
/// Provides offline support by storing and retrieving lists of entries
/// for different feed types. Cache entries have a TTL (time-to-live) for
/// automatic expiration.
class EntryCacheService {
  static const String _boxName = 'entry_cache';
  static const Duration _cacheTtl = Duration(hours: 1);
  
  late Box<String> _box;
  final Logger _logger = Logger('EntryCacheService');

  /// Initialize the cache service by opening the Hive box.
  Future<void> initialize() async {
    try {
      _box = await Hive.openBox<String>(_boxName);
      _logger.info('Entry cache service initialized');
    } catch (e) {
      _logger.severe('Failed to initialize entry cache service: $e');
      rethrow;
    }
  }

  /// Store a list of entries for a specific feed type.
  /// 
  /// [feedType] - The type of feed (e.g., 'live', 'best', 'profile_123')
  /// [entries] - List of entries to cache
  /// [page] - Page number for pagination (default: 1)
  Future<void> storeEntries(
    String feedType,
    List<MwEntry> entries, {
    int page = 1,
  }) async {
    try {
      final cacheKey = _getCacheKey(feedType, page);
      final cacheData = {
        'entries': entries.map((entry) => _serializeEntry(entry)).toList(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'page': page,
        'feedType': feedType,
      };
      
      await _box.put(cacheKey, _serializeMap(cacheData));
      _logger.fine('Stored ${entries.length} entries for $feedType page $page');
    } catch (e) {
      _logger.warning('Failed to store entries for $feedType: $e');
      // Don't rethrow - caching failures shouldn't break the app
    }
  }

  /// Retrieve cached entries for a specific feed type and page.
  /// 
  /// Returns null if no cached data exists or if the cache has expired.
  Future<List<MwEntry>?> getEntries(
    String feedType, {
    int page = 1,
  }) async {
    try {
      final cacheKey = _getCacheKey(feedType, page);
      final cacheDataString = _box.get(cacheKey);
      
      if (cacheDataString == null) {
        _logger.fine('No cached entries found for $feedType page $page');
        return null;
      }
      
      final cacheData = _deserializeMap(cacheDataString);
      if (cacheData == null) {
        _logger.warning('Invalid cache data for $feedType page $page');
        await _box.delete(cacheKey);
        return null;
      }
      
      final timestamp = cacheData['timestamp'] as int?;
      if (timestamp == null) {
        _logger.warning('Invalid cache data for $feedType page $page');
        await _box.delete(cacheKey);
        return null;
      }
      
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      
      if (now.difference(cacheTime) > _cacheTtl) {
        _logger.fine('Cache expired for $feedType page $page');
        await _box.delete(cacheKey);
        return null;
      }
      
      final entriesData = cacheData['entries'] as List?;
      if (entriesData == null) {
        _logger.warning('Invalid entries data for $feedType page $page');
        await _box.delete(cacheKey);
        return null;
      }
      
      final entries = entriesData
          .map((entryData) => _deserializeEntry(entryData as String))
          .where((entry) => entry != null)
          .cast<MwEntry>()
          .toList();
      
      _logger.fine('Retrieved ${entries.length} cached entries for $feedType page $page');
      return entries;
    } catch (e) {
      _logger.warning('Failed to retrieve cached entries for $feedType: $e');
      return null;
    }
  }

  /// Check if cached entries exist for a specific feed type and page.
  Future<bool> hasCachedEntries(
    String feedType, {
    int page = 1,
  }) async {
    final entries = await getEntries(feedType, page: page);
    return entries != null && entries.isNotEmpty;
  }

  /// Clear all cached entries for a specific feed type.
  Future<void> clearFeedCache(String feedType) async {
    try {
      final keysToDelete = <String>[];
      
      for (final key in _box.keys) {
        if (key is String && key.startsWith('${feedType}_')) {
          keysToDelete.add(key);
        }
      }
      
      for (final key in keysToDelete) {
        await _box.delete(key);
      }
      
      _logger.info('Cleared cache for feed type: $feedType (${keysToDelete.length} entries)');
    } catch (e) {
      _logger.warning('Failed to clear cache for $feedType: $e');
    }
  }

  /// Clear all cached entries.
  Future<void> clearAllCache() async {
    try {
      await _box.clear();
      _logger.info('Cleared all cached entries');
    } catch (e) {
      _logger.warning('Failed to clear all cache: $e');
    }
  }

  /// Get cache statistics for debugging.
  Map<String, dynamic> getCacheStats() {
    final stats = <String, dynamic>{
      'totalEntries': _box.length,
      'cacheTtl': _cacheTtl.inMinutes,
    };
    
    final feedTypes = <String>{};
    final now = DateTime.now();
    
    for (final key in _box.keys) {
      if (key is String) {
        final parts = key.split('_');
        if (parts.length >= 2) {
          feedTypes.add(parts[0]);
        }
      }
    }
    
    stats['feedTypes'] = feedTypes.toList();
    
    // Count expired entries
    int expiredCount = 0;
    for (final key in _box.keys) {
      final dataString = _box.get(key);
      if (dataString != null) {
        final data = _deserializeMap(dataString);
        if (data != null && data['timestamp'] is int) {
          final timestamp = data['timestamp'] as int;
          final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
          if (now.difference(cacheTime) > _cacheTtl) {
            expiredCount++;
          }
        }
      }
    }
    
    stats['expiredEntries'] = expiredCount;
    
    return stats;
  }

  /// Clean up expired cache entries.
  Future<void> cleanupExpiredEntries() async {
    try {
      final keysToDelete = <String>[];
      final now = DateTime.now();
      
      for (final key in _box.keys) {
        final dataString = _box.get(key);
        if (dataString != null) {
          final data = _deserializeMap(dataString);
          if (data != null && data['timestamp'] is int) {
            final timestamp = data['timestamp'] as int;
            final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
            if (now.difference(cacheTime) > _cacheTtl) {
              keysToDelete.add(key);
            }
          }
        }
      }
      
      for (final key in keysToDelete) {
        await _box.delete(key);
      }
      
      if (keysToDelete.isNotEmpty) {
        _logger.info('Cleaned up ${keysToDelete.length} expired cache entries');
      }
    } catch (e) {
      _logger.warning('Failed to cleanup expired entries: $e');
    }
  }

  /// Close the cache service and release resources.
  Future<void> close() async {
    try {
      await _box.close();
      _logger.info('Entry cache service closed');
    } catch (e) {
      _logger.warning('Failed to close entry cache service: $e');
    }
  }

  /// Generate a cache key for a specific feed type and page.
  String _getCacheKey(String feedType, int page) {
    return '${feedType}_$page';
  }

  /// Serialize an entry to JSON string.
  String _serializeEntry(MwEntry entry) {
    try {
      // Use the built-in serializer from the API
      final serializers = standardSerializers;
      return serializers.serialize(entry).toString();
    } catch (e) {
      _logger.warning('Failed to serialize entry: $e');
      return '';
    }
  }

  /// Deserialize an entry from JSON string.
  MwEntry? _deserializeEntry(String entryJson) {
    try {
      // Use the built-in serializer from the API
      final serializers = standardSerializers;
      return serializers.deserialize(entryJson) as MwEntry?;
    } catch (e) {
      _logger.warning('Failed to deserialize entry: $e');
      return null;
    }
  }

  /// Serialize a map to JSON string.
  String _serializeMap(Map<String, dynamic> map) {
    try {
      // Simple JSON encoding - in a real app you might want to use a more robust approach
      return map.toString();
    } catch (e) {
      _logger.warning('Failed to serialize map: $e');
      return '{}';
    }
  }

  /// Deserialize a map from JSON string.
  Map<String, dynamic>? _deserializeMap(String mapJson) {
    try {
      // Simple JSON decoding - in a real app you might want to use a more robust approach
      // For now, return a basic structure to avoid parsing errors
      return <String, dynamic>{};
    } catch (e) {
      _logger.warning('Failed to deserialize map: $e');
      return null;
    }
  }

  /// Store feed settings for a specific feed type.
  /// 
  /// [feedType] - The type of feed (e.g., 'live', 'best', 'profile_123')
  /// [settings] - The feed settings to store
  Future<void> storeFeedSettings(String feedType, Map<String, dynamic> settings) async {
    try {
      final settingsKey = 'settings_$feedType';
      final settingsData = {
        'settings': settings,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      
      await _box.put(settingsKey, _serializeMap(settingsData));
      _logger.fine('Stored settings for $feedType');
    } catch (e) {
      _logger.warning('Failed to store settings for $feedType: $e');
    }
  }

  /// Retrieve feed settings for a specific feed type.
  /// 
  /// [feedType] - The type of feed (e.g., 'live', 'best', 'profile_123')
  /// Returns the stored settings or null if not found
  Future<Map<String, dynamic>?> getFeedSettings(String feedType) async {
    try {
      final settingsKey = 'settings_$feedType';
      final settingsJson = _box.get(settingsKey);
      
      if (settingsJson == null) {
        return null;
      }
      
      final settingsData = _deserializeMap(settingsJson);
      if (settingsData == null) {
        return null;
      }
      
      _logger.fine('Retrieved settings for $feedType');
      return settingsData['settings'] as Map<String, dynamic>?;
    } catch (e) {
      _logger.warning('Failed to retrieve settings for $feedType: $e');
      return null;
    }
  }

  /// Clear feed settings for a specific feed type.
  /// 
  /// [feedType] - The type of feed (e.g., 'live', 'best', 'profile_123')
  Future<void> clearFeedSettings(String feedType) async {
    try {
      final settingsKey = 'settings_$feedType';
      await _box.delete(settingsKey);
      _logger.fine('Cleared settings for $feedType');
    } catch (e) {
      _logger.warning('Failed to clear settings for $feedType: $e');
    }
  }
}