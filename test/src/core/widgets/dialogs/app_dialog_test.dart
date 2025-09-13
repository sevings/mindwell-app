import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/core/widgets/dialogs/app_dialog.dart';

void main() {
  group('AppDialog', () {
    testWidgets('showAlert shows Material dialog on Android', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showAlert(
                  context: context,
                  title: 'Test Title',
                  content: 'Test Content',
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('showAlert shows Cupertino dialog on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            platform: TargetPlatform.iOS,
          ),
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showAlert(
                  context: context,
                  title: 'Test Title',
                  content: 'Test Content',
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('showAlert with actions shows buttons', (WidgetTester tester) async {
      bool actionPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showAlert(
                  context: context,
                  title: 'Test Title',
                  content: 'Test Content',
                  actions: [
                    DialogAction(
                      text: 'OK',
                      onPressed: () {
                        actionPressed = true;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
      
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      
      expect(actionPressed, isTrue);
    });

    testWidgets('showConfirmation shows confirm and cancel buttons', (WidgetTester tester) async {
      bool confirmPressed = false;
      bool cancelPressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showConfirmation(
                  context: context,
                  title: 'Confirm Action',
                  content: 'Are you sure?',
                  onConfirm: () => confirmPressed = true,
                  onCancel: () => cancelPressed = true,
                ),
                child: const Text('Show Confirmation'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Confirmation'));
      await tester.pumpAndSettle();

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
      
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      
      expect(cancelPressed, isTrue);
      expect(confirmPressed, isFalse);
    });

    testWidgets('showConfirmation with custom button text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showConfirmation(
                  context: context,
                  title: 'Delete Item',
                  content: 'This action cannot be undone.',
                  confirmText: 'Delete',
                  cancelText: 'Keep',
                ),
                child: const Text('Show Confirmation'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Confirmation'));
      await tester.pumpAndSettle();

      expect(find.text('Keep'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('showLoading shows Material loading dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showLoading(
                  context: context,
                  message: 'Loading...',
                ),
                child: const Text('Show Loading'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Loading'));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('showLoading shows Cupertino loading dialog on iOS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            platform: TargetPlatform.iOS,
          ),
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showLoading(
                  context: context,
                  message: 'Loading...',
                ),
                child: const Text('Show Loading'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Loading'));
      await tester.pump();

      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('showLoading without message shows only indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => AppDialog.showLoading(context: context),
                child: const Text('Show Loading'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Loading'));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsNothing);
    });
  });

  group('DialogAction', () {
    test('creates dialog action with required parameters', () {
      bool pressed = false;
      final action = DialogAction(
        text: 'Test Action',
        onPressed: () => pressed = true,
      );

      expect(action.text, 'Test Action');
      expect(action.isDefaultAction, false);
      
      action.onPressed();
      expect(pressed, isTrue);
    });

    test('creates dialog action with default action flag', () {
      final action = DialogAction(
        text: 'Default Action',
        onPressed: () {},
        isDefaultAction: true,
      );

      expect(action.text, 'Default Action');
      expect(action.isDefaultAction, isTrue);
    });
  });
}
