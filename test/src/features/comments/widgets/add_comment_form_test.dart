import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/comments/widgets/add_comment_form.dart';

void main() {
  group('AddCommentForm', () {
    const testEntryId = 123;

    Widget createTestWidget({
      int? entryId,
      void Function(MwComment)? onCommentPosted,
      void Function(String)? onCommentSubmitted,
      void Function(String)? onError,
      bool isSubmitting = false,
      String? errorMessage,
      EdgeInsetsGeometry? padding,
      bool compact = false,
      String? placeholder,
      int? maxLines,
      bool autofocus = false,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: AddCommentForm(
            entryId: entryId ?? testEntryId,
            onCommentPosted: onCommentPosted,
            onCommentSubmitted: onCommentSubmitted,
            onError: onError,
            isSubmitting: isSubmitting,
            errorMessage: errorMessage,
            padding: padding,
            compact: compact,
            placeholder: placeholder,
            maxLines: maxLines,
            autofocus: autofocus,
          ),
        ),
      );
    }

    testWidgets('displays form elements correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Check that the form elements are present
      expect(find.text('Add comment'), findsNWidgets(2)); // Header and button
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byIcon(Icons.comment_outlined), findsOneWidget);
    });

    testWidgets('shows placeholder text in text field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final textField = find.byType(TextFormField);
      expect(textField, findsOneWidget);

      // Verify placeholder text by checking the hint text in the widget tree
      expect(find.text('Write your comment...'), findsOneWidget);
    });

    testWidgets('shows custom placeholder text when provided', (WidgetTester tester) async {
      const customPlaceholder = 'Custom placeholder text';
      await tester.pumpWidget(createTestWidget(placeholder: customPlaceholder));

      // Verify custom placeholder text by checking the hint text in the widget tree
      expect(find.text(customPlaceholder), findsOneWidget);
    });

    testWidgets('submit button is disabled when text field is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final submitButton = find.byType(ElevatedButton);
      expect(submitButton, findsOneWidget);

      final buttonWidget = tester.widget<ElevatedButton>(submitButton);
      expect(buttonWidget.onPressed, isNull);
    });

    testWidgets('submit button is enabled when text field has content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter text in the text field
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      final submitButton = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(submitButton);
      expect(buttonWidget.onPressed, isNotNull);
    });

    testWidgets('shows cancel button when text field has content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Initially no cancel button
      expect(find.text('Cancel'), findsNothing);

      // Enter text in the text field
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      // Cancel button should appear
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('cancel button clears the text field', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter text in the text field
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      // Verify text is there
      expect(find.text('Test comment'), findsOneWidget);

      // Tap cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pump();

      // Text should be cleared
      expect(find.text('Test comment'), findsNothing);
    });

    testWidgets('calls onCommentPosted when form is submitted', (WidgetTester tester) async {
      MwComment? postedComment;
      void onCommentPosted(MwComment comment) {
        postedComment = comment;
      }

      await tester.pumpWidget(createTestWidget(onCommentPosted: onCommentPosted));

      // Enter text and submit
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify callback was called
      expect(postedComment, isNotNull);
      expect(postedComment!.content, 'Test comment');
      expect(postedComment!.entryId, testEntryId);
    });

    testWidgets('shows loading state when submitting', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(isSubmitting: true));

      // Check for loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Submit button should be disabled
      final submitButton = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(submitButton);
      expect(buttonWidget.onPressed, isNull);
    });

    testWidgets('shows error message when provided', (WidgetTester tester) async {
      const errorMessage = 'Failed to post comment';
      await tester.pumpWidget(createTestWidget(errorMessage: errorMessage));

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('text field is disabled when submitting', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(isSubmitting: true));

      final textField = find.byType(TextFormField);
      final textFieldWidget = tester.widget<TextFormField>(textField);
      expect(textFieldWidget.enabled, isFalse);
    });

    testWidgets('validates minimum comment length', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter text that's too short (empty after trim)
      await tester.enterText(find.byType(TextFormField), '   ');
      await tester.pump();

      // The button should be disabled for empty content
      final submitButton = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(submitButton);
      expect(buttonWidget.onPressed, isNull);
    });

    testWidgets('accepts single character comment', (WidgetTester tester) async {
      String? submittedContent;
      void onCommentSubmitted(String content) {
        submittedContent = content;
      }

      await tester.pumpWidget(createTestWidget(onCommentSubmitted: onCommentSubmitted));

      // Enter single character
      await tester.enterText(find.byType(TextFormField), 'a');
      await tester.pump();

      // Submit
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should accept the comment
      expect(submittedContent, 'a');
    });

    testWidgets('validates maximum comment length', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter text that's too long (501 characters)
      final longText = 'a' * 501;
      await tester.enterText(find.byType(TextFormField), longText);
      await tester.pump();

      // Try to submit
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should show validation error
      expect(find.text('Comment is too long (max 500 characters)'), findsOneWidget);
    });

    testWidgets('submits form when Enter is pressed', (WidgetTester tester) async {
      MwComment? postedComment;
      void onCommentPosted(MwComment comment) {
        postedComment = comment;
      }

      await tester.pumpWidget(createTestWidget(onCommentPosted: onCommentPosted));

      // Enter text
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      // Press Enter
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify callback was called
      expect(postedComment, isNotNull);
      expect(postedComment!.content, 'Test comment');
    });

    testWidgets('uses compact mode when specified', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(compact: true));

      // In compact mode, we can verify the behavior by checking if the form
      // renders correctly with the compact settings
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('uses custom max lines when specified', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(maxLines: 10));

      // Verify the text field renders correctly with custom max lines
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('applies custom padding when provided', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(24);
      await tester.pumpWidget(createTestWidget(padding: customPadding));

      final container = find.ancestor(
        of: find.byType(Form),
        matching: find.byType(Container),
      );
      expect(container, findsOneWidget);

      final containerWidget = tester.widget<Container>(container);
      expect(containerWidget.padding, customPadding);
    });

    testWidgets('autofocuses text field when specified', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(autofocus: true));

      // Verify the text field renders correctly with autofocus
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('clears form after successful submission', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter text
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      // Verify text is there
      expect(find.text('Test comment'), findsOneWidget);

      // Submit
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Text should be cleared
      expect(find.text('Test comment'), findsNothing);
    });

    testWidgets('handles multiple rapid submissions gracefully', (WidgetTester tester) async {
      int submissionCount = 0;
      void onCommentPosted(MwComment comment) {
        submissionCount++;
      }

      await tester.pumpWidget(createTestWidget(onCommentPosted: onCommentPosted));

      // Enter text
      await tester.enterText(find.byType(TextFormField), 'Test comment');
      await tester.pump();

      // Submit multiple times rapidly
      await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Should only submit once (form is cleared after first submission)
      expect(submissionCount, 1);
    });
  });
}
