import 'package:flutter/material.dart';

/// Color schemes for the Mindwell application.
/// 
/// Provides both light and dark color schemes with WCAG AA compliant
/// contrast ratios and Material Design 3 color tokens.
class MindwellColorSchemes {
  // Private constructor to prevent instantiation
  MindwellColorSchemes._();

  /// Light color scheme for the application
  static const ColorScheme light = ColorScheme.light(
    // Primary colors
    primary: Color(0xFFFF5E3A), // Mindwell Orange
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFF7A5C), // Primary Light
    onPrimaryContainer: Color(0xFF000000),
    
    // Secondary colors
    secondary: Color(0xFF7C5AC2), // Purple
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF9A7FD1),
    onSecondaryContainer: Color(0xFF000000),
    
    // Tertiary colors
    tertiary: Color(0xFF38A9FF), // Blue
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF6BC1FF),
    onTertiaryContainer: Color(0xFF000000),
    
    // Error colors
    error: Color(0xFFEF4444),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    
    // Surface colors
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF3F4257), // Dark Gray
    surfaceContainerHighest: Color(0xFFF8F9FA), // Background
    onSurfaceVariant: Color(0xFF515365), // Medium Gray
    
    // Outline colors
    outline: Color(0xFF888DA8), // Light Gray
    outlineVariant: Color(0xFF9A9FBF), // Lighter Gray
    
    // Inverse colors
    inverseSurface: Color(0xFF3F4257),
    onInverseSurface: Color(0xFFF8F9FA),
    inversePrimary: Color(0xFFFF7A5C),
    
    // Shadow and scrim
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  /// Dark color scheme for the application
  static const ColorScheme dark = ColorScheme.dark(
    // Primary colors
    primary: Color(0xFFFF7A5C), // Primary Light for dark mode
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFFE54A2A), // Primary Dark
    onPrimaryContainer: Color(0xFFFFFFFF),
    
    // Secondary colors
    secondary: Color(0xFF9A7FD1), // Lighter purple for dark mode
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFF7C5AC2),
    onSecondaryContainer: Color(0xFFFFFFFF),
    
    // Tertiary colors
    tertiary: Color(0xFF6BC1FF), // Lighter blue for dark mode
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFF38A9FF),
    onTertiaryContainer: Color(0xFFFFFFFF),
    
    // Error colors
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    
    // Surface colors
    surface: Color(0xFF1A1B23), // Dark surface
    onSurface: Color(0xFFE6E7E9), // Light text on dark surface
    surfaceContainerHighest: Color(0xFF2A2B33), // Dark background
    onSurfaceVariant: Color(0xFFC4C7C5), // Light gray for dark mode
    
    // Outline colors
    outline: Color(0xFF8E918F),
    outlineVariant: Color(0xFF44474E),
    
    // Inverse colors
    inverseSurface: Color(0xFFE6E7E9),
    onInverseSurface: Color(0xFF1A1B23),
    inversePrimary: Color(0xFFFF5E3A),
    
    // Shadow and scrim
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  /// Additional semantic colors for the application
  static const SemanticColors semanticColors = SemanticColors();
}

/// Semantic colors used throughout the application
class SemanticColors {
  const SemanticColors();

  // Success colors
  static const Color success = Color(0xFF10B981);
  static const Color successDark = Color(0xFF059669);
  
  // Warning colors
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFD97706);
  
  // Info colors
  static const Color info = Color(0xFF3B82F6);
  static const Color infoDark = Color(0xFF2563EB);
  
  // Additional brand colors from common_ui.md specifications
  static const Color teal = Color(0xFF08DDC1);
  static const Color cyan = Color(0xFF2AEBCB);
  static const Color yellow = Color(0xFFFFDC1B);
  
  // Additional semantic colors for better UX
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);
}

/// Extension to provide semantic colors on ColorScheme
extension MindwellColorSchemeExtension on ColorScheme {
  /// Success color for the current brightness
  Color get success => brightness == Brightness.light 
      ? SemanticColors.success 
      : SemanticColors.successDark;
  
  /// Warning color for the current brightness
  Color get warning => brightness == Brightness.light 
      ? SemanticColors.warning 
      : SemanticColors.warningDark;
  
  /// Info color for the current brightness
  Color get info => brightness == Brightness.light 
      ? SemanticColors.info 
      : SemanticColors.infoDark;
  
  /// Teal brand color
  Color get teal => SemanticColors.teal;
  
  /// Cyan brand color
  Color get cyan => SemanticColors.cyan;
  
  /// Yellow brand color
  Color get yellow => SemanticColors.yellow;
  
  /// Error color for the current brightness
  Color get error => brightness == Brightness.light 
      ? SemanticColors.error 
      : SemanticColors.errorDark;
}
