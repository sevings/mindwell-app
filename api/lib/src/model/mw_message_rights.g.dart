// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_message_rights.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwMessageRights extends MwMessageRights {
  @override
  final bool? edit;
  @override
  final bool? delete;
  @override
  final bool? complain;

  factory _$MwMessageRights([void Function(MwMessageRightsBuilder)? updates]) =>
      (new MwMessageRightsBuilder()..update(updates))._build();

  _$MwMessageRights._({this.edit, this.delete, this.complain}) : super._();

  @override
  MwMessageRights rebuild(void Function(MwMessageRightsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwMessageRightsBuilder toBuilder() =>
      new MwMessageRightsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwMessageRights &&
        edit == other.edit &&
        delete == other.delete &&
        complain == other.complain;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, edit.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jc(_$hash, complain.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwMessageRights')
          ..add('edit', edit)
          ..add('delete', delete)
          ..add('complain', complain))
        .toString();
  }
}

class MwMessageRightsBuilder
    implements Builder<MwMessageRights, MwMessageRightsBuilder> {
  _$MwMessageRights? _$v;

  bool? _edit;
  bool? get edit => _$this._edit;
  set edit(bool? edit) => _$this._edit = edit;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  bool? _complain;
  bool? get complain => _$this._complain;
  set complain(bool? complain) => _$this._complain = complain;

  MwMessageRightsBuilder() {
    MwMessageRights._defaults(this);
  }

  MwMessageRightsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _edit = $v.edit;
      _delete = $v.delete;
      _complain = $v.complain;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwMessageRights other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwMessageRights;
  }

  @override
  void update(void Function(MwMessageRightsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwMessageRights build() => _build();

  _$MwMessageRights _build() {
    final _$result = _$v ??
        new _$MwMessageRights._(edit: edit, delete: delete, complain: complain);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
