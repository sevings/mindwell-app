// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_watching_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwWatchingStatus extends MwWatchingStatus {
  @override
  final int? id;
  @override
  final bool? isWatching;

  factory _$MwWatchingStatus(
          [void Function(MwWatchingStatusBuilder)? updates]) =>
      (new MwWatchingStatusBuilder()..update(updates))._build();

  _$MwWatchingStatus._({this.id, this.isWatching}) : super._();

  @override
  MwWatchingStatus rebuild(void Function(MwWatchingStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwWatchingStatusBuilder toBuilder() =>
      new MwWatchingStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwWatchingStatus &&
        id == other.id &&
        isWatching == other.isWatching;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isWatching.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwWatchingStatus')
          ..add('id', id)
          ..add('isWatching', isWatching))
        .toString();
  }
}

class MwWatchingStatusBuilder
    implements Builder<MwWatchingStatus, MwWatchingStatusBuilder> {
  _$MwWatchingStatus? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _isWatching;
  bool? get isWatching => _$this._isWatching;
  set isWatching(bool? isWatching) => _$this._isWatching = isWatching;

  MwWatchingStatusBuilder() {
    MwWatchingStatus._defaults(this);
  }

  MwWatchingStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _isWatching = $v.isWatching;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwWatchingStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwWatchingStatus;
  }

  @override
  void update(void Function(MwWatchingStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwWatchingStatus build() => _build();

  _$MwWatchingStatus _build() {
    final _$result =
        _$v ?? new _$MwWatchingStatus._(id: id, isWatching: isWatching);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
