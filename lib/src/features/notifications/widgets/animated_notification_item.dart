import 'package:flutter/material.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'notification_item.dart';

/// An animated version of NotificationItem that supports fade-in animations
/// for new notifications received via WebSocket.
///
/// This widget wraps the standard NotificationItem with animation capabilities
/// to provide smooth visual feedback when new notifications arrive.
class AnimatedNotificationItem extends StatefulWidget {
  /// The notification to display
  final MwNotification notification;

  /// Callback when the notification is tapped
  final VoidCallback? onTap;

  /// Whether this notification should animate in (typically for new notifications)
  final bool shouldAnimate;

  /// Callback when animation completes
  final VoidCallback? onAnimationComplete;

  /// Duration of the fade-in animation
  final Duration animationDuration;

  const AnimatedNotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.shouldAnimate = false,
    this.onAnimationComplete,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedNotificationItem> createState() =>
      _AnimatedNotificationItemState();
}

class _AnimatedNotificationItemState extends State<AnimatedNotificationItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, -0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    // Start animation if this is a new notification
    if (widget.shouldAnimate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward().then((_) {
          widget.onAnimationComplete?.call();
        });
      });
    } else {
      // Set to final state immediately for existing notifications
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedNotificationItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the notification ID changed and should animate, restart animation
    if (oldWidget.notification.id != widget.notification.id &&
        widget.shouldAnimate) {
      _animationController.reset();
      _animationController.forward().then((_) {
        widget.onAnimationComplete?.call();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: NotificationItem(
              notification: widget.notification,
              onTap: widget.onTap,
            ),
          ),
        );
      },
    );
  }
}
