import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_schemes.dart';
import 'typography.dart';
import 'spacing.dart';

/// Main theme configuration for the Mindwell application.
/// 
/// Combines color schemes, typography, and component themes to create
/// a cohesive design system that adapts to both light and dark modes.
class MindwellTheme {
  // Private constructor to prevent instantiation
  MindwellTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    const colorScheme = MindwellColorSchemes.light;
    const textTheme = MindwellTypography.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Inter',
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: MindwellSpacing.elevation,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: colorScheme.surfaceTint,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF3F4257),
          size: MindwellSpacing.iconMd,
        ),
        actionsIconTheme: const IconThemeData(
          color: Color(0xFF3F4257),
          size: MindwellSpacing.iconMd,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: MindwellSpacing.elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        color: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        margin: MindwellEdgeInsets.sm,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: MindwellSpacing.elevation,
          padding: MindwellEdgeInsets.buttonPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: MindwellBorderRadius.md,
          ),
          minimumSize: const Size(0, MindwellSpacing.buttonMd),
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: MindwellEdgeInsets.buttonPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: MindwellBorderRadius.md,
          ),
          side: const BorderSide(color: Color(0xFF888DA8)),
          minimumSize: const Size(0, MindwellSpacing.buttonMd),
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: MindwellEdgeInsets.buttonPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: MindwellBorderRadius.md,
          ),
          minimumSize: const Size(0, MindwellSpacing.buttonMd),
          textStyle: textTheme.labelLarge,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: MindwellSpacing.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.circular,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFF888DA8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFF888DA8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFFFF5E3A), width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFFEF4444)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFFEF4444), width: 2),
        ),
        contentPadding: MindwellEdgeInsets.md,
        labelStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.error,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.38),
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.circular,
        ),
        side: BorderSide(color: colorScheme.outline),
        padding: MindwellEdgeInsets.horizontalSm,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: MindwellEdgeInsets.listItemPadding,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        titleTextStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        leadingAndTrailingTextStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: MindwellSpacing.elevationMd,
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(color: colorScheme.onSurface);
          }
          return textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: Color(0xFF000000),
              size: MindwellSpacing.iconMd,
            );
          }
          return const IconThemeData(
            color: Color(0xFF515365),
            size: MindwellSpacing.iconMd,
          );
        }),
        elevation: MindwellSpacing.elevationMd,
        height: MindwellSpacing.bottomNavHeight,
      ),

      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,
        width: MindwellSpacing.drawerWidth,
        elevation: MindwellSpacing.elevationLg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(MindwellSpacing.borderRadiusLg),
            bottomRight: Radius.circular(MindwellSpacing.borderRadiusLg),
          ),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        elevation: MindwellSpacing.elevationXl,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.lg,
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        elevation: MindwellSpacing.elevationLg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MindwellSpacing.borderRadiusLg),
            topRight: Radius.circular(MindwellSpacing.borderRadiusLg),
          ),
        ),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        actionTextColor: colorScheme.inversePrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: MindwellSpacing.elevationMd,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF9A9FBF),
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: Color(0xFF3F4257),
        size: MindwellSpacing.iconMd,
      ),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: Color(0xFFFF5E3A),
        size: MindwellSpacing.iconMd,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    const colorScheme = MindwellColorSchemes.dark;
    const textTheme = MindwellTypography.darkTextTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Inter',
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: MindwellSpacing.elevation,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: colorScheme.surfaceTint,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFE6E7E9),
          size: MindwellSpacing.iconMd,
        ),
        actionsIconTheme: const IconThemeData(
          color: Color(0xFFE6E7E9),
          size: MindwellSpacing.iconMd,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: MindwellSpacing.elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        color: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        margin: MindwellEdgeInsets.sm,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: MindwellSpacing.elevation,
          padding: MindwellEdgeInsets.buttonPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: MindwellBorderRadius.md,
          ),
          minimumSize: const Size(0, MindwellSpacing.buttonMd),
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: MindwellEdgeInsets.buttonPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: MindwellBorderRadius.md,
          ),
          side: const BorderSide(color: Color(0xFF8E918F)),
          minimumSize: const Size(0, MindwellSpacing.buttonMd),
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: MindwellEdgeInsets.buttonPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: MindwellBorderRadius.md,
          ),
          minimumSize: const Size(0, MindwellSpacing.buttonMd),
          textStyle: textTheme.labelLarge,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: MindwellSpacing.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.circular,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFF8E918F)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFF8E918F)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFFFF7A5C), width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFFFFB4AB)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: MindwellBorderRadius.md,
          borderSide: BorderSide(color: Color(0xFFFFB4AB), width: 2),
        ),
        contentPadding: MindwellEdgeInsets.md,
        labelStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.error,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.38),
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.circular,
        ),
        side: BorderSide(color: colorScheme.outline),
        padding: MindwellEdgeInsets.horizontalSm,
      ),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: MindwellEdgeInsets.listItemPadding,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        titleTextStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        leadingAndTrailingTextStyle: textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: textTheme.labelSmall,
        unselectedLabelStyle: textTheme.labelSmall,
        type: BottomNavigationBarType.fixed,
        elevation: MindwellSpacing.elevationMd,
      ),

      // Navigation Bar Theme (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(color: colorScheme.onSurface);
          }
          return textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: Color(0xFFFFFFFF),
              size: MindwellSpacing.iconMd,
            );
          }
          return const IconThemeData(
            color: Color(0xFFC4C7C5),
            size: MindwellSpacing.iconMd,
          );
        }),
        elevation: MindwellSpacing.elevationMd,
        height: MindwellSpacing.bottomNavHeight,
      ),

      // Drawer Theme
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,
        width: MindwellSpacing.drawerWidth,
        elevation: MindwellSpacing.elevationLg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(MindwellSpacing.borderRadiusLg),
            bottomRight: Radius.circular(MindwellSpacing.borderRadiusLg),
          ),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        elevation: MindwellSpacing.elevationXl,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.lg,
        ),
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        elevation: MindwellSpacing.elevationLg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MindwellSpacing.borderRadiusLg),
            topRight: Radius.circular(MindwellSpacing.borderRadiusLg),
          ),
        ),
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        actionTextColor: colorScheme.inversePrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: MindwellBorderRadius.md,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: MindwellSpacing.elevationMd,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF44474E),
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: Color(0xFFE6E7E9),
        size: MindwellSpacing.iconMd,
      ),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: Color(0xFFFF7A5C),
        size: MindwellSpacing.iconMd,
      ),
    );
  }

  /// Get theme data for the given brightness
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }
}

/// Extension to provide additional theme utilities
extension MindwellThemeExtension on ThemeData {
  /// Get semantic colors from the color scheme
  Color get successColor => colorScheme.success;
  Color get warningColor => colorScheme.warning;
  Color get infoColor => colorScheme.info;
  Color get tealColor => colorScheme.teal;
  Color get cyanColor => colorScheme.cyan;
  Color get yellowColor => colorScheme.yellow;
}