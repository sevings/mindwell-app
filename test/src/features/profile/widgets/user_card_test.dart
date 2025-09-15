import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/core/widgets/images/cached_image.dart';
import 'package:mindwell/src/features/profile/widgets/user_card.dart';

// Mock classes
class MockMwFriend extends Mock implements MwFriend {}
class MockMwAvatar extends Mock implements MwAvatar {}
class MockMwCover extends Mock implements MwCover {}
class MockMwFriendAllOfCounts extends Mock implements MwFriendAllOfCounts {}

void main() {
  group('UserCard', () {
    late MockMwFriend mockUser;
    late MockMwAvatar mockAvatar;
    late MockMwCover mockCover;
    late MockMwFriendAllOfCounts mockCounts;

    setUp(() {
      mockUser = MockMwFriend();
      mockAvatar = MockMwAvatar();
      mockCover = MockMwCover();
      mockCounts = MockMwFriendAllOfCounts();

      // Setup default mock values
      when(() => mockUser.id).thenReturn(1);
      when(() => mockUser.name).thenReturn('testuser');
      when(() => mockUser.showName).thenReturn('Test User');
      when(() => mockUser.isOnline).thenReturn(true);
      when(() => mockUser.rank).thenReturn(42.5);
      when(() => mockUser.avatar).thenReturn(mockAvatar);
      when(() => mockUser.cover).thenReturn(mockCover);
      when(() => mockUser.counts).thenReturn(mockCounts);
      when(() => mockUser.gender).thenReturn(MwFriendGenderEnum.male);
      when(() => mockUser.privacy).thenReturn(MwFriendPrivacyEnum.all);
      when(() => mockUser.chatPrivacy).thenReturn(MwFriendChatPrivacyEnum.followers);
      when(() => mockUser.title).thenReturn('Software Developer');
      when(() => mockUser.lastSeenAt).thenReturn(1640995200.0);

      // Setup avatar mock
      when(() => mockAvatar.x42).thenReturn('https://example.com/avatar_42.jpg');
      when(() => mockAvatar.x92).thenReturn('https://example.com/avatar_92.jpg');
      when(() => mockAvatar.x124).thenReturn('https://example.com/avatar_124.jpg');

      // Setup cover mock
      when(() => mockCover.x318).thenReturn('https://example.com/cover_318.jpg');
      when(() => mockCover.x1920).thenReturn('https://example.com/cover_1920.jpg');

      // Setup counts mock
      when(() => mockCounts.entries).thenReturn(25);
      when(() => mockCounts.followers).thenReturn(150);
      when(() => mockCounts.followings).thenReturn(75);
      when(() => mockCounts.comments).thenReturn(200);
      when(() => mockCounts.favorites).thenReturn(50);
      when(() => mockCounts.tags).thenReturn(10);
      when(() => mockCounts.days).thenReturn(365);
      when(() => mockCounts.badges).thenReturn(5);
      when(() => mockCounts.ignored).thenReturn(2);
      when(() => mockCounts.invited).thenReturn(3);
    });

    Widget createTestWidget({
      MwFriend? user,
      VoidCallback? onTap,
      VoidCallback? onEntriesTap,
      VoidCallback? onFollowersTap,
      bool showCover = true,
      double? cardHeight,
      double borderRadius = 12.0,
    }) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: UserCard(
            user: user ?? mockUser,
            onTap: onTap,
            onEntriesTap: onEntriesTap,
            onFollowersTap: onFollowersTap,
            showCover: showCover,
            cardHeight: cardHeight,
            borderRadius: borderRadius,
          ),
        ),
      );
    }

    testWidgets('displays user information correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check if user name is displayed
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('@testuser'), findsOneWidget);

      // Check if online status is displayed
      expect(find.text('Online'), findsOneWidget);

      // Check if stats are displayed
      expect(find.text('25'), findsOneWidget); // entries count
      expect(find.text('150'), findsOneWidget); // followers count
      expect(find.text('entries'), findsOneWidget);
      expect(find.text('followers'), findsOneWidget);

      // Check if rank is displayed
      expect(find.text('42.5'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('displays offline status correctly', (WidgetTester tester) async {
      when(() => mockUser.isOnline).thenReturn(false);
      
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Offline'), findsOneWidget);
      expect(find.text('Online'), findsNothing);
    });

    testWidgets('handles missing user data gracefully', (WidgetTester tester) async {
      final minimalUser = MockMwFriend();
      when(() => minimalUser.name).thenReturn('minimaluser');
      when(() => minimalUser.showName).thenReturn('Minimal User');
      when(() => minimalUser.isOnline).thenReturn(false);
      when(() => minimalUser.counts).thenReturn(null);

      await tester.pumpWidget(createTestWidget(user: minimalUser));
      await tester.pump();

      // Should still display basic info
      expect(find.text('Minimal User'), findsOneWidget);
      expect(find.text('@minimaluser'), findsOneWidget);
      expect(find.text('Offline'), findsOneWidget);

      // Should not display stats since counts is null
      expect(find.text('entries'), findsNothing);
      expect(find.text('followers'), findsNothing);
    });

    testWidgets('handles missing avatar gracefully', (WidgetTester tester) async {
      when(() => mockUser.avatar).thenReturn(null);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Should display fallback avatar icon
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('handles missing cover image gracefully', (WidgetTester tester) async {
      when(() => mockUser.cover).thenReturn(null);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Should not display cover section
      expect(find.byType(CachedImage), findsOneWidget); // Only avatar
    });

    testWidgets('calls onTap when card is tapped', (WidgetTester tester) async {
      bool onTapCalled = false;
      
      await tester.pumpWidget(createTestWidget(
        onTap: () => onTapCalled = true,
      ));
      await tester.pump();

      await tester.tap(find.byType(UserCard));
      await tester.pump();

      expect(onTapCalled, isTrue);
    });

    testWidgets('handles zero counts gracefully', (WidgetTester tester) async {
      when(() => mockCounts.entries).thenReturn(0);
      when(() => mockCounts.followers).thenReturn(0);
      when(() => mockCounts.followings).thenReturn(0);
      when(() => mockCounts.comments).thenReturn(0);
      when(() => mockCounts.favorites).thenReturn(0);
      when(() => mockCounts.tags).thenReturn(0);
      when(() => mockCounts.days).thenReturn(0);
      when(() => mockCounts.badges).thenReturn(0);
      when(() => mockCounts.ignored).thenReturn(0);
      when(() => mockCounts.invited).thenReturn(0);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Should not display any stats
      expect(find.text('entries'), findsNothing);
      expect(find.text('followers'), findsNothing);
    });

    testWidgets('handles null counts gracefully', (WidgetTester tester) async {
      when(() => mockUser.counts).thenReturn(null);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Should not display any stats
      expect(find.text('entries'), findsNothing);
      expect(find.text('followers'), findsNothing);
    });

    testWidgets('handles missing showName gracefully', (WidgetTester tester) async {
      when(() => mockUser.showName).thenReturn(null);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Should fall back to username
      expect(find.text('testuser'), findsOneWidget);
      expect(find.text('@testuser'), findsOneWidget);
    });
  });
}