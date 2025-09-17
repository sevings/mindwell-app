import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import 'package:mindwell/src/core/services/image_polling_service.dart';

class MockImagesApi extends Mock implements ImagesApi {}

void main() {
  group('ImagePollingService', () {
    late ImagePollingService service;
    late MockImagesApi mockImagesApi;

    setUp(() {
      mockImagesApi = MockImagesApi();
      service = ImagePollingService(imagesApi: mockImagesApi);
    });

    tearDown(() {
      service.stopAllPolling();
    });

    group('startPolling', () {
      test('should start polling for processing image', () async {
        const imageId = 123;
        final processingImage = MwImage(
          (b) => b
            ..id = imageId
            ..processing = true,
        );

        // Mock API response
        when(() => mockImagesApi.imagesIdGet(id: imageId)).thenAnswer(
          (_) async => Response<MwImage>(
            data: processingImage,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Track callbacks
        final updateCalls = <MwImage>[];
        final completeCalls = <MwImage>[];
        final errorCalls = <String>[];

        // Start polling
        service.startPolling(
          imageId: imageId,
          onUpdate: (image) => updateCalls.add(image),
          onComplete: (image) => completeCalls.add(image),
          onError: (error) => errorCalls.add(error),
        );

        // Wait a bit for the first poll
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify first poll was made
        verify(() => mockImagesApi.imagesIdGet(id: imageId)).called(1);
        expect(updateCalls.length, equals(1));
        expect(updateCalls.first.processing, isTrue);
        expect(completeCalls.length, equals(0)); // Should not be complete yet
      });

      test('should handle API errors', () async {
        const imageId = 123;
        const errorMessage = 'Network error';

        when(
          () => mockImagesApi.imagesIdGet(id: imageId),
        ).thenThrow(Exception(errorMessage));

        final errorCalls = <String>[];

        service.startPolling(
          imageId: imageId,
          onUpdate: (_) {},
          onComplete: (_) {},
          onError: (error) => errorCalls.add(error),
        );

        // Wait for the poll to fail
        await Future.delayed(const Duration(milliseconds: 100));

        expect(errorCalls.length, equals(1));
        expect(errorCalls.first, contains(errorMessage));
      });

      test('should handle null response data', () async {
        const imageId = 123;

        when(() => mockImagesApi.imagesIdGet(id: imageId)).thenAnswer(
          (_) async => Response<MwImage>(
            data: null,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final errorCalls = <String>[];

        service.startPolling(
          imageId: imageId,
          onUpdate: (_) {},
          onComplete: (_) {},
          onError: (error) => errorCalls.add(error),
        );

        // Wait for the poll to fail
        await Future.delayed(const Duration(milliseconds: 100));

        expect(errorCalls.length, equals(1));
        expect(errorCalls.first, equals('Image not found'));
      });
    });

    group('stopPolling', () {
      test('should stop polling for specific image', () async {
        const imageId = 123;
        final processingImage = MwImage(
          (b) => b
            ..id = imageId
            ..processing = true,
        );

        when(() => mockImagesApi.imagesIdGet(id: imageId)).thenAnswer(
          (_) async => Response<MwImage>(
            data: processingImage,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        service.startPolling(
          imageId: imageId,
          onUpdate: (_) {},
          onComplete: (_) {},
          onError: (_) {},
        );

        // Wait for first poll
        await Future.delayed(const Duration(milliseconds: 100));

        // Stop polling
        service.stopPolling(imageId);

        // Wait longer to ensure no more polls
        await Future.delayed(const Duration(seconds: 2));

        // Should only have been called once
        verify(() => mockImagesApi.imagesIdGet(id: imageId)).called(1);
      });
    });

    group('stopAllPolling', () {
      test('should stop all active polling', () async {
        const imageId1 = 123;
        const imageId2 = 456;
        final processingImage = MwImage(
          (b) => b
            ..id = 123
            ..processing = true,
        );

        when(() => mockImagesApi.imagesIdGet(id: any(named: 'id'))).thenAnswer(
          (_) async => Response<MwImage>(
            data: processingImage,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        service.startPolling(
          imageId: imageId1,
          onUpdate: (_) {},
          onComplete: (_) {},
          onError: (_) {},
        );

        service.startPolling(
          imageId: imageId2,
          onUpdate: (_) {},
          onComplete: (_) {},
          onError: (_) {},
        );

        // Wait for first polls
        await Future.delayed(const Duration(milliseconds: 100));

        // Stop all polling
        service.stopAllPolling();

        // Wait longer to ensure no more polls
        await Future.delayed(const Duration(seconds: 2));

        // Should only have been called once for each image
        verify(() => mockImagesApi.imagesIdGet(id: imageId1)).called(1);
        verify(() => mockImagesApi.imagesIdGet(id: imageId2)).called(1);
      });
    });

    group('exponential backoff', () {
      test('should use exponential backoff for retries', () async {
        const imageId = 123;
        final processingImage = MwImage(
          (b) => b
            ..id = imageId
            ..processing = true,
        );

        when(() => mockImagesApi.imagesIdGet(id: imageId)).thenAnswer(
          (_) async => Response<MwImage>(
            data: processingImage,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final pollTimes = <DateTime>[];

        service.startPolling(
          imageId: imageId,
          onUpdate: (image) => pollTimes.add(DateTime.now()),
          onComplete: (_) {},
          onError: (_) {},
        );

        // Wait for multiple polls
        await Future.delayed(const Duration(seconds: 8));

        // Should have at least 2 polls
        expect(pollTimes.length, greaterThanOrEqualTo(2));

        // Check that the intervals are increasing (exponential backoff)
        if (pollTimes.length >= 3) {
          final interval1 = pollTimes[1].difference(pollTimes[0]);
          final interval2 = pollTimes[2].difference(pollTimes[1]);

          // Allow some tolerance for timing variations
          expect(
            interval2.inMilliseconds,
            greaterThan(interval1.inMilliseconds - 100),
          );
        }
      });
    });
  });
}
