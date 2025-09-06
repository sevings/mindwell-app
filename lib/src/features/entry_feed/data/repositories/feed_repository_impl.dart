import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/entry.dart';
import '../../domain/repositories/feed_repository.dart';
import 'package:mindwell/mindwell.dart';

class FeedRepositoryImpl implements FeedRepository {
  final EntriesApi _entriesApi;
  final VotesApi _votesApi;
  final FavoritesApi _favoritesApi;
  final WatchingsApi _watchingsApi;
  final UsersApi _usersApi;

  const FeedRepositoryImpl(
    this._entriesApi,
    this._votesApi,
    this._favoritesApi,
    this._watchingsApi,
    this._usersApi,
  );

  @override
  Future<Result<List<Entry>>> getLiveFeed({
    int page = 1,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.newest,
  }) async {
    try {
      final response = await _entriesApi.entriesLiveGet(
        limit: limit,
        source_: _loadSourceToString(loadFrom),
        section: _sortByToSection(sortBy),
      );
      
      // Convert SDK model to our domain entities
      return Result.success(_convertFeedResponse(response.data));
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(message: 'Unexpected error occurred', originalError: e),
      );
    }
  }

  @override
  Future<Result<List<Entry>>> getBestFeed({
    int page = 1,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.best,
  }) async {
    try {
      final response = await _entriesApi.entriesBestGet(
        limit: limit,
        source_: _loadSourceToString(loadFrom),
        category: _sortByToCategory(sortBy),
      );
      
      // Convert SDK model to our domain entities
      return Result.success(_convertFeedResponse(response.data));
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(message: 'Unexpected error occurred', originalError: e),
      );
    }
  }

  @override
  Future<Result<List<Entry>>> getFollowingsFeed({
    int page = 1,
    int limit = 20,
    SortBy sortBy = SortBy.newest,
  }) async {
    try {
      final response = await _entriesApi.entriesFriendsGet(
        limit: limit,
        // Note: The SDK doesn't have explicit sort parameter for friends feed
        // We'll use the default behavior of the API
      );
      
      // Convert SDK model to our domain entities
      return Result.success(_convertFeedResponse(response.data));
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(message: 'Unexpected error occurred', originalError: e),
      );
    }
  }

  @override
  Future<Result<List<Entry>>> getProfileFeed({
    required String username,
    int page = 1,
    int limit = 20,
    SortBy sortBy = SortBy.newest,
  }) async {
    try {
      // Use the users API to get user's entries (Tlog endpoint)
      final response = await _usersApi.usersNameTlogGet(
        name: username,
        limit: limit,
        sort: _sortByToSortParam(sortBy),
      );
      
      // Convert SDK model to our domain entities
      return Result.success(_convertFeedResponse(response.data));
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(message: 'Unexpected error occurred', originalError: e),
      );
    }
  }

  @override
  Future<Result<List<Entry>>> refreshFeed({
    required FeedType feedType,
    String? username,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.newest,
  }) async {
    // Refresh is essentially getting the first page
    return switch (feedType) {
      FeedType.live => getLiveFeed(
          page: 1,
          limit: limit,
          loadFrom: loadFrom,
          sortBy: sortBy,
        ),
      FeedType.best => getBestFeed(
          page: 1,
          limit: limit,
          loadFrom: loadFrom,
          sortBy: sortBy,
        ),
      FeedType.followings => getFollowingsFeed(
          page: 1,
          limit: limit,
          sortBy: sortBy,
        ),
      FeedType.profile => username != null
          ? getProfileFeed(
              username: username,
              page: 1,
              limit: limit,
              sortBy: sortBy,
            )
          : const Result.failure(
              Failure.validation(message: 'Username required for profile feed'),
            ),
    };
  }

  @override
  Future<Result<Entry>> voteEntry({
    required int entryId,
    required int weight,
  }) async {
    try {
      // Use the votes API to vote on an entry
      final response = await _votesApi.entriesIdVotePut(
        id: entryId,
        weight: weight,
      );
      
      // Convert SDK response to our domain entity 
      // Note: The response might not contain the full entry, so we'll return a success
      // and let the caller handle any necessary refresh logic
      final entry = response.data?.entry;
      if (entry != null) {
        return Result.success(_convertEntry(entry)!);
      } else {
        // If no entry in response, just return success
        throw Failure.unknown(message: 'Failed to vote on entry');
      }
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(message: 'Failed to vote on entry', originalError: e),
      );
    }
  }

  @override
  Future<Result<Entry>> bookmarkEntry({
    required int entryId,
    required bool bookmark,
  }) async {
    try {
      // Use the favorites API to bookmark/unbookmark an entry
      final response = bookmark 
        ? await _favoritesApi.entriesIdFavoritePut(id: entryId)
        : await _favoritesApi.entriesIdFavoriteDelete(id: entryId);
      
      // Convert SDK response to our domain entity 
      final entry = response.data?.entry;
      if (entry != null) {
        return Result.success(_convertEntry(entry)!);
      } else {
        // If no entry in response, just return success
        throw Failure.unknown(message: 'Failed to ${bookmark ? 'bookmark' : 'unbookmark'} entry');
      }
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(
          message: 'Failed to ${bookmark ? 'bookmark' : 'unbookmark'} entry',
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Result<Entry>> watchEntry({
    required int entryId,
    required bool watch,
  }) async {
    try {
      // Use the watchings API to watch/unwatch an entry
      final response = watch 
        ? await _watchingsApi.entriesIdWatchingPut(id: entryId)
        : await _watchingsApi.entriesIdWatchingDelete(id: entryId);
      
      // Convert SDK response to our domain entity 
      final entry = response.data?.entry;
      if (entry != null) {
        return Result.success(_convertEntry(entry)!);
      } else {
        // If no entry in response, just return success
        throw Failure.unknown(message: 'Failed to ${watch ? 'watch' : 'unwatch'} entry');
      }
    } on DioException catch (e) {
      return Result.failure(_handleDioException(e));
    } catch (e) {
      return Result.failure(
        Failure.unknown(
          message: 'Failed to ${watch ? 'watch' : 'unwatch'} entry',
          originalError: e,
        ),
      );
    }
  }

  /// Converts LoadSource set to API string format
  String? _loadSourceToString(Set<LoadSource> loadFrom) {
    if (loadFrom.isEmpty) return null;
    
    final sources = loadFrom.map((source) {
      return switch (source) {
        LoadSource.diaries => 'diaries',
        LoadSource.themes => 'themes',
      };
    });
    
    return sources.join(',');
  }

  /// Converts SortBy enum to section parameter for live feed
  String? _sortByToSection(SortBy sortBy) {
    return switch (sortBy) {
      SortBy.newest => 'entries',
      SortBy.oldest => 'entries',
      SortBy.best => 'entries',
    };
  }

  /// Converts SortBy enum to category parameter for best feed
  String? _sortByToCategory(SortBy sortBy) {
    return switch (sortBy) {
      SortBy.newest => 'all',
      SortBy.oldest => 'all', 
      SortBy.best => 'all',
    };
  }

  /// Converts SortBy enum to sort parameter for profile feed
  String? _sortByToSortParam(SortBy sortBy) {
    return switch (sortBy) {
      SortBy.newest => 'new',
      SortBy.oldest => 'old',
      SortBy.best => 'best',
    };
  }

  /// Handles DioException and converts to appropriate Failure
  Failure _handleDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout => const Failure.timeout(
          message: 'Connection timeout',
        ),
      DioExceptionType.sendTimeout => const Failure.timeout(
          message: 'Send timeout',
        ),
      DioExceptionType.receiveTimeout => const Failure.timeout(
          message: 'Receive timeout',
        ),
      DioExceptionType.connectionError => const Failure.network(
          message: 'Connection error',
        ),
      DioExceptionType.badResponse => _handleBadResponse(e),
      DioExceptionType.cancel => const Failure.unknown(
          message: 'Request cancelled',
        ),
      DioExceptionType.unknown => Failure.unknown(
          message: 'Unknown network error',
          originalError: e.error,
        ),
      DioExceptionType.badCertificate => const Failure.network(
          message: 'Bad certificate',
        ),
    };
  }

  /// Handles bad HTTP response codes
  Failure _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = e.response?.data?['message'] ?? 'Request failed';

    return switch (statusCode) {
      400 => Failure.validation(message: message),
      401 => Failure.authentication(message: 'Authentication required'),
      403 => Failure.authorization(message: 'Access denied'),
      404 => Failure.notFound(message: 'Resource not found'),
      422 => Failure.validation(
          message: message,
          fieldErrors: _extractFieldErrors(e.response?.data),
        ),
      429 => const Failure.server(
          message: 'Too many requests',
          statusCode: 429,
        ),
      _ => Failure.server(
          message: message,
          statusCode: statusCode,
        ),
    };
  }

  /// Extracts field-specific validation errors from response
  Map<String, String>? _extractFieldErrors(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('errors')) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        return errors.map(
          (key, value) => MapEntry(
            key,
            value is List ? value.join(', ') : value.toString(),
          ),
        );
      }
    }
    return null;
  }

  /// Converts SDK MwFeed to our domain list of entries
  List<Entry> _convertFeedResponse(MwFeed? feed) {
    if (feed == null || feed.entries == null) {
      return [];
    }
    
    return feed.entries!
        .map((entry) => _convertEntry(entry))
        .whereType<Entry>()
        .toList();
  }

  /// Converts SDK MwEntry to our domain Entry
  Entry? _convertEntry(MwEntry? entry) {
    if (entry == null) return null;
    
    // Convert author from SDK model to our User model
    final author = _convertUser(entry.author);
    if (author == null) return null;
    
    return Entry(
      id: entry.id ?? 0,
      title: entry.title ?? '',
      content: entry.content ?? '',
      createdAt: entry.createdAt ?? DateTime.now(),
      updatedAt: entry.updatedAt,
      author: author,
      commentsCount: entry.commentCount ?? 0,
      votesCount: entry.favoriteCount ?? 0,
      isVoted: entry.isFavorited ?? false,
      isBookmarked: entry.isFavorited ?? false,
      isInDiary: entry.inLive ?? false,
      imageUrl: entry.images?.firstOrNull?.url,
      tags: entry.tags,
      isWatching: entry.isWatching,
      canComment: entry.isCommentable,
      canVote: entry.canVote,
      voteWeight: entry.rating,
      privacy: entry.privacy?.toString(),
      cutPos: entry.cutPos,
    );
  }

  /// Converts SDK MwUser to our domain User
  User? _convertUser(MwUser? user) {
    if (user == null) return null;
    
    return User(
      id: user.id ?? 0,
      name: user.name ?? '',
      showName: user.showName ?? '',
      avatarUrl: user.avatarUrl,
      isOnline: user.isOnline,
      gender: user.gender,
      isFollowed: user.isFollowed,
      isIgnored: user.isIgnored,
      isPrivate: user.isPrivate,
      relation: user.relation,
      lastSeenAt: user.lastSeenAt,
    );
  }
}