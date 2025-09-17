import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/core/providers/websocket_provider.dart';
import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell/src/core/api/api_provider.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';

// Mock classes
class MockWebSocketService extends Mock implements WebSocketService {}

class MockAccountApi extends Mock implements AccountApi {}

class MockRef extends Mock implements Ref {}

void main() {
  group('WebSocket Provider Tests', () {
    late MockWebSocketService mockWebSocketService;
    late MockAccountApi mockAccountApi;
    late ProviderContainer container;

    setUp(() {
      mockWebSocketService = MockWebSocketService();
      mockAccountApi = MockAccountApi();

      // Setup default mock behaviors
      when(
        () => mockWebSocketService.connectionStateStream,
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => mockWebSocketService.notificationMessagesStream,
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => mockWebSocketService.messageMessagesStream,
      ).thenAnswer((_) => const Stream.empty());
      when(() => mockWebSocketService.connect()).thenAnswer((_) async {});
      when(() => mockWebSocketService.disconnect()).thenAnswer((_) async {});
    });

    tearDown(() {
      container.dispose();
    });

    group('websocketServiceProvider', () {
      test('should create WebSocketService with correct dependencies', () {
        container = ProviderContainer(
          overrides: [accountApiProvider.overrideWithValue(mockAccountApi)],
        );

        final websocketService = container.read(websocketServiceProvider);

        expect(websocketService, isA<WebSocketService>());
      });
    });

    group('websocketConnectionStateProvider', () {
      test('should provide connection state stream', () {
        final connectionStateController = StreamController<ConnectionState>();

        when(
          () => mockWebSocketService.connectionStateStream,
        ).thenAnswer((_) => connectionStateController.stream);

        container = ProviderContainer(
          overrides: [
            websocketServiceProvider.overrideWithValue(mockWebSocketService),
          ],
        );

        final connectionStateAsync = container.read(
          websocketConnectionStateProvider,
        );

        expect(connectionStateAsync, isA<AsyncValue<ConnectionState>>());

        connectionStateController.close();
      });
    });

    group('websocketNotificationMessagesProvider', () {
      test('should provide notification messages stream', () {
        final notificationController = StreamController<Map<String, dynamic>>();

        when(
          () => mockWebSocketService.notificationMessagesStream,
        ).thenAnswer((_) => notificationController.stream);

        container = ProviderContainer(
          overrides: [
            websocketServiceProvider.overrideWithValue(mockWebSocketService),
          ],
        );

        final notificationAsync = container.read(
          websocketNotificationMessagesProvider,
        );

        expect(notificationAsync, isA<AsyncValue<Map<String, dynamic>>>());

        notificationController.close();
      });
    });

    group('websocketMessageMessagesProvider', () {
      test('should provide message messages stream', () {
        final messageController = StreamController<Map<String, dynamic>>();

        when(
          () => mockWebSocketService.messageMessagesStream,
        ).thenAnswer((_) => messageController.stream);

        container = ProviderContainer(
          overrides: [
            websocketServiceProvider.overrideWithValue(mockWebSocketService),
          ],
        );

        final messageAsync = container.read(websocketMessageMessagesProvider);

        expect(messageAsync, isA<AsyncValue<Map<String, dynamic>>>());

        messageController.close();
      });
    });

    group('websocketLifecycleProvider', () {
      test(
        'should connect WebSocket when user becomes authenticated',
        () async {
          final user = $MwUser(
            (b) => b
              ..id = 1
              ..name = 'testuser'
              ..showName = 'Test User'
              ..isTheme = false
              ..isOnline = true,
          );

          container = ProviderContainer(
            overrides: [
              websocketServiceProvider.overrideWithValue(mockWebSocketService),
              authProvider.overrideWith(
                (ref) => AuthNotifier(
                  tokenStorageService: MockTokenStorageService(),
                  oauth2Api: MockOauth2Api(),
                  accountApi: mockAccountApi,
                  meApi: MockMeApi(),
                ),
              ),
            ],
          );

          // Initialize the lifecycle provider
          container.read(websocketLifecycleProvider);

          // Change auth state to authenticated
          final authNotifier = container.read(authProvider.notifier);
          authNotifier.state = AuthState.authenticated(
            user: user,
            authSource: AuthSource.login,
          );

          // Wait a bit for the async operation
          await Future.delayed(const Duration(milliseconds: 100));

          // Verify that connect was called
          verify(() => mockWebSocketService.connect()).called(1);
        },
      );

      test(
        'should disconnect WebSocket when user becomes unauthenticated',
        () async {
          final user = $MwUser(
            (b) => b
              ..id = 1
              ..name = 'testuser'
              ..showName = 'Test User'
              ..isTheme = false
              ..isOnline = true,
          );

          container = ProviderContainer(
            overrides: [
              websocketServiceProvider.overrideWithValue(mockWebSocketService),
              authProvider.overrideWith(
                (ref) => AuthNotifier(
                  tokenStorageService: MockTokenStorageService(),
                  oauth2Api: MockOauth2Api(),
                  accountApi: mockAccountApi,
                  meApi: MockMeApi(),
                ),
              ),
            ],
          );

          final authNotifier = container.read(authProvider.notifier);

          // Start with authenticated state
          authNotifier.state = AuthState.authenticated(
            user: user,
            authSource: AuthSource.login,
          );

          // Initialize the lifecycle provider
          container.read(websocketLifecycleProvider);

          // Wait a bit for the initial connect
          await Future.delayed(const Duration(milliseconds: 100));

          // Change to unauthenticated state
          authNotifier.state = const AuthState.unauthenticated();

          // Wait a bit for the async operation
          await Future.delayed(const Duration(milliseconds: 100));

          // Verify that disconnect was called
          verify(() => mockWebSocketService.disconnect()).called(1);
        },
      );

      test('should not connect when user is already authenticated', () async {
        final user = $MwUser(
          (b) => b
            ..id = 1
            ..name = 'testuser'
            ..showName = 'Test User'
            ..isTheme = false
            ..isOnline = true,
        );

        container = ProviderContainer(
          overrides: [
            websocketServiceProvider.overrideWithValue(mockWebSocketService),
            authProvider.overrideWith(
              (ref) => AuthNotifier(
                tokenStorageService: MockTokenStorageService(),
                oauth2Api: MockOauth2Api(),
                accountApi: mockAccountApi,
                meApi: MockMeApi(),
              ),
            ),
          ],
        );

        final authNotifier = container.read(authProvider.notifier);

        // Start with authenticated state
        authNotifier.state = AuthState.authenticated(
          user: user,
          authSource: AuthSource.login,
        );

        // Initialize the lifecycle provider
        container.read(websocketLifecycleProvider);

        // Wait a bit for the initial connect
        await Future.delayed(const Duration(milliseconds: 100));

        // Change to another authenticated state (same user)
        authNotifier.state = AuthState.authenticated(
          user: user,
          authSource: AuthSource.login,
        );

        // Wait a bit
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify that connect was called only once (initial connection)
        verify(() => mockWebSocketService.connect()).called(1);
      });

      test('should handle WebSocket connection errors gracefully', () async {
        final user = $MwUser(
          (b) => b
            ..id = 1
            ..name = 'testuser'
            ..showName = 'Test User'
            ..isTheme = false
            ..isOnline = true,
        );

        // Setup mock to throw error on connect
        when(() => mockWebSocketService.connect()).thenAnswer((_) async {
          throw Exception('Connection failed');
        });

        container = ProviderContainer(
          overrides: [
            websocketServiceProvider.overrideWithValue(mockWebSocketService),
            authProvider.overrideWith(
              (ref) => AuthNotifier(
                tokenStorageService: MockTokenStorageService(),
                oauth2Api: MockOauth2Api(),
                accountApi: mockAccountApi,
                meApi: MockMeApi(),
              ),
            ),
          ],
        );

        // Initialize the lifecycle provider
        container.read(websocketLifecycleProvider);

        // Change auth state to authenticated
        final authNotifier = container.read(authProvider.notifier);
        authNotifier.state = AuthState.authenticated(
          user: user,
          authSource: AuthSource.login,
        );

        // Wait a bit for the async operation
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify that connect was called (even though it failed)
        verify(() => mockWebSocketService.connect()).called(1);
      });
    });
  });
}

// Additional mock classes needed for the tests
class MockTokenStorageService extends Mock implements TokenStorageService {}

class MockOauth2Api extends Mock implements Oauth2Api {}

class MockMeApi extends Mock implements MeApi {}
