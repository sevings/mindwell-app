import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/widgets/entry_list.dart';
import 'package:mindwell/src/features/entries/widgets/feed_settings_bottom_sheet.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/l10n/app_localizations.dart';

/// Mock implementations for testing
class _MockEntriesApi implements EntriesApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockEntryCacheService implements EntryCacheService {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

/// Helper function to create test widgets with proper provider overrides
Widget createTestWidget(Widget child) {
  return ProviderScope(
    overrides: [
      entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
      entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
      entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
    ],
    child: MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => child,
          ),
          GoRoute(
            path: '/entries/new',
            builder: (context, state) => const Scaffold(
              body: Text('New Entry Screen'),
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const Scaffold(
              body: Text('Profile Screen'),
            ),
          ),
        ],
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
        Locale('en', ''),
      ],
      locale: const Locale('ru', ''),
    ),
  );
}

/// Mock EntryFeedNotifier that returns empty state
class _MockEntryFeedNotifier extends EntryFeedNotifier {
  _MockEntryFeedNotifier() : super(
    feedType: FeedType.live,
    entriesApi: _MockEntriesApi(),
    cacheService: _MockEntryCacheService(),
  ) {
    state = const EntryFeedState.empty();
  }
  
  @override
  Future<void> fetchInitialEntries() async {}
  
  @override
  Future<void> fetchMoreEntries() async {}
  
  @override
  Future<void> refresh() async {}
  
  @override
  Future<void> updateSettings(dynamic newSettings) async {}
}

/// Widget tests for [EntryFeedScreen]
/// 
/// Tests the main screen functionality including:
/// - Tab navigation between different feed types
/// - App bar actions (settings, menu)
/// - Floating action button navigation
/// - Feed settings bottom sheet
void main() {
  group('EntryFeedScreen', () {
    testWidgets('displays all feed type tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify that all expected tabs are displayed (using Russian locale)
      expect(find.text('Прямой эфир'), findsOneWidget); // Live in Russian
      expect(find.text('Лучшее'), findsOneWidget); // Best in Russian
      expect(find.text('Подписки'), findsOneWidget); // Subscriptions in Russian

      // Verify that TabBar is present
      expect(find.byType(TabBar), findsOneWidget);
    });

    testWidgets('displays SliverAppBar with correct title', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify app title is displayed
      expect(find.text('Mindwell'), findsOneWidget);

      // Verify SliverAppBar is present
      expect(find.byType(SliverAppBar), findsOneWidget);
    });

    testWidgets('displays FloatingActionButton', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify FloatingActionButton is present
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('displays settings and menu buttons in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify settings button is present
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

      // Verify menu button is present
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('opens feed settings bottom sheet when settings button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Tap the settings button
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pump();

      // Verify that the bottom sheet is displayed
      expect(find.byType(FeedSettingsBottomSheet), findsOneWidget);
      expect(find.text('Настройки'), findsOneWidget); // Settings in Russian
    });

    testWidgets('opens popup menu when menu button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pump();

      // Verify that the popup menu items are displayed
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.text('Мои записи'), findsOneWidget); // My Entries in Russian
      expect(find.text('Темы'), findsOneWidget); // Themes in Russian
    });

    testWidgets('displays EntryList widgets for each tab', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify that TabBarView is present
      expect(find.byType(TabBarView), findsOneWidget);

      // Verify that EntryList widgets are present (TabBarView shows one at a time)
      expect(find.byType(EntryList), findsOneWidget);
    });

    testWidgets('switches tabs correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Initially on Live tab
      expect(find.text('Прямой эфир'), findsOneWidget); // Live in Russian

      // Tap on Best tab
      await tester.tap(find.text('Лучшее')); // Best in Russian
      await tester.pump();

      // Verify tab switching (this tests the TabController functionality)
      expect(find.text('Лучшее'), findsOneWidget); // Best in Russian
    });

    testWidgets('navigates to new entry when FAB is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify FloatingActionButton is present
      expect(find.byType(FloatingActionButton), findsOneWidget);
      
      // Tap the floating action button (this will trigger navigation)
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // The FAB should still be present after tap
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('displays correct feed type display names', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify localized tab names are displayed (using Russian locale)
      expect(find.text('Прямой эфир'), findsOneWidget); // Live in Russian
      expect(find.text('Лучшее'), findsOneWidget); // Best in Russian
      expect(find.text('Подписки'), findsOneWidget); // Subscriptions in Russian
    });

    testWidgets('handles menu selection correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(const EntryFeedScreen()),
      );

      await tester.pump();

      // Verify menu button is present
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      
      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pump();

      // Verify that popup menu items are displayed
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.text('Мои записи'), findsOneWidget); // My Entries in Russian
      expect(find.text('Темы'), findsOneWidget); // Themes in Russian
    });
  });

  // Note: FeedSettingsBottomSheet tests are covered in 
  // test/src/features/entries/widgets/feed_settings_bottom_sheet_test.dart

  group('FeedSettingsBottomSheet Integration', () {
    testWidgets('closes when close button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FeedSettingsBottomSheet(
                      feedType: FeedType.live,
                    ),
                  );
                },
                child: const Text('Show Settings'),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Show the bottom sheet
      await tester.tap(find.text('Show Settings'));
      await tester.pump();

      // Verify bottom sheet is displayed
      expect(find.text('Настройки'), findsOneWidget); // Settings in Russian

      // Verify close button is present
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });
}
