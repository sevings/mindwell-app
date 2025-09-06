import '../../../../core/utils/result.dart';
import '../entities/entry.dart';

abstract class FeedRepository {
  /// Fetches entries for the live feed
  Future<Result<List<Entry>>> getLiveFeed({
    int page = 1,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.newest,
  });

  /// Fetches entries for the best feed
  Future<Result<List<Entry>>> getBestFeed({
    int page = 1,
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.best,
  });

  /// Fetches entries from followed users
  Future<Result<List<Entry>>> getFollowingsFeed({
    int page = 1,
    int limit = 20,
    SortBy sortBy = SortBy.newest,
  });

  /// Fetches entries for a specific user profile
  Future<Result<List<Entry>>> getProfileFeed({
    required String username,
    int page = 1,
    int limit = 20,
    SortBy sortBy = SortBy.newest,
  });

  /// Refreshes the feed data
  Future<Result<List<Entry>>> refreshFeed({
    required FeedType feedType,
    String? username, // Required for profile feed
    int limit = 20,
    Set<LoadSource> loadFrom = const {LoadSource.diaries, LoadSource.themes},
    SortBy sortBy = SortBy.newest,
  });

  /// Votes on an entry
  Future<Result<Entry>> voteEntry({
    required int entryId,
    required int weight,
  });

  /// Bookmarks an entry
  Future<Result<Entry>> bookmarkEntry({
    required int entryId,
    required bool bookmark,
  });

  /// Watches/unwatches an entry
  Future<Result<Entry>> watchEntry({
    required int entryId,
    required bool watch,
  });
}