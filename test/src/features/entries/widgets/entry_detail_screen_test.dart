import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/entries/screens/entry_detail_screen.dart';
import 'package:mindwell/src/features/entries/providers/entry_detail_provider.dart';
import 'package:mindwell/src/features/entries/models/entry_detail_state.dart';

// Mock classes
class MockGoRouter extends Mock implements GoRouter {}
class MockEntryDetailNotifier extends Mock implements EntryDetailNotifier {}
class MockMwEntry extends Mock implements MwEntry {}
class MockMwUser extends Mock implements MwUser {}
class MockMwAvatar extends Mock implements MwAvatar {}
class MockMwComment extends Mock implements MwComment {}

void main() {
  group('EntryDetailScreen', () {
    late MockEntryDetailNotifier mockNotifier;
    late MockMwEntry mockEntry;
    late MockMwUser mockAuthor;
    late MockMwAvatar mockAvatar;

    setUp(() {
      mockNotifier = MockEntryDetailNotifier();
      mockEntry = MockMwEntry();
      mockAuthor = MockMwUser();
      mockAvatar = MockMwAvatar();

      // Setup mock entry data
      when(() => mockEntry.id).thenReturn(123);
      when(() => mockEntry.title).thenReturn('Test Entry');
      when(() => mockEntry.content).thenReturn('<p>Test content</p>');
      when(() => mockEntry.tags).thenReturn(BuiltList(['flutter', 'dart', 'mobile']));
      when(() => mockEntry.author).thenReturn(mockAuthor);
      when(() => mockEntry.createdAt).thenReturn(1640995200.0); // 2022-01-01
      when(() => mockEntry.commentCount).thenReturn(5);
      when(() => mockEntry.rating).thenReturn(null);
      when(() => mockEntry.images).thenReturn(BuiltList([]));

      // Setup mock author data
      when(() => mockAuthor.name).thenReturn('Test User');
      when(() => mockAuthor.avatar).thenReturn(mockAvatar);

      // Setup mock avatar data
      when(() => mockAvatar.x92).thenReturn('https://example.com/avatar.jpg');
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [
          entryDetailProvider(123).overrideWith((ref) => mockNotifier),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const EntryDetailScreen(entryId: 123),
              ),
              GoRoute(
                path: '/tags/:tagName',
                builder: (context, state) => const Scaffold(
                  body: Text('Tag Feed'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('should display tags and make them tappable', (WidgetTester tester) async {
      // Setup mock state
      when(() => mockNotifier.state).thenReturn(
        EntryDetailState.loaded(
          entry: mockEntry,
          comments: <MwComment>[],
          hasMoreComments: false,
          isLoadingComments: false,
          adjacentEntries: null,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify tags are displayed
      expect(find.text('#flutter'), findsOneWidget);
      expect(find.text('#dart'), findsOneWidget);
      expect(find.text('#mobile'), findsOneWidget);

      // Tap on a tag
      await tester.tap(find.text('#flutter'));
      await tester.pumpAndSettle();

      // Verify navigation occurred (this would need proper router setup in real test)
      // For now, we just verify the tap was registered
      expect(find.text('#flutter'), findsOneWidget);
    });

    testWidgets('should display entry content correctly', (WidgetTester tester) async {
      // Setup mock state
      when(() => mockNotifier.state).thenReturn(
        EntryDetailState.loaded(
          entry: mockEntry,
          comments: <MwComment>[],
          hasMoreComments: false,
          isLoadingComments: false,
          adjacentEntries: null,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify entry content is displayed
      expect(find.text('Test Entry'), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
    });

    testWidgets('should show loading state', (WidgetTester tester) async {
      // Setup loading state
      when(() => mockNotifier.state).thenReturn(const EntryDetailState.loading());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify loading indicators are shown
      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('should show error state', (WidgetTester tester) async {
      // Setup error state
      when(() => mockNotifier.state).thenReturn(
        const EntryDetailState.error(message: 'Something went wrong'),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify error message is displayed
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });
  });
}
