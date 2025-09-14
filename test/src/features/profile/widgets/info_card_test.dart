import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/profile/widgets/info_card.dart';
import 'package:mindwell_api/mindwell_api.dart';

void main() {
  group('InfoCard', () {
    testWidgets('renders all user information correctly',
        (WidgetTester tester) async {
      final profile = $MwProfile(
        (b) => b
          ..title = 'Test bio'
          ..gender = MwFriendGenderEnum.male
          ..createdAt = DateTime.now()
              .subtract(const Duration(days: 100))
              .millisecondsSinceEpoch
              .toDouble() / 1000
          ..invitedBy = ($MwUserBuilder()..name = 'Inviter').build()
          ..privacy = MwFriendPrivacyEnum.followers
          ..rank = 5,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: InfoCard(profile: profile))));

      expect(find.text('Test bio'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('male'), findsOneWidget);
      expect(find.text('Active Days'), findsOneWidget);
      expect(find.text('100'), findsOneWidget);
      expect(find.text('Invited By'), findsOneWidget);
      expect(find.text('Inviter'), findsOneWidget);
      expect(find.text('Privacy'), findsOneWidget);
      expect(find.text('followers'), findsOneWidget);
      expect(find.text('Rank'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('hides optional fields when they are null',
        (WidgetTester tester) async {
      final profile = $MwProfile(
        (b) => b
          ..createdAt = DateTime.now()
              .subtract(const Duration(days: 100))
              .millisecondsSinceEpoch
              .toDouble() / 1000,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: InfoCard(profile: profile))));

      expect(find.text('Test bio'), findsNothing);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('Not specified'), findsOneWidget);
      expect(find.text('Invited By'), findsNothing);
      expect(find.text('Rank'), findsNothing);
    });
  });
}
