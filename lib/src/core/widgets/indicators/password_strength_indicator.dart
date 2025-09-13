import 'package:flutter/material.dart';

/// Enum representing different password strength levels.
enum PasswordStrength {
  /// Password is too weak
  weak,
  
  /// Password has medium strength
  medium,
  
  /// Password is strong
  strong,
}

/// A widget that displays the strength of a password with a visual indicator.
/// 
/// This widget shows a progress bar with different colors based on the password
/// strength level and displays the strength level text.
class PasswordStrengthIndicator extends StatelessWidget {
  /// The current password strength level
  final PasswordStrength strength;
  
  /// Optional label text to display above the indicator
  final String? label;
  
  /// Whether to show the strength level text
  final bool showText;
  
  /// The height of the progress bar
  final double height;
  
  /// The border radius of the progress bar
  final double borderRadius;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
    this.label,
    this.showText = true,
    this.height = 4.0,
    this.borderRadius = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Row(
          children: [
            Expanded(
              child: _buildProgressBar(context),
            ),
            if (showText) ...[
              const SizedBox(width: 8),
              _buildStrengthText(context),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final (progress, color) = _getProgressAndColor(colorScheme);
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthText(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final (text, color) = _getStrengthTextAndColor(colorScheme);
    
    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Returns the progress value (0.0 to 1.0) and color for the current strength level.
  (double progress, Color color) _getProgressAndColor(ColorScheme colorScheme) {
    switch (strength) {
      case PasswordStrength.weak:
        return (0.33, colorScheme.error);
      case PasswordStrength.medium:
        return (0.66, colorScheme.tertiary);
      case PasswordStrength.strong:
        return (1.0, colorScheme.primary);
    }
  }

  /// Returns the strength text and color for the current strength level.
  (String text, Color color) _getStrengthTextAndColor(ColorScheme colorScheme) {
    switch (strength) {
      case PasswordStrength.weak:
        return ('Weak', colorScheme.error);
      case PasswordStrength.medium:
        return ('Medium', colorScheme.tertiary);
      case PasswordStrength.strong:
        return ('Strong', colorScheme.primary);
    }
  }
}

/// Extension to provide convenient methods for password strength calculation.
extension PasswordStrengthCalculator on String {
  /// Calculates the strength of a password based on various criteria.
  /// 
  /// This method evaluates the password based on:
  /// - Length (minimum 8 characters)
  /// - Contains uppercase letters
  /// - Contains lowercase letters
  /// - Contains numbers
  /// - Contains special characters
  /// 
  /// Returns the calculated password strength level.
  PasswordStrength calculatePasswordStrength() {
    if (isEmpty) return PasswordStrength.weak;
    
    int score = 0;
    
    // Length check
    if (length >= 8) score++;
    if (length >= 12) score++;
    
    // Character type checks
    if (RegExp(r'[a-z]').hasMatch(this)) score++;
    if (RegExp(r'[A-Z]').hasMatch(this)) score++;
    if (RegExp(r'[0-9]').hasMatch(this)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this)) score++;
    
    // Determine strength based on score
    if (score < 3) {
      return PasswordStrength.weak;
    } else if (score < 5) {
      return PasswordStrength.medium;
    } else {
      return PasswordStrength.strong;
    }
  }
}
