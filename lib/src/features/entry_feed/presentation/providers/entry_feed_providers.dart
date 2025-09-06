import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../../config/config.dart';
import '../../domain/entities/entry.dart';
import '../../domain/entities/entry_feed_state.dart';
import '../../domain/usecases/get_feed_entries.dart';
import '../../data/datasources/feed_api_client.dart';
import '../../data/repositories/feed_repository_impl.dart';
import '../../../../core/error/failures.dart';

// Dio provider for networking
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  ));

  // Add interceptors for logging, auth, etc.
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => print(obj),
  ));

  return dio;
});

// API client provider
final feedApiClientProvider = Provider<FeedApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return FeedApiClient(dio, baseUrl: Config.baseUrl);
});

// Repository provider
final feedRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(feedApiClientProvider);
  return FeedRepositoryImpl(apiClient);
});

// Use case provider
final getFeedEntriesProvider = Provider((ref) {
  final repository = ref.watch(feedRepositoryProvider);
  return GetFeedEntries(repository);
});

// Feed settings provider
final feedSettingsProvider = StateProvider.family<FeedSettings, FeedType>(
  (ref, feedType) => const FeedSettings(),
);

// Entry feed state notifier
class EntryFeedNotifier extends StateNotifier<EntryFeedState> {
  EntryFeedNotifier(
    this._getFeedEntries,
    this.feedType, {
    this.username,
  }) : super(const EntryFeedState.loading());

  final GetFeedEntries _getFeedEntries;
  final FeedType feedType;
  final String? username;

  int _currentPage = 1;

  /// Load initial feed data
  Future<void> loadFeed({FeedSettings? settings}) async {
    if (state is EntryFeedLoading) {
      // Already loading initial data
      return;
    }

    state = const EntryFeedState.loading();
    _currentPage = 1;

    final feedSettings = settings ?? const FeedSettings();

    final result = await _getFeedEntries.call(
      feedType: feedType,
      page: _currentPage,
      limit: feedSettings.entriesPerPage,
      loadFrom: feedSettings.loadFrom,
      sortBy: feedSettings.sortBy,
      username: username,
    );

    result.when(
      success: (entries) {
        state = EntryFeedState.loaded(
          entries: entries,
          hasMore: entries.length >= feedSettings.entriesPerPage,
          settings: feedSettings,
          currentPage: _currentPage,
        );
      },
      failure: (failure) {
        state = EntryFeedState.error(
          errorMessage: failure.userMessage,
          settings: feedSettings,
        );
      },
    );
  }

  /// Load more entries (pagination)
  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! EntryFeedLoaded || 
        currentState.isFetchingMore || 
        !currentState.hasMore) {
      return;
    }

    // Set fetching more state
    state = currentState.copyWith(isFetchingMore: true);

    final nextPage = _currentPage + 1;
    final result = await _getFeedEntries.call(
      feedType: feedType,
      page: nextPage,
      limit: currentState.settings.entriesPerPage,
      loadFrom: currentState.settings.loadFrom,
      sortBy: currentState.settings.sortBy,
      username: username,
    );

    result.when(
      success: (newEntries) {
        _currentPage = nextPage;
        final allEntries = <Entry>[...currentState.entries, ...newEntries];
        state = currentState.copyWith(
          entries: allEntries,
          isFetchingMore: false,
          hasMore: newEntries.length >= currentState.settings.entriesPerPage,
          currentPage: nextPage,
        );
      },
      failure: (failure) {
        state = currentState.copyWith(isFetchingMore: false);
        // Could optionally show a snackbar or toast here
      },
    );
  }

  /// Refresh feed data
  Future<void> refresh({FeedSettings? settings}) async {
    final feedSettings = settings ?? 
        (state is EntryFeedLoaded 
            ? (state as EntryFeedLoaded).settings 
            : const FeedSettings());

    _currentPage = 1;

    final result = await _getFeedEntries.refresh(
      feedType: feedType,
      limit: feedSettings.entriesPerPage,
      loadFrom: feedSettings.loadFrom,
      sortBy: feedSettings.sortBy,
      username: username,
    );

    result.when(
      success: (entries) {
        state = EntryFeedState.loaded(
          entries: entries,
          hasMore: entries.length >= feedSettings.entriesPerPage,
          settings: feedSettings,
          currentPage: _currentPage,
        );
      },
      failure: (failure) {
        state = EntryFeedState.error(
          errorMessage: failure.userMessage,
          previousEntries: state is EntryFeedLoaded 
              ? (state as EntryFeedLoaded).entries 
              : null,
          settings: feedSettings,
        );
      },
    );
  }

  /// Update feed settings and reload
  Future<void> updateSettings(FeedSettings newSettings) async {
    await loadFeed(settings: newSettings);
  }

  /// Update a specific entry in the feed (for voting, bookmarking, etc.)
  void updateEntry(Entry updatedEntry) {
    final currentState = state;
    if (currentState is EntryFeedLoaded) {
      final updatedEntries = currentState.entries.map((entry) {
        return entry.id == updatedEntry.id ? updatedEntry : entry;
      }).toList();
      
      state = currentState.copyWith(entries: updatedEntries);
    }
  }

  /// Remove an entry from the feed
  void removeEntry(int entryId) {
    final currentState = state;
    if (currentState is EntryFeedLoaded) {
      final updatedEntries = currentState.entries
          .where((entry) => entry.id != entryId)
          .toList();
      
      state = currentState.copyWith(entries: updatedEntries);
    }
  }
}

// Feed state notifier providers for different feed types
final liveFeedProvider = StateNotifierProvider<EntryFeedNotifier, EntryFeedState>(
  (ref) {
    final getFeedEntries = ref.watch(getFeedEntriesProvider);
    return EntryFeedNotifier(getFeedEntries, FeedType.live);
  },
);

final bestFeedProvider = StateNotifierProvider<EntryFeedNotifier, EntryFeedState>(
  (ref) {
    final getFeedEntries = ref.watch(getFeedEntriesProvider);
    return EntryFeedNotifier(getFeedEntries, FeedType.best);
  },
);

final followingsFeedProvider = StateNotifierProvider<EntryFeedNotifier, EntryFeedState>(
  (ref) {
    final getFeedEntries = ref.watch(getFeedEntriesProvider);
    return EntryFeedNotifier(getFeedEntries, FeedType.followings);
  },
);

// Profile feed provider (requires username)
final profileFeedProvider = StateNotifierProvider.family<EntryFeedNotifier, EntryFeedState, String>(
  (ref, username) {
    final getFeedEntries = ref.watch(getFeedEntriesProvider);
    return EntryFeedNotifier(getFeedEntries, FeedType.profile, username: username);
  },
);

// Helper provider to get the appropriate feed provider based on feed type
final feedProviderSelector = Provider.family<StateNotifierProvider<EntryFeedNotifier, EntryFeedState>, (FeedType, String?)>(
  (ref, params) {
    final (feedType, username) = params;
    
    return switch (feedType) {
      FeedType.live => liveFeedProvider,
      FeedType.best => bestFeedProvider,
      FeedType.followings => followingsFeedProvider,
      FeedType.profile => profileFeedProvider(username!),
    };
  },
);

// Current feed type provider (for tab management)
final currentFeedTypeProvider = StateProvider<FeedType>((ref) => FeedType.live);

// Current username for profile feed
final currentUsernameProvider = StateProvider<String?>((ref) => null);

// Active feed provider based on current feed type
final activeFeedProvider = Provider<StateNotifierProvider<EntryFeedNotifier, EntryFeedState>>((ref) {
  final feedType = ref.watch(currentFeedTypeProvider);
  final username = ref.watch(currentUsernameProvider);
  
  return ref.watch(feedProviderSelector((feedType, username)));
});