import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A platform-adaptive settings tile widget that renders a ListTile on Android
/// and a CupertinoListTile on iOS.
///
/// This widget adapts its appearance based on the current platform to provide
/// a native look and feel on both Android and iOS platforms.
///
/// ## Usage Examples:
///
/// ```dart
/// // Basic tile with title and navigation
/// SettingsTile(
///   title: 'Account Settings',
///   onTap: () => context.go('/settings/account'),
/// )
///
/// // Tile with subtitle and icon
/// SettingsTile(
///   title: 'Notifications',
///   subtitle: 'Manage your notification preferences',
///   leading: Icon(Icons.notifications_outlined),
///   onTap: () => context.go('/settings/notifications'),
/// )
///
/// // Tile with switch control
/// SettingsTile(
///   title: 'Email Notifications',
///   trailing: Switch(
///     value: emailNotificationsEnabled,
///     onChanged: (value) => setState(() => emailNotificationsEnabled = value),
///   ),
/// )
/// ```
class SettingsTile extends StatelessWidget {
  /// The title text displayed in the tile
  final String title;

  /// Optional subtitle text displayed below the title
  final String? subtitle;

  /// Optional leading widget (typically an icon)
  final Widget? leading;

  /// Optional trailing widget (typically a switch, chevron, or other control)
  final Widget? trailing;

  /// Callback when the tile is tapped
  final VoidCallback? onTap;

  /// Whether the tile is enabled (affects tap behavior and visual appearance)
  final bool enabled;

  /// Whether to show a chevron indicating navigation
  final bool showChevron;

  /// Custom text style for the title
  final TextStyle? titleStyle;

  /// Custom text style for the subtitle
  final TextStyle? subtitleStyle;

  /// Custom color for the leading icon
  final Color? leadingIconColor;

  /// Custom color for the trailing icon
  final Color? trailingIconColor;

  /// Whether to show a divider below the tile
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.showChevron = true,
    this.titleStyle,
    this.subtitleStyle,
    this.leadingIconColor,
    this.trailingIconColor,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final platform = theme.platform;

    if (platform == TargetPlatform.iOS) {
      return _buildCupertinoTile(context, theme);
    } else {
      return _buildMaterialTile(context, theme);
    }
  }

  /// Builds the Cupertino (iOS) version of the tile
  Widget _buildCupertinoTile(BuildContext context, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: CupertinoColors.separator.resolveFrom(context),
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: CupertinoListTile(
        title: Text(
          title,
          style:
              titleStyle ??
              TextStyle(
                color: enabled
                    ? CupertinoColors.label.resolveFrom(context)
                    : CupertinoColors.placeholderText.resolveFrom(context),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style:
                    subtitleStyle ??
                    TextStyle(
                      color: enabled
                          ? CupertinoColors.secondaryLabel.resolveFrom(context)
                          : CupertinoColors.placeholderText.resolveFrom(
                              context,
                            ),
                      fontSize: 13,
                    ),
              )
            : null,
        leading: leading != null
            ? IconTheme(
                data: IconThemeData(
                  color:
                      leadingIconColor ??
                      (enabled
                          ? CupertinoColors.systemBlue.resolveFrom(context)
                          : CupertinoColors.placeholderText.resolveFrom(
                              context,
                            )),
                  size: 22,
                ),
                child: leading!,
              )
            : null,
        trailing: _buildTrailingWidget(context, theme),
        onTap: enabled ? onTap : null,
      ),
    );
  }

  /// Builds the Material (Android) version of the tile
  Widget _buildMaterialTile(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              title,
              style:
                  titleStyle ??
                  theme.textTheme.titleMedium?.copyWith(
                    color: enabled
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.38),
                  ),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style:
                        subtitleStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
                          color: enabled
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onSurface.withValues(alpha: 0.38),
                        ),
                  )
                : null,
            leading: leading != null
                ? IconTheme(
                    data: IconThemeData(
                      color:
                          leadingIconColor ??
                          (enabled
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.38)),
                      size: 24,
                    ),
                    child: leading!,
                  )
                : null,
            trailing: _buildTrailingWidget(context, theme),
            onTap: enabled ? onTap : null,
            enabled: enabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              color: colorScheme.outline.withValues(alpha: 0.12),
              indent: leading != null ? 56 : 16,
              endIndent: 16,
            ),
        ],
      ),
    );
  }

  /// Builds the trailing widget with platform-appropriate styling
  Widget _buildTrailingWidget(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final platform = theme.platform;

    // If trailing widget is provided, use it
    if (trailing != null) {
      return trailing!;
    }

    // If onTap is provided and chevron should be shown, show navigation chevron
    if (onTap != null && showChevron && enabled) {
      if (platform == TargetPlatform.iOS) {
        return Icon(
          CupertinoIcons.chevron_right,
          size: 18,
          color: CupertinoColors.tertiaryLabel.resolveFrom(context),
        );
      } else {
        return Icon(
          Icons.chevron_right,
          size: 24,
          color: colorScheme.onSurfaceVariant,
        );
      }
    }

    // No trailing widget
    return const SizedBox.shrink();
  }
}
