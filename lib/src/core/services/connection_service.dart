import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../models/connection_status.dart';

/// Service for monitoring network connectivity
class ConnectionService {
  final Logger _logger = Logger('ConnectionService');
  final StreamController<ConnectionStatus> _statusController =
      StreamController<ConnectionStatus>.broadcast();

  ConnectionStatus _currentStatus = ConnectionStatus.unknown;
  Timer? _statusCheckTimer;

  /// Stream of connection status changes
  Stream<ConnectionStatus> get statusStream => _statusController.stream;

  /// Current connection status
  ConnectionStatus get currentStatus => _currentStatus;

  /// Initialize the connection monitoring
  void initialize() {
    _startStatusMonitoring();
    _logger.info('ConnectionService initialized');
  }

  /// Start monitoring connection status
  void _startStatusMonitoring() {
    // Check status every 5 seconds
    _statusCheckTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkConnectionStatus(),
    );

    // Initial check
    _checkConnectionStatus();
  }

  /// Check the current connection status
  Future<void> _checkConnectionStatus() async {
    try {
      // Simple connectivity check - in a real app you might use
      // connectivity_plus package or similar
      final newStatus = await _performConnectivityCheck();

      if (newStatus != _currentStatus) {
        _currentStatus = newStatus;
        _statusController.add(newStatus);
        _logger.info('Connection status changed to: $newStatus');
      }
    } catch (e, stackTrace) {
      _logger.severe('Failed to check connection status', e, stackTrace);
      _updateStatus(ConnectionStatus.unknown);
    }
  }

  /// Perform actual connectivity check
  Future<ConnectionStatus> _performConnectivityCheck() async {
    try {
      // This is a simplified check - in production you'd want to
      // actually ping a server or use a proper connectivity package
      // For now, we'll simulate based on some heuristics

      // You could implement actual network checks here
      // For example, making a lightweight HTTP request to a known endpoint

      // Simulate connection check - replace with actual implementation
      await Future.delayed(const Duration(milliseconds: 100));

      // For now, assume connected - in real implementation you'd check actual connectivity
      return ConnectionStatus.connected;
    } catch (e) {
      return ConnectionStatus.disconnected;
    }
  }

  /// Update connection status manually
  void _updateStatus(ConnectionStatus status) {
    if (status != _currentStatus && !_statusController.isClosed) {
      _currentStatus = status;
      _statusController.add(status);
    }
  }

  /// Manually set connection status (for testing or manual override)
  void setStatus(ConnectionStatus status) {
    _updateStatus(status);
  }

  /// Dispose resources
  void dispose() {
    _statusCheckTimer?.cancel();
    if (!_statusController.isClosed) {
      _statusController.close();
    }
  }
}

/// Provider for the ConnectionService
final connectionServiceProvider = Provider<ConnectionService>((ref) {
  final service = ConnectionService();
  service.initialize();
  return service;
});
