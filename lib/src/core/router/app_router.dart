import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/screens/home_screen.dart';

/// Application router configuration using GoRouter.
/// 
/// Defines the navigation structure for the Mindwell application,
/// including routes for authenticated and unauthenticated users.
class AppRouter {
  /// The main GoRouter instance for the application.
  static final GoRouter router = GoRouter(
    initialLocation: '/',
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
            builder: (context, state) => const _HomeContent(),
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
        ],
      ),
      
      // Unauthenticated routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const _LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const _RegisterScreen(),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => _ErrorScreen(
      error: state.error,
    ),
  );
}

/// Home content widget.
/// 
/// This will be replaced with actual home content in future tasks.
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article,
            size: 64,
            color: Color(0xFFFF5E3A),
          ),
          SizedBox(height: 16),
          Text(
            'Feed',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your mindful journal entries',
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

/// Login screen widget.
/// 
/// This will be replaced with actual login screen in future tasks.
class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              size: 64,
              color: Color(0xFFFF5E3A),
            ),
            SizedBox(height: 16),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Sign in to your account',
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

/// Register screen widget.
/// 
/// This will be replaced with actual register screen in future tasks.
class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add,
              size: 64,
              color: Color(0xFFFF5E3A),
            ),
            SizedBox(height: 16),
            Text(
              'Register',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Create your account',
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

/// Error screen widget for handling navigation errors.
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({
    required this.error,
  });

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
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
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error occurred',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
