// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_cover.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwCover extends MwCover {
  @override
  final int? id;
  @override
  final String? x1920;
  @override
  final String? x318;

  factory _$MwCover([void Function(MwCoverBuilder)? updates]) =>
      (MwCoverBuilder()..update(updates))._build();

  _$MwCover._({this.id, this.x1920, this.x318}) : super._();
  @override
  MwCover rebuild(void Function(MwCoverBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwCoverBuilder toBuilder() => MwCoverBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwCover &&
        id == other.id &&
        x1920 == other.x1920 &&
        x318 == other.x318;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, x1920.hashCode);
    _$hash = $jc(_$hash, x318.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwCover')
          ..add('id', id)
          ..add('x1920', x1920)
          ..add('x318', x318))
        .toString();
  }
}

class MwCoverBuilder implements Builder<MwCover, MwCoverBuilder> {
  _$MwCover? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _x1920;
  String? get x1920 => _$this._x1920;
  set x1920(String? x1920) => _$this._x1920 = x1920;

  String? _x318;
  String? get x318 => _$this._x318;
  set x318(String? x318) => _$this._x318 = x318;

  MwCoverBuilder() {
    MwCover._defaults(this);
  }

  MwCoverBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _x1920 = $v.x1920;
      _x318 = $v.x318;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwCover other) {
    _$v = other as _$MwCover;
  }

  @override
  void update(void Function(MwCoverBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwCover build() => _build();

  _$MwCover _build() {
    final _$result = _$v ??
        _$MwCover._(
          id: id,
          x1920: x1920,
          x318: x318,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
