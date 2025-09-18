import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../models/invites_state.dart';

/// The invites provider that manages the invites state.
///
/// This provider uses StateNotifierProvider to manage the InvitesState and provides
/// methods for fetching user invites data.
final invitesProvider = StateNotifierProvider<InvitesNotifier, InvitesState>((
  ref,
) {
  return InvitesNotifier(accountApi: ref.read(accountApiProvider));
});

/// Notifier class that manages invites state and business logic.
///
/// This class handles all invites operations including fetching user invites.
/// It uses the provided AccountApi client to communicate with the backend.
class InvitesNotifier extends StateNotifier<InvitesState> {
  /// The Account API client for invites-related operations.
  final AccountApi _accountApi;

  /// Creates an InvitesNotifier with the required dependencies.
  InvitesNotifier({required AccountApi accountApi})
    : _accountApi = accountApi,
      super(const InvitesState.initial());

  /// Initializes the invites by fetching the user's invites data.
  ///
  /// This method:
  /// 1. Sets the state to loading
  /// 2. Makes a call to fetch invites data
  /// 3. Updates the state to loaded with invites data or error
  Future<void> init() async {
    state = const InvitesState.loading();

    try {
      final response = await _accountApi.accountInvitesGet();
      final data = response.data;

      if (data == null) {
        throw Exception('Failed to fetch invites data');
      }

      state = InvitesState.loaded(invites: data);
    } catch (e) {
      state = InvitesState.error(message: _getErrorMessage(e));
    }
  }

  /// Refreshes the invites by refetching data from the server.
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
          return 'Недостаточно прав для просмотра приглашений';
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
