// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_chat_rights.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwChatRights extends MwChatRights {
  @override
  final bool? send;

  factory _$MwChatRights([void Function(MwChatRightsBuilder)? updates]) =>
      (new MwChatRightsBuilder()..update(updates))._build();

  _$MwChatRights._({this.send}) : super._();

  @override
  MwChatRights rebuild(void Function(MwChatRightsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwChatRightsBuilder toBuilder() => new MwChatRightsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwChatRights && send == other.send;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, send.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwChatRights')..add('send', send))
        .toString();
  }
}

class MwChatRightsBuilder
    implements Builder<MwChatRights, MwChatRightsBuilder> {
  _$MwChatRights? _$v;

  bool? _send;
  bool? get send => _$this._send;
  set send(bool? send) => _$this._send = send;

  MwChatRightsBuilder() {
    MwChatRights._defaults(this);
  }

  MwChatRightsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _send = $v.send;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwChatRights other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwChatRights;
  }

  @override
  void update(void Function(MwChatRightsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwChatRights build() => _build();

  _$MwChatRights _build() {
    final _$result = _$v ?? new _$MwChatRights._(send: send);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
