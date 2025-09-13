import 'package:flutter/material.dart';

/// A simple, centered circular progress indicator for loading states.
/// 
/// This widget provides a consistent loading indicator that can be used
/// throughout the application when data is being fetched or processed.
class AppLoader extends StatelessWidget {
  /// The size of the circular progress indicator.
  /// Defaults to 24.0.
  final double size;

  /// The color of the progress indicator.
  /// If null, uses the theme's primary color.
  final Color? color;

  /// The stroke width of the progress indicator.
  /// Defaults to 2.0.
  final double strokeWidth;

  /// Optional message to display below the loader.
  final String? message;

  /// Whether to show the loader in a centered layout.
  /// Defaults to true.
  final bool centered;

  const AppLoader({
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 2.0,
    this.message,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressIndicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? theme.colorScheme.primary,
        ),
      ),
    );

    if (!centered) {
      return progressIndicator;
    }

    final children = <Widget>[progressIndicator];
    
    if (message != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
