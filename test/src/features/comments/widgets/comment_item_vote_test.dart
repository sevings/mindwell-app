import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/comment_item.dart';
import 'package:mindwell/src/features/comments/providers/comment_interactions_provider.dart';

class MockCommentInteractionsNotifier extends Mock
    implements CommentInteractionsNotifier {}

void main() {
  group('CommentItem Vote Button', () {
    late MockCommentInteractionsNotifier mockInteractionsNotifier;

    setUp(() {
      mockInteractionsNotifier = MockCommentInteractionsNotifier();
    });

    Widget createTestWidget({
      required MwComment comment,
      bool showVoting = true,
    }) {
      return ProviderScope(
        overrides: [
          commentInteractionsProvider.overrideWithValue(
            mockInteractionsNotifier,
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CommentItem(comment: comment, showVoting: showVoting),
          ),
        ),
      );
    }

    MwComment createComment({
      int? id,
      MwRating? rating,
      MwCommentRights? rights,
    }) {
      final author = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'Test User',
      );

      return MwComment(
        (b) => b
          ..id = id ?? 123
          ..author = author
          ..content = 'Test comment content'
          ..createdAt =
              1640995200.0 // 2022-01-01
          ..rating = rating?.toBuilder()
          ..rights = rights?.toBuilder(),
      );
    }

    MwRating createRating({int? upCount, int? downCount, int? vote}) {
      return MwRating(
        (b) => b
          ..upCount = upCount ?? 5
          ..downCount = downCount ?? 1
          ..vote = vote ?? 0,
      );
    }

    MwCommentRights createRights({bool? vote}) {
      return MwCommentRights((b) => b..vote = vote ?? true);
    }

    testWidgets('should display vote button with fire icon and vote count', (
      tester,
    ) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 5, downCount: 1),
        rights: createRights(vote: true),
      );

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Assert
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
      expect(find.text('+4'), findsOneWidget); // 5 - 1 = 4
    });

    testWidgets('should display negative vote count correctly', (tester) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 1, downCount: 3),
        rights: createRights(vote: true),
      );

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Assert
      expect(find.text('-2'), findsOneWidget); // 1 - 3 = -2
    });

    testWidgets('should show filled orange button when user has upvoted', (
      tester,
    ) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 5, downCount: 1, vote: 1),
        rights: createRights(vote: true),
      );

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Assert - Check that the fire icon is present and the vote count is displayed
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
      expect(find.text('+4'), findsOneWidget); // 5 - 1 = 4

      // Find the vote button container by looking for the specific text and icon combination
      final voteButtonFinder = find.ancestor(
        of: find.byIcon(Icons.local_fire_department),
        matching: find.byType(Container),
      );
      expect(voteButtonFinder, findsWidgets);

      final container = tester.widget<Container>(voteButtonFinder.first);
      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.color,
        equals(const Color(0xFFFF6B35)),
      ); // Mindwell orange
    });

    testWidgets(
      'should show outline button when user can vote but has not voted',
      (tester) async {
        // Arrange
        final comment = createComment(
          rating: createRating(upCount: 5, downCount: 1, vote: 0),
          rights: createRights(vote: true),
        );

        // Act
        await tester.pumpWidget(createTestWidget(comment: comment));

        // Assert - Check that the fire icon is present and the vote count is displayed
        expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
        expect(find.text('+4'), findsOneWidget); // 5 - 1 = 4

        // Find the vote button container
        final voteButtonFinder = find.ancestor(
          of: find.byIcon(Icons.local_fire_department),
          matching: find.byType(Container),
        );
        expect(voteButtonFinder, findsWidgets);

        final container = tester.widget<Container>(voteButtonFinder.first);
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.transparent));
        expect(decoration.border, isNotNull);
      },
    );

    testWidgets('should show disabled button when user cannot vote', (
      tester,
    ) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 5, downCount: 1),
        rights: createRights(vote: false),
      );

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Assert - Check that the fire icon is present and the vote count is displayed
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
      expect(find.text('+4'), findsOneWidget); // 5 - 1 = 4

      // Find the AbsorbPointer that wraps the vote button
      final absorbPointerFinder = find.ancestor(
        of: find.byIcon(Icons.local_fire_department),
        matching: find.byType(AbsorbPointer),
      );
      expect(absorbPointerFinder, findsWidgets);

      final absorbPointer = tester.widget<AbsorbPointer>(
        absorbPointerFinder.first,
      );
      expect(absorbPointer.absorbing, isTrue);
    });

    testWidgets('should call vote API when tapped and user can vote', (
      tester,
    ) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 5, downCount: 1, vote: 0),
        rights: createRights(vote: true),
      );

      final updatedRating = createRating(upCount: 6, downCount: 1, vote: 1);
      when(
        () => mockInteractionsNotifier.voteComment(123, true),
      ).thenAnswer((_) async => updatedRating);

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Find the GestureDetector that wraps the vote button
      final gestureDetectorFinder = find.ancestor(
        of: find.byIcon(Icons.local_fire_department),
        matching: find.byType(GestureDetector),
      );
      expect(gestureDetectorFinder, findsWidgets);

      await tester.tap(gestureDetectorFinder.first);
      await tester.pump();

      // Assert
      verify(() => mockInteractionsNotifier.voteComment(123, true)).called(1);
    });

    testWidgets(
      'should call remove vote API when tapped and user has already voted',
      (tester) async {
        // Arrange
        final comment = createComment(
          rating: createRating(upCount: 5, downCount: 1, vote: 1),
          rights: createRights(vote: true),
        );

        final updatedRating = createRating(upCount: 4, downCount: 1, vote: 0);
        when(
          () => mockInteractionsNotifier.removeVote(123),
        ).thenAnswer((_) async => updatedRating);

        // Act
        await tester.pumpWidget(createTestWidget(comment: comment));

        // Find the GestureDetector that wraps the vote button
        final gestureDetectorFinder = find.ancestor(
          of: find.byIcon(Icons.local_fire_department),
          matching: find.byType(GestureDetector),
        );
        expect(gestureDetectorFinder, findsWidgets);

        await tester.tap(gestureDetectorFinder.first);
        await tester.pump();

        // Assert
        verify(() => mockInteractionsNotifier.removeVote(123)).called(1);
      },
    );

    testWidgets('should show loading indicator while voting', (tester) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 5, downCount: 1, vote: 0),
        rights: createRights(vote: true),
      );

      // Create a completer to control when the API call completes
      final completer = Completer<MwRating?>();
      when(
        () => mockInteractionsNotifier.voteComment(123, true),
      ).thenAnswer((_) => completer.future);

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Find the GestureDetector that wraps the vote button
      final gestureDetectorFinder = find.ancestor(
        of: find.byIcon(Icons.local_fire_department),
        matching: find.byType(GestureDetector),
      );
      expect(gestureDetectorFinder, findsWidgets);

      await tester.tap(gestureDetectorFinder.first);
      await tester.pump();

      // Assert - should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete the API call
      completer.complete(createRating(upCount: 6, downCount: 1, vote: 1));
      await tester.pump();

      // Assert - loading indicator should be gone
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should not show vote button when showVoting is false', (
      tester,
    ) async {
      // Arrange
      final comment = createComment(
        rating: createRating(upCount: 5, downCount: 1),
        rights: createRights(vote: true),
      );

      // Act
      await tester.pumpWidget(
        createTestWidget(comment: comment, showVoting: false),
      );

      // Assert
      expect(find.byIcon(Icons.local_fire_department), findsNothing);
    });

    testWidgets('should not show vote button when rating is null', (
      tester,
    ) async {
      // Arrange
      final comment = createComment(
        rating: null,
        rights: createRights(vote: true),
      );

      // Act
      await tester.pumpWidget(createTestWidget(comment: comment));

      // Assert
      expect(find.byIcon(Icons.local_fire_department), findsNothing);
    });
  });
}
