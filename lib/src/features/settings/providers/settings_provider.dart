import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../core/api/api_provider.dart';
import '../models/settings_state.dart';

/// The main settings provider that manages the settings state.
///
/// This provider uses StateNotifierProvider to manage the SettingsState and provides
/// methods for fetching and updating different types of settings.
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier(accountApi: ref.read(accountApiProvider));
  },
);

/// Notifier class that manages settings state and business logic.
///
/// This class handles all settings operations including fetching and updating
/// email, telegram, and onsite notification settings. It uses the provided
/// AccountApi client to communicate with the backend.
class SettingsNotifier extends StateNotifier<SettingsState> {
  /// The Account API client for settings-related operations.
  final AccountApi _accountApi;

  /// Creates a SettingsNotifier with the required dependencies.
  SettingsNotifier({required AccountApi accountApi})
    : _accountApi = accountApi,
      super(const SettingsState.initial());

  /// Initializes the settings by fetching all settings groups in parallel.
  ///
  /// This method:
  /// 1. Sets the state to loading
  /// 2. Makes parallel calls to fetch email, telegram, and onsite settings
  /// 3. Updates the state to loaded with all settings or error
  Future<void> init() async {
    state = const SettingsState.loading();

    try {
      // Make parallel calls to fetch all settings
      final futures = await Future.wait([
        _accountApi.accountSettingsEmailGet(),
        _accountApi.accountSettingsTelegramGet(),
        _accountApi.accountSettingsOnsiteGet(),
      ]);

      final emailResponse =
          futures[0] as Response<MwAccountSettingsEmailGet200Response>;
      final telegramResponse =
          futures[1] as Response<MwAccountSettingsTelegramGet200Response>;
      final onsiteResponse =
          futures[2] as Response<MwAccountSettingsOnsiteGet200Response>;

      // Extract data from responses
      final emailData = emailResponse.data;
      final telegramData = telegramResponse.data;
      final onsiteData = onsiteResponse.data;

      if (emailData == null || telegramData == null || onsiteData == null) {
        throw Exception('Failed to fetch settings data');
      }

      // Convert API responses to our models
      final emailSettings = EmailSettings.fromApi(emailData);
      final telegramSettings = TelegramSettings.fromApi(telegramData);
      final onsiteSettings = OnsiteSettings.fromApi(onsiteData);

      state = SettingsState.loaded(
        emailSettings: emailSettings,
        telegramSettings: telegramSettings,
        onsiteSettings: onsiteSettings,
      );
    } catch (e) {
      state = SettingsState.error(message: _getErrorMessage(e));
    }
  }

  /// Updates the email notification settings.
  ///
  /// This method:
  /// 1. Makes a PUT request to update email settings
  /// 2. Refetches all settings to confirm the new state
  /// 3. Updates the state accordingly
  ///
  /// [newSettings] The new email settings to apply
  Future<void> updateEmailSettings(EmailSettings newSettings) async {
    try {
      // Make PUT request with individual parameters
      await _accountApi.accountSettingsEmailPut(
        comments: newSettings.comments,
        followers: newSettings.followers,
        invites: newSettings.invites,
        movedEntries: newSettings.movedEntries,
        badges: newSettings.badges,
      );

      // Refetch all settings to confirm the update
      await init();
    } catch (e) {
      state = SettingsState.error(message: _getErrorMessage(e));
    }
  }

  /// Updates the telegram notification settings.
  ///
  /// This method:
  /// 1. Makes a PUT request to update telegram settings
  /// 2. Refetches all settings to confirm the new state
  /// 3. Updates the state accordingly
  ///
  /// [newSettings] The new telegram settings to apply
  Future<void> updateTelegramSettings(TelegramSettings newSettings) async {
    try {
      // Make PUT request with individual parameters
      await _accountApi.accountSettingsTelegramPut(
        comments: newSettings.comments,
        followers: newSettings.followers,
        invites: newSettings.invites,
        messages: newSettings.messages,
        movedEntries: newSettings.movedEntries,
        badges: newSettings.badges,
      );

      // Refetch all settings to confirm the update
      await init();
    } catch (e) {
      state = SettingsState.error(message: _getErrorMessage(e));
    }
  }

  /// Updates the onsite notification settings.
  ///
  /// This method:
  /// 1. Makes a PUT request to update onsite settings
  /// 2. Refetches all settings to confirm the new state
  /// 3. Updates the state accordingly
  ///
  /// [newSettings] The new onsite settings to apply
  Future<void> updateOnsiteSettings(OnsiteSettings newSettings) async {
    try {
      // Make PUT request with individual parameters
      await _accountApi.accountSettingsOnsitePut(wishes: newSettings.wishes);

      // Refetch all settings to confirm the update
      await init();
    } catch (e) {
      state = SettingsState.error(message: _getErrorMessage(e));
    }
  }

  /// Refreshes the settings by refetching all settings from the server.
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
          return 'Недостаточно прав для изменения настроек';
        case 422:
          return 'Неверные данные настроек';
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
