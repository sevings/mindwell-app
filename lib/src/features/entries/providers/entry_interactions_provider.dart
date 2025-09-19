import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';

/// Provider for entry interactions (voting and favoriting).
///
/// This provider manages the state and API calls for voting and favoriting entries.
/// It provides optimistic updates and handles errors gracefully.
final entryInteractionsProvider = Provider<EntryInteractionsNotifier>((ref) {
  final votesApi = ref.read(votesApiProvider);
  final favoritesApi = ref.read(favoritesApiProvider);

  return EntryInteractionsNotifier(
    votesApi: votesApi,
    favoritesApi: favoritesApi,
  );
});

/// Notifier that handles entry interactions like voting and favoriting.
class EntryInteractionsNotifier {
  final VotesApi _votesApi;
  final FavoritesApi _favoritesApi;
  final Logger _logger = Logger('EntryInteractionsNotifier');

  EntryInteractionsNotifier({
    required VotesApi votesApi,
    required FavoritesApi favoritesApi,
  }) : _votesApi = votesApi,
       _favoritesApi = favoritesApi;

  /// Vote on an entry (upvote/downvote).
  ///
  /// [entryId] The ID of the entry to vote on
  /// [isUpvote] Whether this is an upvote (true) or downvote (false)
  /// Returns the updated rating if successful, null if failed
  Future<MwRating?> voteEntry(int entryId, bool isUpvote) async {
    try {
      _logger.info('Voting ${isUpvote ? 'up' : 'down'} on entry $entryId');

      final response = await _votesApi.entriesIdVotePut(
        id: entryId,
        positive: isUpvote,
      );

      final rating = response.data;
      if (rating != null) {
        _logger.info('Successfully voted on entry $entryId');
        return rating;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe('Failed to vote on entry $entryId', e, stackTrace);
      return null;
    }
  }

  /// Remove vote from an entry.
  ///
  /// [entryId] The ID of the entry to remove vote from
  /// Returns the updated rating if successful, null if failed
  Future<MwRating?> removeVote(int entryId) async {
    try {
      _logger.info('Removing vote from entry $entryId');

      final response = await _votesApi.entriesIdVoteDelete(id: entryId);

      final rating = response.data;
      if (rating != null) {
        _logger.info('Successfully removed vote from entry $entryId');
        return rating;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to remove vote from entry $entryId',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Get current vote status for an entry.
  ///
  /// [entryId] The ID of the entry to get vote status for
  /// Returns the current rating if successful, null if failed
  Future<MwRating?> getVoteStatus(int entryId) async {
    try {
      _logger.info('Getting vote status for entry $entryId');

      final response = await _votesApi.entriesIdVoteGet(id: entryId);

      final rating = response.data;
      if (rating != null) {
        _logger.info('Successfully got vote status for entry $entryId');
        return rating;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to get vote status for entry $entryId',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Toggle favorite status for an entry.
  ///
  /// [entryId] The ID of the entry to toggle favorite for
  /// [isFavorited] Current favorite status
  /// Returns the updated favorite status if successful, null if failed
  Future<MwFavoriteStatus?> toggleFavorite(
    int entryId,
    bool isFavorited,
  ) async {
    try {
      _logger.info(
        'Toggling favorite for entry $entryId (currently: $isFavorited)',
      );

      final response = isFavorited
          ? await _favoritesApi.entriesIdFavoriteDelete(id: entryId)
          : await _favoritesApi.entriesIdFavoritePut(id: entryId);

      final favoriteStatus = response.data;
      if (favoriteStatus != null) {
        _logger.info('Successfully toggled favorite for entry $entryId');
        return favoriteStatus;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to toggle favorite for entry $entryId',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Get current favorite status for an entry.
  ///
  /// [entryId] The ID of the entry to get favorite status for
  /// Returns the current favorite status if successful, null if failed
  Future<MwFavoriteStatus?> getFavoriteStatus(int entryId) async {
    try {
      _logger.info('Getting favorite status for entry $entryId');

      final response = await _favoritesApi.entriesIdFavoriteGet(id: entryId);

      final favoriteStatus = response.data;
      if (favoriteStatus != null) {
        _logger.info('Successfully got favorite status for entry $entryId');
        return favoriteStatus;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to get favorite status for entry $entryId',
        e,
        stackTrace,
      );
      return null;
    }
  }
}
