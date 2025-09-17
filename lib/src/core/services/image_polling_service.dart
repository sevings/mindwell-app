import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../api/api_provider.dart';

/// Provider for the ImagePollingService instance.
final imagePollingServiceProvider = Provider<ImagePollingService>((ref) {
  final imagesApi = ref.read(imagesApiProvider);
  return ImagePollingService(imagesApi: imagesApi);
});

/// Service for polling image processing status.
///
/// This service provides functionality to poll the server for image processing
/// status updates with exponential backoff.
class ImagePollingService {
  final ImagesApi _imagesApi;
  final Logger _logger = Logger('ImagePollingService');

  final Map<int, Timer> _activePolls = {};
  final Map<int, int> _pollAttempts = {};

  ImagePollingService({required ImagesApi imagesApi}) : _imagesApi = imagesApi;

  /// Start polling for an image's processing status.
  ///
  /// [imageId] The ID of the image to poll
  /// [onUpdate] Callback when the image status is updated
  /// [onComplete] Callback when processing is complete
  /// [onError] Callback when an error occurs
  void startPolling({
    required int imageId,
    required void Function(MwImage image) onUpdate,
    required void Function(MwImage image) onComplete,
    required void Function(String error) onError,
  }) {
    // Stop any existing polling for this image
    stopPolling(imageId);

    _logger.info('Starting polling for image $imageId');
    _pollAttempts[imageId] = 0;

    _pollImage(
      imageId: imageId,
      onUpdate: onUpdate,
      onComplete: onComplete,
      onError: onError,
    );
  }

  /// Stop polling for a specific image.
  void stopPolling(int imageId) {
    final timer = _activePolls.remove(imageId);
    timer?.cancel();
    _pollAttempts.remove(imageId);
    _logger.info('Stopped polling for image $imageId');
  }

  /// Stop all active polling.
  void stopAllPolling() {
    for (final timer in _activePolls.values) {
      timer.cancel();
    }
    _activePolls.clear();
    _pollAttempts.clear();
    _logger.info('Stopped all image polling');
  }

  /// Poll a single image with exponential backoff.
  Future<void> _pollImage({
    required int imageId,
    required void Function(MwImage image) onUpdate,
    required void Function(MwImage image) onComplete,
    required void Function(String error) onError,
  }) async {
    try {
      final response = await _imagesApi.imagesIdGet(id: imageId);
      final image = response.data;

      if (image == null) {
        onError('Image not found');
        stopPolling(imageId);
        return;
      }

      // Call update callback
      onUpdate(image);

      // Check if processing is complete
      if (image.processing != true) {
        _logger.info('Image $imageId processing complete');
        onComplete(image);
        stopPolling(imageId);
        return;
      }

      // Schedule next poll with exponential backoff
      final attempts = _pollAttempts[imageId] ?? 0;
      final delay = _calculateDelay(attempts);

      _logger.info(
        'Image $imageId still processing, next poll in ${delay.inSeconds}s',
      );

      final timer = Timer(delay, () {
        _pollAttempts[imageId] = attempts + 1;
        _pollImage(
          imageId: imageId,
          onUpdate: onUpdate,
          onComplete: onComplete,
          onError: onError,
        );
      });

      _activePolls[imageId] = timer;
    } catch (e, stackTrace) {
      _logger.severe('Error polling image $imageId', e, stackTrace);
      onError('Failed to poll image: ${e.toString()}');
      stopPolling(imageId);
    }
  }

  /// Calculate delay for exponential backoff.
  ///
  /// Starts at 1 second, doubles each time, max 30 seconds.
  Duration _calculateDelay(int attempts) {
    final seconds = (1 << attempts).clamp(1, 30);
    return Duration(seconds: seconds);
  }

  /// Dispose the service and stop all polling.
  void dispose() {
    stopAllPolling();
  }
}
