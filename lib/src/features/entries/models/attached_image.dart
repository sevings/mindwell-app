import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'attached_image.freezed.dart';

/// Represents an image attached to an entry with its processing status.
///
/// This model tracks both the image data and its current state in the entry editor.
@freezed
class AttachedImage with _$AttachedImage {
  /// Image that is currently being processed
  const factory AttachedImage.processing({
    required int id,
    required MwImage image,
    @Default(false) bool isUploading,
    @Default(0.0) double uploadProgress,
  }) = _ProcessingImage;

  /// Image that has been fully processed and is ready
  const factory AttachedImage.ready({required int id, required MwImage image}) =
      _ReadyImage;

  /// Image that failed to process
  const factory AttachedImage.failed({
    required int id,
    required MwImage image,
    required String errorMessage,
  }) = _FailedImage;
}

/// Extension methods for AttachedImage
extension AttachedImageX on AttachedImage {
  /// Get the image ID
  int get id => when(
    processing: (id, image, isUploading, uploadProgress) => id,
    ready: (id, image) => id,
    failed: (id, image, errorMessage) => id,
  );

  /// Get the MwImage object
  MwImage get image => when(
    processing: (id, image, isUploading, uploadProgress) => image,
    ready: (id, image) => image,
    failed: (id, image, errorMessage) => image,
  );

  /// Check if the image is currently processing
  bool get isProcessing => when(
    processing: (id, image, isUploading, uploadProgress) => true,
    ready: (id, image) => false,
    failed: (id, image, errorMessage) => false,
  );

  /// Check if the image is ready to use
  bool get isReady => when(
    processing: (id, image, isUploading, uploadProgress) => false,
    ready: (id, image) => true,
    failed: (id, image, errorMessage) => false,
  );

  /// Check if the image failed to process
  bool get isFailed => when(
    processing: (id, image, isUploading, uploadProgress) => false,
    ready: (id, image) => false,
    failed: (id, image, errorMessage) => true,
  );

  /// Get the thumbnail URL for the image
  String? get thumbnailUrl => image.thumbnail?.url;

  /// Get the small image URL
  String? get smallUrl => image.small?.url;

  /// Get the medium image URL
  String? get mediumUrl => image.medium?.url;

  /// Get the large image URL
  String? get largeUrl => image.large?.url;

  /// Get the full image URL (prefer large, fallback to medium, then small)
  String? get fullUrl => largeUrl ?? mediumUrl ?? smallUrl;
}
