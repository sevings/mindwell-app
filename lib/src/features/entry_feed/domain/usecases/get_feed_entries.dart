import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/entry.dart';
import '../repositories/feed_repository.dart';

class GetFeedEntries {
  final FeedRepository _repository;

  const GetFeedEntries(this._repository);

  /// Fetches entries based on the feed type and parameters
  Future<Result<List<Entry>>> call({
    required FeedType feedType,
    int page = 1,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.newest,
    String? username, // Required for profile feed
  }) async {
    switch (feedType) {
      case FeedType.live:
        return _repository.getLiveFeed(
          page: page,
          limit: limit,
          loadFrom: loadFrom,
          sortBy: sortBy,
        );
      case FeedType.best:
        return _repository.getBestFeed(
          page: page,
          limit: limit,
          loadFrom: loadFrom,
          sortBy: sortBy,
        );
      case FeedType.followings:
        return _repository.getFollowingsFeed(
          page: page,
          limit: limit,
          sortBy: sortBy,
        );
      case FeedType.profile:
        if (username == null) {
          return Result.failure(
            Failure.validation(message: 'Username is required for profile feed'),
          );
        }
        return _repository.getProfileFeed(
          username: username,
          page: page,
          limit: limit,
          sortBy: sortBy,
        );
    }
  }

  /// Refreshes the feed data
  Future<Result<List<Entry>>> refresh({
    required FeedType feedType,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.newest,
    String? username,
  }) async {
    return _repository.refreshFeed(
      feedType: feedType,
      username: username,
      limit: limit,
      loadFrom: loadFrom,
      sortBy: sortBy,
    );
  }
}