import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A standardized text field widget that follows the Mindwell design system.
/// 
/// This widget wraps [TextFormField] and applies the consistent styling
/// defined in the application's theme system. It provides a clean API
/// for common text input scenarios with proper validation and error handling.
class StyledTextField extends StatelessWidget {
  /// Creates a styled text field.
  const StyledTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.onSaved,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.prefix,
    this.suffix,
    this.isDense = false,
    this.contentPadding,
    this.focusNode,
    this.autovalidateMode,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.style,
    this.decoration,
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.showCursor,
    this.selectionControls,
    this.onTapOutside,
    this.contextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onAppPrivateCommand,
    this.restorationId,
    this.enableInteractiveSelection,
    this.selectionEnabled,
    this.dragSelectionEnabled,
    this.mouseCursor,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.clipBehavior = Clip.hardEdge,
  });

  /// Controller for the text field
  final TextEditingController? controller;

  /// Label text for the field
  final String? label;

  /// Hint text displayed when the field is empty
  final String? hint;

  /// Helper text displayed below the field
  final String? helperText;

  /// Validator function for form validation
  final String? Function(String?)? validator;

  /// Callback when the text changes
  final ValueChanged<String>? onChanged;

  /// Callback when the user submits the field
  final ValueChanged<String>? onSubmitted;

  /// Callback when the field is tapped
  final GestureTapCallback? onTap;

  /// Callback when editing is completed
  final VoidCallback? onEditingComplete;

  /// Callback when the field is saved (for forms)
  final FormFieldSetter<String>? onSaved;

  /// Whether the text should be obscured (for passwords)
  final bool obscureText;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the field is read-only
  final bool readOnly;

  /// Whether the field should autofocus
  final bool autofocus;

  /// Maximum number of lines
  final int? maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum character length
  final int? maxLength;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Text capitalization
  final TextCapitalization textCapitalization;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Prefix icon
  final Widget? prefixIcon;

  /// Suffix icon
  final Widget? suffixIcon;

  /// Prefix text
  final String? prefixText;

  /// Suffix text
  final String? suffixText;

  /// Prefix widget
  final Widget? prefix;

  /// Suffix widget
  final Widget? suffix;

  /// Whether the field should be dense
  final bool isDense;

  /// Custom content padding
  final EdgeInsetsGeometry? contentPadding;

  /// Focus node
  final FocusNode? focusNode;

  /// Autovalidate mode
  final AutovalidateMode? autovalidateMode;

  /// Whether to enable suggestions
  final bool enableSuggestions;

  /// Whether to enable autocorrect
  final bool autocorrect;

  /// Text alignment
  final TextAlign textAlign;

  /// Text alignment vertical
  final TextAlignVertical? textAlignVertical;

  /// Text style
  final TextStyle? style;

  /// Custom decoration (overrides default styling)
  final InputDecoration? decoration;

  /// Cursor color
  final Color? cursorColor;

  /// Cursor width
  final double cursorWidth;

  /// Cursor height
  final double? cursorHeight;

  /// Cursor radius
  final Radius? cursorRadius;

  /// Whether to show cursor
  final bool? showCursor;

  /// Selection controls
  final TextSelectionControls? selectionControls;

  /// Callback when tapping outside
  final TapRegionCallback? onTapOutside;

  /// Context menu builder
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Whether the field can request focus
  final bool canRequestFocus;

  /// Spell check configuration
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Magnifier configuration
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Undo controller
  final UndoHistoryController? undoController;

  /// App private command callback
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// Restoration ID
  final String? restorationId;

  /// Whether to enable interactive selection
  final bool? enableInteractiveSelection;

  /// Whether selection is enabled
  final bool? selectionEnabled;

  /// Whether drag selection is enabled
  final bool? dragSelectionEnabled;

  /// Mouse cursor
  final MouseCursor? mouseCursor;

  /// Scroll controller
  final ScrollController? scrollController;

  /// Scroll padding
  final EdgeInsets scrollPadding;

  /// Scroll physics
  final ScrollPhysics? scrollPhysics;

  /// Clip behavior
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Build the input decoration
    final inputDecoration = _buildInputDecoration(context, theme, colorScheme);

    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      style: style ?? theme.textTheme.bodyLarge,
      decoration: inputDecoration,
      cursorColor: cursorColor ?? colorScheme.primary,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      showCursor: showCursor,
      selectionControls: selectionControls,
      onTapOutside: onTapOutside,
      contextMenuBuilder: contextMenuBuilder,
      canRequestFocus: canRequestFocus,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
      undoController: undoController,
      onAppPrivateCommand: onAppPrivateCommand,
      restorationId: restorationId,
      enableInteractiveSelection: enableInteractiveSelection,
      mouseCursor: mouseCursor,
      scrollController: scrollController,
      scrollPadding: scrollPadding,
      scrollPhysics: scrollPhysics,
      clipBehavior: clipBehavior,
    );
  }

  /// Builds the input decoration based on the provided parameters
  InputDecoration _buildInputDecoration(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    // If custom decoration is provided, use it
    if (decoration != null) {
      return decoration!;
    }

    // Build decoration from theme and parameters
    return InputDecoration(
      labelText: label,
      hintText: hint,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixText: prefixText,
      suffixText: suffixText,
      prefix: prefix,
      suffix: suffix,
      isDense: isDense,
      contentPadding: contentPadding,
      // Apply theme's input decoration theme
      filled: theme.inputDecorationTheme.filled,
      fillColor: theme.inputDecorationTheme.fillColor,
      border: theme.inputDecorationTheme.border,
      enabledBorder: theme.inputDecorationTheme.enabledBorder,
      focusedBorder: theme.inputDecorationTheme.focusedBorder,
      errorBorder: theme.inputDecorationTheme.errorBorder,
      focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
      disabledBorder: theme.inputDecorationTheme.disabledBorder,
      labelStyle: theme.inputDecorationTheme.labelStyle,
      hintStyle: theme.inputDecorationTheme.hintStyle,
      helperStyle: theme.inputDecorationTheme.helperStyle,
      errorStyle: theme.inputDecorationTheme.errorStyle,
      prefixStyle: theme.inputDecorationTheme.prefixStyle,
      suffixStyle: theme.inputDecorationTheme.suffixStyle,
      counterStyle: theme.inputDecorationTheme.counterStyle,
      floatingLabelStyle: theme.inputDecorationTheme.floatingLabelStyle,
      floatingLabelAlignment: theme.inputDecorationTheme.floatingLabelAlignment,
      floatingLabelBehavior: theme.inputDecorationTheme.floatingLabelBehavior,
      isCollapsed: theme.inputDecorationTheme.isCollapsed,
      prefixIconConstraints: theme.inputDecorationTheme.prefixIconConstraints,
      suffixIconConstraints: theme.inputDecorationTheme.suffixIconConstraints,
      alignLabelWithHint: theme.inputDecorationTheme.alignLabelWithHint,
      constraints: theme.inputDecorationTheme.constraints,
    );
  }
}

/// Extension to provide convenient factory methods for common text field types
extension StyledTextFieldExtensions on StyledTextField {
  /// Creates a password field with visibility toggle
  static StyledTextField password({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    String? helperText,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    FormFieldSetter<String>? onSaved,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    bool enableSuggestions = false,
    bool autocorrect = false,
    Widget? prefixIcon,
    bool isDense = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return StyledTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint,
      helperText: helperText,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      obscureText: true,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      textInputAction: textInputAction,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      prefixIcon: prefixIcon,
      isDense: isDense,
      contentPadding: contentPadding,
    );
  }

  /// Creates an email field with appropriate keyboard type
  static StyledTextField email({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    String? helperText,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    FormFieldSetter<String>? onSaved,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    bool enableSuggestions = true,
    bool autocorrect = true,
    Widget? prefixIcon,
    bool isDense = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return StyledTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint,
      helperText: helperText,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      prefixIcon: prefixIcon,
      isDense: isDense,
      contentPadding: contentPadding,
    );
  }

  /// Creates a multiline text field for longer content
  static StyledTextField multiline({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    String? helperText,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    FormFieldSetter<String>? onSaved,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int? maxLines,
    int? minLines,
    int? maxLength,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    bool enableSuggestions = true,
    bool autocorrect = true,
    Widget? prefixIcon,
    bool isDense = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return StyledTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint,
      helperText: helperText,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: maxLines ?? 5,
      minLines: minLines ?? 3,
      maxLength: maxLength,
      keyboardType: TextInputType.multiline,
      textInputAction: textInputAction,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      prefixIcon: prefixIcon,
      isDense: isDense,
      contentPadding: contentPadding,
    );
  }

  /// Creates a search field with search icon
  static StyledTextField search({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hint,
    String? helperText,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    FormFieldSetter<String>? onSaved,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    bool enableSuggestions = true,
    bool autocorrect = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isDense = false,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return StyledTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint ?? 'Search...',
      helperText: helperText,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      textInputAction: textInputAction ?? TextInputAction.search,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      prefixIcon: prefixIcon ?? const Icon(Icons.search),
      suffixIcon: suffixIcon,
      isDense: isDense,
      contentPadding: contentPadding,
    );
  }
}
