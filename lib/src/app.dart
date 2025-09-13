import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/mindwell_theme.dart';

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
      routerConfig: _router,
    );
  }
}

/// Router configuration for the application.
/// 
/// Currently includes a basic home route placeholder.
/// This will be expanded in Task 3 with proper navigation structure.
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const _HomePlaceholder(),
    ),
  ],
);

/// Placeholder home screen widget.
/// 
/// This is a temporary implementation that will be replaced
/// with the proper HomeScreen in Task 3.
class _HomePlaceholder extends StatelessWidget {
  const _HomePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindwell'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology,
              size: 64,
              color: Color(0xFFFF5E3A),
            ),
            SizedBox(height: 16),
            Text(
              'Welcome to Mindwell',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your mindful journaling companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'App structure is being set up...',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
