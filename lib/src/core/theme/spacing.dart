import 'package:flutter/material.dart';

/// Spacing system for the Mindwell application.
/// 
/// Provides a consistent spacing scale based on an 8dp grid system
/// following Material Design guidelines.
class MindwellSpacing {
  // Private constructor to prevent instantiation
  MindwellSpacing._();

  /// Base unit for the spacing system (8dp)
  static const double baseUnit = 8.0;

  /// Extra small spacing (4dp)
  /// Used for: tight padding, small gaps between related elements
  static const double xs = 4.0;

  /// Small spacing (8dp)
  /// Used for: compact layouts, list item padding, small margins
  static const double sm = 8.0;

  /// Medium spacing (16dp)
  /// Used for: standard padding, margins between sections, form field spacing
  static const double md = 16.0;

  /// Large spacing (24dp)
  /// Used for: section separations, card padding, screen margins
  static const double lg = 24.0;

  /// Extra large spacing (32dp)
  /// Used for: large section gaps, screen padding, major layout spacing
  static const double xl = 32.0;

  /// Extra extra large spacing (48dp)
  /// Used for: major layout separations, page-level spacing
  static const double xxl = 48.0;

  /// Extra extra extra large spacing (64dp)
  /// Used for: maximum spacing, hero sections, onboarding layouts
  static const double xxxl = 64.0;

  /// Minimum touch target size (44dp)
  /// Ensures accessibility compliance for interactive elements
  static const double minTouchTarget = 44.0;

  /// Standard border radius (8dp)
  /// Used for: cards, buttons, input fields
  static const double borderRadius = 8.0;

  /// Large border radius (16dp)
  /// Used for: prominent cards, modals, large components
  static const double borderRadiusLg = 16.0;

  /// Small border radius (4dp)
  /// Used for: chips, badges, small components
  static const double borderRadiusSm = 4.0;

  /// Circular border radius (9999dp)
  /// Used for: circular buttons, avatars, pills
  static const double borderRadiusCircular = 9999.0;

  /// Standard elevation (2dp)
  /// Used for: cards, buttons
  static const double elevation = 2.0;

  /// Medium elevation (4dp)
  /// Used for: floating action buttons, app bars
  static const double elevationMd = 4.0;

  /// Large elevation (8dp)
  /// Used for: navigation drawers, modals
  static const double elevationLg = 8.0;

  /// Extra large elevation (16dp)
  /// Used for: dialogs, dropdowns
  static const double elevationXl = 16.0;

  /// Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  /// Avatar sizes
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 96.0;

  /// Button heights
  static const double buttonSm = 32.0;
  static const double buttonMd = 40.0;
  static const double buttonLg = 48.0;

  /// Input field heights
  static const double inputSm = 36.0;
  static const double inputMd = 48.0;
  static const double inputLg = 56.0;

  /// App bar height
  static const double appBarHeight = 56.0;

  /// Bottom navigation bar height
  static const double bottomNavHeight = 80.0;

  /// Navigation drawer width
  static const double drawerWidth = 304.0;

  /// Maximum content width for larger screens
  static const double maxContentWidth = 1200.0;

  /// Responsive breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;
}

/// Extension to provide spacing utilities
extension SpacingExtension on num {
  /// Convert the number to spacing units (multiply by base unit)
  double get spacing => this * MindwellSpacing.baseUnit;
}

/// Predefined EdgeInsets for common spacing patterns
class MindwellEdgeInsets {
  // Private constructor to prevent instantiation
  MindwellEdgeInsets._();

  /// All sides padding
  static const EdgeInsets xs = EdgeInsets.all(MindwellSpacing.xs);
  static const EdgeInsets sm = EdgeInsets.all(MindwellSpacing.sm);
  static const EdgeInsets md = EdgeInsets.all(MindwellSpacing.md);
  static const EdgeInsets lg = EdgeInsets.all(MindwellSpacing.lg);
  static const EdgeInsets xl = EdgeInsets.all(MindwellSpacing.xl);
  static const EdgeInsets xxl = EdgeInsets.all(MindwellSpacing.xxl);

  /// Horizontal padding
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: MindwellSpacing.xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: MindwellSpacing.sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: MindwellSpacing.md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: MindwellSpacing.lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: MindwellSpacing.xl);

  /// Vertical padding
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: MindwellSpacing.xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: MindwellSpacing.sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: MindwellSpacing.md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: MindwellSpacing.lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: MindwellSpacing.xl);

  /// Screen-level padding
  static const EdgeInsets screenPadding = EdgeInsets.all(MindwellSpacing.md);
  static const EdgeInsets screenPaddingLg = EdgeInsets.all(MindwellSpacing.lg);

  /// Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(MindwellSpacing.md);
  static const EdgeInsets cardPaddingLg = EdgeInsets.all(MindwellSpacing.lg);

  /// List item padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: MindwellSpacing.md,
    vertical: MindwellSpacing.sm,
  );

  /// Button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: MindwellSpacing.lg,
    vertical: MindwellSpacing.sm,
  );
}

/// Predefined BorderRadius for common patterns
class MindwellBorderRadius {
  // Private constructor to prevent instantiation
  MindwellBorderRadius._();

  /// Standard border radius
  static const BorderRadius sm = BorderRadius.all(Radius.circular(MindwellSpacing.borderRadiusSm));
  static const BorderRadius md = BorderRadius.all(Radius.circular(MindwellSpacing.borderRadius));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(MindwellSpacing.borderRadiusLg));
  static const BorderRadius circular = BorderRadius.all(Radius.circular(MindwellSpacing.borderRadiusCircular));

  /// Top-only border radius
  static const BorderRadius topSm = BorderRadius.only(
    topLeft: Radius.circular(MindwellSpacing.borderRadiusSm),
    topRight: Radius.circular(MindwellSpacing.borderRadiusSm),
  );
  static const BorderRadius topMd = BorderRadius.only(
    topLeft: Radius.circular(MindwellSpacing.borderRadius),
    topRight: Radius.circular(MindwellSpacing.borderRadius),
  );
  static const BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(MindwellSpacing.borderRadiusLg),
    topRight: Radius.circular(MindwellSpacing.borderRadiusLg),
  );

  /// Bottom-only border radius
  static const BorderRadius bottomSm = BorderRadius.only(
    bottomLeft: Radius.circular(MindwellSpacing.borderRadiusSm),
    bottomRight: Radius.circular(MindwellSpacing.borderRadiusSm),
  );
  static const BorderRadius bottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(MindwellSpacing.borderRadius),
    bottomRight: Radius.circular(MindwellSpacing.borderRadius),
  );
  static const BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(MindwellSpacing.borderRadiusLg),
    bottomRight: Radius.circular(MindwellSpacing.borderRadiusLg),
  );
}
