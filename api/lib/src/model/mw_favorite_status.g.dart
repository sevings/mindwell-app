// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_favorite_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwFavoriteStatus extends MwFavoriteStatus {
  @override
  final int? id;
  @override
  final bool? isFavorited;
  @override
  final int? count;

  factory _$MwFavoriteStatus(
          [void Function(MwFavoriteStatusBuilder)? updates]) =>
      (MwFavoriteStatusBuilder()..update(updates))._build();

  _$MwFavoriteStatus._({this.id, this.isFavorited, this.count}) : super._();
  @override
  MwFavoriteStatus rebuild(void Function(MwFavoriteStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwFavoriteStatusBuilder toBuilder() =>
      MwFavoriteStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwFavoriteStatus &&
        id == other.id &&
        isFavorited == other.isFavorited &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isFavorited.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwFavoriteStatus')
          ..add('id', id)
          ..add('isFavorited', isFavorited)
          ..add('count', count))
        .toString();
  }
}

class MwFavoriteStatusBuilder
    implements Builder<MwFavoriteStatus, MwFavoriteStatusBuilder> {
  _$MwFavoriteStatus? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _isFavorited;
  bool? get isFavorited => _$this._isFavorited;
  set isFavorited(bool? isFavorited) => _$this._isFavorited = isFavorited;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  MwFavoriteStatusBuilder() {
    MwFavoriteStatus._defaults(this);
  }

  MwFavoriteStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _isFavorited = $v.isFavorited;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwFavoriteStatus other) {
    _$v = other as _$MwFavoriteStatus;
  }

  @override
  void update(void Function(MwFavoriteStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwFavoriteStatus build() => _build();

  _$MwFavoriteStatus _build() {
    final _$result = _$v ??
        _$MwFavoriteStatus._(
          id: id,
          isFavorited: isFavorited,
          count: count,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
