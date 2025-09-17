import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/platform_app_bar.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/models/auth_state.dart';
import '../../features/auth/screens/auth_screen.dart';
import '../../features/entries/screens/entry_feed_screen.dart';
import '../../features/entries/screens/entry_detail_screen.dart';
import '../../features/entries/screens/entry_editor_screen.dart';
import '../../features/entries/models/feed_type.dart';
import '../../features/comments/screens/comment_feed_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/user_list_screen.dart';
import '../../features/profile/models/user_list_state.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/chat/screens/chat_list_screen.dart';

/// Application router configuration using GoRouter.
///
/// Defines the navigation structure for the Mindwell application,
/// including routes for authenticated and unauthenticated users.
class AppRouter {
  /// The main GoRouter instance for the application.
  static final GoRouter router = GoRouter(
    initialLocation: '/feed/live',
    redirect: (context, state) {
      // Get the current authentication state
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authProvider);

      // Define protected routes that require authentication
      const protectedRoutes = [
        '/',
        '/profile',
        '/notifications',
        '/chats',
        '/feed/subscriptions',
        '/feed/my-entries',
      ];

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
        authenticated: (user, authSource) {
          // If user is authenticated and trying to access login/register, redirect based on auth source
          if (unauthenticatedRoutes.contains(currentPath)) {
            return authSource == AuthSource.registration
                ? '/profile'
                : '/feed/live';
          }
          // Allow access to protected routes
          return null;
        },
        unauthenticated: () {
          // If user is not authenticated and trying to access protected routes, redirect to login
          if (protectedRoutes.contains(currentPath)) {
            return '/login';
          }
          // Allow access to unauthenticated routes (including public feeds)
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
          return ProviderScope(child: HomeScreen(child: child));
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) =>
                const EntryFeedScreen(feedType: FeedType.live),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) {
              // Get current user from auth state
              final container = ProviderScope.containerOf(context);
              final authState = container.read(authProvider);

              return authState.when(
                authenticated: (user, authSource) =>
                    ProfileScreen(username: user.name ?? ''),
                initial: () => const _ProfileContent(),
                loading: () => const _ProfileContent(),
                unauthenticated: () => const _ProfileContent(),
                error: (message) => const _ProfileContent(),
              );
            },
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: '/chats',
            name: 'chats',
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: '/entries/new',
            name: 'newEntry',
            builder: (context, state) => const EntryEditorScreen(),
          ),
          GoRoute(
            path: '/themes/:themeName/entries/new',
            name: 'newThemeEntry',
            builder: (context, state) {
              final themeName = Uri.decodeComponent(
                state.pathParameters['themeName']!,
              );
              return EntryEditorScreen(themeName: themeName);
            },
          ),
          GoRoute(
            path: '/entries/:id/edit',
            name: 'editEntry',
            builder: (context, state) {
              final idParam = state.pathParameters['id'];
              if (idParam == null) {
                throw Exception('Entry ID is required');
              }
              final entryId = int.tryParse(idParam);
              if (entryId == null) {
                throw Exception('Invalid entry ID: $idParam');
              }
              return EntryEditorScreen(entryId: entryId);
            },
          ),
          GoRoute(
            path: '/entries/:id',
            name: 'protectedEntryDetail',
            builder: (context, state) {
              final idParam = state.pathParameters['id'];
              if (idParam == null) {
                throw Exception('Entry ID is required');
              }
              final entryId = int.tryParse(idParam);
              if (entryId == null) {
                throw Exception('Invalid entry ID: $idParam');
              }
              final isPreview = state.uri.queryParameters['preview'] == 'true';
              return EntryDetailScreen(entryId: entryId, isPreview: isPreview);
            },
          ),
          // Protected feed type routes (require authentication)
          GoRoute(
            path: '/feed/subscriptions',
            name: 'subscriptionsFeed',
            builder: (context, state) =>
                const EntryFeedScreen(feedType: FeedType.friends),
          ),
          GoRoute(
            path: '/feed/my-entries',
            name: 'myEntriesFeed',
            builder: (context, state) {
              // Get current user from auth state
              final container = ProviderScope.containerOf(context);
              final authState = container.read(authProvider);

              return authState.when(
                authenticated: (user, authSource) => EntryFeedScreen(
                  feedType: FeedType.profile,
                  username: user.name ?? user.id?.toString(),
                ),
                initial: () =>
                    const EntryFeedScreen(feedType: FeedType.profile),
                loading: () =>
                    const EntryFeedScreen(feedType: FeedType.profile),
                unauthenticated: () =>
                    const EntryFeedScreen(feedType: FeedType.profile),
                error: (message) =>
                    const EntryFeedScreen(feedType: FeedType.profile),
              );
            },
          ),
          GoRoute(
            path: '/tags/:tagName',
            name: 'protectedTagFeed',
            builder: (context, state) {
              final tagName = Uri.decodeComponent(
                state.pathParameters['tagName']!,
              );
              return EntryFeedScreen(
                feedType: FeedType.live,
                tagFilter: tagName,
              );
            },
          ),
          GoRoute(
            path: '/users',
            name: 'users',
            builder: (context, state) {
              return UserListScreen(
                type: UserListType.users,
                username: '', // Empty username for general user list
              );
            },
          ),
          GoRoute(
            path: '/users/:name',
            name: 'userProfile',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return ProfileScreen(username: username);
            },
          ),
          GoRoute(
            path: '/users/:name/comments',
            name: 'userComments',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return CommentFeedScreen(username: username);
            },
          ),
          GoRoute(
            path: '/users/:name/followers',
            name: 'userFollowers',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return UserListScreen(
                type: UserListType.followers,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/following',
            name: 'userFollowing',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return UserListScreen(
                type: UserListType.following,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/entries',
            name: 'userEntries',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return EntryFeedScreen(
                feedType: FeedType.profile,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/invited',
            name: 'userInvited',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return UserListScreen(
                type: UserListType.invited,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/favorites',
            name: 'userFavorites',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return EntryFeedScreen(
                feedType: FeedType.favorites,
                username: username,
              );
            },
          ),
        ],
      ),

      // Public shell route for feeds accessible without authentication
      ShellRoute(
        builder: (context, state, child) {
          return ProviderScope(child: HomeScreen(child: child));
        },
        routes: [
          // Public feed routes (accessible without authentication)
          GoRoute(
            path: '/feed/live',
            name: 'liveFeed',
            builder: (context, state) =>
                const EntryFeedScreen(feedType: FeedType.live),
          ),
          GoRoute(
            path: '/feed/best',
            name: 'bestFeed',
            builder: (context, state) =>
                const EntryFeedScreen(feedType: FeedType.best),
          ),
          GoRoute(
            path: '/entries/:id',
            name: 'publicEntryDetail',
            builder: (context, state) {
              final idParam = state.pathParameters['id'];
              if (idParam == null) {
                throw Exception('Entry ID is required');
              }
              final entryId = int.tryParse(idParam);
              if (entryId == null) {
                throw Exception('Invalid entry ID: $idParam');
              }
              final isPreview = state.uri.queryParameters['preview'] == 'true';
              return EntryDetailScreen(entryId: entryId, isPreview: isPreview);
            },
          ),
          GoRoute(
            path: '/tags/:tagName',
            name: 'publicTagFeed',
            builder: (context, state) {
              final tagName = Uri.decodeComponent(
                state.pathParameters['tagName']!,
              );
              return EntryFeedScreen(
                feedType: FeedType.live,
                tagFilter: tagName,
              );
            },
          ),
          GoRoute(
            path: '/users',
            name: 'publicUsers',
            builder: (context, state) {
              return UserListScreen(
                type: UserListType.users,
                username: '', // Empty username for general user list
              );
            },
          ),
          GoRoute(
            path: '/users/:name',
            name: 'publicUserProfile',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return ProfileScreen(username: username);
            },
          ),
          GoRoute(
            path: '/users/:name/comments',
            name: 'publicUserComments',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return CommentFeedScreen(username: username);
            },
          ),
          GoRoute(
            path: '/users/:name/followers',
            name: 'publicUserFollowers',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return UserListScreen(
                type: UserListType.followers,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/following',
            name: 'publicUserFollowing',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return UserListScreen(
                type: UserListType.following,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/entries',
            name: 'publicUserEntries',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return EntryFeedScreen(
                feedType: FeedType.profile,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/invited',
            name: 'publicUserInvited',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return UserListScreen(
                type: UserListType.invited,
                username: username,
              );
            },
          ),
          GoRoute(
            path: '/users/:name/favorites',
            name: 'publicUserFavorites',
            builder: (context, state) {
              final username = Uri.decodeComponent(
                state.pathParameters['name']!,
              );
              return EntryFeedScreen(
                feedType: FeedType.favorites,
                username: username,
              );
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
    errorBuilder: (context, state) => _ErrorScreen(error: state.error),
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
          Icon(Icons.person, size: 64, color: Color(0xFFFF5E3A)),
          SizedBox(height: 16),
          Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Your personal profile and settings',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// Error screen widget for handling navigation errors.
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlatformAppBar(
        title: Text(
          l10n?.error ?? 'Error',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        automaticallyImplyLeading: true,
        showHamburgerMenu: false, // Error screen should show back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              l10n?.somethingWentWrong ?? 'Something went wrong',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ??
                  (l10n?.unknownError ?? 'Unknown error occurred'),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
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
