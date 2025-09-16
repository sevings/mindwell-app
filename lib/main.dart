import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'src/app.dart';

/// Main entry point of the Mindwell application.
///
/// Initializes necessary services and runs the main application widget.
void main() async {
  // Configure logging for debug mode
  _configureLogging();

  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize Flutter Secure Storage
  // This will be used later for storing authentication tokens
  const FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Run the application with ProviderScope for state management
  runApp(const ProviderScope(child: MindWellApp()));
}

/// Configures logging to output to console in debug mode.
void _configureLogging() {
  // Only enable logging in debug mode
  if (kDebugMode) {
    // Set the root logger level to ALL to capture all log messages
    Logger.root.level = Level.ALL;

    // Add a console handler to output logs to the console
    Logger.root.onRecord.listen((record) {
      // Format the log message with timestamp, level, logger name, and message
      final timestamp = DateTime.now().toIso8601String();
      final level = record.level.name.padRight(7);
      final loggerName = record.loggerName;
      final message = record.message;

      // Use different colors for different log levels (if supported by terminal)
      String levelColor = '';
      String resetColor = '';

      switch (record.level) {
        case Level.SEVERE:
          levelColor = '\x1B[31m'; // Red
          break;
        case Level.WARNING:
          levelColor = '\x1B[33m'; // Yellow
          break;
        case Level.INFO:
          levelColor = '\x1B[32m'; // Green
          break;
        case Level.CONFIG:
          levelColor = '\x1B[36m'; // Cyan
          break;
        case Level.FINE:
        case Level.FINER:
        case Level.FINEST:
          levelColor = '\x1B[37m'; // White
          break;
        default:
          levelColor = '\x1B[0m'; // Reset
      }

      // Print the formatted log message
      // ignore: avoid_print
      print('$levelColor[$timestamp] $level [$loggerName] $message$resetColor');

      // Also print the error/stack trace if present
      if (record.error != null) {
        // ignore: avoid_print
        print('$levelColor  Error: ${record.error}$resetColor');
      }
      if (record.stackTrace != null) {
        // ignore: avoid_print
        print('$levelColor  Stack trace: ${record.stackTrace}$resetColor');
      }
    });
  }
}
