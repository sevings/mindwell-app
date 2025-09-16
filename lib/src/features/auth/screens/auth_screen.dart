import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/platform_app_bar.dart';

import '../widgets/login_form.dart';
import '../widgets/registration_form.dart';

/// Authentication screen that hosts login and registration forms.
///
/// This screen provides a tabbed interface allowing users to switch between
/// login and registration forms. It uses a DefaultTabController with TabBar
/// and TabBarView to manage the form switching.
class AuthScreen extends ConsumerWidget {
  /// Creates an authentication screen.
  const AuthScreen({super.key, this.initialTabIndex = 0});

  /// The initial tab index to show when the screen loads.
  /// 0 for login tab, 1 for registration tab.
  final int initialTabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Fallback to default strings if localization is not available
    final loginTabText = l10n?.login ?? 'Login';
    final registerTabText = l10n?.register ?? 'Register';
    final appTitle = l10n?.appTitle ?? 'Mindwell';

    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex,
      child: Scaffold(
        appBar: PlatformAppBar(
          title: Text(
            appTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          automaticallyImplyLeading:
              true, // Allow navigation for unauthenticated access
          bottom: TabBar(
            tabs: [
              Tab(text: loginTabText, icon: const Icon(Icons.login)),
              Tab(text: registerTabText, icon: const Icon(Icons.person_add)),
            ],
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            indicatorColor: colorScheme.primary,
            indicatorWeight: 3.0,
            labelStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface,
                colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TabBarView(
                  children: [
                    // Login tab content
                    _buildTabContent(context, child: const LoginForm()),
                    // Registration tab content
                    _buildTabContent(context, child: const RegistrationForm()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the content wrapper for each tab.
  ///
  /// Provides consistent padding and scrolling behavior for both forms.
  Widget _buildTabContent(BuildContext context, {required Widget child}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
              MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              48.0, // TabBar height
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              // Welcome section
              _buildWelcomeSection(context),

              const SizedBox(height: 32),

              // Form content
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the welcome section with app branding.
  Widget _buildWelcomeSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final welcomeText = l10n?.appTitle ?? 'Mindwell';
    final subtitleText =
        l10n?.appSubtitle ?? 'Your mindful journey starts here';

    return Column(
      children: [
        // App logo/icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.psychology, size: 40, color: colorScheme.primary),
        ),

        const SizedBox(height: 16),

        // App title
        Text(
          welcomeText,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          subtitleText,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
