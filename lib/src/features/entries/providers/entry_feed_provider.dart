import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/services/entry_cache_service.dart';
import '../models/entry_feed_state.dart';
import '../models/feed_settings.dart';
import '../models/feed_type.dart';

/// Provider for the EntryCacheService instance.
final entryCacheServiceProvider = Provider<EntryCacheService>((ref) {
  return EntryCacheService();
});

/// Provider for the EntryFeedNotifier that manages the state of a specific feed type.
/// 
/// Takes a [FeedType] as a parameter to create separate providers for each feed type.
final entryFeedProvider = StateNotifierProvider.family<EntryFeedNotifier, EntryFeedState, FeedType>(
  (ref, feedType) {
    final entriesApi = ref.read(entriesApiProvider);
    final cacheService = ref.read(entryCacheServiceProvider);
    
    return EntryFeedNotifier(
      feedType: feedType,
      entriesApi: entriesApi,
      cacheService: cacheService,
    );
  },
);

/// Notifier that manages the state and logic for fetching and paginating entry feeds.
/// 
/// This class handles:
/// - Fetching initial entries from API or cache
/// - Implementing infinite scrolling with pagination
/// - Pull-to-refresh functionality
/// - Updating feed settings and refetching data
/// - Error handling and offline support
class EntryFeedNotifier extends StateNotifier<EntryFeedState> {
  final FeedType _feedType;
  final EntriesApi _entriesApi;
  final EntryCacheService _cacheService;
  final Logger _logger = Logger('EntryFeedNotifier');
  
  FeedSettings _settings = FeedSettings.defaultSettings;
  String? _nextAfter;
  bool _isLoadingMore = false;
  String? _feedParameter; // For profile/theme feeds

  EntryFeedNotifier({
    required FeedType feedType,
    required EntriesApi entriesApi,
    required EntryCacheService cacheService,
    String? feedParameter,
  })  : _feedType = feedType,
        _entriesApi = entriesApi,
        _cacheService = cacheService,
        _feedParameter = feedParameter,
        super(const EntryFeedState.initial());

  /// Fetch the initial entries for the feed.
  /// 
  /// This method will first try to load from cache, then fetch from the API.
  /// If cache is available, it will be shown immediately while API data loads in background.
  Future<void> fetchInitialEntries() async {
    if (state.when(
      initial: () => false,
      loading: () => true,
      loaded: (entries, hasMore, settings) => false,
      error: (message, entries) => false,
      empty: () => false,
    )) {
      return; // Prevent multiple simultaneous loads
    }
    
    _logger.info('Fetching initial entries for ${_feedType.name}');
    state = const EntryFeedState.loading();
    
    try {
      // Try to load from cache first
      final cacheKey = _feedType.getCacheKey(_feedParameter);
      final cachedEntries = await _cacheService.getEntries(cacheKey, page: 1);
      
      if (cachedEntries != null && cachedEntries.isNotEmpty) {
        _logger.info('Loaded ${cachedEntries.length} cached entries');
        state = EntryFeedState.loaded(
          entries: cachedEntries,
          hasMore: true, // Assume there's more until we fetch from API
          settings: _settings,
        );
      }
      
      // Fetch fresh data from API
      final feed = await _fetchFromApi();
      if (feed != null) {
        final entries = feed.entries?.toList() ?? [];
        _nextAfter = feed.nextAfter;
        
        // Cache the fresh data
        await _cacheService.storeEntries(cacheKey, entries, page: 1);
        
        _logger.info('Fetched ${entries.length} entries from API');
        
        if (entries.isEmpty) {
          // No entries from API
          state = const EntryFeedState.empty();
        } else {
          state = EntryFeedState.loaded(
            entries: entries,
            hasMore: feed.hasAfter ?? false,
            settings: _settings,
          );
        }
      } else if (cachedEntries == null) {
        // No cache and no API data
        state = const EntryFeedState.empty();
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch initial entries', e, stackTrace);
      
      // If we have cached data, show it with an error
      final cacheKey = _feedType.getCacheKey(_feedParameter);
      final cachedEntries = await _cacheService.getEntries(cacheKey, page: 1);
      
      if (cachedEntries != null && cachedEntries.isNotEmpty) {
        state = EntryFeedState.error(
          message: 'Failed to load new entries: ${e.toString()}',
          entries: cachedEntries,
        );
      } else {
        state = EntryFeedState.error(
          message: 'Failed to load entries: ${e.toString()}',
        );
      }
    }
  }

  /// Fetch more entries for infinite scrolling.
  /// 
  /// This method appends new entries to the existing list.
  Future<void> fetchMoreEntries() async {
    if (_isLoadingMore) return;
    
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (entries, hasMore, settings) => (entries: entries, hasMore: hasMore, settings: settings),
      error: (message, entries) => null,
      empty: () => null,
    );
    
    if (currentState == null || !currentState.hasMore) return;
    
    _isLoadingMore = true;
    _logger.info('Fetching more entries for ${_feedType.name}');
    
    try {
      final feed = await _fetchFromApi(after: _nextAfter);
      if (feed != null) {
        final newEntries = feed.entries?.toList() ?? [];
        _nextAfter = feed.nextAfter;
        
        final allEntries = [...currentState.entries, ...newEntries];
        
        // Cache the new page
        final cacheKey = _feedType.getCacheKey(_feedParameter);
        final pageNumber = (allEntries.length / _settings.entriesPerPage).ceil();
        await _cacheService.storeEntries(cacheKey, newEntries, page: pageNumber);
        
        _logger.info('Fetched ${newEntries.length} more entries');
        state = EntryFeedState.loaded(
          entries: allEntries,
          hasMore: feed.hasAfter ?? false,
          settings: _settings,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch more entries', e, stackTrace);
      // Don't change state on error - user can retry
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Refresh the feed by clearing cache and fetching fresh data.
  /// 
  /// This method is called for pull-to-refresh functionality.
  Future<void> refresh() async {
    _logger.info('Refreshing feed for ${_feedType.name}');
    
    // Clear cache for this feed type
    final cacheKey = _feedType.getCacheKey(_feedParameter);
    await _cacheService.clearFeedCache(cacheKey);
    
    // Reset pagination
    _nextAfter = null;
    
    // Fetch fresh data
    await fetchInitialEntries();
  }

  /// Update feed settings and refetch data with new settings.
  /// 
  /// [newSettings] - The new feed settings to apply
  Future<void> updateSettings(FeedSettings newSettings) async {
    if (_settings == newSettings) return;
    
    _logger.info('Updating settings for ${_feedType.name}');
    _settings = newSettings;
    
    // Clear cache since settings changed
    final cacheKey = _feedType.getCacheKey(_feedParameter);
    await _cacheService.clearFeedCache(cacheKey);
    
    // Reset pagination
    _nextAfter = null;
    
    // Fetch data with new settings
    await fetchInitialEntries();
  }

  /// Set the feed parameter for profile/theme feeds.
  /// 
  /// [parameter] - The parameter (e.g., user ID for profile, theme ID for theme)
  void setFeedParameter(String? parameter) {
    if (_feedParameter == parameter) return;
    
    _feedParameter = parameter;
    
    // Clear current state and fetch new data
    state = const EntryFeedState.initial();
    fetchInitialEntries();
  }

  /// Fetch entries from the API based on the feed type.
  Future<MwFeed?> _fetchFromApi({String? after, String? before}) async {
    try {
      switch (_feedType) {
        case FeedType.live:
          // Extract section from feed parameter (entries, waiting, comments)
          final section = _feedParameter?.split('_').last ?? 'entries';
          final response = await _entriesApi.entriesLiveGet(
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
            source_: 'all',
            section: section,
          );
          return response.data;
          
        case FeedType.best:
          // Extract category from feed parameter (week, month, year)
          final category = _feedParameter?.split('_').last ?? 'month';
          final response = await _entriesApi.entriesBestGet(
            limit: _settings.entriesPerPage,
            source_: 'all',
            category: category,
          );
          return response.data;
          
        case FeedType.friends:
          final response = await _entriesApi.entriesFriendsGet(
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
          );
          return response.data;
          
        case FeedType.profile:
          // For profile feeds, we need the user ID parameter
          if (_feedParameter == null) {
            throw Exception('Profile feed requires a user ID parameter');
          }
          // Note: This would need a specific API endpoint for user entries
          // For now, we'll use the live feed as a fallback
          final response = await _entriesApi.entriesLiveGet(
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
            source_: 'all',
            section: 'entries',
          );
          return response.data;
          
        case FeedType.theme:
          // For theme feeds, we need the theme ID parameter
          if (_feedParameter == null) {
            throw Exception('Theme feed requires a theme ID parameter');
          }
          // Note: This would need a specific API endpoint for theme entries
          // For now, we'll use the live feed as a fallback
          final response = await _entriesApi.entriesLiveGet(
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
            source_: 'all',
            section: 'entries',
          );
          return response.data;
      }
    } catch (e) {
      _logger.severe('API call failed for ${_feedType.name}', e);
      rethrow;
    }
  }
}
