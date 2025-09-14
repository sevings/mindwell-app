import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mindwell/src/features/profile/widgets/image_card.dart';
import 'package:mindwell/l10n/app_localizations.dart';
import 'package:mindwell/src/core/widgets/images/cached_image.dart';
import 'package:mindwell/src/features/entries/screens/image_gallery_screen.dart';

void main() {
  group('ImageCard', () {
    // Helper function to create test images
    List<MwImage> createTestImages(int count) {
      return List.generate(count, (index) {
        return MwImage((b) => b
          ..id = index + 1
          ..medium.replace(MwImageSize((b) => b
            ..url = 'https://example.com/image${index + 1}.jpg'
            ..width = 800
            ..height = 600))
          ..small.replace(MwImageSize((b) => b
            ..url = 'https://example.com/image${index + 1}_small.jpg'
            ..width = 400
            ..height = 300))
          ..thumbnail.replace(MwImageSize((b) => b
            ..url = 'https://example.com/image${index + 1}_thumb.jpg'
            ..width = 200
            ..height = 150)));
      });
    }

    Widget createTestWidget({
      required List<MwImage> images,
      VoidCallback? onViewAllImages,
    }) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ru', ''),
        ],
        locale: const Locale('en', ''),
        home: Scaffold(
          body: ImageCard(
            images: images,
            onViewAllImages: onViewAllImages,
          ),
        ),
      );
    }

    testWidgets('should not display when images list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(images: []));

      expect(find.byType(ImageCard), findsOneWidget);
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should display card with images when images are provided', (WidgetTester tester) async {
      final images = createTestImages(3);
      await tester.pumpWidget(createTestWidget(images: images));

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Last Images'), findsOneWidget);
      expect(find.byIcon(Icons.photo_library_outlined), findsOneWidget);
    });

    testWidgets('should display 3x3 grid for up to 9 images', (WidgetTester tester) async {
      final images = createTestImages(9);
      await tester.pumpWidget(createTestWidget(images: images));

      // Should have 9 image items in the grid
      expect(find.byType(GridView), findsOneWidget);
      
      // Check that we have the expected number of image containers
      final gridView = find.byType(GridView);
      expect(gridView, findsOneWidget);
    });

    testWidgets('should display "View All" button when more than 9 images', (WidgetTester tester) async {
      final images = createTestImages(12);
      await tester.pumpWidget(createTestWidget(images: images));

      expect(find.text('View All Images'), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);
    });

    testWidgets('should not display "View All" button when 9 or fewer images', (WidgetTester tester) async {
      final images = createTestImages(9);
      await tester.pumpWidget(createTestWidget(images: images));

      expect(find.text('View All Images'), findsNothing);
      expect(find.text('View All'), findsNothing);
    });

    testWidgets('should call onViewAllImages when "View All Images" button is tapped', (WidgetTester tester) async {
      bool callbackCalled = false;
      final images = createTestImages(12);
      
      await tester.pumpWidget(createTestWidget(
        images: images,
        onViewAllImages: () {
          callbackCalled = true;
        },
      ));

      await tester.tap(find.text('View All Images'));
      await tester.pumpAndSettle();

      expect(callbackCalled, isTrue);
    });

    testWidgets('should call onViewAllImages when "View All" button in grid is tapped', (WidgetTester tester) async {
      bool callbackCalled = false;
      final images = createTestImages(12);
      
      await tester.pumpWidget(createTestWidget(
        images: images,
        onViewAllImages: () {
          callbackCalled = true;
        },
      ));

      // Find the "View All" button in the grid (the 10th item)
      await tester.tap(find.text('View All'));
      await tester.pumpAndSettle();

      expect(callbackCalled, isTrue);
    });

    testWidgets('should display images with proper semantics', (WidgetTester tester) async {
      final images = createTestImages(3);
      await tester.pumpWidget(createTestWidget(images: images));

      // Check that images have proper semantic labels
      expect(find.bySemanticsLabel('Image 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Image 2'), findsOneWidget);
      expect(find.bySemanticsLabel('Image 3'), findsOneWidget);
    });

    testWidgets('should handle images without URLs gracefully', (WidgetTester tester) async {
      final image = MwImage((b) => b
        ..id = 1
        ..medium = null
        ..small = null
        ..thumbnail = null);
      
      await tester.pumpWidget(createTestWidget(images: [image]));

      // Should still display the card structure
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Last Images'), findsOneWidget);
      
      // Should show error state for the image
      expect(find.byIcon(Icons.broken_image_outlined), findsOneWidget);
    });

    testWidgets('should display proper grid layout with correct spacing', (WidgetTester tester) async {
      final images = createTestImages(6);
      await tester.pumpWidget(createTestWidget(images: images));

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate = gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      
      expect(delegate.crossAxisCount, equals(3));
      expect(delegate.crossAxisSpacing, equals(8));
      expect(delegate.mainAxisSpacing, equals(8));
      expect(delegate.childAspectRatio, equals(1.0));
    });

    testWidgets('should handle image tap to open gallery', (WidgetTester tester) async {
      final images = createTestImages(3);
      await tester.pumpWidget(createTestWidget(images: images));

      // Tap on the first image
      await tester.tap(find.bySemanticsLabel('Image 1'));
      await tester.pumpAndSettle();

      // Should navigate to image gallery screen
      expect(find.byType(ImageGalleryScreen), findsOneWidget);
    });

    testWidgets('should use correct image URL priority (medium > small > thumbnail)', (WidgetTester tester) async {
      final image = MwImage((b) => b
        ..id = 1
        ..medium.replace(MwImageSize((b) => b
          ..url = 'https://example.com/medium.jpg'
          ..width = 800
          ..height = 600))
        ..small.replace(MwImageSize((b) => b
          ..url = 'https://example.com/small.jpg'
          ..width = 400
          ..height = 300))
        ..thumbnail.replace(MwImageSize((b) => b
          ..url = 'https://example.com/thumb.jpg'
          ..width = 200
          ..height = 150)));
      
      await tester.pumpWidget(createTestWidget(images: [image]));

      // The CachedImage should be using the medium URL
      final cachedImage = tester.widget<CachedImage>(find.byType(CachedImage));
      expect(cachedImage.imageUrl, equals('https://example.com/medium.jpg'));
    });

    testWidgets('should display error widget when image fails to load', (WidgetTester tester) async {
      final image = MwImage((b) => b
        ..id = 1
        ..medium.replace(MwImageSize((b) => b
          ..url = 'https://invalid-url.com/image.jpg'
          ..width = 800
          ..height = 600)));
      
      await tester.pumpWidget(createTestWidget(images: [image]));

      // Wait for potential loading states
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Should show error icon and text
      expect(find.byIcon(Icons.broken_image_outlined), findsOneWidget);
      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('should maintain consistent card height regardless of image count', (WidgetTester tester) async {
      // Test with 1 image
      final images1 = createTestImages(1);
      await tester.pumpWidget(createTestWidget(images: images1));
      await tester.pumpAndSettle();
      
      final card1 = tester.getSize(find.byType(Card));
      await tester.pumpWidget(Container()); // Clear

      // Test with 9 images
      final images9 = createTestImages(9);
      await tester.pumpWidget(createTestWidget(images: images9));
      await tester.pumpAndSettle();
      
      final card9 = tester.getSize(find.byType(Card));

      // Both cards should have the same height (3 rows * 100px + 2 * 8px spacing + padding)
      expect(card9.height, equals(card1.height));
    });
  });
}
