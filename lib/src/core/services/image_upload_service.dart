import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import '../api/api_provider.dart';

/// Provider for the ImageUploadService instance.
final imageUploadServiceProvider = Provider<ImageUploadService>((ref) {
  final imagesApi = ref.read(imagesApiProvider);
  return ImageUploadService(imagesApi: imagesApi);
});

/// Service for handling image uploads with progress tracking.
/// 
/// This service provides functionality to upload images to the server
/// with progress callbacks and error handling.
class ImageUploadService {
  final ImagesApi _imagesApi;
  final Logger _logger = Logger('ImageUploadService');

  ImageUploadService({
    required ImagesApi imagesApi,
  }) : _imagesApi = imagesApi;

  /// Upload a single image file with progress tracking.
  /// 
  /// [file] The image file to upload
  /// [onProgress] Optional callback for upload progress (0.0 to 1.0)
  /// 
  /// Returns the uploaded image data or null if upload fails.
  Future<MwImage?> uploadImage(
    File file, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      _logger.info('Starting image upload: ${file.path}');
      
      final response = await _imagesApi.imagesPost(
        file: await MultipartFile.fromFile(file.path),
        onSendProgress: (sent, total) {
          if (total > 0) {
            final progress = sent / total;
            onProgress?.call(progress);
          }
        },
      );
      
      final uploadedImage = response.data;
      if (uploadedImage != null) {
        _logger.info('Successfully uploaded image: ${uploadedImage.id}');
        return uploadedImage;
      } else {
        _logger.warning('Image upload returned null data');
        return null;
      }
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to upload image: ${file.path}', e, stackTrace);
      rethrow;
    }
  }

  /// Upload multiple images with progress tracking.
  /// 
  /// [files] List of image files to upload
  /// [onProgress] Optional callback for overall progress (0.0 to 1.0)
  /// [onImageProgress] Optional callback for individual image progress
  /// 
  /// Returns a list of uploaded images. Failed uploads will be null in the list.
  Future<List<MwImage?>> uploadImages(
    List<File> files, {
    void Function(double progress)? onProgress,
    void Function(int imageIndex, double progress)? onImageProgress,
  }) async {
    if (files.isEmpty) return [];
    
    _logger.info('Starting batch upload of ${files.length} images');
    
    final results = <MwImage?>[];
    int completedCount = 0;
    
    for (int i = 0; i < files.length; i++) {
      try {
        final result = await uploadImage(
          files[i],
          onProgress: (progress) {
            onImageProgress?.call(i, progress);
          },
        );
        results.add(result);
      } catch (e) {
        _logger.warning('Failed to upload image ${i + 1}/${files.length}: ${files[i].path}');
        results.add(null);
      }
      
      completedCount++;
      onProgress?.call(completedCount / files.length);
    }
    
    final successCount = results.where((image) => image != null).length;
    _logger.info('Batch upload completed: $successCount/${files.length} successful');
    
    return results;
  }

  /// Get the image URL for a given image ID.
  /// 
  /// This constructs the full URL for displaying the image.
  String getImageUrl(int imageId) {
    // This should match the API base URL structure
    // The actual URL format may need to be adjusted based on the API
    return '/api/v1/images/$imageId';
  }

  /// Get the thumbnail URL for a given image ID.
  /// 
  /// This constructs the full URL for displaying a thumbnail version of the image.
  String getThumbnailUrl(int imageId) {
    // This should match the API base URL structure for thumbnails
    // The actual URL format may need to be adjusted based on the API
    return '/api/v1/images/$imageId/thumbnail';
  }
}
