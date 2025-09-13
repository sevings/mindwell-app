import 'package:flutter/material.dart';

/// A utility class for showing styled SnackBar messages.
/// 
/// This utility provides consistent styling and behavior for displaying
/// feedback messages to users across the application.
class SnackbarUtils {
  /// Shows a success message with green styling.
  /// 
  /// [context] - The build context.
  /// [message] - The message to display.
  /// [duration] - How long to show the message.
  /// [action] - Optional action button.
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      icon: Icons.check_circle,
      duration: duration,
      action: action,
    );
  }

  /// Shows an error message with red styling.
  /// 
  /// [context] - The build context.
  /// [message] - The message to display.
  /// [duration] - How long to show the message.
  /// [action] - Optional action button.
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      icon: Icons.error,
      duration: duration,
      action: action,
    );
  }

  /// Shows an info message with blue styling.
  /// 
  /// [context] - The build context.
  /// [message] - The message to display.
  /// [duration] - How long to show the message.
  /// [action] - Optional action button.
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      icon: Icons.info,
      duration: duration,
      action: action,
    );
  }

  /// Shows a warning message with orange styling.
  /// 
  /// [context] - The build context.
  /// [message] - The message to display.
  /// [duration] - How long to show the message.
  /// [action] - Optional action button.
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      icon: Icons.warning,
      duration: duration,
      action: action,
    );
  }

  /// Shows a custom message with specified styling.
  /// 
  /// [context] - The build context.
  /// [message] - The message to display.
  /// [backgroundColor] - The background color of the snackbar.
  /// [textColor] - The text color of the message.
  /// [icon] - Optional icon to display.
  /// [duration] - How long to show the message.
  /// [action] - Optional action button.
  static void showCustom({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
      action: action,
    );
  }

  /// Internal method to show a styled snackbar.
  static void _showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    // Hide any existing snackbars
    scaffoldMessenger.clearSnackBars();

    final snackBar = SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: textColor,
              size: 20,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      action: action,
    );

    scaffoldMessenger.showSnackBar(snackBar);
  }

  /// Shows a platform-adaptive toast message.
  /// 
  /// On iOS, this will show a Cupertino-style toast.
  /// On Android, this will show a Material Design snackbar.
  static void showToast({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      _showCupertinoToast(
        context: context,
        message: message,
        duration: duration,
      );
    } else {
      showInfo(
        context: context,
        message: message,
        duration: duration,
      );
    }
  }

  /// Shows a Cupertino-style toast message.
  static void _showCupertinoToast({
    required BuildContext context,
    required String message,
    required Duration duration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 50,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the overlay after the specified duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
