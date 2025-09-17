import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:centrifuge/centrifuge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../config/config.dart';
import '../../features/auth/providers/auth_provider.dart';

/// Service for managing WebSocket connections using Centrifuge.
///
/// This service handles:
/// - Connection to the WebSocket server
/// - Authentication using tokens from the AccountApi
/// - Subscription to user-specific channels (notifications and messages)
/// - Connection state management with exponential backoff
/// - Stream of incoming messages for different channels
class WebSocketService {
  static final _logger = Logger('WebSocketService');

  final AccountApi _accountApi;
  final Ref _ref;

  Client? _client;
  Subscription? _notificationsSubscription;
  Subscription? _messagesSubscription;

  // Connection state
  bool _isConnecting = false;
  bool _isConnected = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _baseReconnectDelay = Duration(seconds: 1);

  // Stream controllers for different message types
  final StreamController<Map<String, dynamic>> _notificationsController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _messagesController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<ConnectionState> _connectionStateController =
      StreamController<ConnectionState>.broadcast();

  /// Stream of notification messages from the WebSocket.
  Stream<Map<String, dynamic>> get notificationMessagesStream =>
      _notificationsController.stream;

  /// Stream of chat messages from the WebSocket.
  Stream<Map<String, dynamic>> get messageMessagesStream =>
      _messagesController.stream;

  /// Stream of connection state changes.
  Stream<ConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  /// Current connection state.
  ConnectionState get connectionState => _isConnected
      ? ConnectionState.connected
      : _isConnecting
      ? ConnectionState.connecting
      : ConnectionState.disconnected;

  /// Whether the service is currently connected.
  bool get isConnected => _isConnected;

  /// Whether the service is currently connecting.
  bool get isConnecting => _isConnecting;

  WebSocketService({required AccountApi accountApi, required Ref ref})
    : _accountApi = accountApi,
      _ref = ref;

  /// Connects to the WebSocket server and subscribes to channels.
  ///
  /// This method:
  /// 1. Checks if the user is authenticated
  /// 2. Fetches a connection token from the API
  /// 3. Creates and connects a Centrifuge client
  /// 4. Subscribes to user-specific channels
  Future<void> connect() async {
    if (_isConnecting || _isConnected) {
      _logger.warning('Already connecting or connected');
      return;
    }

    // Check if user is authenticated
    final authState = _ref.read(authProvider);

    // Extract user from authenticated state
    $MwUser? user;
    user = authState.maybeWhen(
      authenticated: (userData, _) => userData,
      orElse: () => null,
    );

    if (user == null || user.name == null) {
      _logger.info(
        'User not authenticated or has no name, skipping WebSocket connection',
      );
      return;
    }

    _isConnecting = true;
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(ConnectionState.connecting);
    }

    try {
      _logger.info('Starting WebSocket connection...');

      // Get connection token from API
      final tokenResponse = await _accountApi.accountSubscribeTokenGet();
      final tokenData = tokenResponse.data;
      if (tokenData == null || tokenData.token == null) {
        throw Exception('Failed to get WebSocket connection token');
      }

      final token = tokenData.token!;

      _logger.info('Got WebSocket token, creating client...');

      // Create Centrifuge client
      _client = createClient(Config.wsUrl, ClientConfig(token: token));

      // Set up connection event listeners
      _client!.connected.listen(_onConnected);
      _client!.disconnected.listen(_onDisconnected);
      _client!.error.listen(_onError);

      // Connect the client
      await _client!.connect();
      _logger.info('WebSocket client connected');

      // Subscribe to channels
      await _subscribeToChannels(user.name ?? 'unknown');
    } catch (e) {
      _logger.severe('Failed to connect WebSocket: $e');
      _isConnecting = false;
      if (!_connectionStateController.isClosed) {
        _connectionStateController.add(ConnectionState.disconnected);
      }
      _scheduleReconnect();
    }
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _logger.info('Disconnecting WebSocket...');

    _isConnecting = false;
    _isConnected = false;
    _reconnectAttempts = 0;

    // Unsubscribe from channels
    await _notificationsSubscription?.unsubscribe();
    await _messagesSubscription?.unsubscribe();
    _notificationsSubscription = null;
    _messagesSubscription = null;

    // Disconnect client
    await _client?.disconnect();
    _client = null;

    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(ConnectionState.disconnected);
    }
    _logger.info('WebSocket disconnected');
  }

  /// Subscribes to user-specific channels.
  ///
  /// [username] The username to subscribe to channels for.
  Future<void> _subscribeToChannels(String username) async {
    if (_client == null) {
      throw Exception('Client not connected');
    }

    _logger.info('Subscribing to channels for user: $username');

    // Subscribe to notifications channel
    _notificationsSubscription = _client!.newSubscription(
      'notifications#$username',
    );
    _notificationsSubscription!.publication.listen((event) {
      try {
        final data = jsonDecode(utf8.decode(event.data));
        _logger.fine('Received notification: $data');
        if (!_notificationsController.isClosed) {
          _notificationsController.add(data);
        }
      } catch (e) {
        _logger.warning('Failed to parse notification message: $e');
      }
    });

    await _notificationsSubscription!.subscribe();

    // Subscribe to messages channel
    _messagesSubscription = _client!.newSubscription('messages#$username');
    _messagesSubscription!.publication.listen((event) {
      try {
        final data = jsonDecode(utf8.decode(event.data));
        _logger.fine('Received message: $data');
        if (!_messagesController.isClosed) {
          _messagesController.add(data);
        }
      } catch (e) {
        _logger.warning('Failed to parse message: $e');
      }
    });

    await _messagesSubscription!.subscribe();

    _logger.info('Successfully subscribed to channels');
  }

  /// Handles successful connection to the WebSocket server.
  void _onConnected(ConnectedEvent event) {
    _logger.info('WebSocket connected successfully');
    _isConnecting = false;
    _isConnected = true;
    _reconnectAttempts = 0;
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(ConnectionState.connected);
    }
  }

  /// Handles disconnection from the WebSocket server.
  void _onDisconnected(DisconnectedEvent event) {
    _logger.info('WebSocket disconnected: ${event.reason}');
    _isConnecting = false;
    _isConnected = false;
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(ConnectionState.disconnected);
    }

    // Schedule reconnection if not manually disconnected
    if (event.reason != 'disconnect called') {
      _scheduleReconnect();
    }
  }

  /// Handles WebSocket errors.
  void _onError(ErrorEvent event) {
    _logger.severe('WebSocket error: ${event.error}');
    _isConnecting = false;
    _isConnected = false;
    if (!_connectionStateController.isClosed) {
      _connectionStateController.add(ConnectionState.error);
    }
    _scheduleReconnect();
  }

  /// Schedules a reconnection attempt with exponential backoff.
  void _scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logger.severe('Max reconnection attempts reached, giving up');
      return;
    }

    _reconnectAttempts++;
    final delay = Duration(
      milliseconds:
          (_baseReconnectDelay.inMilliseconds * pow(2, _reconnectAttempts - 1))
              .round(),
    );

    _logger.info(
      'Scheduling reconnection attempt $_reconnectAttempts in ${delay.inSeconds}s',
    );

    Timer(delay, () {
      if (!_isConnected && !_isConnecting) {
        connect();
      }
    });
  }

  /// Disposes of the service and cleans up resources.
  void dispose() {
    _logger.info('Disposing WebSocket service...');
    disconnect();
    _notificationsController.close();
    _messagesController.close();
    _connectionStateController.close();
  }
}

/// Represents the connection state of the WebSocket service.
enum ConnectionState {
  /// Not connected to the WebSocket server.
  disconnected,

  /// Currently connecting to the WebSocket server.
  connecting,

  /// Successfully connected to the WebSocket server.
  connected,

  /// Connection error occurred.
  error,
}
