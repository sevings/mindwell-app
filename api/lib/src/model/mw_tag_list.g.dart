// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_tag_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwTagList extends MwTagList {
  @override
  final BuiltList<MwTagListDataInner>? data;

  factory _$MwTagList([void Function(MwTagListBuilder)? updates]) =>
      (MwTagListBuilder()..update(updates))._build();

  _$MwTagList._({this.data}) : super._();
  @override
  MwTagList rebuild(void Function(MwTagListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwTagListBuilder toBuilder() => MwTagListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwTagList && data == other.data;
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
    return (newBuiltValueToStringHelper(r'MwTagList')..add('data', data))
        .toString();
  }
}

class MwTagListBuilder implements Builder<MwTagList, MwTagListBuilder> {
  _$MwTagList? _$v;

  ListBuilder<MwTagListDataInner>? _data;
  ListBuilder<MwTagListDataInner> get data =>
      _$this._data ??= ListBuilder<MwTagListDataInner>();
  set data(ListBuilder<MwTagListDataInner>? data) => _$this._data = data;

  MwTagListBuilder() {
    MwTagList._defaults(this);
  }

  MwTagListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwTagList other) {
    _$v = other as _$MwTagList;
  }

  @override
  void update(void Function(MwTagListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwTagList build() => _build();

  _$MwTagList _build() {
    _$MwTagList _$result;
    try {
      _$result = _$v ??
          _$MwTagList._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwTagList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
