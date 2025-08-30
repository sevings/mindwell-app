// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_comment_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwCommentList extends MwCommentList {
  @override
  final BuiltList<MwComment>? data;
  @override
  final String? nextAfter;
  @override
  final bool? hasAfter;
  @override
  final String? nextBefore;
  @override
  final bool? hasBefore;

  factory _$MwCommentList([void Function(MwCommentListBuilder)? updates]) =>
      (new MwCommentListBuilder()..update(updates))._build();

  _$MwCommentList._(
      {this.data,
      this.nextAfter,
      this.hasAfter,
      this.nextBefore,
      this.hasBefore})
      : super._();

  @override
  MwCommentList rebuild(void Function(MwCommentListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwCommentListBuilder toBuilder() => new MwCommentListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwCommentList &&
        data == other.data &&
        nextAfter == other.nextAfter &&
        hasAfter == other.hasAfter &&
        nextBefore == other.nextBefore &&
        hasBefore == other.hasBefore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, nextAfter.hashCode);
    _$hash = $jc(_$hash, hasAfter.hashCode);
    _$hash = $jc(_$hash, nextBefore.hashCode);
    _$hash = $jc(_$hash, hasBefore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwCommentList')
          ..add('data', data)
          ..add('nextAfter', nextAfter)
          ..add('hasAfter', hasAfter)
          ..add('nextBefore', nextBefore)
          ..add('hasBefore', hasBefore))
        .toString();
  }
}

class MwCommentListBuilder
    implements Builder<MwCommentList, MwCommentListBuilder> {
  _$MwCommentList? _$v;

  ListBuilder<MwComment>? _data;
  ListBuilder<MwComment> get data =>
      _$this._data ??= new ListBuilder<MwComment>();
  set data(ListBuilder<MwComment>? data) => _$this._data = data;

  String? _nextAfter;
  String? get nextAfter => _$this._nextAfter;
  set nextAfter(String? nextAfter) => _$this._nextAfter = nextAfter;

  bool? _hasAfter;
  bool? get hasAfter => _$this._hasAfter;
  set hasAfter(bool? hasAfter) => _$this._hasAfter = hasAfter;

  String? _nextBefore;
  String? get nextBefore => _$this._nextBefore;
  set nextBefore(String? nextBefore) => _$this._nextBefore = nextBefore;

  bool? _hasBefore;
  bool? get hasBefore => _$this._hasBefore;
  set hasBefore(bool? hasBefore) => _$this._hasBefore = hasBefore;

  MwCommentListBuilder() {
    MwCommentList._defaults(this);
  }

  MwCommentListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _nextAfter = $v.nextAfter;
      _hasAfter = $v.hasAfter;
      _nextBefore = $v.nextBefore;
      _hasBefore = $v.hasBefore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwCommentList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwCommentList;
  }

  @override
  void update(void Function(MwCommentListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwCommentList build() => _build();

  _$MwCommentList _build() {
    _$MwCommentList _$result;
    try {
      _$result = _$v ??
          new _$MwCommentList._(
              data: _data?.build(),
              nextAfter: nextAfter,
              hasAfter: hasAfter,
              nextBefore: nextBefore,
              hasBefore: hasBefore);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwCommentList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
