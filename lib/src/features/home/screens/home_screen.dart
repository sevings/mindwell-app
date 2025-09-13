import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/widgets/platform_app_bar.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/nav_drawer.dart';
import '../../../core/providers/auth_provider.dart';

/// Main home screen that serves as the shell for authenticated users.
/// 
/// This screen contains the main scaffold structure with the PlatformAppBar,
/// BottomNavBar, and NavDrawer integrated from Task 4.
class HomeScreen extends ConsumerWidget {
  /// Creates a HomeScreen widget.
  /// 
  /// The [child] parameter represents the content that will be displayed
  /// within the scaffold, typically the result of navigation.
  const HomeScreen({
    super.key,
    required this.child,
  });

  /// The child widget to display within the scaffold.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      // Platform-aware app bar
      appBar: PlatformAppBar(
        title: Text(l10n?.appTitle ?? 'Mindwell'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        showHamburgerMenu: true,
        showSearch: true,
        showUserAvatar: authState.isAuthenticated,
        onSearchTap: () {
          // TODO: Implement search functionality
        },
        onAvatarTap: () {
          // TODO: Navigate to profile
        },
        actions: [
          // Add action buttons here in future tasks
          // For now, we'll add a simple settings icon
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
            tooltip: l10n?.settings ?? 'Settings',
          ),
        ],
      ),
      
      // Main content area
      body: child,
      
      // Platform-aware bottom navigation bar
      bottomNavigationBar: const BottomNavBarIndexProvider(),
      
      // Navigation drawer
      drawer: const NavDrawer(),
      
      // Floating action button will be added in future tasks
      floatingActionButton: authState.isAuthenticated
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Add new entry functionality
              },
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
