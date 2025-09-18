import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';
import '../../../core/api/api_provider.dart';

part 'change_password_provider.freezed.dart';

/// State for the change password functionality.
@freezed
class ChangePasswordState with _$ChangePasswordState {
  /// Initial state
  const factory ChangePasswordState.initial() = _Initial;

  /// Loading state while changing password
  const factory ChangePasswordState.loading() = _Loading;

  /// Success state after password changed successfully
  const factory ChangePasswordState.success() = _Success;

  /// Error state when password change fails
  const factory ChangePasswordState.error(String message) = _Error;
}

/// Notifier for managing change password state and operations.
class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  /// Creates a change password notifier.
  ChangePasswordNotifier(this._apiClient)
    : super(const ChangePasswordState.initial());

  final MindwellApi _apiClient;

  /// Changes the user's password.
  ///
  /// [currentPassword] The user's current password
  /// [newPassword] The new password to set
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state = const ChangePasswordState.loading();

    try {
      await _apiClient.getAccountApi().accountPasswordPost(
        oldPassword: currentPassword,
        newPassword: newPassword,
      );

      state = const ChangePasswordState.success();
    } catch (e) {
      String errorMessage = 'Failed to change password';

      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 400:
            errorMessage =
                'Invalid current password or new password requirements not met';
            break;
          case 401:
            errorMessage = 'Current password is incorrect';
            break;
          case 403:
            errorMessage = 'You are not authorized to change password';
            break;
          case 422:
            errorMessage = 'New password does not meet requirements';
            break;
          case 500:
            errorMessage = 'Server error. Please try again later';
            break;
          default:
            errorMessage = 'Failed to change password. Please try again';
        }
      }

      state = ChangePasswordState.error(errorMessage);
    }
  }
}

/// Provider for the change password notifier.
final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
      (ref) => ChangePasswordNotifier(ref.watch(mindwellApiProvider)),
    );
