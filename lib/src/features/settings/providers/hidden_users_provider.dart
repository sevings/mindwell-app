import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_provider.dart';
import '../models/hidden_users_state.dart';

/// Provider for the HiddenUsersNotifier that manages the state of hidden users list.
///
/// This provider uses StateNotifierProvider to manage the HiddenUsersState and provides
/// methods for fetching and managing hidden users.
final hiddenUsersProvider =
    StateNotifierProvider<HiddenUsersNotifier, HiddenUsersState>((ref) {
      return HiddenUsersNotifier(
        meApi: ref.read(meApiProvider),
        relationsApi: ref.read(relationsApiProvider),
      );
    });

/// Notifier class that manages hidden users state and business logic.
///
/// This class handles all hidden users operations including fetching the list
/// of hidden users and unhiding users. It uses the provided MeApi and RelationsApi
/// clients to communicate with the backend.
class HiddenUsersNotifier extends StateNotifier<HiddenUsersState> {
  /// The Me API client for fetching hidden users.
  final MeApi _meApi;

  /// The Relations API client for hiding/unhiding operations.
  final RelationsApi _relationsApi;

  /// Logger instance for debugging.
  final Logger _logger = Logger('HiddenUsersNotifier');

  /// Creates a HiddenUsersNotifier with the required dependencies.
  HiddenUsersNotifier({
    required MeApi meApi,
    required RelationsApi relationsApi,
  }) : _meApi = meApi,
       _relationsApi = relationsApi,
       super(const HiddenUsersState.initial());

  /// Initializes the hidden users by fetching the list from the API.
  ///
  /// This method:
  /// 1. Sets the state to loading
  /// 2. Makes a call to fetch the hidden users
  /// 3. Updates the state to loaded with users or error
  Future<void> init() async {
    state = const HiddenUsersState.loading();

    try {
      final response = await _meApi.meHiddenGet();

      final friendList = response.data;
      if (friendList == null) {
        throw Exception('Hidden users list not found');
      }

      final users = friendList.users?.toList() ?? [];

      _logger.info('Fetched ${users.length} hidden users');

      state = HiddenUsersState.loaded(
        users: users,
        hasMore: friendList.hasAfter ?? false,
        nextAfter: friendList.nextAfter,
        nextBefore: friendList.nextBefore,
      );
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch hidden users list', e, stackTrace);
      state = HiddenUsersState.error(message: _getErrorMessage(e));
    }
  }

  /// Unhides a user by removing them from the hidden list.
  ///
  /// This method:
  /// 1. Makes a DELETE request to remove the hide relation
  /// 2. Updates the local state by removing the user from the list
  /// 3. Handles errors appropriately
  ///
  /// [username] The username of the user to unhide
  Future<void> unhideUser(String username) async {
    try {
      await _relationsApi.relationsFromNameDelete(name: username);

      // Update local state by removing the user from the list
      final currentState = state;
      currentState.when(
        initial: () {},
        loading: () {},
        loaded: (users, hasMore, nextAfter, nextBefore) {
          final updatedUsers = users
              .where((user) => user.name != username)
              .toList();
          state = HiddenUsersState.loaded(
            users: updatedUsers,
            hasMore: hasMore,
            nextAfter: nextAfter,
            nextBefore: nextBefore,
          );
        },
        error: (message) {},
      );

      _logger.info('Successfully unhidden user: $username');
    } catch (e, stackTrace) {
      _logger.severe('Failed to unhide user: $username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Fetches the next page of hidden users (for pagination).
  ///
  /// This method appends new users to the existing list.
  Future<void> fetchNextPage() async {
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

    if (!hasMore || nextAfter == null) {
      return; // No more data to load
    }

    _logger.info('Fetching next page of hidden users');

    try {
      final response = await _meApi.meHiddenGet(after: nextAfter);

      final friendList = response.data;
      if (friendList == null) {
        throw Exception('Hidden users list not found');
      }

      final newUsers = friendList.users?.toList() ?? [];
      final allUsers = [...currentUsers, ...newUsers];
      final hasMoreNew = friendList.hasAfter ?? false;
      final nextAfterNew = friendList.nextAfter;

      _logger.info('Fetched ${newUsers.length} more hidden users');

      state = HiddenUsersState.loaded(
        users: allUsers,
        hasMore: hasMoreNew,
        nextAfter: nextAfterNew,
        nextBefore: null, // We don't need to preserve nextBefore for pagination
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'Failed to fetch next page of hidden users',
        e,
        stackTrace,
      );
      // Don't change state on error - user can retry
    }
  }

  /// Refreshes the hidden users by refetching the list from the server.
  ///
  /// This method is useful for syncing with the server state after
  /// external changes or to recover from error states.
  Future<void> refresh() async {
    await init();
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
        case 401:
          return 'Необходимо войти в систему';
        case 403:
          return 'Нет доступа к списку скрытых пользователей';
        case 404:
          return 'Пользователь не найден';
        case 429:
          return 'Слишком много запросов. Попробуйте позже';
        case 500:
          return 'Ошибка сервера. Попробуйте позже';
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
