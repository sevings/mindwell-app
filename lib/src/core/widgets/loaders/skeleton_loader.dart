import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A composable skeleton loader that provides a shimmer effect.
/// 
/// This widget wraps any child widget structure and applies a shimmer
/// loading effect to create a placeholder preview of the UI while content
/// is loading. This makes the app feel faster and more responsive.
class SkeletonLoader extends StatelessWidget {
  /// The child widget to apply the shimmer effect to.
  final Widget child;

  /// The base color for the shimmer effect.
  /// Defaults to a light gray color.
  final Color? baseColor;

  /// The highlight color for the shimmer effect.
  /// Defaults to a lighter gray color.
  final Color? highlightColor;

  /// The direction of the shimmer effect.
  /// Defaults to [ShimmerDirection.ltr].
  final ShimmerDirection direction;

  /// The duration of the shimmer animation.
  /// Defaults to 1500ms.
  final Duration period;

  /// Whether the shimmer effect is enabled.
  /// Defaults to true.
  final bool enabled;

  const SkeletonLoader({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final defaultBaseColor = isDark 
        ? Colors.grey[800]! 
        : Colors.grey[300]!;
    final defaultHighlightColor = isDark 
        ? Colors.grey[700]! 
        : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor ?? defaultBaseColor,
      highlightColor: highlightColor ?? defaultHighlightColor,
      direction: direction,
      period: period,
      child: child,
    );
  }
}

/// A pre-built skeleton widget for text content.
/// 
/// This widget creates a skeleton placeholder that mimics the appearance
/// of text content with varying line lengths.
class SkeletonText extends StatelessWidget {
  /// The number of lines to display.
  final int lines;

  /// The height of each line.
  final double lineHeight;

  /// The spacing between lines.
  final double lineSpacing;

  /// The width of the text lines as a percentage of available width.
  /// Each element represents one line.
  /// If null, uses default widths.
  final List<double>? lineWidths;

  /// The border radius of the skeleton lines.
  final double borderRadius;

  const SkeletonText({
    super.key,
    this.lines = 3,
    this.lineHeight = 16.0,
    this.lineSpacing = 8.0,
    this.lineWidths,
    this.borderRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final defaultWidths = List.generate(
      lines,
      (index) => index == lines - 1 ? 0.6 : 1.0,
    );
    final widths = lineWidths ?? defaultWidths;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        lines,
        (index) => Container(
          height: lineHeight,
          width: double.infinity,
          margin: EdgeInsets.only(
            bottom: index < lines - 1 ? lineSpacing : 0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: FractionallySizedBox(
            widthFactor: widths[index],
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A pre-built skeleton widget for circular content like avatars.
class SkeletonAvatar extends StatelessWidget {
  /// The size of the avatar.
  final double size;

  /// The border radius of the avatar.
  final double borderRadius;

  const SkeletonAvatar({
    super.key,
    this.size = 40.0,
    this.borderRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// A pre-built skeleton widget for rectangular content like images or cards.
class SkeletonBox extends StatelessWidget {
  /// The width of the box.
  final double? width;

  /// The height of the box.
  final double? height;

  /// The border radius of the box.
  final double borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    this.height = 100.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
