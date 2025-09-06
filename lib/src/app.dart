import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/entry_feed/domain/entities/entry.dart';
import 'features/entry_feed/presentation/screens/entry_feed_screen.dart';

class MindWellApp extends ConsumerWidget {
  const MindWellApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'MindWell',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => EntryFeedScreen.main(),
    ),
    GoRoute(
      path: '/users/:username',
      name: 'profile',
      builder: (context, state) {
        final username = state.pathParameters['username']!;
        return EntryFeedScreen.profile(username);
      },
    ),
    GoRoute(
      path: '/live',
      name: 'live',
      builder: (context, state) => EntryFeedScreen.single(
        FeedType.live,
      ),
    ),
    GoRoute(
      path: '/best',
      name: 'best',
      builder: (context, state) => EntryFeedScreen.single(
        FeedType.best,
      ),
    ),
    GoRoute(
      path: '/followings',
      name: 'followings',
      builder: (context, state) => EntryFeedScreen.single(
        FeedType.followings,
      ),
    ),
    GoRoute(
      path: '/entries/:id',
      name: 'entry-detail',
      builder: (context, state) {
        final entryId = state.pathParameters['id']!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Entry Detail'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Entry ID: $entryId'),
                const SizedBox(height: 16),
                const Text('Entry detail screen coming soon!'),
              ],
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/entries/create',
      name: 'create-entry',
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Entry'),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Create Entry',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Entry creation screen coming soon!'),
              ],
            ),
          ),
        );
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('The page you are looking for does not exist.'),
          ],
        ),
      ),
    );
  },
);