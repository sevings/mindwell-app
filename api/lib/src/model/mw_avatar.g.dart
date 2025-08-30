// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_avatar.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAvatar extends MwAvatar {
  @override
  final String? x124;
  @override
  final String? x92;
  @override
  final String? x42;

  factory _$MwAvatar([void Function(MwAvatarBuilder)? updates]) =>
      (new MwAvatarBuilder()..update(updates))._build();

  _$MwAvatar._({this.x124, this.x92, this.x42}) : super._();

  @override
  MwAvatar rebuild(void Function(MwAvatarBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAvatarBuilder toBuilder() => new MwAvatarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAvatar &&
        x124 == other.x124 &&
        x92 == other.x92 &&
        x42 == other.x42;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, x124.hashCode);
    _$hash = $jc(_$hash, x92.hashCode);
    _$hash = $jc(_$hash, x42.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAvatar')
          ..add('x124', x124)
          ..add('x92', x92)
          ..add('x42', x42))
        .toString();
  }
}

class MwAvatarBuilder implements Builder<MwAvatar, MwAvatarBuilder> {
  _$MwAvatar? _$v;

  String? _x124;
  String? get x124 => _$this._x124;
  set x124(String? x124) => _$this._x124 = x124;

  String? _x92;
  String? get x92 => _$this._x92;
  set x92(String? x92) => _$this._x92 = x92;

  String? _x42;
  String? get x42 => _$this._x42;
  set x42(String? x42) => _$this._x42 = x42;

  MwAvatarBuilder() {
    MwAvatar._defaults(this);
  }

  MwAvatarBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _x124 = $v.x124;
      _x92 = $v.x92;
      _x42 = $v.x42;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAvatar other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAvatar;
  }

  @override
  void update(void Function(MwAvatarBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAvatar build() => _build();

  _$MwAvatar _build() {
    final _$result = _$v ?? new _$MwAvatar._(x124: x124, x92: x92, x42: x42);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
