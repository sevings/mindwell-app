import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/auth_screen.dart';
import '../../features/entries/screens/entry_feed_screen.dart';

/// Application router configuration using GoRouter.
/// 
/// Defines the navigation structure for the Mindwell application,
/// including routes for authenticated and unauthenticated users.
class AppRouter {
  /// The main GoRouter instance for the application.
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Get the current authentication state
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authProvider);
      
      // Define protected routes that require authentication
      const protectedRoutes = ['/', '/profile', '/notifications', '/chat'];
      
      // Define unauthenticated routes that should redirect if user is logged in
      const unauthenticatedRoutes = ['/login', '/register'];
      
      final currentPath = state.uri.path;
      
      // Handle authentication state
      return authState.when(
        initial: () {
          // If we're still determining auth status, don't redirect yet
          return null;
        },
        loading: () {
          // If we're still determining auth status, don't redirect yet
          return null;
        },
        authenticated: (user) {
          // If user is authenticated and trying to access login/register, redirect to home
          if (unauthenticatedRoutes.contains(currentPath)) {
            return '/';
          }
          // Allow access to protected routes
          return null;
        },
        unauthenticated: () {
          // If user is not authenticated and trying to access protected routes, redirect to login
          if (protectedRoutes.contains(currentPath)) {
            return '/login';
          }
          // Allow access to unauthenticated routes
          return null;
        },
        error: (message) {
          // If user has an error state and trying to access protected routes, redirect to login
          if (protectedRoutes.contains(currentPath)) {
            return '/login';
          }
          // Allow access to unauthenticated routes
          return null;
        },
      );
    },
    routes: [
      // Shell route for authenticated users
      ShellRoute(
        builder: (context, state, child) {
          return ProviderScope(
            child: HomeScreen(child: child),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const EntryFeedScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const _ProfileContent(),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const _NotificationsContent(),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const _ChatContent(),
          ),
          GoRoute(
            path: '/entries/new',
            name: 'newEntry',
            builder: (context, state) => const _NewEntryContent(),
          ),
          GoRoute(
            path: '/entries/:id/edit',
            name: 'editEntry',
            builder: (context, state) {
              final entryId = state.pathParameters['id']!;
              return _EditEntryContent(entryId: entryId);
            },
          ),
          GoRoute(
            path: '/entries/:id',
            name: 'entryDetail',
            builder: (context, state) {
              final entryId = state.pathParameters['id']!;
              return _EntryDetailContent(entryId: entryId);
            },
          ),
        ],
      ),
      
      // Unauthenticated routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const AuthScreen(initialTabIndex: 0),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const AuthScreen(initialTabIndex: 1),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => _ErrorScreen(
      error: state.error,
    ),
  );
}


/// Profile content widget.
/// 
/// This will be replaced with actual profile content in future tasks.
class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 64,
            color: Color(0xFFFF5E3A),
          ),
          SizedBox(height: 16),
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your personal profile and settings',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/// Notifications content widget.
/// 
/// This will be replaced with actual notifications content in future tasks.
class _NotificationsContent extends StatelessWidget {
  const _NotificationsContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications,
            size: 64,
            color: Color(0xFFFF5E3A),
          ),
          SizedBox(height: 16),
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Stay updated with your mindful journey',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/// Chat content widget.
/// 
/// This will be replaced with actual chat content in future tasks.
class _ChatContent extends StatelessWidget {
  const _ChatContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat,
            size: 64,
            color: Color(0xFFFF5E3A),
          ),
          SizedBox(height: 16),
          Text(
            'Chat',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Connect with your support community',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/// New entry content widget.
/// 
/// This will be replaced with actual entry editor in future tasks.
class _NewEntryContent extends StatelessWidget {
  const _NewEntryContent();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.newEntry ?? 'New Entry'),
        backgroundColor: const Color(0xFFFF5E3A),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 64,
              color: Color(0xFFFF5E3A),
            ),
            SizedBox(height: 16),
            Text(
              'Entry Editor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Create your mindful entry here',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Edit entry content widget.
/// 
/// This will be replaced with actual entry editor in future tasks.
class _EditEntryContent extends StatelessWidget {
  const _EditEntryContent({required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Entry'),
        backgroundColor: const Color(0xFFFF5E3A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.edit,
              size: 64,
              color: Color(0xFFFF5E3A),
            ),
            const SizedBox(height: 16),
            const Text(
              'Edit Entry',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Editing entry: $entryId',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Entry detail content widget.
/// 
/// This will be replaced with actual entry detail screen in future tasks.
class _EntryDetailContent extends StatelessWidget {
  const _EntryDetailContent({required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Detail'),
        backgroundColor: const Color(0xFFFF5E3A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.article,
              size: 64,
              color: Color(0xFFFF5E3A),
            ),
            const SizedBox(height: 16),
            const Text(
              'Entry Detail',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Viewing entry: $entryId',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// Error screen widget for handling navigation errors.
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({
    required this.error,
  });

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.error ?? 'Error'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.somethingWentWrong ?? 'Something went wrong',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? (l10n?.unknownError ?? 'Unknown error occurred'),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text(l10n?.goHome ?? 'Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
