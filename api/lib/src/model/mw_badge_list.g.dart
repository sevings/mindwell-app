// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_badge_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwBadgeList extends MwBadgeList {
  @override
  final BuiltList<MwBadge>? data;

  factory _$MwBadgeList([void Function(MwBadgeListBuilder)? updates]) =>
      (MwBadgeListBuilder()..update(updates))._build();

  _$MwBadgeList._({this.data}) : super._();
  @override
  MwBadgeList rebuild(void Function(MwBadgeListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwBadgeListBuilder toBuilder() => MwBadgeListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwBadgeList && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwBadgeList')..add('data', data))
        .toString();
  }
}

class MwBadgeListBuilder implements Builder<MwBadgeList, MwBadgeListBuilder> {
  _$MwBadgeList? _$v;

  ListBuilder<MwBadge>? _data;
  ListBuilder<MwBadge> get data => _$this._data ??= ListBuilder<MwBadge>();
  set data(ListBuilder<MwBadge>? data) => _$this._data = data;

  MwBadgeListBuilder() {
    MwBadgeList._defaults(this);
  }

  MwBadgeListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwBadgeList other) {
    _$v = other as _$MwBadgeList;
  }

  @override
  void update(void Function(MwBadgeListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwBadgeList build() => _build();

  _$MwBadgeList _build() {
    _$MwBadgeList _$result;
    try {
      _$result = _$v ??
          _$MwBadgeList._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwBadgeList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
