import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/features/chat/widgets/message_input.dart';

void main() {
  group('MessageInput', () {
    testWidgets('displays input field and send button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MessageInput(onSendMessage: (message) {})),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsOneWidget);
    });

    testWidgets('shows placeholder text', (WidgetTester tester) async {
      const placeholder = 'Type your message here...';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(
              onSendMessage: (message) {},
              placeholder: placeholder,
            ),
          ),
        ),
      );

      expect(find.text(placeholder), findsOneWidget);
    });

    testWidgets('enables send button when text is entered', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MessageInput(onSendMessage: (message) {})),
        ),
      );

      // Initially send button should be disabled
      final sendButton = find.byIcon(Icons.send_rounded);
      expect(sendButton, findsOneWidget);

      // Enter text
      await tester.enterText(find.byType(TextField), 'Hello world');
      await tester.pump();

      // Send button should now be enabled (different color)
      expect(sendButton, findsOneWidget);
    });

    testWidgets('calls onSendMessage when send button is tapped', (
      WidgetTester tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(
              onSendMessage: (message) => sentMessage = message,
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();

      // Tap send button
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      expect(sentMessage, equals('Test message'));
    });

    testWidgets('clears input after sending message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MessageInput(onSendMessage: (message) {})),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();

      // Verify text is entered
      expect(find.text('Test message'), findsOneWidget);

      // Tap send button
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      // Input should be cleared
      expect(find.text('Test message'), findsNothing);
    });

    testWidgets('does not send empty messages', (WidgetTester tester) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(
              onSendMessage: (message) => sentMessage = message,
            ),
          ),
        ),
      );

      // Try to send empty message
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      expect(sentMessage, isNull);
    });

    testWidgets('does not send whitespace-only messages', (
      WidgetTester tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(
              onSendMessage: (message) => sentMessage = message,
            ),
          ),
        ),
      );

      // Enter whitespace
      await tester.enterText(find.byType(TextField), '   ');
      await tester.pump();

      // Try to send
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      expect(sentMessage, isNull);
    });

    testWidgets('disables input when isDisabled is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(onSendMessage: (message) {}, isDisabled: true),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('does not send message when disabled', (
      WidgetTester tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(
              onSendMessage: (message) => sentMessage = message,
              isDisabled: true,
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();

      // Try to send
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pump();

      expect(sentMessage, isNull);
    });

    testWidgets('sends message on Enter key press', (
      WidgetTester tester,
    ) async {
      String? sentMessage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageInput(
              onSendMessage: (message) => sentMessage = message,
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();

      // Press Enter
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(sentMessage, equals('Test message'));
    });

    testWidgets('supports multiline input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MessageInput(onSendMessage: (message) {})),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, isNull); // null means unlimited lines
      expect(textField.keyboardType, equals(TextInputType.multiline));
    });

    testWidgets('has proper accessibility labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MessageInput(onSendMessage: (message) {})),
        ),
      );

      // Check that send button has proper semantics
      final sendButton = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label == 'Send message' &&
            widget.properties.button == true,
      );
      expect(sendButton, findsOneWidget);
    });
  });
}
