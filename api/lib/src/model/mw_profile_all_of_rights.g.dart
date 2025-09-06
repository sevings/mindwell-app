// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_profile_all_of_rights.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwProfileAllOfRights extends MwProfileAllOfRights {
  @override
  final bool? chat;
  @override
  final bool? ignore;
  @override
  final bool? complain;

  factory _$MwProfileAllOfRights(
          [void Function(MwProfileAllOfRightsBuilder)? updates]) =>
      (MwProfileAllOfRightsBuilder()..update(updates))._build();

  _$MwProfileAllOfRights._({this.chat, this.ignore, this.complain}) : super._();
  @override
  MwProfileAllOfRights rebuild(
          void Function(MwProfileAllOfRightsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwProfileAllOfRightsBuilder toBuilder() =>
      MwProfileAllOfRightsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwProfileAllOfRights &&
        chat == other.chat &&
        ignore == other.ignore &&
        complain == other.complain;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chat.hashCode);
    _$hash = $jc(_$hash, ignore.hashCode);
    _$hash = $jc(_$hash, complain.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwProfileAllOfRights')
          ..add('chat', chat)
          ..add('ignore', ignore)
          ..add('complain', complain))
        .toString();
  }
}

class MwProfileAllOfRightsBuilder
    implements Builder<MwProfileAllOfRights, MwProfileAllOfRightsBuilder> {
  _$MwProfileAllOfRights? _$v;

  bool? _chat;
  bool? get chat => _$this._chat;
  set chat(bool? chat) => _$this._chat = chat;

  bool? _ignore;
  bool? get ignore => _$this._ignore;
  set ignore(bool? ignore) => _$this._ignore = ignore;

  bool? _complain;
  bool? get complain => _$this._complain;
  set complain(bool? complain) => _$this._complain = complain;

  MwProfileAllOfRightsBuilder() {
    MwProfileAllOfRights._defaults(this);
  }

  MwProfileAllOfRightsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chat = $v.chat;
      _ignore = $v.ignore;
      _complain = $v.complain;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwProfileAllOfRights other) {
    _$v = other as _$MwProfileAllOfRights;
  }

  @override
  void update(void Function(MwProfileAllOfRightsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwProfileAllOfRights build() => _build();

  _$MwProfileAllOfRights _build() {
    final _$result = _$v ??
        _$MwProfileAllOfRights._(
          chat: chat,
          ignore: ignore,
          complain: complain,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
