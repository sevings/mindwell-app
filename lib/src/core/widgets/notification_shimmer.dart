import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/spacing.dart';

/// A shimmer loading widget that mimics the appearance of notification items.
///
/// This widget provides a skeleton loading effect that matches the layout
/// of actual notification items, creating a smooth loading experience.
class NotificationShimmer extends StatelessWidget {
  /// Number of shimmer items to display
  final int itemCount;

  const NotificationShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _buildShimmerItem(colorScheme, context);
      },
    );
  }

  /// Build a single shimmer notification item.
  Widget _buildShimmerItem(ColorScheme colorScheme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MindwellSpacing.md,
        vertical: MindwellSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        highlightColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.6,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon shimmer
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(width: MindwellSpacing.sm),

            // Notification content shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main text shimmer
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: MindwellSpacing.xs),

                  // Second line shimmer (shorter)
                  Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: MindwellSpacing.xs),

                  // Third line shimmer (even shorter)
                  Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: MindwellSpacing.xs),

                  // Timestamp shimmer
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),

            // Unread indicator shimmer
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
