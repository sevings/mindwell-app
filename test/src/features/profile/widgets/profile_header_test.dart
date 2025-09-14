import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/profile/models/profile_state.dart';
import 'package:mindwell/src/features/profile/providers/profile_provider.dart';
import 'package:mindwell/src/features/profile/widgets/profile_header.dart';

// Mock classes
class MockMwProfile extends Mock implements MwProfile {}
class MockMwAvatar extends Mock implements MwAvatar {}
class MockMwCover extends Mock implements MwCover {}
class MockMwProfileAllOfRelations extends Mock implements MwProfileAllOfRelations {}

void main() {
  group('ProfileHeader', () {
    late MockMwProfile mockUser;
    late MockMwAvatar mockAvatar;
    late MockMwCover mockCover;
    late MockMwProfileAllOfRelations mockRelations;

    setUp(() {
      mockUser = MockMwProfile();
      mockAvatar = MockMwAvatar();
      mockCover = MockMwCover();
      mockRelations = MockMwProfileAllOfRelations();

      // Setup default mock values
      when(() => mockUser.name).thenReturn('testuser');
      when(() => mockUser.showName).thenReturn('Test User');
      when(() => mockUser.isOnline).thenReturn(true);
      when(() => mockUser.avatar).thenReturn(mockAvatar);
      when(() => mockUser.cover).thenReturn(mockCover);
      when(() => mockUser.relations).thenReturn(mockRelations);

      when(() => mockAvatar.x124).thenReturn('https://example.com/avatar124.jpg');
      when(() => mockAvatar.x92).thenReturn('https://example.com/avatar92.jpg');
      when(() => mockAvatar.x42).thenReturn('https://example.com/avatar42.jpg');

      when(() => mockCover.x1920).thenReturn('https://example.com/cover1920.jpg');
      when(() => mockCover.x318).thenReturn('https://example.com/cover318.jpg');

      when(() => mockRelations.fromMe).thenReturn(MwProfileAllOfRelationsFromMeEnum.none);
      when(() => mockRelations.isOpenForMe).thenReturn(true);
    });

    Widget createTestWidget(ProfileState profileState) {
      return ProviderScope(
        overrides: [
          profileProvider('testuser').overrideWith(
            (ref) => MockProfileNotifier(profileState),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ProfileHeader(username: 'testuser'),
          ),
        ),
      );
    }

    testWidgets('displays loading state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(const ProfileState.loading()));

      // Check for skeleton elements
      expect(find.byType(Container), findsWidgets);
      expect(find.text('Test User'), findsNothing);
    });

    testWidgets('displays loaded state with user information', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for user information
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('@testuser'), findsOneWidget);
      expect(find.text('Online'), findsOneWidget);
    });

    testWidgets('displays follow button when user can be followed', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for follow button
      expect(find.text('Follow'), findsOneWidget);
    });

    testWidgets('displays unfollow button when user is being followed', (WidgetTester tester) async {
      when(() => mockRelations.fromMe).thenReturn(MwProfileAllOfRelationsFromMeEnum.followed);

      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for unfollow button
      expect(find.text('Unfollow'), findsOneWidget);
    });

    testWidgets('displays message button when user can be messaged', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for message button
      expect(find.text('Message'), findsOneWidget);
    });

    testWidgets('displays block button', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for block button
      expect(find.text('Block'), findsOneWidget);
    });

    testWidgets('displays unblock button when user is blocked', (WidgetTester tester) async {
      when(() => mockRelations.fromMe).thenReturn(MwProfileAllOfRelationsFromMeEnum.ignored);
      when(() => mockRelations.isOpenForMe).thenReturn(false);

      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for unblock button
      expect(find.text('Unblock'), findsOneWidget);
    });

    testWidgets('displays offline status when user is offline', (WidgetTester tester) async {
      when(() => mockUser.isOnline).thenReturn(false);

      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Check for offline status
      expect(find.text('Offline'), findsOneWidget);
    });

    testWidgets('displays error state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          const ProfileState.error(message: 'User not found'),
        ),
      );

      await tester.pump();

      // Check for error message
      expect(find.text('User not found'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('handles missing avatar gracefully', (WidgetTester tester) async {
      when(() => mockUser.avatar).thenReturn(null);

      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Should still display user info without avatar
      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('handles missing cover image gracefully', (WidgetTester tester) async {
      when(() => mockUser.cover).thenReturn(null);

      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Should still display user info without cover
      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('handles missing display name gracefully', (WidgetTester tester) async {
      when(() => mockUser.showName).thenReturn(null);

      await tester.pumpWidget(
        createTestWidget(
          ProfileState.loaded(
            user: mockUser,
            badges: [],
            images: [],
            tags: [],
          ),
        ),
      );

      await tester.pump();

      // Should display username as fallback
      expect(find.text('@testuser'), findsOneWidget);
    });
  });
}

// Mock ProfileNotifier for testing
class MockProfileNotifier extends ProfileNotifier {
  MockProfileNotifier(ProfileState initialState) 
      : super(username: 'testuser', usersApi: MockUsersApi()) {
    state = initialState;
  }
}

// Mock UsersApi for testing
class MockUsersApi extends Mock implements UsersApi {}
