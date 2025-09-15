import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../../lib/l10n/app_localizations.dart';
import '../../../../../lib/src/features/profile/widgets/profile_edit_dialog.dart';
import '../../../../../lib/src/features/profile/providers/profile_provider.dart';
import '../../../../../lib/src/features/profile/models/profile_state.dart';

class MockProfileNotifier extends Mock implements ProfileNotifier {}

class MockUsersApi extends Mock implements UsersApi {}

class MockRelationsApi extends Mock implements RelationsApi {}

class MockMeApi extends Mock implements MeApi {}

void main() {
  group('ProfileEditDialog', () {
    late MockProfileNotifier mockProfileNotifier;
    late MockUsersApi mockUsersApi;
    late MockRelationsApi mockRelationsApi;
    late MockMeApi mockMeApi;

    setUp(() {
      mockProfileNotifier = MockProfileNotifier();
      mockUsersApi = MockUsersApi();
      mockRelationsApi = MockRelationsApi();
      mockMeApi = MockMeApi();
    });

    Widget createTestWidget(MwProfile profile) {
      return ProviderScope(
        overrides: [
          profileProvider(profile.name!).overrideWith((ref) => mockProfileNotifier),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ProfileEditDialog(profile: profile),
          ),
        ),
      );
    }

    testWidgets('displays profile edit dialog with correct title', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User'
        ..title = 'Test Bio'
        ..gender = MwFriendGenderEnum.male
        ..privacy = MwFriendPrivacyEnum.all
        ..chatPrivacy = MwFriendChatPrivacyEnum.invited
        ..country = 'Russia'
        ..city = 'Moscow'
        ..birthday = '1990-01-01'
        ..showInTops = true
        ..isDaylog = false);

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);
    });

    testWidgets('displays all form fields with current profile data', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User'
        ..title = 'Test Bio'
        ..gender = MwFriendGenderEnum.male
        ..privacy = MwFriendPrivacyEnum.all
        ..chatPrivacy = MwFriendChatPrivacyEnum.invited
        ..country = 'Russia'
        ..city = 'Moscow'
        ..birthday = '1990-01-01'
        ..showInTops = true
        ..isDaylog = false);

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      // Check that all form fields are present
      expect(find.text('Display Name'), findsOneWidget);
      expect(find.text('About'), findsAtLeastNWidgets(1));
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('Country'), findsOneWidget);
      expect(find.text('City'), findsOneWidget);
      expect(find.text('Birthday'), findsOneWidget);
      expect(find.text('Privacy'), findsOneWidget);
      expect(find.text('Chat Privacy'), findsOneWidget);

      // Check that current values are displayed
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Test Bio'), findsOneWidget);
      expect(find.text('Russia'), findsOneWidget);
      expect(find.text('Moscow'), findsOneWidget);
      expect(find.text('1990-01-01'), findsOneWidget);
    });

    testWidgets('displays save and cancel buttons', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User');

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('allows editing text fields', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User'
        ..title = 'Test Bio');

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      // Find the display name field and edit it
      final showNameField = find.byType(TextField).first;
      await tester.enterText(showNameField, 'Updated Name');
      await tester.pumpAndSettle();

      expect(find.text('Updated Name'), findsOneWidget);
    });

    testWidgets('allows changing dropdown values', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User'
        ..gender = MwFriendGenderEnum.male
        ..privacy = MwFriendPrivacyEnum.all);

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      // Find and tap the gender dropdown
      final genderDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(genderDropdown);
      await tester.pumpAndSettle();

      // Select a different gender option
      final femaleOption = find.text('Женский');
      expect(femaleOption, findsOneWidget);
      await tester.tap(femaleOption);
      await tester.pumpAndSettle();
    });


    testWidgets('calls updateProfileInfo when save button is tapped', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User'
        ..title = 'Test Bio'
        ..gender = MwFriendGenderEnum.male
        ..privacy = MwFriendPrivacyEnum.all
        ..chatPrivacy = MwFriendChatPrivacyEnum.invited
        ..country = 'Russia'
        ..city = 'Moscow'
        ..birthday = '1990-01-01'
        ..showInTops = true
        ..isDaylog = false);

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      // Mock the updateProfileInfo method
      when(() => mockProfileNotifier.updateProfileInfo(
        showName: any(named: 'showName'),
        privacy: any(named: 'privacy'),
        chatPrivacy: any(named: 'chatPrivacy'),
        gender: any(named: 'gender'),
        isDaylog: any(named: 'isDaylog'),
        title: any(named: 'title'),
        birthday: any(named: 'birthday'),
        country: any(named: 'country'),
        city: any(named: 'city'),
        showInTops: any(named: 'showInTops'),
      )).thenAnswer((_) async {});

      // Tap the save button
      final saveButton = find.text('Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Verify that updateProfileInfo was called
      verify(() => mockProfileNotifier.updateProfileInfo(
        showName: 'Test User',
        privacy: 'all',
        chatPrivacy: 'invited',
        gender: 'male',
        isDaylog: null,
        title: 'Test Bio',
        birthday: '1990-01-01',
        country: 'Russia',
        city: 'Moscow',
        showInTops: null,
      )).called(1);
    });

    testWidgets('closes dialog when cancel button is tapped', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User');

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      // Tap the cancel button
      final cancelButton = find.text('Cancel');
      await tester.tap(cancelButton);
      await tester.pumpAndSettle();

      // Dialog should be closed
      expect(find.byType(ProfileEditDialog), findsNothing);
    });


    testWidgets('handles empty profile data correctly', (WidgetTester tester) async {
      final profile = MwAuthProfile((b) => b
        ..name = 'testuser'
        ..showName = 'Test User');

      await tester.pumpWidget(createTestWidget(profile));
      await tester.pumpAndSettle();

      // All fields should be present even with empty data
      expect(find.text('Display Name'), findsOneWidget);
      expect(find.text('About'), findsAtLeastNWidgets(1));
      expect(find.text('Gender'), findsAtLeastNWidgets(1));
      expect(find.text('Country'), findsOneWidget);
      expect(find.text('City'), findsOneWidget);
      expect(find.text('Birthday'), findsOneWidget);
      expect(find.text('Privacy'), findsOneWidget);
      expect(find.text('Chat Privacy'), findsOneWidget);
    });
  });
}
