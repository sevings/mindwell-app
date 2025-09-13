import 'package:flutter/material.dart';

/// Typography system for the Mindwell application.
/// 
/// Defines the text theme with proper type scale and font families
/// following Material Design 3 typography guidelines.
class MindwellTypography {
  // Private constructor to prevent instantiation
  MindwellTypography._();

  /// Base font family for the application
  /// Uses Inter as primary with system font fallbacks
  static const String _fontFamily = 'Inter';
  
  /// Monospace font family for code and technical content
  static const String _monospaceFontFamily = 'JetBrains Mono';

  /// Light text theme for light mode
  static const TextTheme lightTextTheme = TextTheme(
    // Display styles
    displayLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.12,
      letterSpacing: -0.25,
      color: Color(0xFF3F4257), // Dark Gray
    ),
    displayMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
      color: Color(0xFF3F4257),
    ),
    displaySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.22,
      color: Color(0xFF3F4257),
    ),
    
    // Headline styles
    headlineLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: Color(0xFF3F4257),
    ),
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.29,
      color: Color(0xFF3F4257),
    ),
    headlineSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.33,
      color: Color(0xFF3F4257),
    ),
    
    // Title styles
    titleLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 1.27,
      color: Color(0xFF3F4257),
    ),
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.50,
      letterSpacing: 0.15,
      color: Color(0xFF3F4257),
    ),
    titleSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
      color: Color(0xFF3F4257),
    ),
    
    // Body styles
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.5,
      color: Color(0xFF3F4257),
    ),
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.25,
      color: Color(0xFF515365), // Medium Gray
    ),
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: 0.4,
      color: Color(0xFF888DA8), // Light Gray
    ),
    
    // Label styles
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
      color: Color(0xFF3F4257),
    ),
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: 0.5,
      color: Color(0xFF515365),
    ),
    labelSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.5,
      color: Color(0xFF888DA8),
    ),
  );

  /// Dark text theme for dark mode
  static const TextTheme darkTextTheme = TextTheme(
    // Display styles
    displayLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1.12,
      letterSpacing: -0.25,
      color: Color(0xFFE6E7E9), // Light text for dark mode
    ),
    displayMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
      color: Color(0xFFE6E7E9),
    ),
    displaySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.22,
      color: Color(0xFFE6E7E9),
    ),
    
    // Headline styles
    headlineLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: Color(0xFFE6E7E9),
    ),
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.29,
      color: Color(0xFFE6E7E9),
    ),
    headlineSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.33,
      color: Color(0xFFE6E7E9),
    ),
    
    // Title styles
    titleLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 1.27,
      color: Color(0xFFE6E7E9),
    ),
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.50,
      letterSpacing: 0.15,
      color: Color(0xFFE6E7E9),
    ),
    titleSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
      color: Color(0xFFE6E7E9),
    ),
    
    // Body styles
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.5,
      color: Color(0xFFE6E7E9),
    ),
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.25,
      color: Color(0xFFC4C7C5), // Light gray for dark mode
    ),
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: 0.4,
      color: Color(0xFF8E918F), // Lighter gray for dark mode
    ),
    
    // Label styles
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
      color: Color(0xFFE6E7E9),
    ),
    labelMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: 0.5,
      color: Color(0xFFC4C7C5),
    ),
    labelSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.5,
      color: Color(0xFF8E918F),
    ),
  );

  /// Monospace text style for code and technical content
  static const TextStyle monospace = TextStyle(
    fontFamily: _monospaceFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
  );

  /// Get text theme for the given brightness
  static TextTheme getTextTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightTextTheme : darkTextTheme;
  }
}

/// Extension to provide additional text styles
extension MindwellTextThemeExtension on TextTheme {
  /// Monospace text style that adapts to the current theme
  TextStyle get monospace => MindwellTypography.monospace.copyWith(
    color: bodyMedium?.color,
  );
  
  /// Caption style for small descriptive text
  TextStyle get caption => bodySmall!.copyWith(
    fontSize: 10,
    height: 1.4,
  );
  
  /// Overline style for category labels and metadata
  TextStyle get overline => labelSmall!.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );
}
