import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindwell_api/mindwell_api.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/inputs/styled_text_field.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../providers/change_email_provider.dart';

/// Screen for changing the user's email.
///
/// This screen provides a form with fields for the new email and current password
/// for confirmation. It displays the current email and verification status,
/// includes form validation, and integration with the change email provider.
class ChangeEmailScreen extends ConsumerStatefulWidget {
  /// Creates a change email screen.
  const ChangeEmailScreen({super.key});

  @override
  ConsumerState<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends ConsumerState<ChangeEmailScreen> {
  /// Form key for validation and state management
  final _formKey = GlobalKey<FormState>();

  /// Controller for the new email field
  final _newEmailController = TextEditingController();

  /// Controller for the password field
  final _passwordController = TextEditingController();

  /// Focus node for the new email field
  final _newEmailFocusNode = FocusNode();

  /// Focus node for the password field
  final _passwordFocusNode = FocusNode();

  /// Whether the password is visible or obscured
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Load user profile when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(changeEmailProvider.notifier).loadUserProfile();
    });
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    _passwordController.dispose();
    _newEmailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changeEmailState = ref.watch(changeEmailProvider);
    final l10n = AppLocalizations.of(context);

    // Fallback to default strings if localization is not available
    final newEmailLabel = l10n?.newEmail ?? 'New Email';
    final newEmailHint = l10n?.newEmailHint ?? 'Enter your new email address';
    final passwordLabel = l10n?.password ?? 'Password';
    final passwordHint = l10n?.passwordHint ?? 'Enter your current password';
    final changeEmailButtonText = l10n?.changeEmailButton ?? 'Change Email';
    final currentEmailLabel = l10n?.currentEmail ?? 'Current Email';
    final emailVerificationLabel =
        l10n?.emailVerification ?? 'Email Verification';

    // Listen to change email state changes and handle accordingly
    ref.listen<ChangeEmailState>(changeEmailProvider, (previous, next) {
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
                  l10n?.changeEmailSuccess ??
                      'Email changed successfully. Please check your new email for verification.',
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
            // Only pop if we can pop (avoid error in tests)
            if (context.canPop()) {
              context.pop();
            }
          }
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.changeEmail ?? 'Change Email',
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
        child: changeEmailState.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (userProfile) => _buildLoadedContent(
            context,
            userProfile,
            l10n,
            newEmailLabel,
            newEmailHint,
            passwordLabel,
            passwordHint,
            changeEmailButtonText,
            currentEmailLabel,
            emailVerificationLabel,
          ),
          changing: () => _buildLoadedContent(
            context,
            null, // Keep showing the form but disable it
            l10n,
            newEmailLabel,
            newEmailHint,
            passwordLabel,
            passwordHint,
            changeEmailButtonText,
            currentEmailLabel,
            emailVerificationLabel,
            isLoading: true,
          ),
          success: () => const Center(child: CircularProgressIndicator()),
          error: (message) => _buildErrorContent(context, message, l10n),
        ),
      ),
    );
  }

  /// Builds the loaded content with the form.
  Widget _buildLoadedContent(
    BuildContext context,
    MwAuthProfile? userProfile,
    AppLocalizations? l10n,
    String newEmailLabel,
    String newEmailHint,
    String passwordLabel,
    String passwordHint,
    String changeEmailButtonText,
    String currentEmailLabel,
    String emailVerificationLabel, {
    bool isLoading = false,
  }) {
    final currentEmail = userProfile?.account?.email ?? '';
    final isEmailVerified = userProfile?.account?.verified ?? false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current email information card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentEmailLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (currentEmail.isNotEmpty) ...[
                      Text(
                        currentEmail,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            isEmailVerified
                                ? Icons.verified_outlined
                                : Icons.warning_amber_outlined,
                            size: 16,
                            color: isEmailVerified
                                ? Colors.green
                                : Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isEmailVerified
                                ? l10n?.emailVerified ?? 'Email verified'
                                : l10n?.emailNotVerified ??
                                      'Email not verified',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isEmailVerified
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        l10n?.noEmailSet ?? 'No email set',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // New email field
            StyledTextField(
              controller: _newEmailController,
              label: newEmailLabel,
              hint: newEmailHint,
              focusNode: _newEmailFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: _validateNewEmail,
              enabled: !isLoading,
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
              enabled: !isLoading,
              onSubmitted: (_) {
                if (!isLoading) {
                  _submitForm();
                }
              },
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
              ),
            ),

            const SizedBox(height: 16),

            // Information text
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n?.changeEmailInfo ??
                          'After changing your email, you will need to verify the new email address.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Change email button
            PrimaryButton(
              text: changeEmailButtonText,
              onPressed: isLoading ? null : _submitForm,
              isLoading: isLoading,
              expanded: true,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the error content.
  Widget _buildErrorContent(
    BuildContext context,
    String message,
    AppLocalizations? l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.somethingWentWrong ?? 'Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(changeEmailProvider.notifier).loadUserProfile();
              },
              child: Text(l10n?.retry ?? 'Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Validates the new email field.
  ///
  /// Returns an error message if validation fails, null if valid.
  String? _validateNewEmail(String? value) {
    final l10n = AppLocalizations.of(context);

    if (value == null || value.trim().isEmpty) {
      return l10n?.newEmailRequired ?? 'New email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return l10n?.invalidEmailFormat ?? 'Please enter a valid email address';
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

    return null;
  }

  /// Submits the change email form.
  ///
  /// Validates the form and calls the change email provider's changeEmail method.
  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Call the change email provider
    ref
        .read(changeEmailProvider.notifier)
        .changeEmail(_newEmailController.text.trim(), _passwordController.text);
  }
}
