import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A standardized dialog function that shows a platform-adaptive dialog.
/// 
/// This utility provides a consistent way to display dialogs across the app,
/// automatically choosing between Material Design dialogs on Android and
/// Cupertino dialogs on iOS.
class AppDialog {
  /// Shows a platform-adaptive alert dialog.
  /// 
  /// [context] - The build context.
  /// [title] - The title of the dialog.
  /// [content] - The content/message of the dialog.
  /// [actions] - List of dialog actions (buttons).
  /// [barrierDismissible] - Whether the dialog can be dismissed by tapping outside.
  static Future<T?> showAlert<T>({
    required BuildContext context,
    String? title,
    String? content,
    List<DialogAction> actions = const [],
    bool barrierDismissible = true,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _showCupertinoAlert(
        context: context,
        title: title,
        content: content,
        actions: actions,
        barrierDismissible: barrierDismissible,
      );
    } else {
      return _showMaterialAlert(
        context: context,
        title: title,
        content: content,
        actions: actions,
        barrierDismissible: barrierDismissible,
      );
    }
  }

  /// Shows a platform-adaptive confirmation dialog.
  /// 
  /// [context] - The build context.
  /// [title] - The title of the dialog.
  /// [content] - The content/message of the dialog.
  /// [confirmText] - Text for the confirm button.
  /// [cancelText] - Text for the cancel button.
  /// [onConfirm] - Callback when confirm is pressed.
  /// [onCancel] - Callback when cancel is pressed.
  /// [barrierDismissible] - Whether the dialog can be dismissed by tapping outside.
  static Future<bool?> showConfirmation({
    required BuildContext context,
    String? title,
    String? content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    final actions = [
      DialogAction(
        text: cancelText,
        onPressed: () {
          Navigator.of(context).pop(false);
          onCancel?.call();
        },
        isDefaultAction: false,
      ),
      DialogAction(
        text: confirmText,
        onPressed: () {
          Navigator.of(context).pop(true);
          onConfirm?.call();
        },
        isDefaultAction: true,
      ),
    ];

    return showAlert<bool>(
      context: context,
      title: title,
      content: content,
      actions: actions,
      barrierDismissible: barrierDismissible,
    );
  }

  /// Shows a platform-adaptive loading dialog.
  /// 
  /// [context] - The build context.
  /// [message] - Optional message to display with the loader.
  /// [barrierDismissible] - Whether the dialog can be dismissed by tapping outside.
  static Future<void> showLoading({
    required BuildContext context,
    String? message,
    bool barrierDismissible = false,
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _showCupertinoLoading(
        context: context,
        message: message,
        barrierDismissible: barrierDismissible,
      );
    } else {
      return _showMaterialLoading(
        context: context,
        message: message,
        barrierDismissible: barrierDismissible,
      );
    }
  }

  /// Shows a Material Design alert dialog.
  static Future<T?> _showMaterialAlert<T>({
    required BuildContext context,
    String? title,
    String? content,
    required List<DialogAction> actions,
    required bool barrierDismissible,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: actions.map((action) => TextButton(
          onPressed: action.onPressed,
          child: Text(action.text),
        )).toList(),
      ),
    );
  }

  /// Shows a Cupertino alert dialog.
  static Future<T?> _showCupertinoAlert<T>({
    required BuildContext context,
    String? title,
    String? content,
    required List<DialogAction> actions,
    required bool barrierDismissible,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: actions.map((action) => CupertinoDialogAction(
          onPressed: action.onPressed,
          isDefaultAction: action.isDefaultAction,
          child: Text(action.text),
        )).toList(),
      ),
    );
  }

  /// Shows a Material Design loading dialog.
  static Future<void> _showMaterialLoading({
    required BuildContext context,
    String? message,
    required bool barrierDismissible,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(message),
            ],
          ],
        ),
      ),
    );
  }

  /// Shows a Cupertino loading dialog.
  static Future<void> _showCupertinoLoading({
    required BuildContext context,
    String? message,
    required bool barrierDismissible,
  }) {
    return showCupertinoDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CupertinoActivityIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(message),
            ],
          ],
        ),
      ),
    );
  }
}

/// Represents an action button in a dialog.
class DialogAction {
  /// The text to display on the button.
  final String text;

  /// The callback to execute when the button is pressed.
  final VoidCallback onPressed;

  /// Whether this is the default action (typically styled differently).
  final bool isDefaultAction;

  const DialogAction({
    required this.text,
    required this.onPressed,
    this.isDefaultAction = false,
  });
}
