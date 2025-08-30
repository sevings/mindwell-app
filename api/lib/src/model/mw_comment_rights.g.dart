// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_comment_rights.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwCommentRights extends MwCommentRights {
  @override
  final bool? edit;
  @override
  final bool? delete;
  @override
  final bool? vote;
  @override
  final bool? complain;

  factory _$MwCommentRights([void Function(MwCommentRightsBuilder)? updates]) =>
      (new MwCommentRightsBuilder()..update(updates))._build();

  _$MwCommentRights._({this.edit, this.delete, this.vote, this.complain})
      : super._();

  @override
  MwCommentRights rebuild(void Function(MwCommentRightsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwCommentRightsBuilder toBuilder() =>
      new MwCommentRightsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwCommentRights &&
        edit == other.edit &&
        delete == other.delete &&
        vote == other.vote &&
        complain == other.complain;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, edit.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jc(_$hash, vote.hashCode);
    _$hash = $jc(_$hash, complain.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwCommentRights')
          ..add('edit', edit)
          ..add('delete', delete)
          ..add('vote', vote)
          ..add('complain', complain))
        .toString();
  }
}

class MwCommentRightsBuilder
    implements Builder<MwCommentRights, MwCommentRightsBuilder> {
  _$MwCommentRights? _$v;

  bool? _edit;
  bool? get edit => _$this._edit;
  set edit(bool? edit) => _$this._edit = edit;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  bool? _vote;
  bool? get vote => _$this._vote;
  set vote(bool? vote) => _$this._vote = vote;

  bool? _complain;
  bool? get complain => _$this._complain;
  set complain(bool? complain) => _$this._complain = complain;

  MwCommentRightsBuilder() {
    MwCommentRights._defaults(this);
  }

  MwCommentRightsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _edit = $v.edit;
      _delete = $v.delete;
      _vote = $v.vote;
      _complain = $v.complain;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwCommentRights other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwCommentRights;
  }

  @override
  void update(void Function(MwCommentRightsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwCommentRights build() => _build();

  _$MwCommentRights _build() {
    final _$result = _$v ??
        new _$MwCommentRights._(
            edit: edit, delete: delete, vote: vote, complain: complain);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
