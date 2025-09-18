import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/settings/models/settings_state.dart';
import 'package:mindwell/src/features/settings/providers/settings_provider.dart';

// Mock classes
class MockAccountApi extends Mock implements AccountApi {}

void main() {
  group('SettingsNotifier', () {
    late MockAccountApi mockAccountApi;
    late SettingsNotifier settingsNotifier;

    setUp(() {
      mockAccountApi = MockAccountApi();
      settingsNotifier = SettingsNotifier(accountApi: mockAccountApi);
    });

    group('Initial State', () {
      test('should start with initial state', () {
        expect(settingsNotifier.state, const SettingsState.initial());
      });
    });

    group('Init', () {
      test('should fetch all settings successfully', () async {
        // Arrange
        final emailResponse = Response<MwAccountSettingsEmailGet200Response>(
          data: MwAccountSettingsEmailGet200Response(
            (b) => b
              ..comments = true
              ..followers = false
              ..invites = true
              ..movedEntries = false
              ..badges = true,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/email'),
        );

        final telegramResponse =
            Response<MwAccountSettingsTelegramGet200Response>(
              data: MwAccountSettingsTelegramGet200Response(
                (b) => b
                  ..comments = false
                  ..followers = true
                  ..invites = false
                  ..messages = true
                  ..movedEntries = false
                  ..badges = false,
              ),
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '/account/settings/telegram',
              ),
            );

        final onsiteResponse = Response<MwAccountSettingsOnsiteGet200Response>(
          data: MwAccountSettingsOnsiteGet200Response((b) => b..wishes = true),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/onsite'),
        );

        when(
          () => mockAccountApi.accountSettingsEmailGet(),
        ).thenAnswer((_) async => emailResponse);
        when(
          () => mockAccountApi.accountSettingsTelegramGet(),
        ).thenAnswer((_) async => telegramResponse);
        when(
          () => mockAccountApi.accountSettingsOnsiteGet(),
        ).thenAnswer((_) async => onsiteResponse);

        // Act
        await settingsNotifier.init();

        // Assert
        expect(settingsNotifier.state, isA<SettingsState>());
        final state = settingsNotifier.state;

        state.when(
          initial: () => fail('Expected loaded state, got initial'),
          loading: () => fail('Expected loaded state, got loading'),
          loaded: (emailSettings, telegramSettings, onsiteSettings) {
            expect(emailSettings.comments, true);
            expect(emailSettings.followers, false);
            expect(emailSettings.invites, true);
            expect(emailSettings.movedEntries, false);
            expect(emailSettings.badges, true);

            expect(telegramSettings.comments, false);
            expect(telegramSettings.followers, true);
            expect(telegramSettings.invites, false);
            expect(telegramSettings.messages, true);
            expect(telegramSettings.movedEntries, false);
            expect(telegramSettings.badges, false);

            expect(onsiteSettings.wishes, true);
          },
          error: (message) =>
              fail('Expected loaded state, got error: $message'),
        );

        verify(() => mockAccountApi.accountSettingsEmailGet()).called(1);
        verify(() => mockAccountApi.accountSettingsTelegramGet()).called(1);
        verify(() => mockAccountApi.accountSettingsOnsiteGet()).called(1);
      });

      test('should handle API error during init', () async {
        // Arrange
        when(() => mockAccountApi.accountSettingsEmailGet()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/settings/email'),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/account/settings/email'),
            ),
          ),
        );

        // Act
        await settingsNotifier.init();

        // Assert
        expect(settingsNotifier.state, isA<SettingsState>());
        final state = settingsNotifier.state;

        state.when(
          initial: () => fail('Expected error state, got initial'),
          loading: () => fail('Expected error state, got loading'),
          loaded: (_, __, ___) => fail('Expected error state, got loaded'),
          error: (message) => expect(message, contains('Ошибка сервера')),
        );
      });

      test('should handle null response data', () async {
        // Arrange
        final emailResponse = Response<MwAccountSettingsEmailGet200Response>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/email'),
        );

        final telegramResponse =
            Response<MwAccountSettingsTelegramGet200Response>(
              data: null,
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '/account/settings/telegram',
              ),
            );

        final onsiteResponse = Response<MwAccountSettingsOnsiteGet200Response>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/onsite'),
        );

        when(
          () => mockAccountApi.accountSettingsEmailGet(),
        ).thenAnswer((_) async => emailResponse);
        when(
          () => mockAccountApi.accountSettingsTelegramGet(),
        ).thenAnswer((_) async => telegramResponse);
        when(
          () => mockAccountApi.accountSettingsOnsiteGet(),
        ).thenAnswer((_) async => onsiteResponse);

        // Act
        await settingsNotifier.init();

        // Assert
        expect(settingsNotifier.state, isA<SettingsState>());
        final state = settingsNotifier.state;

        state.when(
          initial: () => fail('Expected error state, got initial'),
          loading: () => fail('Expected error state, got loading'),
          loaded: (_, __, ___) => fail('Expected error state, got loaded'),
          error: (message) =>
              expect(message, contains('Failed to fetch settings data')),
        );
      });
    });

    group('Update Email Settings', () {
      test('should update email settings successfully', () async {
        // Arrange
        final newEmailSettings = const EmailSettings(
          comments: true,
          followers: false,
          invites: true,
          movedEntries: false,
          badges: true,
        );

        final emailResponse = Response<MwAccountSettingsEmailGet200Response>(
          data: MwAccountSettingsEmailGet200Response(
            (b) => b
              ..comments = true
              ..followers = false
              ..invites = true
              ..movedEntries = false
              ..badges = true,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/email'),
        );

        final telegramResponse =
            Response<MwAccountSettingsTelegramGet200Response>(
              data: MwAccountSettingsTelegramGet200Response(
                (b) => b
                  ..comments = false
                  ..followers = true
                  ..invites = false
                  ..messages = true
                  ..movedEntries = false
                  ..badges = false,
              ),
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '/account/settings/telegram',
              ),
            );

        final onsiteResponse = Response<MwAccountSettingsOnsiteGet200Response>(
          data: MwAccountSettingsOnsiteGet200Response((b) => b..wishes = true),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/onsite'),
        );

        when(
          () => mockAccountApi.accountSettingsEmailPut(
            comments: true,
            followers: false,
            invites: true,
            movedEntries: false,
            badges: true,
          ),
        ).thenAnswer(
          (_) async => Response<void>(
            statusCode: 200,
            requestOptions: RequestOptions(path: '/account/settings/email'),
          ),
        );

        when(
          () => mockAccountApi.accountSettingsEmailGet(),
        ).thenAnswer((_) async => emailResponse);
        when(
          () => mockAccountApi.accountSettingsTelegramGet(),
        ).thenAnswer((_) async => telegramResponse);
        when(
          () => mockAccountApi.accountSettingsOnsiteGet(),
        ).thenAnswer((_) async => onsiteResponse);

        // Act
        await settingsNotifier.updateEmailSettings(newEmailSettings);

        // Assert
        verify(
          () => mockAccountApi.accountSettingsEmailPut(
            comments: true,
            followers: false,
            invites: true,
            movedEntries: false,
            badges: true,
          ),
        ).called(1);
        verify(() => mockAccountApi.accountSettingsEmailGet()).called(1);
        verify(() => mockAccountApi.accountSettingsTelegramGet()).called(1);
        verify(() => mockAccountApi.accountSettingsOnsiteGet()).called(1);
      });

      test('should handle error during email settings update', () async {
        // Arrange
        final newEmailSettings = const EmailSettings(
          comments: true,
          followers: false,
          invites: true,
          movedEntries: false,
          badges: true,
        );

        when(
          () => mockAccountApi.accountSettingsEmailPut(
            comments: true,
            followers: false,
            invites: true,
            movedEntries: false,
            badges: true,
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/account/settings/email'),
            response: Response(
              statusCode: 422,
              requestOptions: RequestOptions(path: '/account/settings/email'),
            ),
          ),
        );

        // Act
        await settingsNotifier.updateEmailSettings(newEmailSettings);

        // Assert
        expect(settingsNotifier.state, isA<SettingsState>());
        final state = settingsNotifier.state;

        state.when(
          initial: () => fail('Expected error state, got initial'),
          loading: () => fail('Expected error state, got loading'),
          loaded: (_, __, ___) => fail('Expected error state, got loaded'),
          error: (message) =>
              expect(message, contains('Неверные данные настроек')),
        );
      });
    });

    group('Update Telegram Settings', () {
      test('should update telegram settings successfully', () async {
        // Arrange
        final newTelegramSettings = const TelegramSettings(
          comments: false,
          followers: true,
          invites: false,
          messages: true,
          movedEntries: false,
          badges: false,
        );

        final emailResponse = Response<MwAccountSettingsEmailGet200Response>(
          data: MwAccountSettingsEmailGet200Response(
            (b) => b
              ..comments = true
              ..followers = false
              ..invites = true
              ..movedEntries = false
              ..badges = true,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/email'),
        );

        final telegramResponse =
            Response<MwAccountSettingsTelegramGet200Response>(
              data: MwAccountSettingsTelegramGet200Response(
                (b) => b
                  ..comments = false
                  ..followers = true
                  ..invites = false
                  ..messages = true
                  ..movedEntries = false
                  ..badges = false,
              ),
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '/account/settings/telegram',
              ),
            );

        final onsiteResponse = Response<MwAccountSettingsOnsiteGet200Response>(
          data: MwAccountSettingsOnsiteGet200Response((b) => b..wishes = true),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/onsite'),
        );

        when(
          () => mockAccountApi.accountSettingsTelegramPut(
            comments: false,
            followers: true,
            invites: false,
            messages: true,
            movedEntries: false,
            badges: false,
          ),
        ).thenAnswer(
          (_) async => Response<void>(
            statusCode: 200,
            requestOptions: RequestOptions(path: '/account/settings/telegram'),
          ),
        );

        when(
          () => mockAccountApi.accountSettingsEmailGet(),
        ).thenAnswer((_) async => emailResponse);
        when(
          () => mockAccountApi.accountSettingsTelegramGet(),
        ).thenAnswer((_) async => telegramResponse);
        when(
          () => mockAccountApi.accountSettingsOnsiteGet(),
        ).thenAnswer((_) async => onsiteResponse);

        // Act
        await settingsNotifier.updateTelegramSettings(newTelegramSettings);

        // Assert
        verify(
          () => mockAccountApi.accountSettingsTelegramPut(
            comments: false,
            followers: true,
            invites: false,
            messages: true,
            movedEntries: false,
            badges: false,
          ),
        ).called(1);
        verify(() => mockAccountApi.accountSettingsEmailGet()).called(1);
        verify(() => mockAccountApi.accountSettingsTelegramGet()).called(1);
        verify(() => mockAccountApi.accountSettingsOnsiteGet()).called(1);
      });
    });

    group('Update Onsite Settings', () {
      test('should update onsite settings successfully', () async {
        // Arrange
        final newOnsiteSettings = const OnsiteSettings(wishes: true);

        final emailResponse = Response<MwAccountSettingsEmailGet200Response>(
          data: MwAccountSettingsEmailGet200Response(
            (b) => b
              ..comments = true
              ..followers = false
              ..invites = true
              ..movedEntries = false
              ..badges = true,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/email'),
        );

        final telegramResponse =
            Response<MwAccountSettingsTelegramGet200Response>(
              data: MwAccountSettingsTelegramGet200Response(
                (b) => b
                  ..comments = false
                  ..followers = true
                  ..invites = false
                  ..messages = true
                  ..movedEntries = false
                  ..badges = false,
              ),
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '/account/settings/telegram',
              ),
            );

        final onsiteResponse = Response<MwAccountSettingsOnsiteGet200Response>(
          data: MwAccountSettingsOnsiteGet200Response((b) => b..wishes = true),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/onsite'),
        );

        when(
          () => mockAccountApi.accountSettingsOnsitePut(wishes: true),
        ).thenAnswer(
          (_) async => Response<void>(
            statusCode: 200,
            requestOptions: RequestOptions(path: '/account/settings/onsite'),
          ),
        );

        when(
          () => mockAccountApi.accountSettingsEmailGet(),
        ).thenAnswer((_) async => emailResponse);
        when(
          () => mockAccountApi.accountSettingsTelegramGet(),
        ).thenAnswer((_) async => telegramResponse);
        when(
          () => mockAccountApi.accountSettingsOnsiteGet(),
        ).thenAnswer((_) async => onsiteResponse);

        // Act
        await settingsNotifier.updateOnsiteSettings(newOnsiteSettings);

        // Assert
        verify(
          () => mockAccountApi.accountSettingsOnsitePut(wishes: true),
        ).called(1);
        verify(() => mockAccountApi.accountSettingsEmailGet()).called(1);
        verify(() => mockAccountApi.accountSettingsTelegramGet()).called(1);
        verify(() => mockAccountApi.accountSettingsOnsiteGet()).called(1);
      });
    });

    group('Refresh', () {
      test('should refresh settings by calling init', () async {
        // Arrange
        final emailResponse = Response<MwAccountSettingsEmailGet200Response>(
          data: MwAccountSettingsEmailGet200Response(
            (b) => b
              ..comments = true
              ..followers = false
              ..invites = true
              ..movedEntries = false
              ..badges = true,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/email'),
        );

        final telegramResponse =
            Response<MwAccountSettingsTelegramGet200Response>(
              data: MwAccountSettingsTelegramGet200Response(
                (b) => b
                  ..comments = false
                  ..followers = true
                  ..invites = false
                  ..messages = true
                  ..movedEntries = false
                  ..badges = false,
              ),
              statusCode: 200,
              requestOptions: RequestOptions(
                path: '/account/settings/telegram',
              ),
            );

        final onsiteResponse = Response<MwAccountSettingsOnsiteGet200Response>(
          data: MwAccountSettingsOnsiteGet200Response((b) => b..wishes = true),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/account/settings/onsite'),
        );

        when(
          () => mockAccountApi.accountSettingsEmailGet(),
        ).thenAnswer((_) async => emailResponse);
        when(
          () => mockAccountApi.accountSettingsTelegramGet(),
        ).thenAnswer((_) async => telegramResponse);
        when(
          () => mockAccountApi.accountSettingsOnsiteGet(),
        ).thenAnswer((_) async => onsiteResponse);

        // Act
        await settingsNotifier.refresh();

        // Assert
        verify(() => mockAccountApi.accountSettingsEmailGet()).called(1);
        verify(() => mockAccountApi.accountSettingsTelegramGet()).called(1);
        verify(() => mockAccountApi.accountSettingsOnsiteGet()).called(1);
      });
    });
  });
}
