import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_provider.dart';
import '../models/user_list_state.dart';

/// Provider for the UserListNotifier that manages the state of user lists.
/// 
/// Takes a [UserListType] and [username] as parameters to create separate providers 
/// for each type of user list and user.
final userListProvider = StateNotifierProvider.family<UserListNotifier, UserListState, ({UserListType type, String username})>(
  (ref, params) {
    final usersApi = ref.read(usersApiProvider);
    
    return UserListNotifier(
      type: params.type,
      username: params.username,
      usersApi: usersApi,
    );
  },
);

/// Notifier that manages the state and logic for fetching user list data.
/// 
/// This class handles:
/// - Fetching user list data from the appropriate API endpoint based on list type
/// - Pagination support with cursor-based navigation
/// - Error handling and state management
/// - Refresh functionality
class UserListNotifier extends StateNotifier<UserListState> {
  final UserListType _type;
  final String _username;
  final UsersApi _usersApi;
  final Logger _logger = Logger('UserListNotifier');
  
  bool _isLoading = false;
  bool _isLoadingMore = false;

  UserListNotifier({
    required UserListType type,
    required String username,
    required UsersApi usersApi,
  })  : _type = type,
        _username = username,
        _usersApi = usersApi,
        super(const UserListState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by fetching the user list data.
  Future<void> _initialize() async {
    await fetchUserList();
  }

  /// Fetch user list data from the API.
  /// 
  /// This method fetches the appropriate user list based on the type:
  /// - followers: Users who follow the specified user
  /// - following: Users that the specified user follows
  /// - invited: Users invited by the specified user
  /// - users: General user search/list
  Future<void> fetchUserList({String? after, String? before}) async {
    if (_isLoading) {
      return; // Prevent multiple simultaneous loads
    }
    
    _logger.info('Fetching ${_type.name} list for user $_username');
    state = const UserListState.loading();
    _isLoading = true;
    
    try {
      Response<MwFriendList> response;
      
      switch (_type) {
        case UserListType.followers:
          response = await _usersApi.usersNameFollowersGet(
            name: _username,
            after: after,
            before: before,
          );
          break;
        case UserListType.following:
          response = await _usersApi.usersNameFollowingsGet(
            name: _username,
            after: after,
            before: before,
          );
          break;
        case UserListType.invited:
          response = await _usersApi.usersNameInvitedGet(
            name: _username,
            after: after,
            before: before,
          );
          break;
        case UserListType.users:
          // For general user search, we'll use the usersGet endpoint
          // This would typically be used for search functionality
          final usersResponse = await _usersApi.usersGet();
          final users = usersResponse.data?.users?.toList() ?? [];
          state = UserListState.loaded(
            users: users,
            hasMore: false, // General user list doesn't support pagination
          );
          return;
      }
      
      final friendList = response.data;
      if (friendList == null) {
        throw Exception('User list not found');
      }
      
      final users = friendList.users?.toList() ?? [];
      final hasMore = friendList.hasAfter ?? false;
      final nextAfter = friendList.nextAfter;
      final nextBefore = friendList.nextBefore;
      
      _logger.info('Fetched ${users.length} users for ${_type.name} list');
      
      state = UserListState.loaded(
        users: users,
        hasMore: hasMore,
        nextAfter: nextAfter,
        nextBefore: nextBefore,
      );
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch ${_type.name} list for user $_username', e, stackTrace);
      state = UserListState.error(
        message: _getErrorMessage(e),
      );
    } finally {
      _isLoading = false;
    }
  }

  /// Fetch the next page of users (for pagination).
  /// 
  /// This method appends new users to the existing list.
  Future<void> fetchNextPage() async {
    if (_isLoadingMore) {
      return; // Prevent multiple simultaneous loads
    }
    
    final currentState = state;
    bool hasMore = false;
    String? nextAfter;
    List<MwFriend> currentUsers = [];
    
    currentState.when(
      initial: () {},
      loading: () {},
      loaded: (users, hasMoreValue, nextAfterValue, nextBefore) {
        hasMore = hasMoreValue;
        nextAfter = nextAfterValue;
        currentUsers = users;
      },
      error: (message) {},
    );
    
    if (!hasMore) {
      return; // No more data to load
    }
    
    _logger.info('Fetching next page of ${_type.name} list for user $_username');
    _isLoadingMore = true;
    
    try {
      Response<MwFriendList> response;
      
        switch (_type) {
        case UserListType.followers:
          response = await _usersApi.usersNameFollowersGet(
            name: _username,
            after: nextAfter,
          );
          break;
        case UserListType.following:
          response = await _usersApi.usersNameFollowingsGet(
            name: _username,
            after: nextAfter,
          );
          break;
        case UserListType.invited:
          response = await _usersApi.usersNameInvitedGet(
            name: _username,
            after: nextAfter,
          );
          break;
        case UserListType.users:
          // General user list doesn't support pagination
          return;
      }
      
      final friendList = response.data;
      if (friendList == null) {
        throw Exception('User list not found');
      }
      
      final newUsers = friendList.users?.toList() ?? [];
      final allUsers = [...currentUsers, ...newUsers];
      final hasMoreNew = friendList.hasAfter ?? false;
      final nextAfterNew = friendList.nextAfter;
      
      _logger.info('Fetched ${newUsers.length} more users for ${_type.name} list');
      
      state = UserListState.loaded(
        users: allUsers,
        hasMore: hasMoreNew,
        nextAfter: nextAfterNew,
        nextBefore: null, // We don't need to preserve nextBefore for pagination
      );
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch next page of ${_type.name} list for user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Refresh the user list data.
  /// 
  /// This method clears the current state and fetches fresh data from the beginning.
  Future<void> refresh() async {
    _logger.info('Refreshing ${_type.name} list for user $_username');
    await fetchUserList();
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
          return 'Нет доступа к списку пользователей';
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
