import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mindwell/src/features/entries/screens/entry_feed_screen.dart';
import 'package:mindwell/src/features/entries/models/feed_type.dart';
import 'package:mindwell/src/features/entries/models/entry_feed_state.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';
import 'package:mindwell/src/features/entries/providers/entry_feed_provider.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/services/entry_cache_service.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell_api/mindwell_api.dart';

/// Mock implementations for testing
class MockEntriesApi extends Mock implements EntriesApi {}

class MockUsersApi extends Mock implements UsersApi {}

class MockEntryCacheService extends Mock implements EntryCacheService {}

/// Mock EntryFeedNotifier that tracks refresh calls
class MockEntryFeedNotifier extends EntryFeedNotifier {
  bool refreshCalled = false;
  String? lastFeedType;
  String? lastFeedParameter;

  MockEntryFeedNotifier({required super.feedType, super.feedParameter})
    : super(
        entriesApi: MockEntriesApi(),
        usersApi: MockUsersApi(),
        cacheServiceAsync: Future.value(MockEntryCacheService()),
      ) {
    state = EntryFeedState.loaded(
      entries: [],
      hasMore: false,
      settings: FeedSettings.defaultSettings,
    );
  }

  @override
  Future<void> fetchInitialEntries() async {}

  @override
  Future<void> fetchMoreEntries() async {}

  @override
  Future<void> refresh() async {
    refreshCalled = true;
    // Store the values when refresh is called
    // We'll need to get these from the test setup
    lastFeedType = 'unknown';
    lastFeedParameter = null;
  }

  @override
  Future<void> updateSettings(dynamic newSettings) async {}
}

void main() {
  group('EntryFeedScreen - Refresh Functionality', () {
    late MockEntriesApi mockEntriesApi;
    late MockUsersApi mockUsersApi;
    late MockEntryCacheService mockCacheService;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockUsersApi = MockUsersApi();
      mockCacheService = MockEntryCacheService();
    });

    Widget createTestWidget({
      FeedType? feedType,
      String? tagFilter,
      String? username,
      Locale locale = const Locale('en', ''),
    }) {
      return ProviderScope(
        overrides: [
          entriesApiProvider.overrideWith((ref) => mockEntriesApi),
          usersApiProvider.overrideWith((ref) => mockUsersApi),
          entryCacheServiceProvider.overrideWith((ref) => mockCacheService),
          // Override the unified feed provider with mock notifiers
          entryFeedProvider.overrideWith(
            (ref, params) => MockEntryFeedNotifier(
              feedType: params.feedType,
              feedParameter: params.feedParameter,
            ),
          ),
        ],
        child: MaterialApp(
          home: EntryFeedScreen(
            feedType: feedType,
            tagFilter: tagFilter,
            username: username,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru', ''), Locale('en', '')],
          locale: locale,
        ),
      );
    }

    testWidgets('displays refresh option in menu button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap the menu button
      final menuButton = find.byIcon(Icons.more_vert);
      expect(menuButton, findsOneWidget);

      await tester.tap(menuButton);
      await tester.pump();

      // Verify refresh option is displayed
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('displays refresh option in Russian locale', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget(locale: const Locale('ru', '')));
      await tester.pump();

      // Find and tap the menu button
      final menuButton = find.byIcon(Icons.more_vert);
      expect(menuButton, findsOneWidget);

      await tester.tap(menuButton);
      await tester.pump();

      // Verify refresh option is displayed in Russian
      expect(find.text('Обновить'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('only shows refresh option in menu (no other options)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap the menu button
      final menuButton = find.byIcon(Icons.more_vert);
      await tester.tap(menuButton);
      await tester.pump();

      // Verify only refresh option is shown
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.text('My Entries'), findsNothing);
      expect(find.text('Themes'), findsNothing);

      // Verify only one menu item
      final popupMenuItems = find.byType(PopupMenuItem<String>);
      expect(popupMenuItems, findsOneWidget);
    });

    testWidgets('menu button has correct icon', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find the menu button
      final menuButton = find.byIcon(Icons.more_vert);
      expect(menuButton, findsOneWidget);

      // Verify the icon button exists
      final iconButton = find.byType(IconButton);
      expect(iconButton, findsWidgets);
    });

    testWidgets('refresh option has correct icon and spacing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Find and tap the menu button
      final menuButton = find.byIcon(Icons.more_vert);
      await tester.tap(menuButton);
      await tester.pump();

      // Verify refresh option structure
      final refreshRow = find.ancestor(
        of: find.text('Refresh'),
        matching: find.byType(Row),
      );
      expect(refreshRow, findsOneWidget);

      // Verify icon is present
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('displays menu button in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify menu button is present
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('displays settings button in app bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify settings button is present
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('both buttons are present in app bar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify both buttons are present
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('menu button works for different feed types', (
      WidgetTester tester,
    ) async {
      final feedTypes = [
        FeedType.live,
        FeedType.best,
        FeedType.friends,
        FeedType.profile,
      ];

      for (final feedType in feedTypes) {
        await tester.pumpWidget(createTestWidget(feedType: feedType));
        await tester.pump();

        // Verify menu button is present
        expect(find.byIcon(Icons.more_vert), findsOneWidget);

        // Tap the menu button
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pump();

        // Verify refresh option is shown
        expect(find.text('Refresh'), findsOneWidget);

        // Clean up for next iteration
        await tester.pumpWidget(Container());
        await tester.pump();
      }
    });

    testWidgets('menu button works for feed with tag filter', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(feedType: FeedType.live, tagFilter: 'testtag'),
      );
      await tester.pump();

      // Verify menu button is present
      expect(find.byIcon(Icons.more_vert), findsOneWidget);

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pump();

      // Verify refresh option is shown
      expect(find.text('Refresh'), findsOneWidget);
    });

    testWidgets('menu button works for profile feed with username', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(feedType: FeedType.profile, username: 'testuser'),
      );
      await tester.pump();

      // Verify menu button is present
      expect(find.byIcon(Icons.more_vert), findsOneWidget);

      // Tap the menu button
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pump();

      // Verify refresh option is shown
      expect(find.text('Refresh'), findsOneWidget);
    });
  });

  group('EntryFeedScreen - Menu Structure Tests', () {
    late MockEntriesApi mockEntriesApi;
    late MockUsersApi mockUsersApi;
    late MockEntryCacheService mockCacheService;

    setUp(() {
      mockEntriesApi = MockEntriesApi();
      mockUsersApi = MockUsersApi();
      mockCacheService = MockEntryCacheService();
    });

    Widget createTestWidget({
      FeedType? feedType,
      String? tagFilter,
      String? username,
    }) {
      return ProviderScope(
        overrides: [
          entriesApiProvider.overrideWith((ref) => mockEntriesApi),
          usersApiProvider.overrideWith((ref) => mockUsersApi),
          entryCacheServiceProvider.overrideWith((ref) => mockCacheService),
          // Override the unified feed provider with mock notifiers
          entryFeedProvider.overrideWith(
            (ref, params) => MockEntryFeedNotifier(
              feedType: params.feedType,
              feedParameter: params.feedParameter,
            ),
          ),
        ],
        child: MaterialApp(
          home: EntryFeedScreen(
            feedType: feedType,
            tagFilter: tagFilter,
            username: username,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru', ''), Locale('en', '')],
          locale: const Locale('en', ''),
        ),
      );
    }

    testWidgets('app bar contains both settings and menu buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify both buttons are present in the app bar
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('menu button is a PopupMenuButton', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Verify the menu button is a PopupMenuButton
      expect(find.byType(PopupMenuButton<String>), findsOneWidget);
    });

    testWidgets('menu contains only refresh option', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Open the menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pump();

      // Verify only one menu item exists
      expect(find.byType(PopupMenuItem<String>), findsOneWidget);

      // Verify the menu item contains refresh text and icon
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('menu item has correct value', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Open the menu
      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pump();

      // Find the popup menu item and verify its value
      final popupMenuItem = tester.widget<PopupMenuItem<String>>(
        find.byType(PopupMenuItem<String>),
      );
      expect(popupMenuItem.value, 'refresh');
    });
  });
}
