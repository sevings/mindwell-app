import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/features/entries/screens/image_gallery_screen.dart';

void main() {
  group('ImageGalleryScreen', () {
    testWidgets('creates ImageGalleryScreen widget', (WidgetTester tester) async {
      // Test that the widget can be created without crashing
      final widget = ImageGalleryScreen(
        images: [],
        initialIndex: 0,
        title: 'Test Gallery',
      );
      
      expect(widget, isA<ImageGalleryScreen>());
      expect(widget.images, isEmpty);
      expect(widget.initialIndex, equals(0));
      expect(widget.title, equals('Test Gallery'));
    });

  });
}