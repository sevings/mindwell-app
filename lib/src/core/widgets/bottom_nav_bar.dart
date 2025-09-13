import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../theme/spacing.dart';

/// Platform-aware bottom navigation bar widget.
/// 
/// Displays navigation tabs for Home, Notifications, and Chat.
/// Only visible when the user is authenticated.
/// Uses NavigationBar for Material Design and CupertinoTabBar for iOS.
class PlatformBottomNavBar extends ConsumerWidget {
  /// Creates a platform-aware bottom navigation bar.
  /// 
  /// The [currentIndex] parameter determines which tab is currently selected.
  const PlatformBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  /// The currently selected tab index.
  final int currentIndex;

  /// Navigation destinations for the bottom navigation bar.
  /// Based on common_ui.md specifications: entry feeds, user profiles, notifications, and chats.
  static const List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.article_outlined),
      selectedIcon: Icon(Icons.article),
      label: 'Feed',
      tooltip: 'View your journal entries feed',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
      tooltip: 'View your profile',
    ),
    NavigationDestination(
      icon: Icon(Icons.notifications_outlined),
      selectedIcon: Icon(Icons.notifications),
      label: 'Notifications',
      tooltip: 'View notifications',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_outlined),
      selectedIcon: Icon(Icons.chat),
      label: 'Chat',
      tooltip: 'View chat messages',
    ),
  ];

  /// Cupertino tab bar items for iOS.
  static const List<BottomNavigationBarItem> _cupertinoItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.article_outlined),
      activeIcon: Icon(Icons.article),
      label: 'Feed',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      activeIcon: Icon(Icons.notifications),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat_outlined),
      activeIcon: Icon(Icons.chat),
      label: 'Chat',
    ),
  ];

  /// Route paths for each tab.
  static const List<String> _routes = [
    '/',
    '/profile',
    '/notifications',
    '/chat',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final platform = theme.platform;

    // Only show the bottom navigation bar when authenticated
    if (!authState.isAuthenticated) {
      return const SizedBox.shrink();
    }

    if (platform == TargetPlatform.iOS) {
      return CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTabTapped(context, index),
        items: _cupertinoItems,
        backgroundColor: theme.colorScheme.surface,
        activeColor: theme.colorScheme.primary,
        inactiveColor: theme.colorScheme.onSurfaceVariant,
        border: const Border(
          top: BorderSide(
            color: CupertinoColors.separator,
            width: 0.5,
          ),
        ),
        height: MindwellSpacing.bottomNavHeight,
      );
    } else {
      return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onTabTapped(context, index),
        destinations: _destinations,
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: theme.colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface,
            );
          }
          return theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          );
        }),
        height: MindwellSpacing.bottomNavHeight,
      );
    }
  }

  /// Handles tab tap events and navigates to the appropriate route.
  void _onTabTapped(BuildContext context, int index) {
    if (index >= 0 && index < _routes.length) {
      context.go(_routes[index]);
    }
  }
}

/// Helper widget to determine the current tab index based on the current route.
class BottomNavBarIndexProvider extends ConsumerWidget {
  /// Creates a bottom navigation bar index provider.
  const BottomNavBarIndexProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Try to get the current route, fallback to home if not available
    int currentIndex = 0;
    try {
      final location = GoRouterState.of(context).uri.path;
      switch (location) {
        case '/':
          currentIndex = 0; // Feed
          break;
        case '/profile':
          currentIndex = 1; // Profile
          break;
        case '/notifications':
          currentIndex = 2; // Notifications
          break;
        case '/chat':
          currentIndex = 3; // Chat
          break;
        default:
          currentIndex = 0; // Default to Feed
      }
    } catch (e) {
      // If GoRouterState is not available (e.g., in tests), default to Feed
      currentIndex = 0;
    }

    return PlatformBottomNavBar(currentIndex: currentIndex);
  }
}
