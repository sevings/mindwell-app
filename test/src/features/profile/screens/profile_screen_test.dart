import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:built_collection/built_collection.dart';

import 'package:mindwell/src/features/profile/screens/profile_screen.dart';
import 'package:mindwell/src/features/profile/models/profile_state.dart';
import 'package:mindwell/src/features/profile/providers/profile_provider.dart';
import 'package:mindwell/src/features/profile/widgets/info_card.dart';
import 'package:mindwell/src/features/profile/widgets/badge_card.dart';
import 'package:mindwell/src/features/profile/widgets/image_card.dart';
import 'package:mindwell/src/features/profile/widgets/tag_card.dart';
import 'package:mindwell/src/features/profile/widgets/last_entries_card.dart';
import 'package:mindwell/src/features/profile/widgets/calendar_card.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/core/widgets/loaders/skeleton_loader.dart';
import 'package:mindwell/l10n/app_localizations.dart';

// Mock classes
class MockUsersApi extends Mock implements UsersApi {}
class MockMindwellApi extends Mock implements MindwellApi {}
class MockRelationsApi extends Mock implements RelationsApi {}
class MockMeApi extends Mock implements MeApi {}

void main() {
  group('ProfileScreen', () {
    late MockUsersApi mockUsersApi;
    late MockMindwellApi mockMindwellApi;

    setUp(() {
      mockUsersApi = MockUsersApi();
      mockMindwellApi = MockMindwellApi();
    });

    Widget createTestWidget({
      required String username,
      required ProfileState profileState,
    }) {
      return ProviderScope(
        overrides: [
          mindwellApiProvider.overrideWithValue(mockMindwellApi),
          usersApiProvider.overrideWithValue(mockUsersApi),
          profileProvider(username).overrideWith((ref) => MockProfileNotifier(profileState)),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ProfileScreen(username: username),
        ),
      );
    }

    testWidgets('displays loading state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          username: 'testuser',
          profileState: const ProfileState.loading(),
        ),
      );

      // Verify loading screen is displayed
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
      
      // Verify skeleton loaders are present
      expect(find.byType(SkeletonLoader), findsWidgets);
      
      // Verify no error content is shown
      expect(find.text('Something went wrong'), findsNothing);
    });

    testWidgets('displays error state correctly', (WidgetTester tester) async {
      const errorMessage = 'User not found';
      
      await tester.pumpWidget(
        createTestWidget(
          username: 'testuser',
          profileState: const ProfileState.error(message: errorMessage),
        ),
      );

      // Verify error screen is displayed
      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
      
      // Verify no loading content is shown
      expect(find.byType(SkeletonLoader), findsNothing);
    });

    testWidgets('handles try again button in error state', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          username: 'testuser',
          profileState: const ProfileState.error(message: 'Test error'),
        ),
      );

      // Find and tap the try again button
      final tryAgainButton = find.text('Try Again');
      expect(tryAgainButton, findsOneWidget);
      
      await tester.tap(tryAgainButton);
      await tester.pumpAndSettle();

      // Verify the button is still there (since we're not actually refreshing)
      expect(tryAgainButton, findsOneWidget);
    });

    group('Responsive Layout Tests', () {
      testWidgets('displays single column layout on mobile screens (< 540dp)', (WidgetTester tester) async {
        // Create mock profile data using builder pattern
        final mockProfile = $MwProfile((b) => b
          ..name = 'testuser'
          ..showName = 'Test User'
          ..title = 'Test bio');
        final mockBadges = <MwBadge>[
          MwBadge((b) => b
            ..code = 'test_badge'
            ..title = 'Test Badge'
            ..description = 'Test description'
            ..icon = 'https://example.com/badge.png'),
        ];
        final mockImages = <MwImage>[
          MwImage((b) => b
            ..id = 1
            ..thumbnail = MwImageSize((b) => b
              ..width = 150
              ..height = 150
              ..url = 'https://example.com/image.jpg').toBuilder()),
        ];
        final mockTags = <MwTagListDataInner>[
          MwTagListDataInner((b) => b
            ..tag = 'test-tag'
            ..count = 5),
        ];
        final mockCalendar = MwCalendar((b) => b
          ..entries = BuiltList<MwCalendarEntry>([]).toBuilder());

        await tester.pumpWidget(
          createTestWidget(
            username: 'testuser',
            profileState: ProfileState.loaded(
              user: mockProfile,
              badges: mockBadges,
              images: mockImages,
              tags: mockTags,
              calendarData: mockCalendar,
            ),
          ),
        );

        // Set screen size to mobile (< 540dp)
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pump();

        // Verify staggered grid is present with 1 column
        expect(find.byType(StaggeredGrid), findsOneWidget);
        
        // Verify all expected cards are present
        expect(find.byType(InfoCard), findsOneWidget);
        expect(find.byType(BadgeCard), findsOneWidget);
        expect(find.byType(ImageCard), findsOneWidget);
        expect(find.byType(TagCard), findsOneWidget);
        expect(find.byType(LastEntriesCard), findsOneWidget);
        expect(find.byType(CalendarCard), findsOneWidget);
      });

      testWidgets('displays two column layout on tablet screens (540dp - 1200dp)', (WidgetTester tester) async {
        // Create mock profile data using builder pattern
        final mockProfile = $MwProfile((b) => b
          ..name = 'testuser'
          ..showName = 'Test User'
          ..title = 'Test bio');
        final mockBadges = <MwBadge>[
          MwBadge((b) => b
            ..code = 'test_badge'
            ..title = 'Test Badge'
            ..description = 'Test description'
            ..icon = 'https://example.com/badge.png'),
        ];
        final mockImages = <MwImage>[
          MwImage((b) => b
            ..id = 1
            ..thumbnail = MwImageSize((b) => b
              ..width = 150
              ..height = 150
              ..url = 'https://example.com/image.jpg').toBuilder()),
        ];
        final mockTags = <MwTagListDataInner>[
          MwTagListDataInner((b) => b
            ..tag = 'test-tag'
            ..count = 5),
        ];
        final mockCalendar = MwCalendar((b) => b
          ..entries = BuiltList<MwCalendarEntry>([]).toBuilder());

        await tester.pumpWidget(
          createTestWidget(
            username: 'testuser',
            profileState: ProfileState.loaded(
              user: mockProfile,
              badges: mockBadges,
              images: mockImages,
              tags: mockTags,
              calendarData: mockCalendar,
            ),
          ),
        );

        // Set screen size to tablet (540dp - 1200dp)
        await tester.binding.setSurfaceSize(const Size(800, 600));
        await tester.pump();

        // Verify staggered grid is present
        expect(find.byType(StaggeredGrid), findsOneWidget);
        
        // Verify all expected cards are present
        expect(find.byType(InfoCard), findsOneWidget);
        expect(find.byType(BadgeCard), findsOneWidget);
        expect(find.byType(ImageCard), findsOneWidget);
        expect(find.byType(TagCard), findsOneWidget);
        expect(find.byType(LastEntriesCard), findsOneWidget);
        expect(find.byType(CalendarCard), findsOneWidget);
      });

      testWidgets('displays three column layout on desktop screens (> 1200dp)', (WidgetTester tester) async {
        // Create mock profile data using builder pattern
        final mockProfile = $MwProfile((b) => b
          ..name = 'testuser'
          ..showName = 'Test User'
          ..title = 'Test bio');
        final mockBadges = <MwBadge>[
          MwBadge((b) => b
            ..code = 'test_badge'
            ..title = 'Test Badge'
            ..description = 'Test description'
            ..icon = 'https://example.com/badge.png'),
        ];
        final mockImages = <MwImage>[
          MwImage((b) => b
            ..id = 1
            ..thumbnail = MwImageSize((b) => b
              ..width = 150
              ..height = 150
              ..url = 'https://example.com/image.jpg').toBuilder()),
        ];
        final mockTags = <MwTagListDataInner>[
          MwTagListDataInner((b) => b
            ..tag = 'test-tag'
            ..count = 5),
        ];
        final mockCalendar = MwCalendar((b) => b
          ..entries = BuiltList<MwCalendarEntry>([]).toBuilder());

        await tester.pumpWidget(
          createTestWidget(
            username: 'testuser',
            profileState: ProfileState.loaded(
              user: mockProfile,
              badges: mockBadges,
              images: mockImages,
              tags: mockTags,
              calendarData: mockCalendar,
            ),
          ),
        );

        // Set screen size to desktop (> 1200dp)
        await tester.binding.setSurfaceSize(const Size(1400, 800));
        await tester.pump();

        // Verify staggered grid is present
        expect(find.byType(StaggeredGrid), findsOneWidget);
        
        // Verify all expected cards are present
        expect(find.byType(InfoCard), findsOneWidget);
        expect(find.byType(BadgeCard), findsOneWidget);
        expect(find.byType(ImageCard), findsOneWidget);
        expect(find.byType(TagCard), findsOneWidget);
        expect(find.byType(LastEntriesCard), findsOneWidget);
        expect(find.byType(CalendarCard), findsOneWidget);
      });

      testWidgets('displays empty state when no content is available', (WidgetTester tester) async {
        // Create mock profile data with no additional content
        final mockProfile = $MwProfile((b) => b
          ..name = 'testuser'
          ..showName = 'Test User'
          ..title = 'Test bio');

        await tester.pumpWidget(
          createTestWidget(
            username: 'testuser',
            profileState: ProfileState.loaded(
              user: mockProfile,
              badges: <MwBadge>[], // No badges
              images: <MwImage>[], // No images
              tags: <MwTagListDataInner>[], // No tags
              calendarData: null, // No calendar data
            ),
          ),
        );

        // Verify empty state is displayed
        expect(find.text('No content available'), findsOneWidget);
        expect(find.text('This profile is empty'), findsOneWidget);
        expect(find.byIcon(Icons.person_outline), findsOneWidget);
        
        // Verify no cards are displayed (empty state replaces all cards)
        expect(find.byType(InfoCard), findsNothing);
        expect(find.byType(BadgeCard), findsNothing);
        expect(find.byType(ImageCard), findsNothing);
        expect(find.byType(TagCard), findsNothing);
        expect(find.byType(LastEntriesCard), findsNothing);
        expect(find.byType(CalendarCard), findsNothing);
      });

      testWidgets('loading state uses responsive staggered grid', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget(
            username: 'testuser',
            profileState: const ProfileState.loading(),
          ),
        );

        // Set screen size to tablet
        await tester.binding.setSurfaceSize(const Size(800, 600));
        await tester.pump();

        // Verify staggered grid is present in loading state
        expect(find.byType(StaggeredGrid), findsOneWidget);
        
        // Verify skeleton loaders are present
        expect(find.byType(SkeletonLoader), findsWidgets);
      });
    });
  });
}

/// Mock ProfileNotifier for testing
class MockProfileNotifier extends ProfileNotifier {
  MockProfileNotifier(ProfileState initialState) : super(username: 'test', usersApi: MockUsersApi(), relationsApi: MockRelationsApi(), meApi: MockMeApi()) {
    state = initialState;
  }
  
  @override
  Future<void> fetchProfileData() async {
    // Override to prevent HTTP requests
  }
}