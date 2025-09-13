import 'package:flutter/material.dart';

/// Main home screen that serves as the shell for authenticated users.
/// 
/// This screen contains the main scaffold structure that will hold
/// the PlatformAppBar, BottomNavBar, and NavDrawer in subsequent tasks.
/// Currently, it provides a basic scaffold with the child content.
class HomeScreen extends StatelessWidget {
  /// Creates a HomeScreen widget.
  /// 
  /// The [child] parameter represents the content that will be displayed
  /// within the scaffold, typically the result of navigation.
  const HomeScreen({
    super.key,
    required this.child,
  });

  /// The child widget to display within the scaffold.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar will be added in Task 4
      appBar: AppBar(
        title: const Text('Mindwell'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
      ),
      
      // Main content area
      body: child,
      
      // Bottom navigation bar will be added in Task 4
      bottomNavigationBar: null,
      
      // Navigation drawer will be added in Task 4
      drawer: null,
      
      // Floating action button will be added in future tasks
      floatingActionButton: null,
    );
  }
}
