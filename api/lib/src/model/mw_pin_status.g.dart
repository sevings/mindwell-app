// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_pin_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwPinStatus extends MwPinStatus {
  @override
  final int? id;
  @override
  final bool? isPinned;

  factory _$MwPinStatus([void Function(MwPinStatusBuilder)? updates]) =>
      (MwPinStatusBuilder()..update(updates))._build();

  _$MwPinStatus._({this.id, this.isPinned}) : super._();
  @override
  MwPinStatus rebuild(void Function(MwPinStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwPinStatusBuilder toBuilder() => MwPinStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwPinStatus && id == other.id && isPinned == other.isPinned;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isPinned.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwPinStatus')
          ..add('id', id)
          ..add('isPinned', isPinned))
        .toString();
  }
}

class MwPinStatusBuilder implements Builder<MwPinStatus, MwPinStatusBuilder> {
  _$MwPinStatus? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _isPinned;
  bool? get isPinned => _$this._isPinned;
  set isPinned(bool? isPinned) => _$this._isPinned = isPinned;

  MwPinStatusBuilder() {
    MwPinStatus._defaults(this);
  }

  MwPinStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _isPinned = $v.isPinned;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwPinStatus other) {
    _$v = other as _$MwPinStatus;
  }

  @override
  void update(void Function(MwPinStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwPinStatus build() => _build();

  _$MwPinStatus _build() {
    final _$result = _$v ??
        _$MwPinStatus._(
          id: id,
          isPinned: isPinned,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
