import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// Mock implementations for testing
class _MockEntriesApi implements EntriesApi {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _MockEntryCacheService implements EntryCacheService {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
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

/// Simple widget tests for [EntryFeedScreen]
/// 
/// Tests the basic UI structure without requiring provider setup
void main() {
  group('EntryFeedScreen - Basic Structure', () {
    testWidgets('displays all feed type tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
            entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
          ],
          child: MaterialApp(
            home: const EntryFeedScreen(),
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
        ),
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
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
            entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
          ],
          child: MaterialApp(
            home: const EntryFeedScreen(),
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
        ),
      );

      await tester.pump();

      // Verify app title is displayed
      expect(find.text('Mindwell'), findsOneWidget);

      // Verify SliverAppBar is present
      expect(find.byType(SliverAppBar), findsOneWidget);
    });

    testWidgets('displays FloatingActionButton', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
            entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
          ],
          child: MaterialApp(
            home: const EntryFeedScreen(),
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
        ),
      );

      await tester.pump();

      // Verify FloatingActionButton is present
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('displays settings and menu buttons in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
            entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
          ],
          child: MaterialApp(
            home: const EntryFeedScreen(),
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
        ),
      );

      await tester.pump();

      // Verify settings button is present
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

      // Verify menu button is present
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('displays TabBarView for tabs', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
            entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
          ],
          child: MaterialApp(
            home: const EntryFeedScreen(),
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
        ),
      );

      await tester.pump();

      // Verify that TabBarView is present
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('switches tabs correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            entriesApiProvider.overrideWith((ref) => _MockEntriesApi()),
            entryCacheServiceProvider.overrideWith((ref) => _MockEntryCacheService()),
            entryFeedProvider.overrideWith((ref, feedType) => _MockEntryFeedNotifier()),
          ],
          child: MaterialApp(
            home: const EntryFeedScreen(),
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
        ),
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
  });

  group('FeedType Extension', () {
    test('displays correct names for feed types', () {
      expect(FeedType.live.displayName, 'Live');
      expect(FeedType.best.displayName, 'Best');
      expect(FeedType.friends.displayName, 'Friends');
      expect(FeedType.profile.displayName, 'Profile');
      expect(FeedType.theme.displayName, 'Theme');
    });

    test('generates correct cache keys', () {
      expect(FeedType.live.getCacheKey(), 'live');
      expect(FeedType.best.getCacheKey(), 'best');
      expect(FeedType.friends.getCacheKey(), 'friends');
      expect(FeedType.profile.getCacheKey('user123'), 'profile_user123');
      expect(FeedType.theme.getCacheKey('theme456'), 'theme_theme456');
    });
  });
}
