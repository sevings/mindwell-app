import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/profile/providers/profile_provider.dart';
import 'package:mindwell/src/features/profile/widgets/complain_dialog.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:dio/dio.dart';

class MockUsersApi extends Mock implements UsersApi {}
class MockRelationsApi extends Mock implements RelationsApi {}
class MockMeApi extends Mock implements MeApi {}
class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late MockUsersApi mockUsersApi;
  late MockRelationsApi mockRelationsApi;
  late MockMeApi mockMeApi;

  setUp(() {
    mockUsersApi = MockUsersApi();
    mockRelationsApi = MockRelationsApi();
    mockMeApi = MockMeApi();
  });

  Widget createTestWidget({required Widget child}) {
    return ProviderScope(
      overrides: [
        profileProvider('testuser').overrideWith(
          (ref) => ProfileNotifier(
            username: 'testuser',
            usersApi: mockUsersApi,
            relationsApi: mockRelationsApi,
            meApi: mockMeApi,
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  group('ComplainDialog', () {
    testWidgets('should display dialog with correct title and content', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(username: 'testuser'),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Complain'), findsNWidgets(2)); // Title and button
      expect(find.text('Report testuser for inappropriate behavior.'), findsOneWidget);
      expect(find.text('Additional details (optional)'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('should allow typing in the text field', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(username: 'testuser'),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      final textField = find.byType(TextFormField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'This user is being inappropriate');
      await tester.pump();

      expect(find.text('This user is being inappropriate'), findsOneWidget);
    });

    testWidgets('should close dialog when cancel is pressed', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(username: 'testuser'),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Complain'), findsNWidgets(2)); // Title and button

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Dialog should be closed, so no Complain text should be found
      expect(find.text('Complain'), findsNothing);
    });

    testWidgets('should submit complaint successfully', (tester) async {
      when(() => mockUsersApi.usersNameComplainPost(name: 'testuser', content: any(named: 'content')))
          .thenAnswer((_) async => MockResponse<void>());

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(username: 'testuser'),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Complain'));
      await tester.pumpAndSettle();

      verify(() => mockUsersApi.usersNameComplainPost(name: 'testuser', content: null)).called(1);
      expect(find.text('Complaint submitted successfully'), findsOneWidget);
    });

    testWidgets('should submit complaint with content', (tester) async {
      const complaintContent = 'This user is being inappropriate';
      
      when(() => mockUsersApi.usersNameComplainPost(name: 'testuser', content: complaintContent))
          .thenAnswer((_) async => MockResponse<void>());

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(username: 'testuser'),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      final textField = find.byType(TextFormField);
      await tester.enterText(textField, complaintContent);
      await tester.pump();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Complain'));
      await tester.pumpAndSettle();

      verify(() => mockUsersApi.usersNameComplainPost(name: 'testuser', content: complaintContent)).called(1);
      expect(find.text('Complaint submitted successfully'), findsOneWidget);
    });

    testWidgets('should handle API error gracefully', (tester) async {
      when(() => mockUsersApi.usersNameComplainPost(name: 'testuser', content: any(named: 'content')))
          .thenThrow(Exception('API Error'));

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(username: 'testuser'),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Complain'));
      await tester.pumpAndSettle();

      // Check for SnackBar with error message
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should call onComplaintSubmitted callback when provided', (tester) async {
      bool callbackCalled = false;
      
      when(() => mockUsersApi.usersNameComplainPost(name: 'testuser', content: any(named: 'content')))
          .thenAnswer((_) async => MockResponse<void>());

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ComplainDialog(
                      username: 'testuser',
                      onComplaintSubmitted: () {
                        callbackCalled = true;
                      },
                    ),
                  );
                },
                child: Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Complain'));
      await tester.pumpAndSettle();

      expect(callbackCalled, isTrue);
    });
  });
}

