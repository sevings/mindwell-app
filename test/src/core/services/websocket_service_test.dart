import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/core/services/websocket_service.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';

// Mock classes
class MockAccountApi extends Mock implements AccountApi {}

class MockRef extends Mock implements Ref {}

class MockMwUser extends Mock implements $MwUser {}

class MockProviderListenable extends Mock
    implements ProviderListenable<Object?> {}

void main() {
  group('WebSocketService', () {
    late WebSocketService webSocketService;
    late MockAccountApi mockAccountApi;
    late MockRef mockRef;

    setUpAll(() {
      // Register fallback values for mocktail
      registerFallbackValue(const AuthState.unauthenticated());
      registerFallbackValue(MockProviderListenable());
    });

    setUp(() {
      mockAccountApi = MockAccountApi();
      mockRef = MockRef();

      webSocketService = WebSocketService(
        accountApi: mockAccountApi,
        ref: mockRef,
      );
    });

    tearDown(() {
      // Don't dispose here - let individual tests handle disposal
      // to avoid interfering with stream tests
    });

    group('connect', () {
      test('should not connect when user is not authenticated', () async {
        // Arrange
        final authState = const AuthState.unauthenticated();
        when(() => mockRef.read(authProvider)).thenReturn(authState);

        // Act
        await webSocketService.connect();

        // Assert
        verifyNever(() => mockAccountApi.accountSubscribeTokenGet());
        expect(webSocketService.isConnected, false);
        expect(webSocketService.isConnecting, false);

        // Cleanup
        webSocketService.dispose();
      });

      test(
        'should not connect when user is authenticated but has no name',
        () async {
          // Arrange
          final mockUser = MockMwUser();
          when(() => mockUser.name).thenReturn(null);
          final authState = AuthState.authenticated(user: mockUser);
          when(() => mockRef.read(authProvider)).thenReturn(authState);

          // Act
          await webSocketService.connect();

          // Assert
          verifyNever(() => mockAccountApi.accountSubscribeTokenGet());
          expect(webSocketService.isConnected, false);
          expect(webSocketService.isConnecting, false);

          // Cleanup
          webSocketService.dispose();
        },
      );

      test('should connect successfully when user is authenticated', () async {
        // Arrange
        final mockUser = MockMwUser();
        when(() => mockUser.name).thenReturn('testuser');
        final authState = AuthState.authenticated(user: mockUser);
        when(() => mockRef.read(authProvider)).thenReturn(authState);

        final tokenResponse = Response<MwAccountSubscribeTokenGet200Response>(
          data: MwAccountSubscribeTokenGet200Response(
            (b) => b..token = 'test-token',
          ),
          statusCode: 200,
          requestOptions: RequestOptions(path: '/test'),
        );
        when(
          () => mockAccountApi.accountSubscribeTokenGet(),
        ).thenAnswer((_) async => tokenResponse);

        // Mock the centrifuge client creation and connection
        // Note: In a real test, you would need to mock the centrifuge package
        // This is a simplified test that focuses on the service logic

        // Act
        await webSocketService.connect();

        // Assert
        verify(() => mockAccountApi.accountSubscribeTokenGet()).called(1);

        // Cleanup
        webSocketService.dispose();
      });

      test('should handle API errors gracefully', () async {
        // Arrange
        final mockUser = MockMwUser();
        when(() => mockUser.name).thenReturn('testuser');
        final authState = AuthState.authenticated(user: mockUser);
        when(() => mockRef.read(authProvider)).thenReturn(authState);

        when(
          () => mockAccountApi.accountSubscribeTokenGet(),
        ).thenThrow(Exception('API Error'));

        // Act
        await webSocketService.connect();

        // Assert
        expect(webSocketService.isConnected, false);
        expect(webSocketService.isConnecting, false);

        // Cleanup
        webSocketService.dispose();
      });

      test('should not connect when already connecting', () async {
        // Arrange
        final mockUser = MockMwUser();
        when(() => mockUser.name).thenReturn('testuser');
        final authState = AuthState.authenticated(user: mockUser);
        when(() => mockRef.read(authProvider)).thenReturn(authState);

        // Set up a long-running API call to simulate connecting state
        when(() => mockAccountApi.accountSubscribeTokenGet()).thenAnswer((
          _,
        ) async {
          await Future.delayed(const Duration(seconds: 1));
          return Response<MwAccountSubscribeTokenGet200Response>(
            data: MwAccountSubscribeTokenGet200Response(
              (b) => b..token = 'test-token',
            ),
            statusCode: 200,
            requestOptions: RequestOptions(path: '/test'),
          );
        });

        // Act - start first connection
        final firstConnect = webSocketService.connect();

        // Try to connect again while first is still running
        await webSocketService.connect();

        // Wait for first connection to complete
        await firstConnect;

        // Assert - should only call API once
        verify(() => mockAccountApi.accountSubscribeTokenGet()).called(1);

        // Cleanup
        webSocketService.dispose();
      });

      // Note: Testing "already connected" scenario is complex because it requires
      // mocking the centrifuge client connection events. This would require
      // more complex test setup that goes beyond the scope of basic unit tests.
    });

    group('disconnect', () {
      test('should disconnect successfully', () async {
        // Act
        await webSocketService.disconnect();

        // Assert
        expect(webSocketService.isConnected, false);
        expect(webSocketService.isConnecting, false);

        // Cleanup
        webSocketService.dispose();
      });
    });

    group('connection state', () {
      test('should start in disconnected state', () {
        expect(webSocketService.connectionState, ConnectionState.disconnected);
        expect(webSocketService.isConnected, false);
        expect(webSocketService.isConnecting, false);

        // Cleanup
        webSocketService.dispose();
      });

      test('should provide connection state stream', () {
        // Assert - the service should provide a connection state stream
        expect(
          webSocketService.connectionStateStream,
          isA<Stream<ConnectionState>>(),
        );

        // Cleanup
        webSocketService.dispose();
      });
    });

    group('message streams', () {
      test('should provide notification message stream', () {
        expect(
          webSocketService.notificationMessagesStream,
          isA<Stream<Map<String, dynamic>>>(),
        );

        // Cleanup
        webSocketService.dispose();
      });

      test('should provide message stream', () {
        expect(
          webSocketService.messageMessagesStream,
          isA<Stream<Map<String, dynamic>>>(),
        );

        // Cleanup
        webSocketService.dispose();
      });
    });

    group('dispose', () {
      test('should dispose resources properly', () {
        // Act
        webSocketService.dispose();

        // Assert - should not throw any exceptions
        expect(() => webSocketService.dispose(), returnsNormally);
      });
    });
  });

  group('ConnectionState', () {
    test('should have correct enum values', () {
      expect(ConnectionState.values, [
        ConnectionState.disconnected,
        ConnectionState.connecting,
        ConnectionState.connected,
        ConnectionState.error,
      ]);
    });
  });
}
