import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../models/comment_feed_state.dart';

/// Provider for the CommentFeedNotifier that manages the state of a user's comment feed.
/// 
/// Takes a [String] username as a parameter to create separate providers for each user.
final commentFeedProvider = StateNotifierProvider.family<CommentFeedNotifier, CommentFeedState, String>(
  (ref, username) {
    final usersApi = ref.read(usersApiProvider);
    
    return CommentFeedNotifier(
      username: username,
      usersApi: usersApi,
    );
  },
);

/// Notifier that manages the state and logic for fetching and paginating user comment feeds.
/// 
/// This class handles:
/// - Fetching initial comments from API
/// - Implementing infinite scrolling with pagination
/// - Pull-to-refresh functionality
/// - Error handling
class CommentFeedNotifier extends StateNotifier<CommentFeedState> {
  final String _username;
  final UsersApi _usersApi;
  final Logger _logger = Logger('CommentFeedNotifier');
  
  String? _nextAfter;
  bool _isLoadingMore = false;
  static const int _defaultLimit = 30;

  CommentFeedNotifier({
    required String username,
    required UsersApi usersApi,
  })  : _username = username,
        _usersApi = usersApi,
        super(const CommentFeedState.initial()) {
    // Don't automatically fetch on initialization
    // Let the UI decide when to fetch
  }

  /// Fetch the initial comments for the user.
  /// 
  /// This method will fetch the first page of comments from the API.
  Future<void> fetchInitialComments() async {
    if (state.when(
      initial: () => false,
      loading: () => true,
      loaded: (comments, hasMore, isFetchingMore) => false,
      error: (message, comments) => false,
      empty: () => false,
    )) {
      return; // Prevent multiple simultaneous loads
    }
    
    _logger.info('Fetching initial comments for user: $_username');
    state = const CommentFeedState.loading();
    
    try {
      final response = await _usersApi.usersNameCommentsGet(
        name: _username,
        limit: _defaultLimit,
      );
      
      final commentList = response.data;
      if (commentList != null) {
        final comments = commentList.data?.toList() ?? [];
        _nextAfter = commentList.nextAfter;
        
        _logger.info('Fetched ${comments.length} comments from API');
        
        if (comments.isEmpty) {
          state = const CommentFeedState.empty();
        } else {
          state = CommentFeedState.loaded(
            comments: comments,
            hasMore: commentList.hasAfter ?? false,
          );
        }
      } else {
        state = const CommentFeedState.empty();
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch initial comments', e, stackTrace);
      state = CommentFeedState.error(
        message: _getErrorMessage(e),
      );
    }
  }

  /// Fetch more comments for infinite scrolling.
  /// 
  /// This method appends new comments to the existing list.
  Future<void> fetchMoreComments() async {
    if (_isLoadingMore) return;
    
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (comments, hasMore, isFetchingMore) => (comments: comments, hasMore: hasMore),
      error: (message, comments) => null,
      empty: () => null,
    );
    
    if (currentState == null || !currentState.hasMore) return;
    
    _isLoadingMore = true;
    _logger.info('Fetching more comments for user: $_username');
    
    // Update state to show loading indicator
    state = CommentFeedState.loaded(
      comments: currentState.comments,
      hasMore: currentState.hasMore,
      isFetchingMore: true,
    );
    
    try {
      final response = await _usersApi.usersNameCommentsGet(
        name: _username,
        limit: _defaultLimit,
        after: _nextAfter,
      );
      
      final commentList = response.data;
      if (commentList != null) {
        final newComments = commentList.data?.toList() ?? [];
        _nextAfter = commentList.nextAfter;
        
        final allComments = [...currentState.comments, ...newComments];
        
        _logger.info('Fetched ${newComments.length} more comments');
        state = CommentFeedState.loaded(
          comments: allComments,
          hasMore: commentList.hasAfter ?? false,
          isFetchingMore: false,
        );
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch more comments', e, stackTrace);
      // Revert to previous state on error
      state = CommentFeedState.loaded(
        comments: currentState.comments,
        hasMore: currentState.hasMore,
        isFetchingMore: false,
      );
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Refresh the comment feed by fetching fresh data.
  /// 
  /// This method is called for pull-to-refresh functionality.
  Future<void> refresh() async {
    _logger.info('Refreshing comment feed for user: $_username');
    
    // Reset pagination
    _nextAfter = null;
    
    // Fetch fresh data
    await fetchInitialComments();
  }

  /// Update the username and fetch new comments.
  /// 
  /// [username] - The new username to fetch comments for
  void updateUsername(String username) {
    if (_username == username) return;
    
    _logger.info('Updating username from $_username to $username');
    
    // Reset pagination and state
    _nextAfter = null;
    state = const CommentFeedState.initial();
    
    // Update username and fetch new data
    // Note: We need to create a new notifier instance for this
    // as the username is immutable in this class
    throw UnsupportedError(
      'Username cannot be changed after creation. Create a new provider instance instead.'
    );
  }

  /// Extracts a user-friendly error message from an exception.
  /// 
  /// This method handles different types of exceptions and returns
  /// appropriate error messages for display to the user.
  /// 
  /// [error] The exception that occurred
  /// Returns a user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.response?.statusCode) {
        case 404:
          return 'Пользователь не найден';
        case 403:
          return 'Нет доступа к комментариям этого пользователя';
        case 429:
          return 'Слишком много запросов. Попробуйте позже';
        default:
          return 'Произошла ошибка сети. Проверьте подключение к интернету';
      }
    }
    
    if (error is Exception) {
      return error.toString();
    }
    
    return 'Произошла неизвестная ошибка';
  }
}
