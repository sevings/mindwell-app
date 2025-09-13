import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  
  /// Controller for the email field
  final _emailController = TextEditingController();
  
  /// Controller for the password field
  final _passwordController = TextEditingController();
  
  /// Focus node for the email field
  final _emailFocusNode = FocusNode();
  
  /// Focus node for the password field
  final _passwordFocusNode = FocusNode();
  
  /// Whether the password is visible or obscured
  bool _isPasswordVisible = false;
  
  /// Whether the form is currently being submitted
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context);
    
    // Fallback to default strings if localization is not available
    final emailLabel = l10n?.email ?? 'Email';
    final emailHint = l10n?.emailHint ?? 'Enter your email address';
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
        authenticated: (_) {
          _isSubmitting = false;
          // Navigation will be handled by the router
        },
        orElse: () {},
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email field
          StyledTextField(
            controller: _emailController,
            label: emailLabel,
            hint: emailHint,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            onSubmitted: (_) {
              _passwordFocusNode.requestFocus();
            },
            prefixIcon: const Icon(Icons.email_outlined),
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
            isLoading: _isSubmitting || authState.maybeWhen(loading: () => true, orElse: () => false),
            expanded: true,
          ),
        ],
      ),
    );
  }

  /// Validates the email field.
  /// 
  /// Returns an error message if validation fails, null if valid.
  String? _validateEmail(String? value) {
    final l10n = AppLocalizations.of(context);
    
    if (value == null || value.trim().isEmpty) {
      return l10n?.emailRequired ?? 'Email is required';
    }
    
    // Basic email validation regex
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return l10n?.emailInvalid ?? 'Please enter a valid email address';
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
    
    if (value.length < 8) {
      return l10n?.passwordTooShort ?? 'Password must be at least 8 characters';
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
    ref.read(authProvider.notifier).login(
      _emailController.text.trim(),
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
