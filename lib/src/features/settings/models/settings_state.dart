import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'settings_state.freezed.dart';

/// Email notification settings for the user.
@freezed
class EmailSettings with _$EmailSettings {
  const factory EmailSettings({
    @Default(false) bool comments,
    @Default(false) bool followers,
    @Default(false) bool invites,
    @Default(false) bool movedEntries,
    @Default(false) bool badges,
  }) = _EmailSettings;

  /// Creates EmailSettings from API response.
  factory EmailSettings.fromApi(MwAccountSettingsEmailGet200Response response) {
    return EmailSettings(
      comments: response.comments ?? false,
      followers: response.followers ?? false,
      invites: response.invites ?? false,
      movedEntries: response.movedEntries ?? false,
      badges: response.badges ?? false,
    );
  }
}

/// Telegram notification settings for the user.
@freezed
class TelegramSettings with _$TelegramSettings {
  const factory TelegramSettings({
    @Default(false) bool comments,
    @Default(false) bool followers,
    @Default(false) bool invites,
    @Default(false) bool messages,
    @Default(false) bool movedEntries,
    @Default(false) bool badges,
  }) = _TelegramSettings;

  /// Creates TelegramSettings from API response.
  factory TelegramSettings.fromApi(
    MwAccountSettingsTelegramGet200Response response,
  ) {
    return TelegramSettings(
      comments: response.comments ?? false,
      followers: response.followers ?? false,
      invites: response.invites ?? false,
      messages: response.messages ?? false,
      movedEntries: response.movedEntries ?? false,
      badges: response.badges ?? false,
    );
  }
}

/// Onsite notification settings for the user.
@freezed
class OnsiteSettings with _$OnsiteSettings {
  const factory OnsiteSettings({@Default(false) bool wishes}) = _OnsiteSettings;

  /// Creates OnsiteSettings from API response.
  factory OnsiteSettings.fromApi(
    MwAccountSettingsOnsiteGet200Response response,
  ) {
    return OnsiteSettings(wishes: response.wishes ?? false);
  }
}

/// Represents the current settings state of the application.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various settings scenarios.
@freezed
sealed class SettingsState with _$SettingsState {
  /// Initial state when settings haven't been loaded yet.
  const factory SettingsState.initial() = _Initial;

  /// Loading state when settings are being fetched.
  const factory SettingsState.loading() = _Loading;

  /// Loaded state when settings have been successfully fetched.
  ///
  /// [emailSettings] Email notification settings
  /// [telegramSettings] Telegram notification settings
  /// [onsiteSettings] Onsite notification settings
  const factory SettingsState.loaded({
    required EmailSettings emailSettings,
    required TelegramSettings telegramSettings,
    required OnsiteSettings onsiteSettings,
  }) = _Loaded;

  /// Error state when settings operations fail.
  ///
  /// [message] The error message describing what went wrong.
  const factory SettingsState.error({required String message}) = _Error;
}
