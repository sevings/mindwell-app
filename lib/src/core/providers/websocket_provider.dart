import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/models/auth_state.dart';
import '../api/api_provider.dart';
import '../services/websocket_service.dart';

/// Provider for the WebSocketService instance.
///
/// This provider creates and manages the lifecycle of the WebSocketService.
/// It automatically connects/disconnects based on the authentication state.
final websocketServiceProvider = Provider<WebSocketService>((ref) {
  final accountApi = ref.read(accountApiProvider);
  return WebSocketService(accountApi: accountApi, ref: ref);
});

/// Provider for the WebSocket connection state.
///
/// This provider exposes the current connection state of the WebSocket service.
final websocketConnectionStateProvider = StreamProvider<ConnectionState>((ref) {
  final websocketService = ref.read(websocketServiceProvider);
  return websocketService.connectionStateStream;
});

/// Provider for WebSocket notification messages.
///
/// This provider exposes the stream of notification messages from the WebSocket.
final websocketNotificationMessagesProvider =
    StreamProvider<Map<String, dynamic>>((ref) {
      final websocketService = ref.read(websocketServiceProvider);
      return websocketService.notificationMessagesStream;
    });

/// Provider for WebSocket chat messages.
///
/// This provider exposes the stream of chat messages from the WebSocket.
final websocketMessageMessagesProvider = StreamProvider<Map<String, dynamic>>((
  ref,
) {
  final websocketService = ref.read(websocketServiceProvider);
  return websocketService.messageMessagesStream;
});

/// Global provider that manages the WebSocket service lifecycle.
///
/// This provider listens to authentication state changes and automatically
/// connects or disconnects the WebSocket service accordingly.
final websocketLifecycleProvider = Provider<void>((ref) {
  final websocketService = ref.read(websocketServiceProvider);
  final authState = ref.watch(authProvider);

  // Listen to authentication state changes
  ref.listen<AuthState>(authProvider, (previous, next) {
    _handleAuthStateChange(websocketService, previous, next);
  });

  // Initial connection check
  _handleAuthStateChange(websocketService, null, authState);
});

/// Handles authentication state changes for WebSocket connection management.
///
/// This function:
/// 1. Connects the WebSocket when user becomes authenticated
/// 2. Disconnects the WebSocket when user becomes unauthenticated
/// 3. Handles state transitions gracefully
void _handleAuthStateChange(
  WebSocketService websocketService,
  AuthState? previous,
  AuthState next,
) {
  final logger = Logger('WebSocketLifecycle');

  // Check if user is authenticated
  final isAuthenticated = next.maybeWhen(
    authenticated: (_, _) => true,
    orElse: () => false,
  );

  // Check if user was previously authenticated
  final wasAuthenticated =
      previous?.maybeWhen(authenticated: (_, _) => true, orElse: () => false) ??
      false;

  // Connect if user just became authenticated
  if (isAuthenticated && !wasAuthenticated) {
    logger.info('User authenticated, connecting WebSocket...');
    websocketService.connect().catchError((error) {
      logger.severe('Failed to connect WebSocket after authentication: $error');
    });
  }

  // Disconnect if user just became unauthenticated
  if (!isAuthenticated && wasAuthenticated) {
    logger.info('User unauthenticated, disconnecting WebSocket...');
    websocketService.disconnect().catchError((error) {
      logger.severe('Failed to disconnect WebSocket after logout: $error');
    });
  }
}
