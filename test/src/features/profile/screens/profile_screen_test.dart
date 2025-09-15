import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../../lib/src/features/profile/screens/profile_screen.dart';
import '../../../../../lib/src/features/profile/models/profile_state.dart';
import '../../../../../lib/src/features/profile/providers/profile_provider.dart';
import '../../../../../lib/src/core/api/api_provider.dart';
import '../../../../../lib/src/core/widgets/loaders/skeleton_loader.dart';

// Mock classes
class MockUsersApi extends Mock implements UsersApi {}
class MockMindwellApi extends Mock implements MindwellApi {}

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
  });
}

/// Mock ProfileNotifier for testing
class MockProfileNotifier extends ProfileNotifier {
  MockProfileNotifier(ProfileState initialState) : super(username: 'test', usersApi: MockUsersApi()) {
    state = initialState;
  }
}