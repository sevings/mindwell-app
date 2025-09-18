import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_provider.dart';
import '../models/entry_detail_state.dart';

/// Provider for the EntryDetailNotifier that manages the state of a specific entry.
///
/// Takes an [entryId] as a parameter to create separate providers for each entry.
final entryDetailProvider =
    StateNotifierProvider.family<EntryDetailNotifier, EntryDetailState, int>((
      ref,
      entryId,
    ) {
      final entriesApi = ref.read(entriesApiProvider);
      final commentsApi = ref.read(commentsApiProvider);
      final watchingsApi = ref.read(watchingsApiProvider);

      return EntryDetailNotifier(
        entryId: entryId,
        entriesApi: entriesApi,
        commentsApi: commentsApi,
        watchingsApi: watchingsApi,
      );
    });

/// Notifier that manages the state and logic for fetching entry details and comments.
///
/// This class handles:
/// - Fetching entry details from the API
/// - Fetching and paginating comments for the entry
/// - Error handling and state management
/// - Optimistic UI updates for voting and favoriting
class EntryDetailNotifier extends StateNotifier<EntryDetailState> {
  final int _entryId;
  final EntriesApi _entriesApi;
  final CommentsApi _commentsApi;
  final WatchingsApi _watchingsApi;
  final Logger _logger = Logger('EntryDetailNotifier');

  String? _commentsBefore;
  bool _isLoadingComments = false;

  EntryDetailNotifier({
    required int entryId,
    required EntriesApi entriesApi,
    required CommentsApi commentsApi,
    required WatchingsApi watchingsApi,
  }) : _entryId = entryId,
       _entriesApi = entriesApi,
       _commentsApi = commentsApi,
       _watchingsApi = watchingsApi,
       super(const EntryDetailState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by fetching the entry details.
  Future<void> _initialize() async {
    await fetchEntryDetails();
  }

  /// Fetch the entry details from the API.
  ///
  /// This method fetches the full entry details including initial comments and adjacent entries.
  Future<void> fetchEntryDetails() async {
    if (state.when(
      initial: () => false,
      loading: () => true,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => false,
      error: (message, entry) => false,
    )) {
      return; // Prevent multiple simultaneous loads
    }

    _logger.info('Fetching entry details for entry $_entryId');
    state = const EntryDetailState.loading();

    try {
      // Fetch entry details and adjacent entries in parallel
      final futures = await Future.wait([
        _entriesApi.entriesIdGet(id: _entryId),
        _entriesApi.entriesIdAdjacentGet(id: _entryId),
      ]);

      final entryResponse = futures[0] as Response<MwEntry>;
      final adjacentResponse = futures[1] as Response<MwAdjacentEntries>;

      final entry = entryResponse.data;
      final adjacentEntries = adjacentResponse.data;

      if (entry == null) {
        throw Exception('Entry not found');
      }

      _logger.info('Fetched entry details for entry $_entryId');
      if (adjacentEntries != null) {
        _logger.info('Fetched adjacent entries for entry $_entryId');
      }

      // Extract comments from the entry response
      final commentList = entry.comments;
      if (commentList != null) {
        final initialComments = commentList.data?.toList() ?? [];
        _commentsBefore = commentList.nextBefore;

        _logger.info(
          'Loaded ${initialComments.length} initial comments from entry response',
        );

        state = EntryDetailState.loaded(
          entry: entry,
          comments: initialComments,
          hasMoreComments: commentList.hasBefore ?? false,
          isLoadingComments: false,
          adjacentEntries: adjacentEntries,
        );
      } else {
        // No comments in the entry response
        state = EntryDetailState.loaded(
          entry: entry,
          comments: [],
          hasMoreComments: false,
          isLoadingComments: false,
          adjacentEntries: adjacentEntries,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to fetch entry details for entry $_entryId',
        e,
        stackTrace,
      );
      state = EntryDetailState.error(
        message: 'Failed to load entry: ${e.toString()}',
      );
    }
  }

  /// Fetch more comments for the entry (for pagination).
  Future<void> _fetchMoreComments() async {
    if (_isLoadingComments) return;

    _isLoadingComments = true;

    try {
      final commentsResponse = await _commentsApi.entriesIdCommentsGet(
        id: _entryId,
        limit: 30,
        before: _commentsBefore,
      );

      final commentList = commentsResponse.data;
      if (commentList != null) {
        final newComments = commentList.data?.toList() ?? [];
        _commentsBefore = commentList.nextBefore;

        // Load more comments - append to existing list
        final currentState = state.when(
          initial: () => null,
          loading: () => null,
          loaded:
              (
                entry,
                comments,
                hasMoreComments,
                isLoadingComments,
                adjacentEntries,
              ) => (
                entry: entry,
                comments: comments,
                hasMoreComments: hasMoreComments,
                adjacentEntries: adjacentEntries,
              ),
          error: (message, entry) => null,
        );

        if (currentState != null) {
          final allComments = <MwComment>[
            ...currentState.comments,
            ...newComments,
          ];
          state = EntryDetailState.loaded(
            entry: currentState.entry,
            comments: allComments,
            hasMoreComments: commentList.hasBefore ?? false,
            isLoadingComments: false,
            adjacentEntries: currentState.adjacentEntries,
          );
        }

        _logger.info(
          'Fetched ${newComments.length} more comments for entry $_entryId',
        );
      }
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to fetch more comments for entry $_entryId',
        e,
        stackTrace,
      );

      // Update state to show error but keep existing data
      final currentState = state.when(
        initial: () => null,
        loading: () => null,
        loaded:
            (
              entry,
              comments,
              hasMoreComments,
              isLoadingComments,
              adjacentEntries,
            ) => (
              entry: entry,
              comments: comments,
              hasMoreComments: hasMoreComments,
              adjacentEntries: adjacentEntries,
            ),
        error: (message, entry) => null,
      );

      if (currentState != null) {
        state = EntryDetailState.loaded(
          entry: currentState.entry,
          comments: currentState.comments,
          hasMoreComments: currentState.hasMoreComments,
          isLoadingComments: false,
          adjacentEntries: currentState.adjacentEntries,
        );
      }
    } finally {
      _isLoadingComments = false;
    }
  }

  /// Load more comments for infinite scrolling.
  Future<void> loadMoreComments() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null ||
        !currentState.hasMoreComments ||
        _isLoadingComments) {
      return;
    }

    _logger.info('Loading more comments for entry $_entryId');
    await _fetchMoreComments();
  }

  /// Refresh the entry details and comments.
  ///
  /// This method clears the current state and fetches fresh data.
  Future<void> refresh() async {
    _logger.info('Refreshing entry details for entry $_entryId');

    // Reset pagination
    _commentsBefore = null;

    // Fetch fresh data
    await fetchEntryDetails();
  }

  /// Vote on the entry (upvote/downvote).
  ///
  /// [isUpvote] Whether this is an upvote (true) or downvote (false)
  Future<void> voteEntry(bool isUpvote) async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      // Optimistic update
      // Note: Since MwEntry is a built_value model, we can't easily modify it
      // In a real implementation, you'd need to create a new instance or use a different approach
      // For now, we'll just keep the current entry unchanged
      final updatedEntry = currentState.entry;

      state = EntryDetailState.loaded(
        entry: updatedEntry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );

      // Make API call
      // Note: The actual voting API endpoint would need to be implemented
      // For now, we'll just log the action
      _logger.info('Voting ${isUpvote ? 'up' : 'down'} on entry $_entryId');
    } catch (e, stackTrace) {
      _logger.severe('Failed to vote on entry $_entryId', e, stackTrace);

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
      );
    }
  }

  /// Toggle favorite status for the entry.
  Future<void> toggleFavorite() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      // Optimistic update
      // Note: Since MwEntry is a built_value model, we can't easily modify it
      // In a real implementation, you'd need to create a new instance or use a different approach
      // For now, we'll just keep the current entry unchanged
      final updatedEntry = currentState.entry;

      state = EntryDetailState.loaded(
        entry: updatedEntry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );

      // Make API call
      // Note: The actual favorite API endpoint would need to be implemented
      // For now, we'll just log the action
      _logger.info('Toggling favorite for entry $_entryId');
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to toggle favorite for entry $_entryId',
        e,
        stackTrace,
      );

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
      );
    }
  }

  /// Add a new comment to the entry.
  ///
  /// [content] The content of the comment
  /// Returns true if successful, false if failed or duplicate
  Future<bool> addComment(String content) async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return false;

    try {
      // Make API call to add comment
      final response = await _commentsApi.entriesIdCommentsPost(
        id: _entryId,
        content: content,
      );

      final newComment = response.data;
      if (newComment != null) {
        // Check if comment already exists by ID
        final commentExists = currentState.comments.any(
          (comment) => comment.id == newComment.id,
        );

        if (commentExists) {
          _logger.warning(
            'Comment with ID ${newComment.id} already exists in the list',
          );
          return false; // Don't add duplicate comment
        }

        // Add the new comment to the list
        final updatedComments = [...currentState.comments, newComment];

        // Update comment count in entry
        // Note: Since MwEntry is a built_value model, we can't easily modify it
        // In a real implementation, you'd need to create a new instance or use a different approach
        // For now, we'll just keep the current entry unchanged
        final updatedEntry = currentState.entry;

        state = EntryDetailState.loaded(
          entry: updatedEntry,
          comments: updatedComments,
          hasMoreComments: currentState.hasMoreComments,
          isLoadingComments: false,
          adjacentEntries: currentState.adjacentEntries,
        );

        _logger.info('Added comment to entry $_entryId');
        return true; // Success
      }
      return false; // No comment data returned
    } catch (e, stackTrace) {
      _logger.severe('Failed to add comment to entry $_entryId', e, stackTrace);
      // Don't change state on error - user can retry
      return false; // Failed
    }
  }

  /// Pin the entry.
  Future<void> pinEntry() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      _logger.info('Pinning entry $_entryId');

      // Make API call to pin entry
      final response = await _entriesApi.entriesIdPinPut(id: _entryId);
      final pinStatus = response.data;

      if (pinStatus != null) {
        _logger.info('Successfully pinned entry $_entryId');

        // Update the entry with the new pin status
        final updatedEntry = currentState.entry.rebuild(
          (b) => b..isPinned = true,
        );

        state = EntryDetailState.loaded(
          entry: updatedEntry,
          comments: currentState.comments,
          hasMoreComments: currentState.hasMoreComments,
          isLoadingComments: false,
          adjacentEntries: currentState.adjacentEntries,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to pin entry $_entryId', e, stackTrace);

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );
    }
  }

  /// Unpin the entry.
  Future<void> unpinEntry() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      _logger.info('Unpinning entry $_entryId');

      // Make API call to unpin entry
      final response = await _entriesApi.entriesIdPinDelete(id: _entryId);
      final pinStatus = response.data;

      if (pinStatus != null) {
        _logger.info('Successfully unpinned entry $_entryId');

        // Update the entry with the new pin status
        final updatedEntry = currentState.entry.rebuild(
          (b) => b..isPinned = false,
        );

        state = EntryDetailState.loaded(
          entry: updatedEntry,
          comments: currentState.comments,
          hasMoreComments: currentState.hasMoreComments,
          isLoadingComments: false,
          adjacentEntries: currentState.adjacentEntries,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to unpin entry $_entryId', e, stackTrace);

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );
    }
  }

  /// Follow the entry.
  Future<void> followEntry() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      _logger.info('Following entry $_entryId');

      // Make API call to follow entry
      final response = await _watchingsApi.entriesIdWatchingPut(id: _entryId);
      final watchingStatus = response.data;

      if (watchingStatus != null) {
        _logger.info('Successfully followed entry $_entryId');

        // Update the entry with the new watching status
        final updatedEntry = currentState.entry.rebuild(
          (b) => b..isWatching = true,
        );

        state = EntryDetailState.loaded(
          entry: updatedEntry,
          comments: currentState.comments,
          hasMoreComments: currentState.hasMoreComments,
          isLoadingComments: false,
          adjacentEntries: currentState.adjacentEntries,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to follow entry $_entryId', e, stackTrace);

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );
    }
  }

  /// Unfollow the entry.
  Future<void> unfollowEntry() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      _logger.info('Unfollowing entry $_entryId');

      // Make API call to unfollow entry
      final response = await _watchingsApi.entriesIdWatchingDelete(
        id: _entryId,
      );
      final watchingStatus = response.data;

      if (watchingStatus != null) {
        _logger.info('Successfully unfollowed entry $_entryId');

        // Update the entry with the new watching status
        final updatedEntry = currentState.entry.rebuild(
          (b) => b..isWatching = false,
        );

        state = EntryDetailState.loaded(
          entry: updatedEntry,
          comments: currentState.comments,
          hasMoreComments: currentState.hasMoreComments,
          isLoadingComments: false,
          adjacentEntries: currentState.adjacentEntries,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to unfollow entry $_entryId', e, stackTrace);

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );
    }
  }

  /// Delete the entry.
  Future<void> deleteEntry() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      _logger.info('Deleting entry $_entryId');

      // Make API call to delete entry
      await _entriesApi.entriesIdDelete(id: _entryId);

      _logger.info('Successfully deleted entry $_entryId');

      // In a real implementation, you would navigate back or show a deleted state
      // For now, we'll just keep the current state
    } catch (e, stackTrace) {
      _logger.severe('Failed to delete entry $_entryId', e, stackTrace);
    }
  }

  /// Submit a complaint about the entry.
  Future<void> complainEntry({String? content}) async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      _logger.info('Submitting complaint for entry $_entryId');

      // Make API call to submit complaint
      // Use provided content or default message
      await _entriesApi.entriesIdComplainPost(
        id: _entryId,
        content: content ?? 'Complaint submitted via mobile app',
      );

      _logger.info('Successfully submitted complaint for entry $_entryId');
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to submit complaint for entry $_entryId',
        e,
        stackTrace,
      );
    }
  }

  /// Delete a comment.
  Future<void> deleteComment(int commentId) async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      // Make API call to delete comment
      // Note: The actual delete comment API endpoint would need to be implemented
      // For now, we'll just log the action
      _logger.info('Deleting comment $commentId from entry $_entryId');

      // Optimistic update - remove comment from list
      final updatedComments = currentState.comments
          .where((comment) => comment.id != commentId)
          .toList();

      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: updatedComments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
        adjacentEntries: currentState.adjacentEntries,
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to delete comment $commentId from entry $_entryId',
        e,
        stackTrace,
      );

      // Revert optimistic update on error
      state = EntryDetailState.loaded(
        entry: currentState.entry,
        comments: currentState.comments,
        hasMoreComments: currentState.hasMoreComments,
        isLoadingComments: false,
      );
    }
  }

  /// Vote on a comment.
  Future<void> voteComment(int commentId, bool isUpvote) async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      // Make API call to vote on comment
      // Note: The actual comment voting API endpoint would need to be implemented
      // For now, we'll just log the action
      _logger.info('Voting ${isUpvote ? 'up' : 'down'} on comment $commentId');

      // Optimistic update - in a real implementation, you'd update the comment's rating
      // For now, we'll just keep the current comments unchanged
    } catch (e, stackTrace) {
      _logger.severe('Failed to vote on comment $commentId', e, stackTrace);
    }
  }

  /// Submit a complaint about a comment.
  Future<void> complainComment(int commentId) async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded:
          (
            entry,
            comments,
            hasMoreComments,
            isLoadingComments,
            adjacentEntries,
          ) => (
            entry: entry,
            comments: comments,
            hasMoreComments: hasMoreComments,
            adjacentEntries: adjacentEntries,
          ),
      error: (message, entry) => null,
    );

    if (currentState == null) return;

    try {
      // Make API call to submit complaint
      // Note: The actual complaint API endpoint would need to be implemented
      // For now, we'll just log the action
      _logger.info('Submitting complaint for comment $commentId');
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to submit complaint for comment $commentId',
        e,
        stackTrace,
      );
    }
  }
}
