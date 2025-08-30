// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_image_size.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwImageSize extends MwImageSize {
  @override
  final int? width;
  @override
  final int? height;
  @override
  final String? url;
  @override
  final String? preview;

  factory _$MwImageSize([void Function(MwImageSizeBuilder)? updates]) =>
      (new MwImageSizeBuilder()..update(updates))._build();

  _$MwImageSize._({this.width, this.height, this.url, this.preview})
      : super._();

  @override
  MwImageSize rebuild(void Function(MwImageSizeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwImageSizeBuilder toBuilder() => new MwImageSizeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwImageSize &&
        width == other.width &&
        height == other.height &&
        url == other.url &&
        preview == other.preview;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, width.hashCode);
    _$hash = $jc(_$hash, height.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, preview.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwImageSize')
          ..add('width', width)
          ..add('height', height)
          ..add('url', url)
          ..add('preview', preview))
        .toString();
  }
}

class MwImageSizeBuilder implements Builder<MwImageSize, MwImageSizeBuilder> {
  _$MwImageSize? _$v;

  int? _width;
  int? get width => _$this._width;
  set width(int? width) => _$this._width = width;

  int? _height;
  int? get height => _$this._height;
  set height(int? height) => _$this._height = height;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _preview;
  String? get preview => _$this._preview;
  set preview(String? preview) => _$this._preview = preview;

  MwImageSizeBuilder() {
    MwImageSize._defaults(this);
  }

  MwImageSizeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _width = $v.width;
      _height = $v.height;
      _url = $v.url;
      _preview = $v.preview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwImageSize other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwImageSize;
  }

  @override
  void update(void Function(MwImageSizeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwImageSize build() => _build();

  _$MwImageSize _build() {
    final _$result = _$v ??
        new _$MwImageSize._(
            width: width, height: height, url: url, preview: preview);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
