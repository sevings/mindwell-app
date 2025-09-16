import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../../../core/services/entry_cache_service.dart';
import '../models/entry_feed_state.dart';
import '../models/feed_settings.dart';
import '../models/feed_type.dart';

/// Provider for the EntryCacheService instance.
final entryCacheServiceProvider = FutureProvider<EntryCacheService>((
  ref,
) async {
  final service = EntryCacheService();
  await service.initialize();
  return service;
});

/// Provider for the EntryFeedNotifier that manages the state of a specific feed type.
///
/// Takes both [FeedType] and optional [String] (feedParameter) as parameters.
/// This unified provider handles all feed types, whether they need parameters or not.
final entryFeedProvider =
    StateNotifierProvider.family<
      EntryFeedNotifier,
      EntryFeedState,
      ({FeedType feedType, String? feedParameter})
    >((ref, params) {
      final entriesApi = ref.read(entriesApiProvider);
      final usersApi = ref.read(usersApiProvider);

      // Get the cache service asynchronously
      final cacheServiceAsync = ref.read(entryCacheServiceProvider.future);

      return EntryFeedNotifier(
        feedType: params.feedType,
        entriesApi: entriesApi,
        usersApi: usersApi,
        cacheServiceAsync: cacheServiceAsync,
        feedParameter: params.feedParameter,
      );
    });

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
  final UsersApi _usersApi;
  final Future<EntryCacheService> _cacheServiceAsync;
  final Logger _logger = Logger('EntryFeedNotifier');

  FeedSettings _settings = FeedSettings.defaultSettings;
  String? _nextAfter;
  bool _isLoadingMore = false;
  String? _feedParameter; // For profile/theme feeds
  String? _tagFilter; // For tag-filtered feeds

  EntryFeedNotifier({
    required FeedType feedType,
    required EntriesApi entriesApi,
    required UsersApi usersApi,
    required Future<EntryCacheService> cacheServiceAsync,
    String? feedParameter,
    String? tagFilter,
  }) : _feedType = feedType,
       _entriesApi = entriesApi,
       _usersApi = usersApi,
       _cacheServiceAsync = cacheServiceAsync,
       _feedParameter = feedParameter,
       _tagFilter = tagFilter,
       super(const EntryFeedState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by loading settings from cache.
  Future<void> _initialize() async {
    await _loadSettingsFromCache();
  }

  /// Get the cache key for this feed configuration.
  String _getCacheKey() {
    final baseKey = _feedType.getCacheKey(_feedParameter);
    if (_tagFilter != null) {
      return '${baseKey}_tag_$_tagFilter';
    }
    return baseKey;
  }

  /// Load settings from cache.
  Future<void> _loadSettingsFromCache() async {
    try {
      final cacheService = await _cacheServiceAsync;
      final cacheKey = _getCacheKey();
      final cachedSettings = await cacheService.getFeedSettings(cacheKey);

      if (cachedSettings != null) {
        // Convert the cached map back to FeedSettings
        _settings = FeedSettings(
          entriesPerPage: cachedSettings['entriesPerPage'] ?? 20,
          displayFormat: DisplayFormat.values.firstWhere(
            (format) => format.name == cachedSettings['displayFormat'],
            orElse: () => DisplayFormat.short,
          ),
          sortOrder: SortOrder.values.firstWhere(
            (order) => order.name == cachedSettings['sortOrder'],
            orElse: () => SortOrder.newest,
          ),
          includeTlogs: cachedSettings['includeTlogs'] ?? true,
          includeThemes: cachedSettings['includeThemes'] ?? true,
        );
        _logger.info('Loaded settings from cache for ${_feedType.name}');
      }
    } catch (e) {
      _logger.warning('Failed to load settings from cache: $e');
    }
  }

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
      final cacheService = await _cacheServiceAsync;

      // Try to load from cache first
      final cacheKey = _getCacheKey();
      final cachedEntries = await cacheService.getEntries(cacheKey, page: 1);

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
        await cacheService.storeEntries(cacheKey, entries, page: 1);

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
      try {
        final cacheService = await _cacheServiceAsync;
        final cacheKey = _getCacheKey();
        final cachedEntries = await cacheService.getEntries(cacheKey, page: 1);

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
      } catch (cacheError) {
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
      loaded: (entries, hasMore, settings) =>
          (entries: entries, hasMore: hasMore, settings: settings),
      error: (message, entries) => null,
      empty: () => null,
    );

    if (currentState == null || !currentState.hasMore) return;

    _isLoadingMore = true;
    _logger.info('Fetching more entries for ${_feedType.name}');

    try {
      final cacheService = await _cacheServiceAsync;
      final feed = await _fetchFromApi(after: _nextAfter);
      if (feed != null) {
        final newEntries = feed.entries?.toList() ?? [];
        _nextAfter = feed.nextAfter;

        final allEntries = [...currentState.entries, ...newEntries];

        // Cache the new page
        final cacheKey = _getCacheKey();
        final pageNumber = (allEntries.length / _settings.entriesPerPage)
            .ceil();
        await cacheService.storeEntries(cacheKey, newEntries, page: pageNumber);

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

    // Get current settings from state to ensure we use the most up-to-date settings
    final currentSettings = state.when(
      initial: () => _settings,
      loading: () => _settings,
      loaded: (entries, hasMore, settings) => settings,
      error: (message, entries) => _settings,
      empty: () => _settings,
    );

    // Update internal settings to match current state
    _settings = currentSettings;

    // Clear only the entries cache, preserve settings
    final cacheService = await _cacheServiceAsync;
    final cacheKey = _getCacheKey();
    await cacheService.clearFeedCache(cacheKey);

    // Reset pagination
    _nextAfter = null;

    // Fetch fresh data with current settings
    await fetchInitialEntries();
  }

  /// Save current settings to cache.
  Future<void> _saveSettingsToCache() async {
    try {
      final cacheService = await _cacheServiceAsync;
      final cacheKey = _getCacheKey();
      final settingsMap = {
        'entriesPerPage': _settings.entriesPerPage,
        'displayFormat': _settings.displayFormat.name,
        'sortOrder': _settings.sortOrder.name,
        'includeTlogs': _settings.includeTlogs,
        'includeThemes': _settings.includeThemes,
      };

      await cacheService.storeFeedSettings(cacheKey, settingsMap);
      _logger.info('Saved settings to cache for ${_feedType.name}');
    } catch (e) {
      _logger.warning('Failed to save settings to cache: $e');
    }
  }

  /// Update feed settings and refetch data with new settings.
  ///
  /// [newSettings] - The new feed settings to apply
  Future<void> updateSettings(FeedSettings newSettings) async {
    if (_settings == newSettings) return;

    _logger.info('Updating settings for ${_feedType.name}');
    _settings = newSettings;

    // Save settings to cache
    await _saveSettingsToCache();

    // Clear cache since settings changed
    final cacheService = await _cacheServiceAsync;
    final cacheKey = _getCacheKey();
    await cacheService.clearFeedCache(cacheKey);

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

  /// Set the tag filter for tag-filtered feeds.
  ///
  /// [tag] - The tag to filter entries by
  void setTagFilter(String? tag) {
    if (_tagFilter == tag) return;

    _tagFilter = tag;

    // Clear current state and fetch new data
    state = const EntryFeedState.initial();
    fetchInitialEntries();
  }

  /// Get the source parameter based on current settings
  String _getSourceParameter() {
    if (_settings.includeTlogs && _settings.includeThemes) {
      return 'all';
    } else if (_settings.includeTlogs) {
      return 'users';
    } else if (_settings.includeThemes) {
      return 'themes';
    } else {
      // If neither is selected, default to all
      return 'all';
    }
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
            tag: _tagFilter,
            source_: _getSourceParameter(),
            section: section,
          );
          return response.data;

        case FeedType.best:
          // Extract category from feed parameter (week, month, year)
          final category = _feedParameter?.split('_').last ?? 'month';
          final response = await _entriesApi.entriesBestGet(
            limit: _settings.entriesPerPage,
            tag: _tagFilter,
            source_: _getSourceParameter(),
            category: category,
          );
          return response.data;

        case FeedType.friends:
          // For subscriptions feed, check the feed parameter to determine which endpoint to use
          if (_feedParameter != null && _feedParameter!.contains('_')) {
            final endpoint = _feedParameter!.split('_').last;
            if (endpoint == 'watching') {
              final response = await _entriesApi.entriesWatchingGet(
                limit: _settings.entriesPerPage,
                after: after,
                before: before,
              );
              return response.data;
            }
          }
          // Default to friends endpoint
          final response = await _entriesApi.entriesFriendsGet(
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
          );
          return response.data;

        case FeedType.profile:
          // For profile feeds, we need the username parameter
          if (_feedParameter == null) {
            throw Exception('Profile feed requires a username parameter');
          }
          // Use the proper user tlog API endpoint
          final response = await _usersApi.usersNameTlogGet(
            name: _feedParameter!,
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
            tag: _tagFilter,
            sort: _settings.sortOrder == SortOrder.newest
                ? 'new'
                : _settings.sortOrder == SortOrder.oldest
                ? 'old'
                : 'best',
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

        case FeedType.favorites:
          // For favorites feeds, we need the username parameter
          if (_feedParameter == null) {
            throw Exception('Favorites feed requires a username parameter');
          }
          final response = await _usersApi.usersNameFavoritesGet(
            name: _feedParameter!,
            limit: _settings.entriesPerPage,
            after: after,
            before: before,
          );
          return response.data;
      }
    } catch (e) {
      _logger.severe('API call failed for ${_feedType.name}', e);
      rethrow;
    }
  }
}
