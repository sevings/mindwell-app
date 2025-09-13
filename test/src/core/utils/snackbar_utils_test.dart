import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/utils/snackbar_utils.dart';

void main() {
  group('SnackbarUtils', () {
    testWidgets('showSuccess displays success snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showSuccess(
                  context: context,
                  message: 'Success message',
                ),
                child: const Text('Show Success'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('showError displays error snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showError(
                  context: context,
                  message: 'Error message',
                ),
                child: const Text('Show Error'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('showInfo displays info snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showInfo(
                  context: context,
                  message: 'Info message',
                ),
                child: const Text('Show Info'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Info'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('showWarning displays warning snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showWarning(
                  context: context,
                  message: 'Warning message',
                ),
                child: const Text('Show Warning'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Warning'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('showCustom displays custom snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showCustom(
                  context: context,
                  message: 'Custom message',
                  backgroundColor: Colors.purple,
                  textColor: Colors.white,
                  icon: Icons.star,
                ),
                child: const Text('Show Custom'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Custom'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Custom message'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('showCustom without icon displays snackbar without icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showCustom(
                  context: context,
                  message: 'Custom message',
                  backgroundColor: Colors.purple,
                  textColor: Colors.white,
                ),
                child: const Text('Show Custom'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Custom'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Custom message'), findsOneWidget);
    });

    testWidgets('showSuccess with action displays snackbar with action', (WidgetTester tester) async {
      bool actionPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showSuccess(
                  context: context,
                  message: 'Success message',
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => actionPressed = true,
                  ),
                ),
                child: const Text('Show Success'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);
      
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      
      expect(actionPressed, isTrue);
    });

    testWidgets('showToast shows Material snackbar on Android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showToast(
                  context: context,
                  message: 'Toast message',
                ),
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Toast message'), findsOneWidget);
    });

    testWidgets('showToast shows Cupertino toast on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            platform: TargetPlatform.iOS,
          ),
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showToast(
                  context: context,
                  message: 'Toast message',
                ),
                child: const Text('Show Toast'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pumpAndSettle();

      // On iOS, it should show an overlay instead of a snackbar
      expect(find.byType(Overlay), findsOneWidget);
      expect(find.text('Toast message'), findsOneWidget);
      
      // Wait for the timer to complete to avoid pending timer issues
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('snackbar has correct styling properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showSuccess(
                  context: context,
                  message: 'Success message',
                ),
                child: const Text('Show Success'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Success'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.behavior, SnackBarBehavior.floating);
      expect(snackBar.duration, const Duration(seconds: 3));
      expect(snackBar.backgroundColor, Colors.green);
    });

    testWidgets('error snackbar has longer duration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showError(
                  context: context,
                  message: 'Error message',
                ),
                child: const Text('Show Error'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Error'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.duration, const Duration(seconds: 4));
    });

    testWidgets('custom snackbar with custom duration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => SnackbarUtils.showCustom(
                  context: context,
                  message: 'Custom message',
                  backgroundColor: Colors.purple,
                  textColor: Colors.white,
                  duration: const Duration(seconds: 5),
                ),
                child: const Text('Show Custom'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Custom'));
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.duration, const Duration(seconds: 5));
    });
  });
}
