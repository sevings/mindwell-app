import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/models/attached_image.dart';
import 'package:mindwell/src/features/entries/widgets/image_manager.dart';

void main() {
  group('ImageManager', () {
    late List<AttachedImage> mockImages;
    late MwImage mockMwImage;

    setUp(() {
      mockMwImage = MwImage(
        (b) => b
          ..id = 123
          ..processing = false
          ..thumbnail = (MwImageSizeBuilder()
            ..url = 'https://example.com/thumb.jpg'
            ..width = 150
            ..height = 150),
      );

      mockImages = [
        AttachedImage.ready(id: 123, image: mockMwImage),
        AttachedImage.processing(id: 456, image: mockMwImage),
        AttachedImage.failed(
          id: 789,
          image: mockMwImage,
          errorMessage: 'Upload failed',
        ),
      ];
    });

    Widget createWidget({
      List<AttachedImage>? images,
      void Function(int)? onRemoveImage,
      void Function(List<File>)? onAddImages,
      void Function(int, int)? onReorderImages,
      void Function(AttachedImage)? onOpenImage,
      void Function(AttachedImage)? onInsertImage,
      bool isUploading = false,
      double uploadProgress = 0.0,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ImageManager(
            images: images ?? mockImages,
            onRemoveImage: onRemoveImage ?? (_) {},
            onAddImages: onAddImages ?? (_) {},
            onReorderImages: onReorderImages ?? (_, _) {},
            onOpenImage: onOpenImage ?? (_) {},
            onInsertImage: onInsertImage ?? (_) {},
            isUploading: isUploading,
            uploadProgress: uploadProgress,
          ),
        ),
      );
    }

    testWidgets('should display images in grid layout', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      // Should show 3 images
      expect(find.byType(ImageManager), findsOneWidget);

      // Should show image thumbnails (using CachedImage)
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should show processing indicator for processing images', (
      WidgetTester tester,
    ) async {
      final processingImages = [
        AttachedImage.processing(id: 123, image: mockMwImage),
      ];

      await tester.pumpWidget(createWidget(images: processingImages));

      // Should show processing indicator (there might be multiple CircularProgressIndicators
      // - one for the image placeholder and one for the processing overlay)
      expect(find.byType(CircularProgressIndicator), findsWidgets);

      // Should show processing status text
      expect(find.text('Processing'), findsOneWidget);
    });

    testWidgets('should show error indicator for failed images', (
      WidgetTester tester,
    ) async {
      final failedImages = [
        AttachedImage.failed(
          id: 123,
          image: mockMwImage,
          errorMessage: 'Failed',
        ),
      ];

      await tester.pumpWidget(createWidget(images: failedImages));

      // Should show error icon
      expect(find.byIcon(Icons.error), findsOneWidget);

      // Should show failed status text
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('should show upload progress when uploading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createWidget(isUploading: true, uploadProgress: 0.5),
      );

      // Should show progress indicator
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('should call onRemoveImage when remove button is tapped', (
      WidgetTester tester,
    ) async {
      bool removeCalled = false;
      int? removedImageId;

      await tester.pumpWidget(
        createWidget(
          onRemoveImage: (imageId) {
            removeCalled = true;
            removedImageId = imageId;
          },
        ),
      );

      // Find and tap the remove button (close icon)
      final removeButton = find.byIcon(Icons.close);
      expect(removeButton, findsWidgets);

      await tester.tap(removeButton.first);
      await tester.pump();

      expect(removeCalled, isTrue);
      expect(removedImageId, equals(123));
    });

    testWidgets('should show image menu when image is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      // Tap on an image (find the first GestureDetector that's not the add button)
      final imageWidgets = find.byType(GestureDetector);
      expect(imageWidgets, findsWidgets);

      // Find the first image GestureDetector (skip the add button which is also a GestureDetector)
      final imageWidget = imageWidgets.at(
        1,
      ); // Second GestureDetector should be the image
      await tester.tap(imageWidget);

      // Wait for the bottom sheet to appear
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Should show bottom sheet with menu
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Open'), findsOneWidget);
      expect(find.text('Insert'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('should call onOpenImage when Open is tapped in menu', (
      WidgetTester tester,
    ) async {
      AttachedImage? openedImage;

      await tester.pumpWidget(
        createWidget(
          onOpenImage: (image) {
            openedImage = image;
          },
        ),
      );

      // Tap on an image to open menu (skip the add button GestureDetector)
      final imageWidgets = find.byType(GestureDetector);
      final imageWidget = imageWidgets.at(
        1,
      ); // Second GestureDetector should be the image
      await tester.tap(imageWidget);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Wait for the bottom sheet to appear and tap Open button
      final openButton = find.text('Open');
      expect(openButton, findsOneWidget);
      await tester.tap(openButton, warnIfMissed: false);
      await tester.pump();

      expect(openedImage, isNotNull);
      expect(openedImage!.id, equals(123));
    });

    testWidgets('should call onInsertImage when Insert is tapped in menu', (
      WidgetTester tester,
    ) async {
      AttachedImage? insertedImage;

      await tester.pumpWidget(
        createWidget(
          onInsertImage: (image) {
            insertedImage = image;
          },
        ),
      );

      // Tap on a ready image to open menu (skip the add button GestureDetector)
      final imageWidgets = find.byType(GestureDetector);
      final imageWidget = imageWidgets.at(
        1,
      ); // Second GestureDetector should be the image
      await tester.tap(imageWidget);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Wait for the bottom sheet to appear and tap Insert button
      final insertButton = find.text('Insert');
      expect(insertButton, findsOneWidget);
      await tester.tap(insertButton, warnIfMissed: false);
      await tester.pump();

      expect(insertedImage, isNotNull);
      expect(insertedImage!.id, equals(123));
    });

    testWidgets('should not show Insert button for processing images', (
      WidgetTester tester,
    ) async {
      final processingImages = [
        AttachedImage.processing(id: 123, image: mockMwImage),
      ];

      await tester.pumpWidget(createWidget(images: processingImages));

      // Tap on the processing image (skip the add button GestureDetector)
      final imageWidgets = find.byType(GestureDetector);
      final imageWidget = imageWidgets.at(
        1,
      ); // Second GestureDetector should be the image
      await tester.tap(imageWidget);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Insert button should not be visible for processing images
      expect(find.text('Insert'), findsNothing);
    });

    testWidgets('should show add button when not uploading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget(isUploading: false));

      // Should show add button
      expect(find.byIcon(Icons.add_photo_alternate), findsOneWidget);
    });

    testWidgets(
      'should show progress indicator instead of add button when uploading',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidget(isUploading: true));

        // Should show progress indicator instead of add button
        expect(find.byIcon(Icons.add_photo_alternate), findsNothing);
        // There might be multiple CircularProgressIndicators (one for upload, one for processing images)
        expect(find.byType(CircularProgressIndicator), findsWidgets);
      },
    );

    testWidgets('should display correct status text in menu', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidget());

      // Tap on the first image (ready) - skip the add button GestureDetector
      final imageWidgets = find.byType(GestureDetector);
      final imageWidget = imageWidgets.at(
        1,
      ); // Second GestureDetector should be the image
      await tester.tap(imageWidget);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Should show "Ready" status
      expect(find.text('Ready'), findsOneWidget);
    });

    testWidgets('should handle empty images list', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(images: []));

      // Should not show any image widgets (only the add button GestureDetector should be present)
      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsOneWidget); // Only the add button

      // Should still show add button
      expect(find.byIcon(Icons.add_photo_alternate), findsOneWidget);
    });
  });
}
