import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import 'package:mindwell/src/features/settings/screens/change_email_screen.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/l10n/app_localizations.dart';

class MockMindwellApi extends Mock implements MindwellApi {}

class MockAccountApi extends Mock implements AccountApi {}

class MockMeApi extends Mock implements MeApi {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('ChangeEmailScreen', () {
    late MockMindwellApi mockApi;
    late MockAccountApi mockAccountApi;
    late MockMeApi mockMeApi;

    setUp(() {
      mockApi = MockMindwellApi();
      mockAccountApi = MockAccountApi();
      mockMeApi = MockMeApi();

      when(() => mockApi.getAccountApi()).thenReturn(mockAccountApi);
      when(() => mockApi.getMeApi()).thenReturn(mockMeApi);
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [mindwellApiProvider.overrideWithValue(mockApi)],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const ChangeEmailScreen(),
              ),
            ],
          ),
        ),
      );
    }

    testWidgets('displays loading indicator initially', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message when loading fails', (tester) async {
      when(() => mockMeApi.meGet()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/me'),
          response: Response(
            requestOptions: RequestOptions(path: '/me'),
            statusCode: 500,
          ),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(
        find.text('Server error. Please try again later'),
        findsAtLeastNWidgets(1),
      );
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('displays form when user profile is loaded', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Current Email'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('Email verified'), findsOneWidget);
      expect(find.text('New Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(
        find.text('Change Email'),
        findsNWidgets(2),
      ); // App bar title and button
    });

    testWidgets('displays unverified email status', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = false),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Email not verified'), findsOneWidget);
    });

    testWidgets('displays no email set message when email is null', (
      tester,
    ) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = null
            ..verified = false),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('No email set'), findsOneWidget);
    });

    testWidgets('validates email format', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      // Tap the change email button (find by type to avoid ambiguity)
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('validates required fields', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap the change email button without entering any data
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('New email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('submits form with valid data', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      when(
        () => mockAccountApi.accountEmailPost(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Response<void>(
          requestOptions: RequestOptions(path: '/account/email'),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'new@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      // Tap the change email button (find by type to avoid ambiguity)
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(
        () => mockAccountApi.accountEmailPost(
          email: 'new@example.com',
          password: 'password123',
        ),
      ).called(1);
    });

    testWidgets('toggles password visibility', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find the password visibility toggle button
      final visibilityButton = find.byIcon(Icons.visibility_outlined);
      expect(visibilityButton, findsOneWidget);

      // Tap to toggle visibility
      await tester.tap(visibilityButton);
      await tester.pump();

      // Should now show the visibility_off icon
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('displays loading state during email change', (tester) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      // Create a completer to control when the API call completes
      final completer = Completer<Response<void>>();
      when(
        () => mockAccountApi.accountEmailPost(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) => completer.future);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'new@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      // Tap the change email button (find by type to avoid ambiguity)
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete the API call
      completer.complete(
        Response<void>(requestOptions: RequestOptions(path: '/account/email')),
      );
      await tester.pump();
      await tester.pump();

      // Should show success message
      expect(
        find.text(
          'Email changed successfully. Please check your new email for verification.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays error message when email change fails', (
      tester,
    ) async {
      final mockUserProfile = MwAuthProfile(
        (b) => b
          ..account = (MwAuthProfileAllOfAccountBuilder()
            ..email = 'test@example.com'
            ..verified = true),
      );

      when(() => mockMeApi.meGet()).thenAnswer(
        (_) async => Response<MwAuthProfile>(
          requestOptions: RequestOptions(path: '/me'),
          data: mockUserProfile,
        ),
      );

      when(
        () => mockAccountApi.accountEmailPost(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/account/email'),
          response: Response(
            requestOptions: RequestOptions(path: '/account/email'),
            statusCode: 401,
          ),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid data
      await tester.enterText(
        find.byType(TextFormField).first,
        'new@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'wrongpassword');

      // Tap the change email button (find by type to avoid ambiguity)
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Should show error message
      expect(find.text('Password is incorrect'), findsAtLeastNWidgets(1));
    });
  });
}
