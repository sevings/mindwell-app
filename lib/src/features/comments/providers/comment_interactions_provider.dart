import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';

/// Provider for comment interactions (voting).
///
/// This provider manages the state and API calls for voting on comments.
/// It provides optimistic updates and handles errors gracefully.
final commentInteractionsProvider = Provider<CommentInteractionsNotifier>((
  ref,
) {
  final votesApi = ref.read(votesApiProvider);

  return CommentInteractionsNotifier(votesApi: votesApi);
});

/// Notifier that handles comment interactions like voting.
class CommentInteractionsNotifier {
  final VotesApi _votesApi;
  final Logger _logger = Logger('CommentInteractionsNotifier');

  CommentInteractionsNotifier({required VotesApi votesApi})
    : _votesApi = votesApi;

  /// Vote on a comment (upvote/downvote).
  ///
  /// [commentId] The ID of the comment to vote on
  /// [isUpvote] Whether this is an upvote (true) or downvote (false)
  /// Returns the updated rating if successful, null if failed
  Future<MwRating?> voteComment(int commentId, bool isUpvote) async {
    try {
      _logger.info('Voting ${isUpvote ? 'up' : 'down'} on comment $commentId');

      final response = await _votesApi.commentsIdVotePut(
        id: commentId,
        positive: isUpvote,
      );

      final rating = response.data;
      if (rating != null) {
        _logger.info('Successfully voted on comment $commentId');
        return rating;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe('Failed to vote on comment $commentId', e, stackTrace);
      return null;
    }
  }

  /// Remove vote from a comment.
  ///
  /// [commentId] The ID of the comment to remove vote from
  /// Returns the updated rating if successful, null if failed
  Future<MwRating?> removeVote(int commentId) async {
    try {
      _logger.info('Removing vote from comment $commentId');

      final response = await _votesApi.commentsIdVoteDelete(id: commentId);

      final rating = response.data;
      if (rating != null) {
        _logger.info('Successfully removed vote from comment $commentId');
        return rating;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to remove vote from comment $commentId',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Get current vote status for a comment.
  ///
  /// [commentId] The ID of the comment to get vote status for
  /// Returns the current rating if successful, null if failed
  Future<MwRating?> getVoteStatus(int commentId) async {
    try {
      _logger.info('Getting vote status for comment $commentId');

      final response = await _votesApi.commentsIdVoteGet(id: commentId);

      final rating = response.data;
      if (rating != null) {
        _logger.info('Successfully got vote status for comment $commentId');
        return rating;
      }

      return null;
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to get vote status for comment $commentId',
        e,
        stackTrace,
      );
      return null;
    }
  }
}
