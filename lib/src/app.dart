import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/mindwell_theme.dart';
import 'core/router/app_router.dart';

/// Main application widget for Mindwell.
/// 
/// Configures the MaterialApp with themes, localization, and routing.
class MindWellApp extends StatelessWidget {
  const MindWellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mindwell',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: MindwellTheme.lightTheme,
      darkTheme: MindwellTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      // Localization configuration
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''), // Russian (default)
        Locale('en', ''), // English
      ],
      locale: const Locale('ru', ''), // Default to Russian
      
      // Router configuration
      routerConfig: AppRouter.router,
    );
  }
}

