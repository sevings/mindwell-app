import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/connection_status.dart';
import '../../../core/services/connection_service.dart';

/// Widget that displays the current connection status
class ConnectionStatusIndicator extends ConsumerWidget {
  const ConnectionStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionService = ref.watch(connectionServiceProvider);
    final status = connectionService.currentStatus;

    return StreamBuilder<ConnectionStatus>(
      stream: connectionService.statusStream,
      initialData: status,
      builder: (context, snapshot) {
        final currentStatus = snapshot.data ?? ConnectionStatus.unknown;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildStatusWidget(context, currentStatus),
        );
      },
    );
  }

  Widget _buildStatusWidget(BuildContext context, ConnectionStatus status) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (status) {
      case ConnectionStatus.connected:
        return Container(
          key: const ValueKey('connected'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi, size: 16, color: colorScheme.onPrimaryContainer),
              const SizedBox(width: 4),
              Text(
                'Connected',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        );

      case ConnectionStatus.disconnected:
        return Container(
          key: const ValueKey('disconnected'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off,
                size: 16,
                color: colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 4),
              Text(
                'Offline',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
        );

      case ConnectionStatus.unknown:
        return Container(
          key: const ValueKey('unknown'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help_outline,
                size: 16,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 4),
              Text(
                'Unknown',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
    }
  }
}

/// Compact connection status indicator for use in app bars
class CompactConnectionStatusIndicator extends ConsumerWidget {
  const CompactConnectionStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionService = ref.watch(connectionServiceProvider);
    final status = connectionService.currentStatus;

    return StreamBuilder<ConnectionStatus>(
      stream: connectionService.statusStream,
      initialData: status,
      builder: (context, snapshot) {
        final currentStatus = snapshot.data ?? ConnectionStatus.unknown;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildCompactStatusWidget(context, currentStatus),
        );
      },
    );
  }

  Widget _buildCompactStatusWidget(
    BuildContext context,
    ConnectionStatus status,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (status) {
      case ConnectionStatus.connected:
        return Container(
          key: const ValueKey('connected'),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
        );

      case ConnectionStatus.disconnected:
        return Container(
          key: const ValueKey('disconnected'),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: colorScheme.error,
            shape: BoxShape.circle,
          ),
        );

      case ConnectionStatus.unknown:
        return Container(
          key: const ValueKey('unknown'),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: colorScheme.onSurface.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        );
    }
  }
}
