import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../models/settings_state.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

/// Main settings screen that displays all user settings organized in sections.
///
/// This screen features:
/// - A platform-adaptive [PlatformAppBar] with title
/// - A [ListView] of [SettingsSection] widgets for different setting categories
/// - Platform-adaptive UI that uses Material Design on Android and Cupertino on iOS
/// - Integration with [SettingsProvider] for state management
/// - Navigation to various settings sub-screens
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize settings when the screen is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.settings ?? 'Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: false,
        showHamburgerMenu: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(settingsProvider);

          return state.when(
            initial: () => _buildLoadingState(l10n, theme, colorScheme),
            loading: () => _buildLoadingState(l10n, theme, colorScheme),
            loaded: (emailSettings, telegramSettings, onsiteSettings) =>
                _buildLoadedState(
                  emailSettings,
                  telegramSettings,
                  onsiteSettings,
                  l10n,
                  theme,
                  colorScheme,
                ),
            error: (message) =>
                _buildErrorState(message, l10n, theme, colorScheme),
          );
        },
      ),
    );
  }

  /// Build the loading state with a centered loading indicator.
  Widget _buildLoadingState(
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: colorScheme.primary),
          const SizedBox(height: MindwellSpacing.md),
          Text(
            l10n?.loadingSettings ?? 'Loading settings...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the loaded state with all settings sections.
  Widget _buildLoadedState(
    EmailSettings emailSettings,
    TelegramSettings telegramSettings,
    OnsiteSettings onsiteSettings,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return RefreshIndicator(
      onRefresh: () => ref.read(settingsProvider.notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.all(MindwellSpacing.md),
        children: [
          // Account Settings Section
          SettingsSection(
            title: l10n?.accountSettings ?? 'Account',
            children: [
              SettingsTile(
                title: l10n?.changePassword ?? 'Change Password',
                leading: const Icon(Icons.lock_outline),
                onTap: () => context.go('/settings/change-password'),
              ),
              SettingsTile(
                title: l10n?.changeEmail ?? 'Change Email',
                leading: const Icon(Icons.email_outlined),
                onTap: () => context.go('/settings/change-email'),
              ),
              SettingsTile(
                title: l10n?.invited ?? 'Invites',
                leading: const Icon(Icons.person_add_outlined),
                onTap: () => context.go('/settings/invites'),
              ),
            ],
          ),

          // Notification Settings Section
          SettingsSection(
            title: l10n?.notificationSettings ?? 'Notifications',
            subtitle:
                l10n?.notificationSettingsSubtitle ??
                'Manage how you receive notifications',
            children: [
              // Email Notifications
              SettingsTile(
                title: l10n?.emailNotifications ?? 'Email Notifications',
                subtitle:
                    l10n?.emailNotificationsSubtitle ??
                    'Receive notifications via email',
                leading: const Icon(Icons.email_outlined),
                onTap: () => _showEmailNotificationSettings(
                  emailSettings,
                  l10n,
                  theme,
                  colorScheme,
                ),
              ),

              // Telegram Notifications
              SettingsTile(
                title: l10n?.telegramNotifications ?? 'Telegram Notifications',
                subtitle:
                    l10n?.telegramNotificationsSubtitle ??
                    'Receive notifications via Telegram',
                leading: const Icon(Icons.telegram),
                onTap: () => _showTelegramNotificationSettings(
                  telegramSettings,
                  l10n,
                  theme,
                  colorScheme,
                ),
              ),

              // On-site Notifications
              SettingsTile(
                title: l10n?.onsiteNotifications ?? 'On-site Notifications',
                subtitle:
                    l10n?.onsiteNotificationsSubtitle ??
                    'Receive notifications within the app',
                leading: const Icon(Icons.notifications_outlined),
                onTap: () => _showOnsiteNotificationSettings(
                  onsiteSettings,
                  l10n,
                  theme,
                  colorScheme,
                ),
              ),
            ],
          ),

          // Privacy Settings Section
          SettingsSection(
            title: l10n?.privacySettings ?? 'Privacy & Data',
            children: [
              SettingsTile(
                title: l10n?.blockedProfiles ?? 'Blocked Profiles',
                leading: const Icon(Icons.block_outlined),
                onTap: () => context.go('/settings/blocked-users'),
              ),
              SettingsTile(
                title: l10n?.hiddenProfiles ?? 'Hidden Profiles',
                leading: const Icon(Icons.visibility_off_outlined),
                onTap: () => context.go('/settings/hidden-users'),
              ),
              SettingsTile(
                title: l10n?.privacyPolicy ?? 'Privacy Policy',
                leading: const Icon(Icons.privacy_tip_outlined),
                onTap: () => _openPrivacyPolicy(l10n),
              ),
              SettingsTile(
                title: l10n?.termsOfService ?? 'Terms of Service',
                leading: const Icon(Icons.description_outlined),
                onTap: () => _openTermsOfService(l10n),
              ),
              SettingsTile(
                title: l10n?.deleteAccount ?? 'Delete Account',
                leading: const Icon(Icons.delete_outline),
                leadingIconColor: colorScheme.error,
                titleStyle: TextStyle(color: colorScheme.error),
                onTap: () => _showDeleteAccountDialog(l10n, theme, colorScheme),
              ),
            ],
          ),

          // About Section
          SettingsSection(
            title: l10n?.about ?? 'About',
            children: [
              SettingsTile(
                title: l10n?.appVersion ?? 'App Version',
                subtitle: _getAppVersion(),
                leading: const Icon(Icons.info_outline),
                showChevron: false,
              ),
              SettingsTile(
                title: l10n?.contactUs ?? 'Contact Us',
                leading: const Icon(Icons.contact_support_outlined),
                onTap: () => _openContactUs(l10n),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build the error state with retry functionality.
  Widget _buildErrorState(
    String message,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: MindwellSpacing.md),
          Text(
            l10n?.error ?? 'Error',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: MindwellSpacing.sm),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MindwellSpacing.lg),
          ElevatedButton(
            onPressed: () {
              ref.read(settingsProvider.notifier).refresh();
            },
            child: Text(l10n?.retry ?? 'Retry'),
          ),
        ],
      ),
    );
  }

  /// Show email notification settings dialog.
  void _showEmailNotificationSettings(
    EmailSettings emailSettings,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    // TODO: Implement email notification settings dialog
    // This will be implemented in future tasks
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n?.emailNotificationSettingsComingSoon ??
              'Email notification settings coming soon',
        ),
      ),
    );
  }

  /// Show telegram notification settings dialog.
  void _showTelegramNotificationSettings(
    TelegramSettings telegramSettings,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    // TODO: Implement telegram notification settings dialog
    // This will be implemented in future tasks
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n?.telegramNotificationSettingsComingSoon ??
              'Telegram notification settings coming soon',
        ),
      ),
    );
  }

  /// Show on-site notification settings dialog.
  void _showOnsiteNotificationSettings(
    OnsiteSettings onsiteSettings,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    // TODO: Implement on-site notification settings dialog
    // This will be implemented in future tasks
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n?.onsiteNotificationSettingsComingSoon ??
              'On-site notification settings coming soon',
        ),
      ),
    );
  }

  /// Open privacy policy in external browser.
  void _openPrivacyPolicy(AppLocalizations? l10n) {
    // TODO: Implement privacy policy URL opening
    // This will be implemented when the URL is available
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n?.privacyPolicyComingSoon ?? 'Privacy policy coming soon',
        ),
      ),
    );
  }

  /// Open terms of service in external browser.
  void _openTermsOfService(AppLocalizations? l10n) {
    // TODO: Implement terms of service URL opening
    // This will be implemented when the URL is available
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n?.termsOfServiceComingSoon ?? 'Terms of service coming soon',
        ),
      ),
    );
  }

  /// Show delete account confirmation dialog.
  void _showDeleteAccountDialog(
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l10n?.deleteAccount ?? 'Delete Account',
          style: TextStyle(color: colorScheme.error),
        ),
        content: Text(
          l10n?.deleteAccountWarning ??
              'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement account deletion
              // This will be implemented when the API endpoint is available
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l10n?.deleteAccountComingSoon ??
                        'Account deletion coming soon',
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            child: Text(l10n?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
  }

  /// Open contact us functionality.
  void _openContactUs(AppLocalizations? l10n) {
    // TODO: Implement contact us functionality
    // This will be implemented when the contact method is available
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.contactUsComingSoon ?? 'Contact us coming soon'),
      ),
    );
  }

  /// Get the current app version.
  String _getAppVersion() {
    // TODO: Get actual app version from package_info_plus
    // For now, return a placeholder
    return '1.0.0';
  }
}
