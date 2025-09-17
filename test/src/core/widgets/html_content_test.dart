import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/core/widgets/html_content.dart';

void main() {
  group('HtmlContent', () {
    testWidgets('renders plain text correctly', (WidgetTester tester) async {
      const plainText = 'Hello, world!';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HtmlContent(html: plainText)),
        ),
      );

      expect(find.text('Hello, world!'), findsOneWidget);
    });

    testWidgets('renders HTML content correctly', (WidgetTester tester) async {
      const htmlText = '<p>Hello, <strong>world</strong>!</p>';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HtmlContent(html: htmlText)),
        ),
      );

      expect(find.text('Hello, world!'), findsOneWidget);
    });

    testWidgets('renders with custom text style', (WidgetTester tester) async {
      const htmlText = '<p>Styled text</p>';
      const customStyle = TextStyle(fontSize: 20, color: Colors.red);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HtmlContent(html: htmlText, textStyle: customStyle),
          ),
        ),
      );

      expect(find.text('Styled text'), findsOneWidget);
    });

    testWidgets('handles empty HTML content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: HtmlContent(html: '')),
        ),
      );

      // Should not crash and render empty content
      expect(find.byType(HtmlContent), findsOneWidget);
    });
  });
}
