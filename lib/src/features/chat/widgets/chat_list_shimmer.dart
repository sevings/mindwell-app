import 'package:flutter/material.dart';

import '../../../core/widgets/loaders/skeleton_loader.dart';

/// A shimmer loading widget that mimics the appearance of chat list items.
///
/// This widget provides a skeleton loading effect that matches the layout
/// of actual chat list items, creating a smooth loading experience.
class ChatListShimmer extends StatelessWidget {
  /// Number of shimmer items to display
  final int itemCount;

  const ChatListShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildShimmerItem(colorScheme, context),
        childCount: itemCount,
      ),
    );
  }

  /// Build a single shimmer chat list item.
  Widget _buildShimmerItem(ColorScheme colorScheme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SkeletonLoader(
        baseColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        highlightColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.6,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar shimmer
            const SkeletonAvatar(size: 48, borderRadius: 24),
            const SizedBox(width: 16),

            // Chat content shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username shimmer
                  Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Last message shimmer
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),

            // Trailing content shimmer
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Timestamp shimmer
                Container(
                  height: 12,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),

                // Unread badge shimmer
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
