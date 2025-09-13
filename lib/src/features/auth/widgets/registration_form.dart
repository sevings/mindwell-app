import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../core/widgets/inputs/styled_text_field.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/indicators/password_strength_indicator.dart';
import '../providers/auth_provider.dart';
import '../models/auth_state.dart';

/// A form widget for user registration.
/// 
/// This widget provides a complete registration form with username, email, password,
/// and confirm password fields. It includes form validation, password strength indicator,
/// and integration with the authentication provider.
class RegistrationForm extends ConsumerStatefulWidget {
  /// Creates a registration form widget.
  const RegistrationForm({super.key});

  @override
  ConsumerState<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm> {
  /// Form key for validation and state management
  final _formKey = GlobalKey<FormState>();
  
  /// Controller for the username field
  final _usernameController = TextEditingController();
  
  /// Controller for the email field
  final _emailController = TextEditingController();
  
  /// Controller for the password field
  final _passwordController = TextEditingController();
  
  /// Controller for the confirm password field
  final _confirmPasswordController = TextEditingController();
  
  /// Selected gender value
  String? _selectedGender;
  
  /// Focus node for the username field
  final _usernameFocusNode = FocusNode();
  
  /// Focus node for the email field
  final _emailFocusNode = FocusNode();
  
  /// Focus node for the password field
  final _passwordFocusNode = FocusNode();
  
  /// Focus node for the confirm password field
  final _confirmPasswordFocusNode = FocusNode();
  
  /// Whether the password is visible or obscured
  bool _isPasswordVisible = false;
  
  /// Whether the confirm password is visible or obscured
  bool _isConfirmPasswordVisible = false;
  
  /// Whether the form is currently being submitted
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Listen to password changes to update strength indicator
    _passwordController.addListener(_onPasswordChanged);
    // Set default gender value
    _selectedGender = 'notSet';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context);
    
    // Fallback to default strings if localization is not available
    final usernameLabel = l10n?.username?.toString() ?? 'Username';
    final usernameHint = l10n?.usernameHint?.toString() ?? 'Enter your username';
    final emailLabel = l10n?.email?.toString() ?? 'Email';
    final emailHint = l10n?.emailHint?.toString() ?? 'Enter your email address';
    final passwordLabel = l10n?.password?.toString() ?? 'Password';
    final passwordHint = l10n?.passwordHint?.toString() ?? 'Enter your password';
    final confirmPasswordLabel = l10n?.confirmPassword?.toString() ?? 'Confirm Password';
    final confirmPasswordHint = l10n?.confirmPasswordHint?.toString() ?? 'Confirm your password';
    final registerButtonText = l10n?.registerButton?.toString() ?? 'Register';
    final passwordStrengthLabel = l10n?.passwordStrength?.toString() ?? 'Password Strength';
    final genderLabel = l10n?.gender?.toString() ?? 'Gender';
    final genderHint = l10n?.genderHint?.toString() ?? 'Select your gender';

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
          // Username field
          StyledTextField(
            controller: _usernameController,
            label: usernameLabel,
            hint: usernameHint,
            focusNode: _usernameFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: _validateUsername,
            onSubmitted: (_) {
              _emailFocusNode.requestFocus();
            },
            prefixIcon: const Icon(Icons.person_outline),
          ),
          
          const SizedBox(height: 16),
          
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
          
          // Gender field
          _buildGenderDropdown(context, genderLabel, genderHint),
          
          const SizedBox(height: 16),
          
          // Password field
          StyledTextField(
            controller: _passwordController,
            label: passwordLabel,
            hint: passwordHint,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.next,
            validator: _validatePassword,
            obscureText: !_isPasswordVisible,
            onSubmitted: (_) {
              _confirmPasswordFocusNode.requestFocus();
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
          
          // Password strength indicator
          PasswordStrengthIndicator(
            strength: _passwordController.text.calculatePasswordStrength(),
            label: passwordStrengthLabel,
          ),
          
          const SizedBox(height: 16),
          
          // Confirm password field
          StyledTextField(
            controller: _confirmPasswordController,
            label: confirmPasswordLabel,
            hint: confirmPasswordHint,
            focusNode: _confirmPasswordFocusNode,
            textInputAction: TextInputAction.done,
            validator: _validateConfirmPassword,
            obscureText: !_isConfirmPasswordVisible,
            onSubmitted: (_) {
              _submitForm();
            },
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Terms agreement
          _buildTermsAgreement(context),
          
          const SizedBox(height: 24),
          
          // Register button
          PrimaryButton(
            text: registerButtonText,
            onPressed: _isSubmitting ? null : _submitForm,
            isLoading: _isSubmitting || authState.maybeWhen(loading: () => true, orElse: () => false),
            expanded: true,
          ),
        ],
      ),
    );
  }

  /// Builds the gender dropdown field.
  Widget _buildGenderDropdown(BuildContext context, String label, String hint) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final genderNotSet = l10n?.genderNotSet?.toString() ?? 'Not set';
    final genderMale = l10n?.genderMale?.toString() ?? 'Male';
    final genderFemale = l10n?.genderFemale?.toString() ?? 'Female';
    
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        filled: true,
        fillColor: colorScheme.surface,
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'notSet',
          child: Text(genderNotSet),
        ),
        DropdownMenuItem<String>(
          value: 'male',
          child: Text(genderMale),
        ),
        DropdownMenuItem<String>(
          value: 'female',
          child: Text(genderFemale),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
    );
  }

  /// Builds the terms of service and privacy policy agreement section.
  Widget _buildTermsAgreement(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final termsText = l10n?.termsOfService?.toString() ?? 'Terms of Service';
    final privacyText = l10n?.privacyPolicy?.toString() ?? 'Privacy Policy';
    final agreementText = l10n?.agreeToTerms?.toString() ?? 'By registering, you agree to our Terms of Service and Privacy Policy';
    
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        children: [
          TextSpan(
            text: agreementText
                .replaceAll('{termsOfService}', termsText)
                .replaceAll('{privacyPolicy}', privacyText)
                .split(termsText)[0],
          ),
          TextSpan(
            text: termsText,
            style: TextStyle(
              color: colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
            // TODO: Add onTap handler for Terms of Service
          ),
          TextSpan(
            text: agreementText
                .split(termsText)[1]
                .split(privacyText)[0],
          ),
          TextSpan(
            text: privacyText,
            style: TextStyle(
              color: colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
            // TODO: Add onTap handler for Privacy Policy
          ),
          TextSpan(
            text: agreementText.split(privacyText)[1],
          ),
        ],
      ),
    );
  }

  /// Called when the password field value changes to update the strength indicator.
  void _onPasswordChanged() {
    setState(() {
      // This will trigger a rebuild to update the password strength indicator
    });
  }

  /// Validates the username field.
  /// 
  /// Returns an error message if validation fails, null if valid.
  String? _validateUsername(String? value) {
    final l10n = AppLocalizations.of(context);
    
    if (value == null || value.trim().isEmpty) {
      return l10n?.usernameRequired?.toString() ?? 'Username is required';
    }
    
    final trimmedValue = value.trim();
    
    if (trimmedValue.length < 3) {
      return l10n?.usernameTooShort?.toString() ?? 'Username must be at least 3 characters';
    }
    
    // Username can only contain letters, numbers, and underscores
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(trimmedValue)) {
      return l10n?.usernameInvalid?.toString() ?? 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
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
    
    if (value.length < 6) {
      return l10n?.passwordTooShort ?? 'Password must be at least 6 characters';
    }
    
    return null;
  }

  /// Validates the confirm password field.
  /// 
  /// Returns an error message if validation fails, null if valid.
  String? _validateConfirmPassword(String? value) {
    final l10n = AppLocalizations.of(context);
    
    if (value == null || value.isEmpty) {
      return l10n?.confirmPasswordRequired?.toString() ?? 'Please confirm your password';
    }
    
    if (value != _passwordController.text) {
      return l10n?.passwordsDoNotMatch?.toString() ?? 'Passwords do not match';
    }
    
    return null;
  }

  /// Submits the registration form.
  /// 
  /// Validates the form and calls the authentication provider's register method.
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
    ref.read(authProvider.notifier).register(
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );
  }
}
