import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Platform-aware app bar widget that adapts to the current platform.
///
/// Returns a Material AppBar on Android and a CupertinoSliverNavigationBar on iOS.
/// Provides consistent styling and behavior across platforms while respecting
/// platform-specific design guidelines as specified in common_ui.md.
class PlatformAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a platform-aware app bar.
  ///
  /// The [title] parameter is required and will be displayed as the app bar title.
  /// The [actions] parameter is optional and can contain a list of action widgets.
  /// The [leading] parameter is optional and can be used to customize the leading widget.
  /// The [automaticallyImplyLeading] parameter controls whether to automatically show a back button.
  /// The [showHamburgerMenu] parameter controls whether to show hamburger menu for drawer.
  const PlatformAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.systemOverlayStyle,
    this.showHamburgerMenu = false,
    this.bottom,
  });

  /// The title to display in the app bar.
  final Widget title;

  /// Optional list of action widgets to display in the app bar.
  final List<Widget>? actions;

  /// Optional leading widget to display at the start of the app bar.
  final Widget? leading;

  /// Whether to automatically show a back button when appropriate.
  final bool automaticallyImplyLeading;

  /// Whether to center the title.
  final bool? centerTitle;

  /// Background color of the app bar.
  final Color? backgroundColor;

  /// Foreground color of the app bar.
  final Color? foregroundColor;

  /// Elevation of the app bar.
  final double? elevation;

  /// System overlay style for the app bar.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Whether to show hamburger menu for navigation drawer.
  final bool showHamburgerMenu;

  /// Optional bottom widget (like TabBar)
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final platform = Theme.of(context).platform;

    // Build action items
    final List<Widget> allActions = _buildActionItems(context, theme);

    if (platform == TargetPlatform.iOS) {
      return CupertinoSliverNavigationBar(
        largeTitle: title,
        backgroundColor: backgroundColor ?? theme.colorScheme.surface,
        border: const Border(
          bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
        ),
        leading: _buildLeadingWidget(context, theme),
        trailing: allActions.isNotEmpty
            ? Row(mainAxisSize: MainAxisSize.min, children: allActions)
            : null,
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    } else {
      return AppBar(
        title: title,
        actions: allActions,
        leading: _buildLeadingWidget(context, theme),
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle ?? false,
        backgroundColor: backgroundColor ?? theme.colorScheme.surface,
        foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
        elevation: elevation ?? theme.appBarTheme.elevation,
        systemOverlayStyle:
            systemOverlayStyle ?? theme.appBarTheme.systemOverlayStyle,
        bottom: bottom,
        titleSpacing: 0.0,
        actionsIconTheme: IconThemeData(size: 24.0),
        toolbarHeight: kToolbarHeight,
      );
    }
  }

  /// Builds the leading widget (hamburger menu or back button).
  Widget? _buildLeadingWidget(BuildContext context, ThemeData theme) {
    if (leading != null) return leading;

    if (showHamburgerMenu) {
      return Semantics(
        label: 'Open navigation menu',
        button: true,
        child: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Find the Scaffold that has a drawer (could be an ancestor)
            final scaffoldWithDrawer = context
                .findAncestorStateOfType<ScaffoldState>();
            if (scaffoldWithDrawer != null) {
              scaffoldWithDrawer.openDrawer();
            }
          },
          tooltip: 'Open navigation menu',
        ),
      );
    }

    // If not showing hamburger menu and automaticallyImplyLeading is true,
    // let the platform handle the back button automatically
    if (automaticallyImplyLeading) {
      return null; // Let the platform show the default back button
    }

    return null;
  }

  /// Builds all action items.
  List<Widget> _buildActionItems(BuildContext context, ThemeData theme) {
    final List<Widget> items = <Widget>[];

    // Add custom actions
    if (actions != null) {
      for (final action in actions!) {
        // Wrap each action in a constrained box to prevent overflow
        items.add(
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 48.0,
              maxWidth: 48.0,
              minHeight: 48.0,
              maxHeight: 48.0,
            ),
            child: action,
          ),
        );
      }
    }

    return items;
  }

  @override
  Size get preferredSize {
    // For Material AppBar, use the standard height plus bottom widget height
    // For CupertinoSliverNavigationBar, it will be handled by the sliver
    double height = kToolbarHeight;
    if (bottom != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }
}
