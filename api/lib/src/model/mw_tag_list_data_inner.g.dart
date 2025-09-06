// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_tag_list_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwTagListDataInner extends MwTagListDataInner {
  @override
  final String? tag;
  @override
  final int? count;

  factory _$MwTagListDataInner(
          [void Function(MwTagListDataInnerBuilder)? updates]) =>
      (MwTagListDataInnerBuilder()..update(updates))._build();

  _$MwTagListDataInner._({this.tag, this.count}) : super._();
  @override
  MwTagListDataInner rebuild(
          void Function(MwTagListDataInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwTagListDataInnerBuilder toBuilder() =>
      MwTagListDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwTagListDataInner &&
        tag == other.tag &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tag.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwTagListDataInner')
          ..add('tag', tag)
          ..add('count', count))
        .toString();
  }
}

class MwTagListDataInnerBuilder
    implements Builder<MwTagListDataInner, MwTagListDataInnerBuilder> {
  _$MwTagListDataInner? _$v;

  String? _tag;
  String? get tag => _$this._tag;
  set tag(String? tag) => _$this._tag = tag;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  MwTagListDataInnerBuilder() {
    MwTagListDataInner._defaults(this);
  }

  MwTagListDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tag = $v.tag;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwTagListDataInner other) {
    _$v = other as _$MwTagListDataInner;
  }

  @override
  void update(void Function(MwTagListDataInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwTagListDataInner build() => _build();

  _$MwTagListDataInner _build() {
    final _$result = _$v ??
        _$MwTagListDataInner._(
          tag: tag,
          count: count,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
