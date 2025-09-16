import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../core/widgets/inputs/styled_text_field.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../providers/auth_provider.dart';
import '../models/auth_state.dart';

/// A form widget for user login.
///
/// This widget provides a complete login form with email and password fields,
/// form validation, and integration with the authentication provider.
/// It includes password visibility toggle and proper error handling.
class LoginForm extends ConsumerStatefulWidget {
  /// Creates a login form widget.
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  /// Form key for validation and state management
  final _formKey = GlobalKey<FormState>();

  /// Controller for the email/username field
  final _emailOrUsernameController = TextEditingController();

  /// Controller for the password field
  final _passwordController = TextEditingController();

  /// Focus node for the email/username field
  final _emailOrUsernameFocusNode = FocusNode();

  /// Focus node for the password field
  final _passwordFocusNode = FocusNode();

  /// Whether the password is visible or obscured
  bool _isPasswordVisible = false;

  /// Whether the form is currently being submitted
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    _emailOrUsernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context);

    // Fallback to default strings if localization is not available
    final emailOrUsernameLabel = l10n?.emailOrUsername ?? 'Email or Username';
    final emailOrUsernameHint =
        l10n?.emailOrUsernameHint ?? 'Enter your email or username';
    final passwordLabel = l10n?.password ?? 'Password';
    final passwordHint = l10n?.passwordHint ?? 'Enter your password';
    final loginButtonText = l10n?.loginButton ?? 'Login';
    final forgotPasswordText = l10n?.forgotPassword ?? 'Forgot password?';

    // Listen to auth state changes and handle accordingly
    ref.listen<AuthState>(authProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          _isSubmitting = false;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        authenticated: (_, authSource) {
          _isSubmitting = false;
          // Manually trigger navigation based on auth source
          if (mounted) {
            final redirectPath = authSource == AuthSource.registration
                ? '/profile'
                : '/feed/live';
            context.go(redirectPath);
          }
        },
        orElse: () {},
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email or Username field
          StyledTextField(
            controller: _emailOrUsernameController,
            label: emailOrUsernameLabel,
            hint: emailOrUsernameHint,
            focusNode: _emailOrUsernameFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: _validateEmailOrUsername,
            onSubmitted: (_) {
              _passwordFocusNode.requestFocus();
            },
            prefixIcon: const Icon(Icons.person_outline),
          ),

          const SizedBox(height: 16),

          // Password field
          StyledTextField(
            controller: _passwordController,
            label: passwordLabel,
            hint: passwordHint,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.done,
            validator: _validatePassword,
            obscureText: !_isPasswordVisible,
            onSubmitted: (_) {
              _submitForm();
            },
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),

          const SizedBox(height: 8),

          // Forgot password link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _handleForgotPassword,
              child: Text(forgotPasswordText),
            ),
          ),

          const SizedBox(height: 24),

          // Login button
          PrimaryButton(
            text: loginButtonText,
            onPressed: _isSubmitting ? null : _submitForm,
            isLoading:
                _isSubmitting ||
                authState.maybeWhen(loading: () => true, orElse: () => false),
            expanded: true,
          ),
        ],
      ),
    );
  }

  /// Validates the email or username field.
  ///
  /// Returns an error message if validation fails, null if valid.
  String? _validateEmailOrUsername(String? value) {
    final l10n = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return l10n?.emailOrUsernameRequired ?? 'Email or username is required';
    }

    return null;
  }

  /// Validates the password field.
  ///
  /// Returns an error message if validation fails, null if valid.
  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context);

    if (value == null || value.isEmpty) {
      return l10n?.passwordRequired ?? 'Password is required';
    }

    if (value.length < 6) {
      return l10n?.passwordTooShort ?? 'Password must be at least 6 characters';
    }

    return null;
  }

  /// Submits the login form.
  ///
  /// Validates the form and calls the authentication provider's login method.
  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Call the authentication provider
    ref
        .read(authProvider.notifier)
        .login(
          _emailOrUsernameController.text.trim(),
          _passwordController.text,
        );
  }

  /// Handles the forgot password action.
  ///
  /// This is a placeholder for future implementation of password recovery.
  void _handleForgotPassword() {
    // TODO: Implement forgot password functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Forgot password functionality coming soon'),
      ),
    );
  }
}
