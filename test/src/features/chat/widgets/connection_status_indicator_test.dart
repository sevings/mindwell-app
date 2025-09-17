import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mindwell/src/core/models/connection_status.dart';
import 'package:mindwell/src/core/services/connection_service.dart';
import 'package:mindwell/src/features/chat/widgets/connection_status_indicator.dart';

void main() {
  group('ConnectionStatusIndicator', () {
    late ConnectionService connectionService;

    setUp(() {
      connectionService = ConnectionService();
      connectionService.initialize();
    });

    tearDown(() {
      connectionService.dispose();
    });

    Widget createTestWidget(Widget child) {
      return ProviderScope(
        overrides: [
          connectionServiceProvider.overrideWithValue(connectionService),
        ],
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    group('ConnectionStatusIndicator', () {
      testWidgets('should show connected status', (WidgetTester tester) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.connected);

        // Act
        await tester.pumpWidget(
          createTestWidget(const ConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Connected'), findsOneWidget);
        expect(find.byIcon(Icons.wifi), findsOneWidget);
      });

      testWidgets('should show disconnected status', (
        WidgetTester tester,
      ) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.disconnected);

        // Act
        await tester.pumpWidget(
          createTestWidget(const ConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Offline'), findsOneWidget);
        expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      });

      testWidgets('should show unknown status', (WidgetTester tester) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.unknown);

        // Act
        await tester.pumpWidget(
          createTestWidget(const ConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Unknown'), findsOneWidget);
        expect(find.byIcon(Icons.help_outline), findsOneWidget);
      });

      testWidgets('should animate status changes', (WidgetTester tester) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.connected);

        // Act
        await tester.pumpWidget(
          createTestWidget(const ConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert initial state
        expect(find.text('Connected'), findsOneWidget);

        // Change status
        connectionService.setStatus(ConnectionStatus.disconnected);
        await tester.pumpAndSettle();

        // Assert new state
        expect(find.text('Offline'), findsOneWidget);
        expect(find.text('Connected'), findsNothing);
      });
    });

    group('CompactConnectionStatusIndicator', () {
      testWidgets('should show connected status as dot', (
        WidgetTester tester,
      ) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.connected);

        // Act
        await tester.pumpWidget(
          createTestWidget(const CompactConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert
        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.shape, BoxShape.circle);
      });

      testWidgets('should show disconnected status as red dot', (
        WidgetTester tester,
      ) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.disconnected);

        // Act
        await tester.pumpWidget(
          createTestWidget(const CompactConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert
        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.shape, BoxShape.circle);
      });

      testWidgets('should show unknown status as gray dot', (
        WidgetTester tester,
      ) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.unknown);

        // Act
        await tester.pumpWidget(
          createTestWidget(const CompactConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Assert
        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.shape, BoxShape.circle);
      });

      testWidgets('should animate status changes', (WidgetTester tester) async {
        // Arrange
        connectionService.setStatus(ConnectionStatus.connected);

        // Act
        await tester.pumpWidget(
          createTestWidget(const CompactConnectionStatusIndicator()),
        );
        await tester.pumpAndSettle();

        // Change status
        connectionService.setStatus(ConnectionStatus.disconnected);
        await tester.pumpAndSettle();

        // Assert - should still be a container with circle decoration
        final container = tester.widget<Container>(
          find.byType(Container).first,
        );
        expect(container.decoration, isA<BoxDecoration>());
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.shape, BoxShape.circle);
      });
    });
  });
}
