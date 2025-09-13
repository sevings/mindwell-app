/// Button size enumeration for consistent sizing across button components.
enum ButtonSize {
  /// Small button (32dp height)
  small,
  
  /// Medium button (40dp height)
  medium,
  
  /// Large button (48dp height)
  large,
}

/// Extension to provide utility methods for ButtonSize
extension ButtonSizeExtension on ButtonSize {
  /// Get the height for this button size
  double get height {
    switch (this) {
      case ButtonSize.small:
        return 32.0;
      case ButtonSize.medium:
        return 40.0;
      case ButtonSize.large:
        return 48.0;
    }
  }
  
  /// Get the horizontal padding for this button size
  double get horizontalPadding {
    switch (this) {
      case ButtonSize.small:
        return 12.0;
      case ButtonSize.medium:
        return 16.0;
      case ButtonSize.large:
        return 20.0;
    }
  }
  
  /// Get the vertical padding for this button size
  double get verticalPadding {
    switch (this) {
      case ButtonSize.small:
        return 6.0;
      case ButtonSize.medium:
        return 8.0;
      case ButtonSize.large:
        return 12.0;
    }
  }
  
  /// Get the icon size for this button size
  double get iconSize {
    switch (this) {
      case ButtonSize.small:
        return 16.0;
      case ButtonSize.medium:
        return 20.0;
      case ButtonSize.large:
        return 24.0;
    }
  }
  
  /// Get the font size for this button size
  double get fontSize {
    switch (this) {
      case ButtonSize.small:
        return 12.0;
      case ButtonSize.medium:
        return 14.0;
      case ButtonSize.large:
        return 16.0;
    }
  }
}
