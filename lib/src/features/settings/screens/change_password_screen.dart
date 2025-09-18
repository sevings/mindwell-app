import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/inputs/styled_text_field.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/indicators/password_strength_indicator.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../providers/change_password_provider.dart';

/// Screen for changing the user's password.
///
/// This screen provides a form with fields for the current password and new password
/// (with confirmation). It includes form validation, password strength indicator,
/// and integration with the change password provider.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  /// Creates a change password screen.
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  /// Form key for validation and state management
  final _formKey = GlobalKey<FormState>();

  /// Controller for the current password field
  final _currentPasswordController = TextEditingController();

  /// Controller for the new password field
  final _newPasswordController = TextEditingController();

  /// Controller for the confirm new password field
  final _confirmNewPasswordController = TextEditingController();

  /// Focus node for the current password field
  final _currentPasswordFocusNode = FocusNode();

  /// Focus node for the new password field
  final _newPasswordFocusNode = FocusNode();

  /// Focus node for the confirm new password field
  final _confirmNewPasswordFocusNode = FocusNode();

  /// Whether the current password is visible or obscured
  bool _isCurrentPasswordVisible = false;

  /// Whether the new password is visible or obscured
  bool _isNewPasswordVisible = false;

  /// Whether the confirm new password is visible or obscured
  bool _isConfirmNewPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Listen to new password changes to update strength indicator
    _newPasswordController.addListener(_onNewPasswordChanged);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = ref.watch(changePasswordProvider);
    final l10n = AppLocalizations.of(context);

    // Fallback to default strings if localization is not available
    final currentPasswordLabel = l10n?.currentPassword ?? 'Current Password';
    final currentPasswordHint =
        l10n?.currentPasswordHint ?? 'Enter your current password';
    final newPasswordLabel = l10n?.newPassword ?? 'New Password';
    final newPasswordHint = l10n?.newPasswordHint ?? 'Enter your new password';
    final confirmNewPasswordLabel =
        l10n?.confirmNewPassword ?? 'Confirm New Password';
    final confirmNewPasswordHint =
        l10n?.confirmNewPasswordHint ?? 'Confirm your new password';
    final changePasswordButtonText =
        l10n?.changePasswordButton ?? 'Change Password';
    final passwordStrengthLabel = l10n?.passwordStrength ?? 'Password Strength';

    // Listen to change password state changes and handle accordingly
    ref.listen<ChangePasswordState>(changePasswordProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        success: () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l10n?.changePasswordSuccess ??
                      'Password changed successfully',
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
            context.pop();
          }
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.changePassword ?? 'Change Password',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: true,
        showHamburgerMenu: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Current password field
                StyledTextField(
                  controller: _currentPasswordController,
                  label: currentPasswordLabel,
                  hint: currentPasswordHint,
                  focusNode: _currentPasswordFocusNode,
                  textInputAction: TextInputAction.next,
                  validator: _validateCurrentPassword,
                  obscureText: !_isCurrentPasswordVisible,
                  onSubmitted: (_) {
                    _newPasswordFocusNode.requestFocus();
                  },
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isCurrentPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // New password field
                StyledTextField(
                  controller: _newPasswordController,
                  label: newPasswordLabel,
                  hint: newPasswordHint,
                  focusNode: _newPasswordFocusNode,
                  textInputAction: TextInputAction.next,
                  validator: _validateNewPassword,
                  obscureText: !_isNewPasswordVisible,
                  onSubmitted: (_) {
                    _confirmNewPasswordFocusNode.requestFocus();
                  },
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Password strength indicator
                PasswordStrengthIndicator(
                  strength: _newPasswordController.text
                      .calculatePasswordStrength(),
                  label: passwordStrengthLabel,
                ),

                const SizedBox(height: 16),

                // Confirm new password field
                StyledTextField(
                  controller: _confirmNewPasswordController,
                  label: confirmNewPasswordLabel,
                  hint: confirmNewPasswordHint,
                  focusNode: _confirmNewPasswordFocusNode,
                  textInputAction: TextInputAction.done,
                  validator: _validateConfirmNewPassword,
                  obscureText: !_isConfirmNewPasswordVisible,
                  onSubmitted: (_) {
                    _submitForm();
                  },
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmNewPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmNewPasswordVisible =
                            !_isConfirmNewPasswordVisible;
                      });
                    },
                  ),
                ),

                const Spacer(),

                // Change password button
                PrimaryButton(
                  text: changePasswordButtonText,
                  onPressed: changePasswordState.maybeWhen(
                    loading: () => null,
                    orElse: () => _submitForm,
                  ),
                  isLoading: changePasswordState.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  ),
                  expanded: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Called when the new password field value changes to update the strength indicator.
  void _onNewPasswordChanged() {
    setState(() {
      // This will trigger a rebuild to update the password strength indicator
    });
  }

  /// Validates the current password field.
  ///
  /// Returns an error message if validation fails, null if valid.
  String? _validateCurrentPassword(String? value) {
    final l10n = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return l10n?.currentPasswordRequired ?? 'Current password is required';
    }

    return null;
  }

  /// Validates the new password field.
  ///
  /// Returns an error message if validation fails, null if valid.
  String? _validateNewPassword(String? value) {
    final l10n = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return l10n?.newPasswordRequired ?? 'New password is required';
    }

    if (value.length < 6) {
      return l10n?.passwordTooShort ?? 'Password must be at least 6 characters';
    }

    if (value == _currentPasswordController.text) {
      return l10n?.newPasswordSameAsCurrent ??
          'New password must be different from current password';
    }

    return null;
  }

  /// Validates the confirm new password field.
  ///
  /// Returns an error message if validation fails, null if valid.
  String? _validateConfirmNewPassword(String? value) {
    final l10n = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return l10n?.confirmNewPasswordRequired ??
          'Please confirm your new password';
    }

    if (value != _newPasswordController.text) {
      return l10n?.passwordsDoNotMatch ?? 'Passwords do not match';
    }

    return null;
  }

  /// Submits the change password form.
  ///
  /// Validates the form and calls the change password provider's changePassword method.
  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Call the change password provider
    ref
        .read(changePasswordProvider.notifier)
        .changePassword(
          _currentPasswordController.text,
          _newPasswordController.text,
        );
  }
}
