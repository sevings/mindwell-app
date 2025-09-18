import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import 'package:mindwell/src/features/settings/screens/change_password_screen.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/l10n/app_localizations.dart';

class MockMindwellApi extends Mock implements MindwellApi {}

class MockAccountApi extends Mock implements AccountApi {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('ChangePasswordScreen', () {
    late MockMindwellApi mockApi;
    late MockAccountApi mockAccountApi;

    setUp(() {
      mockApi = MockMindwellApi();
      mockAccountApi = MockAccountApi();

      when(() => mockApi.getAccountApi()).thenReturn(mockAccountApi);
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [mindwellApiProvider.overrideWithValue(mockApi)],
        child: MaterialApp.router(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: GoRouter(
            initialLocation: '/',
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const ChangePasswordScreen(),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('displays all form fields correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Check that all form fields are present
      expect(find.text('Current Password'), findsOneWidget);
      expect(find.text('New Password'), findsOneWidget);
      expect(find.text('Confirm New Password'), findsOneWidget);
      expect(
        find.text('Change Password'),
        findsNWidgets(2),
      ); // App bar title and button
    });

    testWidgets('shows password strength indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Check that password strength indicator is present
      expect(find.text('Password Strength'), findsOneWidget);
    });

    testWidgets('validates current password field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Try to submit form without current password
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Current password is required'), findsOneWidget);
    });

    testWidgets('validates new password field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter current password
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );

      // Try to submit form without new password
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('New password is required'), findsOneWidget);
    });

    testWidgets('validates new password length', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter current password
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );

      // Enter short new password
      await tester.enterText(find.byType(TextFormField).at(1), '123');

      // Try to submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must be at least 6 characters'),
        findsOneWidget,
      );
    });

    testWidgets('validates new password is different from current', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      const password = 'samePassword123';

      // Enter same password for current and new
      await tester.enterText(find.byType(TextFormField).first, password);
      await tester.enterText(find.byType(TextFormField).at(1), password);

      // Try to submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(
        find.text('New password must be different from current password'),
        findsOneWidget,
      );
    });

    testWidgets('validates confirm password field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      // Enter current and new passwords
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newPassword123',
      );

      // Try to submit form without confirm password
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Please confirm your new password'), findsOneWidget);
    });

    testWidgets('validates passwords match', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter current password
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );

      // Enter new password
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newPassword123',
      );

      // Enter different confirm password
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'differentPassword123',
      );

      // Try to submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find all visibility toggle buttons
      final visibilityButtons = find.byIcon(Icons.visibility_outlined);
      expect(visibilityButtons, findsNWidgets(3));

      // Tap first visibility button (current password)
      await tester.tap(visibilityButtons.first);
      await tester.pumpAndSettle();

      // Check that icon changed to visibility_off
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsNWidgets(2));
    });

    testWidgets('calls API when form is valid', (WidgetTester tester) async {
      // Mock successful API response
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer(
        (_) async => Response<void>(
          requestOptions: RequestOptions(path: '/account/password'),
          statusCode: 200,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      // Fill form with valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'newPassword123',
      );

      // Submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Don't settle to avoid navigation issues

      // Verify API was called
      verify(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: 'currentPassword123',
          newPassword: 'newPassword123',
        ),
      ).called(1);
    });

    testWidgets('shows loading state during API call', (
      WidgetTester tester,
    ) async {
      // Mock API call that takes time
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return Response<void>(
          requestOptions: RequestOptions(path: '/account/password'),
          statusCode: 200,
        );
      });

      await tester.pumpWidget(createTestWidget());

      // Fill form with valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'newPassword123',
      );

      // Submit form
      await tester.tap(find.text('Change Password'));
      await tester.pump();

      // Check that button shows loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message on API failure', (
      WidgetTester tester,
    ) async {
      // Mock API failure
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/account/password'),
          response: Response(
            requestOptions: RequestOptions(path: '/account/password'),
            statusCode: 401,
          ),
        ),
      );

      await tester.pumpWidget(createTestWidget());

      // Fill form with valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'newPassword123',
      );

      // Submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Check that error message is shown
      expect(find.text('Current password is incorrect'), findsOneWidget);
    });

    testWidgets('shows success message on successful password change', (
      WidgetTester tester,
    ) async {
      // Mock successful API response
      when(
        () => mockAccountApi.accountPasswordPost(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer(
        (_) async => Response<void>(
          requestOptions: RequestOptions(path: '/account/password'),
          statusCode: 200,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      // Fill form with valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'currentPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'newPassword123',
      );
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'newPassword123',
      );

      // Submit form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Don't settle to avoid navigation issues

      // Check that success message is shown (it will be in a SnackBar)
      expect(find.text('Password changed successfully'), findsOneWidget);
    });
  });
}
