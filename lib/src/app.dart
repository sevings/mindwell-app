import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../l10n/app_localizations.dart';
import 'core/theme/mindwell_theme.dart';
import 'core/router/app_router.dart';
import 'features/auth/providers/auth_provider.dart';

/// Main application widget for Mindwell.
/// 
/// Configures the MaterialApp with themes, localization, and routing.
class MindWellApp extends ConsumerStatefulWidget {
  const MindWellApp({super.key});

  @override
  ConsumerState<MindWellApp> createState() => _MindWellAppState();
}

class _MindWellAppState extends ConsumerState<MindWellApp> {
  @override
  void initState() {
    super.initState();
    // Check authentication status when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).checkAuthStatus();
    });
  }

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
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
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

