import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/entries/models/attached_image.dart';

void main() {
  group('AttachedImage', () {
    late MwImage mockImage;

    setUp(() {
      mockImage = MwImage(
        (b) => b
          ..id = 123
          ..processing = false
          ..thumbnail = (MwImageSizeBuilder()
            ..url = 'https://example.com/thumb.jpg'
            ..width = 150
            ..height = 150)
          ..small = (MwImageSizeBuilder()
            ..url = 'https://example.com/small.jpg'
            ..width = 300
            ..height = 300)
          ..medium = (MwImageSizeBuilder()
            ..url = 'https://example.com/medium.jpg'
            ..width = 600
            ..height = 600)
          ..large = (MwImageSizeBuilder()
            ..url = 'https://example.com/large.jpg'
            ..width = 1200
            ..height = 1200),
      );
    });

    group('AttachedImage.processing', () {
      test('should create processing image with correct properties', () {
        final attachedImage = AttachedImage.processing(
          id: 123,
          image: mockImage,
          isUploading: true,
          uploadProgress: 0.5,
        );

        expect(attachedImage.id, equals(123));
        expect(attachedImage.image, equals(mockImage));
        expect(attachedImage.isProcessing, isTrue);
        expect(attachedImage.isReady, isFalse);
        expect(attachedImage.isFailed, isFalse);
      });

      test('should return correct thumbnail URL', () {
        final attachedImage = AttachedImage.processing(
          id: 123,
          image: mockImage,
        );

        expect(
          attachedImage.thumbnailUrl,
          equals('https://example.com/thumb.jpg'),
        );
      });

      test('should return correct full URL (prefer large)', () {
        final attachedImage = AttachedImage.processing(
          id: 123,
          image: mockImage,
        );

        expect(attachedImage.fullUrl, equals('https://example.com/large.jpg'));
      });
    });

    group('AttachedImage.ready', () {
      test('should create ready image with correct properties', () {
        final attachedImage = AttachedImage.ready(id: 123, image: mockImage);

        expect(attachedImage.id, equals(123));
        expect(attachedImage.image, equals(mockImage));
        expect(attachedImage.isProcessing, isFalse);
        expect(attachedImage.isReady, isTrue);
        expect(attachedImage.isFailed, isFalse);
      });
    });

    group('AttachedImage.failed', () {
      test('should create failed image with correct properties', () {
        const errorMessage = 'Upload failed';
        final attachedImage = AttachedImage.failed(
          id: 123,
          image: mockImage,
          errorMessage: errorMessage,
        );

        expect(attachedImage.id, equals(123));
        expect(attachedImage.image, equals(mockImage));
        expect(attachedImage.isProcessing, isFalse);
        expect(attachedImage.isReady, isFalse);
        expect(attachedImage.isFailed, isTrue);
      });
    });

    group('AttachedImageX extension', () {
      test('should return correct URL fallbacks', () {
        final imageWithoutLarge = MwImage(
          (b) => b
            ..id = 123
            ..processing = false
            ..medium = (MwImageSizeBuilder()
              ..url = 'https://example.com/medium.jpg'
              ..width = 600
              ..height = 600)
            ..small = (MwImageSizeBuilder()
              ..url = 'https://example.com/small.jpg'
              ..width = 300
              ..height = 300),
        );

        final attachedImage = AttachedImage.ready(
          id: 123,
          image: imageWithoutLarge,
        );

        expect(attachedImage.fullUrl, equals('https://example.com/medium.jpg'));
      });

      test('should return small URL when only small is available', () {
        final imageOnlySmall = MwImage(
          (b) => b
            ..id = 123
            ..processing = false
            ..small = (MwImageSizeBuilder()
              ..url = 'https://example.com/small.jpg'
              ..width = 300
              ..height = 300),
        );

        final attachedImage = AttachedImage.ready(
          id: 123,
          image: imageOnlySmall,
        );

        expect(attachedImage.fullUrl, equals('https://example.com/small.jpg'));
      });

      test('should return null when no URLs are available', () {
        final imageNoUrls = MwImage(
          (b) => b
            ..id = 123
            ..processing = false,
        );

        final attachedImage = AttachedImage.ready(id: 123, image: imageNoUrls);

        expect(attachedImage.fullUrl, isNull);
        expect(attachedImage.thumbnailUrl, isNull);
      });
    });

    group('when method', () {
      test('should handle processing state correctly', () {
        final attachedImage = AttachedImage.processing(
          id: 123,
          image: mockImage,
          isUploading: true,
          uploadProgress: 0.7,
        );

        final result = attachedImage.when(
          processing: (id, image, isUploading, uploadProgress) => 'processing',
          ready: (id, image) => 'ready',
          failed: (id, image, errorMessage) => 'failed',
        );

        expect(result, equals('processing'));
      });

      test('should handle ready state correctly', () {
        final attachedImage = AttachedImage.ready(id: 123, image: mockImage);

        final result = attachedImage.when(
          processing: (id, image, isUploading, uploadProgress) => 'processing',
          ready: (id, image) => 'ready',
          failed: (id, image, errorMessage) => 'failed',
        );

        expect(result, equals('ready'));
      });

      test('should handle failed state correctly', () {
        const errorMessage = 'Network error';
        final attachedImage = AttachedImage.failed(
          id: 123,
          image: mockImage,
          errorMessage: errorMessage,
        );

        final result = attachedImage.when(
          processing: (id, image, isUploading, uploadProgress) => 'processing',
          ready: (id, image) => 'ready',
          failed: (id, image, errorMessage) => 'failed',
        );

        expect(result, equals('failed'));
      });
    });
  });
}
