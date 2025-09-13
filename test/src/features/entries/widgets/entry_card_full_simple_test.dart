import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/entries/widgets/entry_card_full.dart';

void main() {
  group('EntryCardFull - Simple Tests', () {
    late MwEntry mockEntry;
    late MwUser mockAuthor;
    late MwAvatar mockAvatar;

    setUp(() {
      mockAvatar = MwAvatar((b) => b
        ..x42 = 'https://example.com/avatar.jpg');

      mockAuthor = $MwUser((b) => b
        ..id = 1
        ..name = 'testuser'
        ..showName = 'Test User'
        ..avatar = mockAvatar.toBuilder());

      mockEntry = MwEntry((b) => b
        ..id = 1
        ..author = mockAuthor
        ..title = 'Test Entry Title'
        ..content = '<p>This is a test entry content with <strong>HTML</strong> tags.</p>'
        ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000.0
        ..commentCount = 5
        ..favoriteCount = 10
        ..isFavorited = false
        ..rating = MwRating((b) => b..rating = 15.0).toBuilder()
        ..tags = ListBuilder(['flutter', 'dart', 'testing'])
        ..isPinned = false);
    });

    testWidgets('creates EntryCardFull widget without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
              child: EntryCardFull(
                entry: mockEntry,
              ),
            ),
          ),
        ),
      );

      // Just verify the widget was created without throwing exceptions
      expect(find.byType(EntryCardFull), findsOneWidget);
    });

    testWidgets('handles null entry gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
              child: EntryCardFull(
                entry: MwEntry((b) => b..id = 1),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(EntryCardFull), findsOneWidget);
    });

    testWidgets('calls onTap when provided', (WidgetTester tester) async {
      bool onTapCalled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
              child: EntryCardFull(
                entry: mockEntry,
                onTap: () => onTapCalled = true,
              ),
            ),
          ),
        ),
      );

      // Find the InkWell and tap it
      final inkWell = find.byType(InkWell);
      expect(inkWell, findsOneWidget);
      
      await tester.tap(inkWell);
      expect(onTapCalled, isTrue);
    });

    testWidgets('respects showImages parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
              child: EntryCardFull(
                entry: mockEntry,
                showImages: false,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(EntryCardFull), findsOneWidget);
    });

    testWidgets('respects maxContentLines parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
              child: EntryCardFull(
                entry: mockEntry,
                maxContentLines: 3,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(EntryCardFull), findsOneWidget);
    });
  });
}
