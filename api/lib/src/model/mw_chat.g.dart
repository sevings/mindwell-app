// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_chat.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwChat extends MwChat {
  @override
  final int? id;
  @override
  final MwUser? partner;
  @override
  final MwMessage? lastMessage;
  @override
  final int? unreadCount;
  @override
  final MwChatRights? rights;

  factory _$MwChat([void Function(MwChatBuilder)? updates]) =>
      (MwChatBuilder()..update(updates))._build();

  _$MwChat._(
      {this.id, this.partner, this.lastMessage, this.unreadCount, this.rights})
      : super._();
  @override
  MwChat rebuild(void Function(MwChatBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwChatBuilder toBuilder() => MwChatBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwChat &&
        id == other.id &&
        partner == other.partner &&
        lastMessage == other.lastMessage &&
        unreadCount == other.unreadCount &&
        rights == other.rights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, partner.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, rights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwChat')
          ..add('id', id)
          ..add('partner', partner)
          ..add('lastMessage', lastMessage)
          ..add('unreadCount', unreadCount)
          ..add('rights', rights))
        .toString();
  }
}

class MwChatBuilder implements Builder<MwChat, MwChatBuilder> {
  _$MwChat? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MwUser? _partner;
  MwUser? get partner => _$this._partner;
  set partner(MwUser? partner) => _$this._partner = partner;

  MwMessageBuilder? _lastMessage;
  MwMessageBuilder get lastMessage =>
      _$this._lastMessage ??= MwMessageBuilder();
  set lastMessage(MwMessageBuilder? lastMessage) =>
      _$this._lastMessage = lastMessage;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  MwChatRightsBuilder? _rights;
  MwChatRightsBuilder get rights => _$this._rights ??= MwChatRightsBuilder();
  set rights(MwChatRightsBuilder? rights) => _$this._rights = rights;

  MwChatBuilder() {
    MwChat._defaults(this);
  }

  MwChatBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _partner = $v.partner;
      _lastMessage = $v.lastMessage?.toBuilder();
      _unreadCount = $v.unreadCount;
      _rights = $v.rights?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwChat other) {
    _$v = other as _$MwChat;
  }

  @override
  void update(void Function(MwChatBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwChat build() => _build();

  _$MwChat _build() {
    _$MwChat _$result;
    try {
      _$result = _$v ??
          _$MwChat._(
            id: id,
            partner: partner,
            lastMessage: _lastMessage?.build(),
            unreadCount: unreadCount,
            rights: _rights?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lastMessage';
        _lastMessage?.build();

        _$failedField = 'rights';
        _rights?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwChat', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
