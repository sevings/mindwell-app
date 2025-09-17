import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/core/models/connection_status.dart';
import 'package:mindwell/src/core/services/connection_service.dart';

void main() {
  group('ConnectionService', () {
    late ConnectionService service;

    setUp(() {
      service = ConnectionService();
      service.initialize();
    });

    tearDown(() {
      service.dispose();
    });

    group('initialization', () {
      test('should initialize with unknown status', () {
        // Assert
        expect(service.currentStatus, ConnectionStatus.unknown);
      });

      test('should provide status stream', () async {
        // Act
        final statusStream = service.statusStream;

        // Assert
        expect(statusStream, isA<Stream<ConnectionStatus>>());
      });
    });

    group('setStatus', () {
      test('should update current status', () {
        // Act
        service.setStatus(ConnectionStatus.connected);

        // Assert
        expect(service.currentStatus, ConnectionStatus.connected);
      });

      test('should emit status changes on stream', () async {
        // Arrange
        final statusChanges = <ConnectionStatus>[];
        final subscription = service.statusStream.listen(statusChanges.add);

        // Act
        service.setStatus(ConnectionStatus.connected);
        service.setStatus(ConnectionStatus.disconnected);

        // Wait for stream emissions
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(statusChanges, contains(ConnectionStatus.connected));
        expect(statusChanges, contains(ConnectionStatus.disconnected));

        // Cleanup
        await subscription.cancel();
      });

      test('should not emit duplicate status', () async {
        // Arrange
        final statusChanges = <ConnectionStatus>[];
        final subscription = service.statusStream.listen(statusChanges.add);

        // Act
        service.setStatus(ConnectionStatus.connected);
        service.setStatus(ConnectionStatus.connected); // Duplicate

        // Wait for stream emissions
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(
          statusChanges.where((s) => s == ConnectionStatus.connected),
          hasLength(1),
        );

        // Cleanup
        await subscription.cancel();
      });
    });

    group('status transitions', () {
      test('should handle all status transitions', () {
        // Test all possible status values
        final statuses = ConnectionStatus.values;

        for (final status in statuses) {
          service.setStatus(status);
          expect(service.currentStatus, status);
        }
      });
    });

    group('dispose', () {
      test('should dispose resources properly', () {
        // Act & Assert - should not throw
        expect(() => service.dispose(), returnsNormally);
      });

      test('should not emit after disposal', () async {
        // Arrange
        final statusChanges = <ConnectionStatus>[];
        final subscription = service.statusStream.listen(statusChanges.add);

        // Act
        service.dispose();
        service.setStatus(ConnectionStatus.connected);

        // Wait for potential emissions
        await Future.delayed(const Duration(milliseconds: 100));

        // Assert - should not have received the status change after disposal
        expect(statusChanges, isEmpty);

        // Cleanup
        await subscription.cancel();
      });
    });
  });
}
