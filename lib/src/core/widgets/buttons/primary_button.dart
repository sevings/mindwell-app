import 'package:flutter/material.dart';
import 'button_size.dart';

/// A standardized primary button component for the Mindwell application.
/// 
/// This button uses the primary color scheme and provides consistent styling
/// across the application. It supports loading states and proper accessibility.
class PrimaryButton extends StatelessWidget {
  /// The text to display on the button
  final String text;
  
  /// Callback function called when the button is pressed
  final VoidCallback? onPressed;
  
  /// Whether the button is in a loading state
  final bool isLoading;
  
  /// Whether the button is enabled
  final bool enabled;
  
  /// Optional icon to display before the text
  final IconData? icon;
  
  /// Optional icon to display after the text
  final IconData? trailingIcon;
  
  /// The size of the button
  final ButtonSize size;
  
  /// Whether the button should expand to fill available width
  final bool expanded;
  
  /// Custom minimum width for the button
  final double? minWidth;
  
  /// Custom minimum height for the button
  final double? minHeight;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.trailingIcon,
    this.size = ButtonSize.medium,
    this.expanded = false,
    this.minWidth,
    this.minHeight,
  });

  /// Creates a small primary button
  const PrimaryButton.small({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.trailingIcon,
    this.expanded = false,
    this.minWidth,
    this.minHeight,
  }) : size = ButtonSize.small;

  /// Creates a large primary button
  const PrimaryButton.large({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.trailingIcon,
    this.expanded = false,
    this.minWidth,
    this.minHeight,
  }) : size = ButtonSize.large;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Determine if button should be enabled
    final isButtonEnabled = enabled && !isLoading && onPressed != null;
    
    // Get button dimensions based on size
    final buttonHeight = _getButtonHeight();
    final buttonPadding = _getButtonPadding();
    final textStyle = _getTextStyle(theme);
    
    return SizedBox(
      width: expanded ? double.infinity : minWidth,
      height: minHeight ?? buttonHeight,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.surfaceContainerHighest,
          disabledForegroundColor: colorScheme.onSurfaceVariant,
          elevation: theme.elevatedButtonTheme.style?.elevation?.resolve({}) ?? 2.0,
          shadowColor: colorScheme.shadow,
          surfaceTintColor: colorScheme.surfaceTint,
          padding: buttonPadding,
          minimumSize: Size(minWidth ?? 0, minHeight ?? buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: textStyle,
        ),
        child: _buildButtonContent(theme),
      ),
    );
  }

  Widget _buildButtonContent(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            theme.colorScheme.onPrimary,
          ),
        ),
      );
    }

    final children = <Widget>[];
    
    // Add leading icon
    if (icon != null) {
      children.add(
        Icon(
          icon,
          size: _getIconSize(),
        ),
      );
      children.add(const SizedBox(width: 8));
    }
    
    // Add text
    children.add(
      Text(
        text,
        style: _getTextStyle(theme),
        textAlign: TextAlign.center,
      ),
    );
    
    // Add trailing icon
    if (trailingIcon != null) {
      children.add(const SizedBox(width: 8));
      children.add(
        Icon(
          trailingIcon,
          size: _getIconSize(),
        ),
      );
    }

    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children.map((child) {
        if (child is Text) {
          return Flexible(child: child);
        }
        return child;
      }).toList(),
    );
  }

  double _getButtonHeight() {
    return size.height;
  }

  EdgeInsets _getButtonPadding() {
    return EdgeInsets.symmetric(
      horizontal: size.horizontalPadding,
      vertical: size.verticalPadding,
    );
  }

  double _getIconSize() {
    return size.iconSize;
  }

  TextStyle _getTextStyle(ThemeData theme) {
    final baseStyle = theme.textTheme.labelLarge;
    return baseStyle?.copyWith(fontSize: size.fontSize) ?? 
           TextStyle(fontSize: size.fontSize);
  }
}

