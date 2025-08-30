// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_entry_rights.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwEntryRights extends MwEntryRights {
  @override
  final bool? edit;
  @override
  final bool? delete;
  @override
  final bool? comment;
  @override
  final bool? vote;
  @override
  final bool? complain;

  factory _$MwEntryRights([void Function(MwEntryRightsBuilder)? updates]) =>
      (new MwEntryRightsBuilder()..update(updates))._build();

  _$MwEntryRights._(
      {this.edit, this.delete, this.comment, this.vote, this.complain})
      : super._();

  @override
  MwEntryRights rebuild(void Function(MwEntryRightsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwEntryRightsBuilder toBuilder() => new MwEntryRightsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwEntryRights &&
        edit == other.edit &&
        delete == other.delete &&
        comment == other.comment &&
        vote == other.vote &&
        complain == other.complain;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, edit.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, vote.hashCode);
    _$hash = $jc(_$hash, complain.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwEntryRights')
          ..add('edit', edit)
          ..add('delete', delete)
          ..add('comment', comment)
          ..add('vote', vote)
          ..add('complain', complain))
        .toString();
  }
}

class MwEntryRightsBuilder
    implements Builder<MwEntryRights, MwEntryRightsBuilder> {
  _$MwEntryRights? _$v;

  bool? _edit;
  bool? get edit => _$this._edit;
  set edit(bool? edit) => _$this._edit = edit;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  bool? _comment;
  bool? get comment => _$this._comment;
  set comment(bool? comment) => _$this._comment = comment;

  bool? _vote;
  bool? get vote => _$this._vote;
  set vote(bool? vote) => _$this._vote = vote;

  bool? _complain;
  bool? get complain => _$this._complain;
  set complain(bool? complain) => _$this._complain = complain;

  MwEntryRightsBuilder() {
    MwEntryRights._defaults(this);
  }

  MwEntryRightsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _edit = $v.edit;
      _delete = $v.delete;
      _comment = $v.comment;
      _vote = $v.vote;
      _complain = $v.complain;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwEntryRights other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwEntryRights;
  }

  @override
  void update(void Function(MwEntryRightsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwEntryRights build() => _build();

  _$MwEntryRights _build() {
    final _$result = _$v ??
        new _$MwEntryRights._(
            edit: edit,
            delete: delete,
            comment: comment,
            vote: vote,
            complain: complain);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
