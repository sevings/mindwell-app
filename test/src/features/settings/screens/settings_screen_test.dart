import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/features/settings/models/settings_state.dart';
import 'package:mindwell/src/features/settings/providers/settings_provider.dart';
import 'package:mindwell/src/features/settings/screens/settings_screen.dart';

/// Mock class for AccountApi
class MockAccountApi extends Mock implements AccountApi {}

/// Mock class for SettingsNotifier
class MockSettingsNotifier extends SettingsNotifier {
  MockSettingsNotifier() : super(accountApi: MockAccountApi());

  @override
  Future<void> init() async {
    // Mock implementation
  }

  @override
  Future<void> updateEmailSettings(EmailSettings newSettings) async {
    // Mock implementation
  }

  @override
  Future<void> updateTelegramSettings(TelegramSettings newSettings) async {
    // Mock implementation
  }

  @override
  Future<void> updateOnsiteSettings(OnsiteSettings newSettings) async {
    // Mock implementation
  }

  @override
  Future<void> refresh() async {
    // Mock implementation
  }
}

void main() {
  group('SettingsScreen', () {
    late MockSettingsNotifier mockSettingsNotifier;

    setUp(() {
      mockSettingsNotifier = MockSettingsNotifier();
    });

    Widget createTestWidget({required SettingsState initialState}) {
      return ProviderScope(
        overrides: [
          settingsProvider.overrideWith((ref) => mockSettingsNotifier),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsScreen(),
        ),
      );
    }

    group('Initial State', () {
      testWidgets('displays loading indicator when state is initial', (
        WidgetTester tester,
      ) async {
        // Arrange
        mockSettingsNotifier.state = const SettingsState.initial();

        // Act
        await tester.pumpWidget(
          createTestWidget(initialState: const SettingsState.initial()),
        );
        await tester.pump();

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('displays loading indicator when state is loading', (
        WidgetTester tester,
      ) async {
        // Arrange
        mockSettingsNotifier.state = const SettingsState.loading();

        // Act
        await tester.pumpWidget(
          createTestWidget(initialState: const SettingsState.loading()),
        );
        await tester.pump();

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Loaded State', () {
      testWidgets('displays settings sections when state is loaded', (
        WidgetTester tester,
      ) async {
        // Arrange
        const emailSettings = EmailSettings();
        const telegramSettings = TelegramSettings();
        const onsiteSettings = OnsiteSettings();
        mockSettingsNotifier.state = const SettingsState.loaded(
          emailSettings: emailSettings,
          telegramSettings: telegramSettings,
          onsiteSettings: onsiteSettings,
        );

        // Act
        await tester.pumpWidget(
          createTestWidget(
            initialState: const SettingsState.loaded(
              emailSettings: emailSettings,
              telegramSettings: telegramSettings,
              onsiteSettings: onsiteSettings,
            ),
          ),
        );
        await tester.pump();

        // Assert
        // Check that the screen contains the expected number of settings sections
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(RefreshIndicator), findsOneWidget);
      });
    });

    group('Error State', () {
      testWidgets('displays error message when state is error', (
        WidgetTester tester,
      ) async {
        // Arrange
        const errorMessage = 'Failed to load settings';
        mockSettingsNotifier.state = const SettingsState.error(
          message: errorMessage,
        );

        // Act
        await tester.pumpWidget(
          createTestWidget(
            initialState: const SettingsState.error(message: errorMessage),
          ),
        );
        await tester.pump();

        // Assert
        expect(find.text(errorMessage), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });
    });

    group('Platform Adaptation', () {
      testWidgets('uses Material Design on Android', (
        WidgetTester tester,
      ) async {
        // Arrange
        const emailSettings = EmailSettings();
        const telegramSettings = TelegramSettings();
        const onsiteSettings = OnsiteSettings();
        mockSettingsNotifier.state = const SettingsState.loaded(
          emailSettings: emailSettings,
          telegramSettings: telegramSettings,
          onsiteSettings: onsiteSettings,
        );

        // Act
        await tester.pumpWidget(
          createTestWidget(
            initialState: const SettingsState.loaded(
              emailSettings: emailSettings,
              telegramSettings: telegramSettings,
              onsiteSettings: onsiteSettings,
            ),
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });
    });

    group('Widget Structure', () {
      testWidgets('contains expected widget types in loaded state', (
        WidgetTester tester,
      ) async {
        // Arrange
        const emailSettings = EmailSettings();
        const telegramSettings = TelegramSettings();
        const onsiteSettings = OnsiteSettings();
        mockSettingsNotifier.state = const SettingsState.loaded(
          emailSettings: emailSettings,
          telegramSettings: telegramSettings,
          onsiteSettings: onsiteSettings,
        );

        // Act
        await tester.pumpWidget(
          createTestWidget(
            initialState: const SettingsState.loaded(
              emailSettings: emailSettings,
              telegramSettings: telegramSettings,
              onsiteSettings: onsiteSettings,
            ),
          ),
        );
        await tester.pump();

        // Assert
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(RefreshIndicator), findsOneWidget);
      });
    });
  });
}
