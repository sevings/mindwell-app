import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'settings_tile.dart';

/// A platform-adaptive settings section widget that groups SettingsTile widgets
/// under a common header with platform-appropriate styling.
///
/// This widget adapts its appearance based on the current platform to provide
/// a native look and feel on both Android and iOS platforms.
///
/// ## Usage Examples:
///
/// ```dart
/// // Basic section with title and tiles
/// SettingsSection(
///   title: 'Account',
///   children: [
///     SettingsTile(
///       title: 'Change Password',
///       onTap: () => context.go('/settings/change-password'),
///     ),
///     SettingsTile(
///       title: 'Change Email',
///       onTap: () => context.go('/settings/change-email'),
///     ),
///   ],
/// )
///
/// // Section with subtitle and custom styling
/// SettingsSection(
///   title: 'Notifications',
///   subtitle: 'Manage how you receive notifications',
///   children: [
///     SettingsTile(
///       title: 'Email Notifications',
///       trailing: Switch(value: true, onChanged: (v) {}),
///     ),
///     SettingsTile(
///       title: 'Push Notifications',
///       trailing: Switch(value: false, onChanged: (v) {}),
///     ),
///   ],
/// )
/// ```
class SettingsSection extends StatelessWidget {
  /// The title displayed in the section header
  final String title;

  /// Optional subtitle displayed below the title in the section header
  final String? subtitle;

  /// The list of SettingsTile widgets to display in this section
  final List<SettingsTile> children;

  /// Custom text style for the section title
  final TextStyle? titleStyle;

  /// Custom text style for the section subtitle
  final TextStyle? subtitleStyle;

  /// Custom color for the section header
  final Color? headerColor;

  /// Whether to show a divider after the section
  final bool showDivider;

  /// Padding around the section content
  final EdgeInsetsGeometry? contentPadding;

  /// Whether to add extra spacing between tiles
  final bool addSpacingBetweenTiles;

  /// Custom spacing between tiles (only used if addSpacingBetweenTiles is true)
  final double tileSpacing;

  const SettingsSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.titleStyle,
    this.subtitleStyle,
    this.headerColor,
    this.showDivider = false,
    this.contentPadding,
    this.addSpacingBetweenTiles = false,
    this.tileSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final platform = theme.platform;

    if (platform == TargetPlatform.iOS) {
      return _buildCupertinoSection(context, theme);
    } else {
      return _buildMaterialSection(context, theme);
    }
  }

  /// Builds the Cupertino (iOS) version of the section
  Widget _buildCupertinoSection(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          _buildCupertinoHeader(context, theme),

          // Section content
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: CupertinoColors.separator.resolveFrom(context),
                width: 0.5,
              ),
            ),
            child: Column(children: _buildCupertinoTiles(context, theme)),
          ),

          // Optional divider
          if (showDivider) _buildCupertinoDivider(context, theme),
        ],
      ),
    );
  }

  /// Builds the Material (Android) version of the section
  Widget _buildMaterialSection(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          _buildMaterialHeader(context, theme),

          // Section content
          Card(
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.12),
                width: 1,
              ),
            ),
            child: Column(children: _buildMaterialTiles(context, theme)),
          ),

          // Optional divider
          if (showDivider) _buildMaterialDivider(context, theme),
        ],
      ),
    );
  }

  /// Builds the Cupertino section header
  Widget _buildCupertinoHeader(BuildContext context, ThemeData theme) {
    return Padding(
      padding: contentPadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                titleStyle ??
                TextStyle(
                  color:
                      headerColor ?? CupertinoColors.label.resolveFrom(context),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.08,
                ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style:
                  subtitleStyle ??
                  TextStyle(
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  /// Builds the Material section header
  Widget _buildMaterialHeader(BuildContext context, ThemeData theme) {
    return Padding(
      padding: contentPadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                titleStyle ??
                theme.textTheme.titleSmall?.copyWith(
                  color: headerColor ?? theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style:
                  subtitleStyle ??
                  theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  /// Builds the list of Cupertino tiles
  List<Widget> _buildCupertinoTiles(BuildContext context, ThemeData theme) {
    final List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      final tile = children[i];
      widgets.add(tile);

      // Add spacing between tiles if requested and not the last tile
      if (addSpacingBetweenTiles && i < children.length - 1) {
        widgets.add(SizedBox(height: tileSpacing));
      }
    }

    return widgets;
  }

  /// Builds the list of Material tiles
  List<Widget> _buildMaterialTiles(BuildContext context, ThemeData theme) {
    final List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      final tile = children[i];

      // For Material design, we want to show dividers between tiles
      // except for the last one
      final showDivider = i < children.length - 1;

      widgets.add(
        SettingsTile(
          title: tile.title,
          subtitle: tile.subtitle,
          leading: tile.leading,
          trailing: tile.trailing,
          onTap: tile.onTap,
          enabled: tile.enabled,
          showChevron: tile.showChevron,
          titleStyle: tile.titleStyle,
          subtitleStyle: tile.subtitleStyle,
          leadingIconColor: tile.leadingIconColor,
          trailingIconColor: tile.trailingIconColor,
          showDivider: showDivider,
        ),
      );

      // Add spacing between tiles if requested and not the last tile
      if (addSpacingBetweenTiles && i < children.length - 1) {
        widgets.add(SizedBox(height: tileSpacing));
      }
    }

    return widgets;
  }

  /// Builds the Cupertino divider
  Widget _buildCupertinoDivider(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 0.5,
      color: CupertinoColors.separator.resolveFrom(context),
    );
  }

  /// Builds the Material divider
  Widget _buildMaterialDivider(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.colorScheme.outline.withValues(alpha: 0.12),
      ),
    );
  }
}
