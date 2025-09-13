import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
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

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          // Drawer header
          _buildDrawerHeader(context, authState, theme),
          
          // Navigation items
          Expanded(
            child: authState.isAuthenticated
                ? _buildAuthenticatedContent(context, ref, theme)
                : _buildUnauthenticatedContent(context, theme),
          ),
          
          // Footer
          _buildDrawerFooter(context, authState, ref, theme),
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
      child: authState.isAuthenticated
          ? _buildUserProfile(context, authState, theme)
          : _buildAppBranding(context, theme),
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
            authState.username?.isNotEmpty == true
                ? authState.username!.substring(0, 1).toUpperCase()
                : 'U',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: MindwellSpacing.sm),
        
        // Username
        Text(
          authState.username ?? 'User',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: MindwellSpacing.xs),
        
        // User ID (optional, for debugging)
        if (authState.userId != null)
          Text(
            'ID: ${authState.userId}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
            ),
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
  ) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Main navigation items as per common_ui.md specifications
        _buildDrawerItem(
          context: context,
          icon: Icons.add_circle_outline,
          title: 'New Entry',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to new entry screen
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.article_outlined,
          title: 'My Entries',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to user's entries
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.subscriptions_outlined,
          title: 'Subscriptions',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to subscriptions
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.live_tv_outlined,
          title: 'Live',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to live feed
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.star_outline,
          title: 'Best',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to best entries
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.timeline_outlined,
          title: 'Tlogs',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to tlogs
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.palette_outlined,
          title: 'Themes',
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
          title: 'Settings',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to settings screen
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.help_outline,
          title: 'Help',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.newspaper_outlined,
          title: 'News',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to 'mindwell' user profile entries
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.rule_outlined,
          title: 'Rules',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.info_outline,
          title: 'About',
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
  Widget _buildUnauthenticatedContent(BuildContext context, ThemeData theme) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Authentication options
        _buildDrawerItem(
          context: context,
          icon: Icons.login_outlined,
          title: 'Login',
          onTap: () {
            Navigator.of(context).pop();
            context.go('/login');
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.person_add_outlined,
          title: 'Register',
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
          title: 'Live',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to live feed
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.star_outline,
          title: 'Best',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to best entries
          },
          theme: theme,
        ),
        
        const Divider(),
        
        // Settings and support
        _buildDrawerItem(
          context: context,
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to settings screen
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.help_outline,
          title: 'Help',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.newspaper_outlined,
          title: 'News',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Navigate to 'mindwell' user profile entries
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.rule_outlined,
          title: 'Rules',
          onTap: () {
            Navigator.of(context).pop();
            // TODO: Open website link
          },
          theme: theme,
        ),
        _buildDrawerItem(
          context: context,
          icon: Icons.info_outline,
          title: 'About',
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
      child: authState.isAuthenticated
          ? _buildLogoutButton(context, ref, theme)
          : _buildAppVersion(context, theme),
    );
  }

  /// Builds the logout button for authenticated users.
  Widget _buildLogoutButton(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
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
        label: const Text('Logout'),
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
