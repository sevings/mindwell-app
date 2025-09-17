// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attached_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AttachedImage {
  int get id => throw _privateConstructorUsedError;
  MwImage get image => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)
        processing,
    required TResult Function(int id, MwImage image) ready,
    required TResult Function(int id, MwImage image, String errorMessage)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult? Function(int id, MwImage image)? ready,
    TResult? Function(int id, MwImage image, String errorMessage)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult Function(int id, MwImage image)? ready,
    TResult Function(int id, MwImage image, String errorMessage)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingImage value) processing,
    required TResult Function(_ReadyImage value) ready,
    required TResult Function(_FailedImage value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingImage value)? processing,
    TResult? Function(_ReadyImage value)? ready,
    TResult? Function(_FailedImage value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingImage value)? processing,
    TResult Function(_ReadyImage value)? ready,
    TResult Function(_FailedImage value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttachedImageCopyWith<AttachedImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachedImageCopyWith<$Res> {
  factory $AttachedImageCopyWith(
          AttachedImage value, $Res Function(AttachedImage) then) =
      _$AttachedImageCopyWithImpl<$Res, AttachedImage>;
  @useResult
  $Res call({int id, MwImage image});
}

/// @nodoc
class _$AttachedImageCopyWithImpl<$Res, $Val extends AttachedImage>
    implements $AttachedImageCopyWith<$Res> {
  _$AttachedImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MwImage,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcessingImageImplCopyWith<$Res>
    implements $AttachedImageCopyWith<$Res> {
  factory _$$ProcessingImageImplCopyWith(_$ProcessingImageImpl value,
          $Res Function(_$ProcessingImageImpl) then) =
      __$$ProcessingImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, MwImage image, bool isUploading, double uploadProgress});
}

/// @nodoc
class __$$ProcessingImageImplCopyWithImpl<$Res>
    extends _$AttachedImageCopyWithImpl<$Res, _$ProcessingImageImpl>
    implements _$$ProcessingImageImplCopyWith<$Res> {
  __$$ProcessingImageImplCopyWithImpl(
      _$ProcessingImageImpl _value, $Res Function(_$ProcessingImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
    Object? isUploading = null,
    Object? uploadProgress = null,
  }) {
    return _then(_$ProcessingImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MwImage,
      isUploading: null == isUploading
          ? _value.isUploading
          : isUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      uploadProgress: null == uploadProgress
          ? _value.uploadProgress
          : uploadProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ProcessingImageImpl implements _ProcessingImage {
  const _$ProcessingImageImpl(
      {required this.id,
      required this.image,
      this.isUploading = false,
      this.uploadProgress = 0.0});

  @override
  final int id;
  @override
  final MwImage image;
  @override
  @JsonKey()
  final bool isUploading;
  @override
  @JsonKey()
  final double uploadProgress;

  @override
  String toString() {
    return 'AttachedImage.processing(id: $id, image: $image, isUploading: $isUploading, uploadProgress: $uploadProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessingImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isUploading, isUploading) ||
                other.isUploading == isUploading) &&
            (identical(other.uploadProgress, uploadProgress) ||
                other.uploadProgress == uploadProgress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, image, isUploading, uploadProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessingImageImplCopyWith<_$ProcessingImageImpl> get copyWith =>
      __$$ProcessingImageImplCopyWithImpl<_$ProcessingImageImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)
        processing,
    required TResult Function(int id, MwImage image) ready,
    required TResult Function(int id, MwImage image, String errorMessage)
        failed,
  }) {
    return processing(id, image, isUploading, uploadProgress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult? Function(int id, MwImage image)? ready,
    TResult? Function(int id, MwImage image, String errorMessage)? failed,
  }) {
    return processing?.call(id, image, isUploading, uploadProgress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult Function(int id, MwImage image)? ready,
    TResult Function(int id, MwImage image, String errorMessage)? failed,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(id, image, isUploading, uploadProgress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingImage value) processing,
    required TResult Function(_ReadyImage value) ready,
    required TResult Function(_FailedImage value) failed,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingImage value)? processing,
    TResult? Function(_ReadyImage value)? ready,
    TResult? Function(_FailedImage value)? failed,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingImage value)? processing,
    TResult Function(_ReadyImage value)? ready,
    TResult Function(_FailedImage value)? failed,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class _ProcessingImage implements AttachedImage {
  const factory _ProcessingImage(
      {required final int id,
      required final MwImage image,
      final bool isUploading,
      final double uploadProgress}) = _$ProcessingImageImpl;

  @override
  int get id;
  @override
  MwImage get image;
  bool get isUploading;
  double get uploadProgress;
  @override
  @JsonKey(ignore: true)
  _$$ProcessingImageImplCopyWith<_$ProcessingImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReadyImageImplCopyWith<$Res>
    implements $AttachedImageCopyWith<$Res> {
  factory _$$ReadyImageImplCopyWith(
          _$ReadyImageImpl value, $Res Function(_$ReadyImageImpl) then) =
      __$$ReadyImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, MwImage image});
}

/// @nodoc
class __$$ReadyImageImplCopyWithImpl<$Res>
    extends _$AttachedImageCopyWithImpl<$Res, _$ReadyImageImpl>
    implements _$$ReadyImageImplCopyWith<$Res> {
  __$$ReadyImageImplCopyWithImpl(
      _$ReadyImageImpl _value, $Res Function(_$ReadyImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
  }) {
    return _then(_$ReadyImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MwImage,
    ));
  }
}

/// @nodoc

class _$ReadyImageImpl implements _ReadyImage {
  const _$ReadyImageImpl({required this.id, required this.image});

  @override
  final int id;
  @override
  final MwImage image;

  @override
  String toString() {
    return 'AttachedImage.ready(id: $id, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadyImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadyImageImplCopyWith<_$ReadyImageImpl> get copyWith =>
      __$$ReadyImageImplCopyWithImpl<_$ReadyImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)
        processing,
    required TResult Function(int id, MwImage image) ready,
    required TResult Function(int id, MwImage image, String errorMessage)
        failed,
  }) {
    return ready(id, image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult? Function(int id, MwImage image)? ready,
    TResult? Function(int id, MwImage image, String errorMessage)? failed,
  }) {
    return ready?.call(id, image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult Function(int id, MwImage image)? ready,
    TResult Function(int id, MwImage image, String errorMessage)? failed,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(id, image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingImage value) processing,
    required TResult Function(_ReadyImage value) ready,
    required TResult Function(_FailedImage value) failed,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingImage value)? processing,
    TResult? Function(_ReadyImage value)? ready,
    TResult? Function(_FailedImage value)? failed,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingImage value)? processing,
    TResult Function(_ReadyImage value)? ready,
    TResult Function(_FailedImage value)? failed,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _ReadyImage implements AttachedImage {
  const factory _ReadyImage(
      {required final int id, required final MwImage image}) = _$ReadyImageImpl;

  @override
  int get id;
  @override
  MwImage get image;
  @override
  @JsonKey(ignore: true)
  _$$ReadyImageImplCopyWith<_$ReadyImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailedImageImplCopyWith<$Res>
    implements $AttachedImageCopyWith<$Res> {
  factory _$$FailedImageImplCopyWith(
          _$FailedImageImpl value, $Res Function(_$FailedImageImpl) then) =
      __$$FailedImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, MwImage image, String errorMessage});
}

/// @nodoc
class __$$FailedImageImplCopyWithImpl<$Res>
    extends _$AttachedImageCopyWithImpl<$Res, _$FailedImageImpl>
    implements _$$FailedImageImplCopyWith<$Res> {
  __$$FailedImageImplCopyWithImpl(
      _$FailedImageImpl _value, $Res Function(_$FailedImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? image = null,
    Object? errorMessage = null,
  }) {
    return _then(_$FailedImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as MwImage,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailedImageImpl implements _FailedImage {
  const _$FailedImageImpl(
      {required this.id, required this.image, required this.errorMessage});

  @override
  final int id;
  @override
  final MwImage image;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AttachedImage.failed(id: $id, image: $image, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, image, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedImageImplCopyWith<_$FailedImageImpl> get copyWith =>
      __$$FailedImageImplCopyWithImpl<_$FailedImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)
        processing,
    required TResult Function(int id, MwImage image) ready,
    required TResult Function(int id, MwImage image, String errorMessage)
        failed,
  }) {
    return failed(id, image, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult? Function(int id, MwImage image)? ready,
    TResult? Function(int id, MwImage image, String errorMessage)? failed,
  }) {
    return failed?.call(id, image, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int id, MwImage image, bool isUploading, double uploadProgress)?
        processing,
    TResult Function(int id, MwImage image)? ready,
    TResult Function(int id, MwImage image, String errorMessage)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(id, image, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProcessingImage value) processing,
    required TResult Function(_ReadyImage value) ready,
    required TResult Function(_FailedImage value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProcessingImage value)? processing,
    TResult? Function(_ReadyImage value)? ready,
    TResult? Function(_FailedImage value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProcessingImage value)? processing,
    TResult Function(_ReadyImage value)? ready,
    TResult Function(_FailedImage value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _FailedImage implements AttachedImage {
  const factory _FailedImage(
      {required final int id,
      required final MwImage image,
      required final String errorMessage}) = _$FailedImageImpl;

  @override
  int get id;
  @override
  MwImage get image;
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$FailedImageImplCopyWith<_$FailedImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
