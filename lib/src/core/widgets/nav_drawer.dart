import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/models/auth_state.dart';
import '../theme/spacing.dart';

/// Navigation drawer widget that displays different content based on authentication state.
/// 
/// Shows user profile information and navigation options when authenticated,
/// and login/register options when not authenticated.
class NavDrawer extends ConsumerWidget {
  /// Creates a navigation drawer.
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          // Drawer header
          _buildDrawerHeader(context, authState, theme),
          
          // Navigation items
          Expanded(
            child: authState.maybeWhen(
              authenticated: (_) => _buildAuthenticatedContent(context, ref, theme, l10n),
              orElse: () => _buildUnauthenticatedContent(context, theme, l10n),
            ),
          ),
          
          // Footer
          _buildDrawerFooter(context, authState, ref, theme, l10n),
        ],
      ),
    );
  }

  /// Builds the drawer header with user information or app branding.
  Widget _buildDrawerHeader(
    BuildContext context,
    AuthState authState,
    ThemeData theme,
  ) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(MindwellSpacing.borderRadiusLg),
        ),
      ),
      child: authState.maybeWhen(
        authenticated: (user) => _buildUserProfile(context, authState, theme),
        orElse: () => _buildAppBranding(context, theme),
      ),
    );
  }

  /// Builds the user profile section in the drawer header.
  Widget _buildUserProfile(
    BuildContext context,
    AuthState authState,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Avatar
        CircleAvatar(
          radius: MindwellSpacing.avatarMd / 2,
          backgroundColor: theme.colorScheme.primary,
          child: Text(
            authState.maybeWhen(
              authenticated: (user) => user.name?.isNotEmpty == true
                  ? user.name!.substring(0, 1).toUpperCase()
                  : 'U',
              orElse: () => 'U',
            ),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: MindwellSpacing.sm),
        
        // Username
        Text(
          authState.maybeWhen(
            authenticated: (user) => user.name ?? 'User',
            orElse: () => 'User',
          ),
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: MindwellSpacing.xs),
        
        // User ID (optional, for debugging)
        authState.maybeWhen(
          authenticated: (user) => user.id != null
              ? Text(
                  'ID: ${user.id}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                )
              : const SizedBox.shrink(),
          orElse: () => const SizedBox.shrink(),
        ),
      ],
    );
  }

  /// Builds the app branding section in the drawer header.
  Widget _buildAppBranding(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // App icon/logo placeholder
        Container(
          width: MindwellSpacing.avatarMd,
          height: MindwellSpacing.avatarMd,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: MindwellBorderRadius.circular,
          ),
          child: Icon(
            Icons.psychology,
            color: theme.colorScheme.onPrimary,
            size: MindwellSpacing.iconLg,
          ),
        ),
        const SizedBox(height: MindwellSpacing.sm),
        
        // App name
        Text(
          'Mindwell',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: MindwellSpacing.xs),
        
        // App tagline
        Text(
          'Your mindful journal',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  /// Builds the navigation content for authenticated users.
  Widget _buildAuthenticatedContent(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Main navigation items as per common_ui.md specifications
        _buildDrawerItem(
          context: context,
          icon: Icons.add_circle_outline,
          title: l10n.newEntry,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/entries/new');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.article_outlined,
          title: l10n.myEntries,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/feed/my-entries');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.subscriptions_outlined,
          title: l10n.subscriptions,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/feed/subscriptions');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.live_tv_outlined,
          title: l10n.live,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/feed/live');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.star_outline,
          title: l10n.best,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/feed/best');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.timeline_outlined,
          title: l10n.tlogs,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to tlogs
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.palette_outlined,
          title: l10n.themes,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to themes
          },
          theme: theme,
        ),
        
        const Divider(),
        
        // Settings and support
        _buildDrawerItem(
          context: context,
          icon: Icons.settings_outlined,
          title: l10n.settings,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to settings screen
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.help_outline,
          title: l10n.help,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.newspaper_outlined,
          title: l10n.news,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to 'mindwell' user profile entries
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.rule_outlined,
          title: l10n.rules,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.info_outline,
          title: l10n.about,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to about screen
          },
          theme: theme,
        ),
      ],
    );
  }

  /// Builds the navigation content for unauthenticated users.
  Widget _buildUnauthenticatedContent(BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Authentication options
        _buildDrawerItem(
          context: context,
          icon: Icons.login_outlined,
          title: l10n.login,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/login');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.person_add_outlined,
          title: l10n.register,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/register');
          },
          theme: theme,
        ),
        
        const Divider(),
        
        // Public features as per common_ui.md specifications
        _buildDrawerItem(
          context: context,
          icon: Icons.live_tv_outlined,
          title: l10n.live,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/feed/live');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.star_outline,
          title: l10n.best,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/feed/best');
          },
          theme: theme,
        ),
        
        const Divider(),
        
        // Settings and support
        _buildDrawerItem(
          context: context,
          icon: Icons.settings_outlined,
          title: l10n.settings,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to settings screen
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.help_outline,
          title: l10n.help,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.newspaper_outlined,
          title: l10n.news,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to 'mindwell' user profile entries
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.rule_outlined,
          title: l10n.rules,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.info_outline,
          title: l10n.about,
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to about screen
          },
          theme: theme,
        ),
      ],
    );
  }

  /// Builds the drawer footer with logout button or app version.
  Widget _buildDrawerFooter(
    BuildContext context,
    AuthState authState,
    WidgetRef ref,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: MindwellEdgeInsets.md,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: authState.maybeWhen(
        authenticated: (_) => _buildLogoutButton(context, ref, theme, l10n),
        orElse: () => _buildAppVersion(context, theme),
      ),
    );
  }

  /// Builds the logout button for authenticated users.
  Widget _buildLogoutButton(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          ref.read(authProvider.notifier).logout();
          context.go('/login');
        },
        icon: const Icon(Icons.logout),
        label: Text(l10n.logout),
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.error,
          side: BorderSide(color: theme.colorScheme.error),
        ),
      ),
    );
  }

  /// Builds the app version display for unauthenticated users.
  Widget _buildAppVersion(BuildContext context, ThemeData theme) {
    return Text(
      'Mindwell v1.0.0',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Builds a drawer list item.
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return Semantics(
      label: title,
      button: true,
      child: ListTile(
        leading: Icon(
          icon,
          color: theme.colorScheme.onSurfaceVariant,
          semanticLabel: '$title icon',
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        onTap: onTap,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        contentPadding: MindwellEdgeInsets.listItemPadding,
      ),
    );
  }
}
