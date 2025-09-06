// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_image.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwImage extends MwImage {
  @override
  final int? id;
  @override
  final MwUser? author;
  @override
  final bool? isAnimated;
  @override
  final bool? processing;
  @override
  final MwImageSize? thumbnail;
  @override
  final MwImageSize? small;
  @override
  final MwImageSize? medium;
  @override
  final MwImageSize? large;

  factory _$MwImage([void Function(MwImageBuilder)? updates]) =>
      (MwImageBuilder()..update(updates))._build();

  _$MwImage._(
      {this.id,
      this.author,
      this.isAnimated,
      this.processing,
      this.thumbnail,
      this.small,
      this.medium,
      this.large})
      : super._();
  @override
  MwImage rebuild(void Function(MwImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwImageBuilder toBuilder() => MwImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwImage &&
        id == other.id &&
        author == other.author &&
        isAnimated == other.isAnimated &&
        processing == other.processing &&
        thumbnail == other.thumbnail &&
        small == other.small &&
        medium == other.medium &&
        large == other.large;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, isAnimated.hashCode);
    _$hash = $jc(_$hash, processing.hashCode);
    _$hash = $jc(_$hash, thumbnail.hashCode);
    _$hash = $jc(_$hash, small.hashCode);
    _$hash = $jc(_$hash, medium.hashCode);
    _$hash = $jc(_$hash, large.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwImage')
          ..add('id', id)
          ..add('author', author)
          ..add('isAnimated', isAnimated)
          ..add('processing', processing)
          ..add('thumbnail', thumbnail)
          ..add('small', small)
          ..add('medium', medium)
          ..add('large', large))
        .toString();
  }
}

class MwImageBuilder implements Builder<MwImage, MwImageBuilder> {
  _$MwImage? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MwUser? _author;
  MwUser? get author => _$this._author;
  set author(MwUser? author) => _$this._author = author;

  bool? _isAnimated;
  bool? get isAnimated => _$this._isAnimated;
  set isAnimated(bool? isAnimated) => _$this._isAnimated = isAnimated;

  bool? _processing;
  bool? get processing => _$this._processing;
  set processing(bool? processing) => _$this._processing = processing;

  MwImageSizeBuilder? _thumbnail;
  MwImageSizeBuilder get thumbnail =>
      _$this._thumbnail ??= MwImageSizeBuilder();
  set thumbnail(MwImageSizeBuilder? thumbnail) => _$this._thumbnail = thumbnail;

  MwImageSizeBuilder? _small;
  MwImageSizeBuilder get small => _$this._small ??= MwImageSizeBuilder();
  set small(MwImageSizeBuilder? small) => _$this._small = small;

  MwImageSizeBuilder? _medium;
  MwImageSizeBuilder get medium => _$this._medium ??= MwImageSizeBuilder();
  set medium(MwImageSizeBuilder? medium) => _$this._medium = medium;

  MwImageSizeBuilder? _large;
  MwImageSizeBuilder get large => _$this._large ??= MwImageSizeBuilder();
  set large(MwImageSizeBuilder? large) => _$this._large = large;

  MwImageBuilder() {
    MwImage._defaults(this);
  }

  MwImageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _author = $v.author;
      _isAnimated = $v.isAnimated;
      _processing = $v.processing;
      _thumbnail = $v.thumbnail?.toBuilder();
      _small = $v.small?.toBuilder();
      _medium = $v.medium?.toBuilder();
      _large = $v.large?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwImage other) {
    _$v = other as _$MwImage;
  }

  @override
  void update(void Function(MwImageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwImage build() => _build();

  _$MwImage _build() {
    _$MwImage _$result;
    try {
      _$result = _$v ??
          _$MwImage._(
            id: id,
            author: author,
            isAnimated: isAnimated,
            processing: processing,
            thumbnail: _thumbnail?.build(),
            small: _small?.build(),
            medium: _medium?.build(),
            large: _large?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'thumbnail';
        _thumbnail?.build();
        _$failedField = 'small';
        _small?.build();
        _$failedField = 'medium';
        _medium?.build();
        _$failedField = 'large';
        _large?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwImage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
