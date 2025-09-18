import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';
import '../../../core/api/api_provider.dart';

part 'change_email_provider.freezed.dart';

/// State for the change email functionality.
@freezed
class ChangeEmailState with _$ChangeEmailState {
  /// Initial state
  const factory ChangeEmailState.initial() = _Initial;

  /// Loading state while fetching current user profile
  const factory ChangeEmailState.loading() = _Loading;

  /// Loaded state with current user profile information
  const factory ChangeEmailState.loaded({required MwAuthProfile userProfile}) =
      _Loaded;

  /// Loading state while changing email
  const factory ChangeEmailState.changing() = _Changing;

  /// Success state after email changed successfully
  const factory ChangeEmailState.success() = _Success;

  /// Error state when email change fails
  const factory ChangeEmailState.error(String message) = _Error;
}

/// Notifier for managing change email state and operations.
class ChangeEmailNotifier extends StateNotifier<ChangeEmailState> {
  /// Creates a change email notifier.
  ChangeEmailNotifier(this._apiClient)
    : super(const ChangeEmailState.initial());

  final MindwellApi _apiClient;

  /// Loads the current user profile to get email information.
  Future<void> loadUserProfile() async {
    state = const ChangeEmailState.loading();

    try {
      final response = await _apiClient.getMeApi().meGet();
      final userProfile = response.data!;

      state = ChangeEmailState.loaded(userProfile: userProfile);
    } catch (e) {
      String errorMessage = 'Failed to load user profile';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 401:
            errorMessage = 'You are not authorized to access this information';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later';
            break;
          default:
            errorMessage = 'Failed to load user profile. Please try again';
        }
      }

      state = ChangeEmailState.error(errorMessage);
    }
  }

  /// Changes the user's email.
  ///
  /// [newEmail] The new email address to set
  /// [password] The user's current password for confirmation
  Future<void> changeEmail(String newEmail, String password) async {
    state = const ChangeEmailState.changing();

    try {
      await _apiClient.getAccountApi().accountEmailPost(
        email: newEmail,
        password: password,
      );

      state = const ChangeEmailState.success();
    } catch (e) {
      String errorMessage = 'Failed to change email';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 400:
            errorMessage = 'Invalid email format or password is incorrect';
            break;
          case 401:
            errorMessage = 'Password is incorrect';
            break;
          case 403:
            errorMessage = 'You are not authorized to change email';
            break;
          case 409:
            errorMessage = 'This email is already in use';
            break;
          case 422:
            errorMessage = 'Email format is invalid';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later';
            break;
          default:
            errorMessage = 'Failed to change email. Please try again';
        }
      }

      state = ChangeEmailState.error(errorMessage);
    }
  }
}

/// Provider for the change email notifier.
final changeEmailProvider =
    StateNotifierProvider<ChangeEmailNotifier, ChangeEmailState>(
      (ref) => ChangeEmailNotifier(ref.watch(mindwellApiProvider)),
    );
