// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_settings_telegram_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountSettingsTelegramGet200Response
    extends MwAccountSettingsTelegramGet200Response {
  @override
  final bool? comments;
  @override
  final bool? followers;
  @override
  final bool? invites;
  @override
  final bool? messages;
  @override
  final bool? movedEntries;
  @override
  final bool? badges;

  factory _$MwAccountSettingsTelegramGet200Response(
          [void Function(MwAccountSettingsTelegramGet200ResponseBuilder)?
              updates]) =>
      (MwAccountSettingsTelegramGet200ResponseBuilder()..update(updates))
          ._build();

  _$MwAccountSettingsTelegramGet200Response._(
      {this.comments,
      this.followers,
      this.invites,
      this.messages,
      this.movedEntries,
      this.badges})
      : super._();
  @override
  MwAccountSettingsTelegramGet200Response rebuild(
          void Function(MwAccountSettingsTelegramGet200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountSettingsTelegramGet200ResponseBuilder toBuilder() =>
      MwAccountSettingsTelegramGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountSettingsTelegramGet200Response &&
        comments == other.comments &&
        followers == other.followers &&
        invites == other.invites &&
        messages == other.messages &&
        movedEntries == other.movedEntries &&
        badges == other.badges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, followers.hashCode);
    _$hash = $jc(_$hash, invites.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, movedEntries.hashCode);
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'MwAccountSettingsTelegramGet200Response')
          ..add('comments', comments)
          ..add('followers', followers)
          ..add('invites', invites)
          ..add('messages', messages)
          ..add('movedEntries', movedEntries)
          ..add('badges', badges))
        .toString();
  }
}

class MwAccountSettingsTelegramGet200ResponseBuilder
    implements
        Builder<MwAccountSettingsTelegramGet200Response,
            MwAccountSettingsTelegramGet200ResponseBuilder> {
  _$MwAccountSettingsTelegramGet200Response? _$v;

  bool? _comments;
  bool? get comments => _$this._comments;
  set comments(bool? comments) => _$this._comments = comments;

  bool? _followers;
  bool? get followers => _$this._followers;
  set followers(bool? followers) => _$this._followers = followers;

  bool? _invites;
  bool? get invites => _$this._invites;
  set invites(bool? invites) => _$this._invites = invites;

  bool? _messages;
  bool? get messages => _$this._messages;
  set messages(bool? messages) => _$this._messages = messages;

  bool? _movedEntries;
  bool? get movedEntries => _$this._movedEntries;
  set movedEntries(bool? movedEntries) => _$this._movedEntries = movedEntries;

  bool? _badges;
  bool? get badges => _$this._badges;
  set badges(bool? badges) => _$this._badges = badges;

  MwAccountSettingsTelegramGet200ResponseBuilder() {
    MwAccountSettingsTelegramGet200Response._defaults(this);
  }

  MwAccountSettingsTelegramGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comments = $v.comments;
      _followers = $v.followers;
      _invites = $v.invites;
      _messages = $v.messages;
      _movedEntries = $v.movedEntries;
      _badges = $v.badges;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountSettingsTelegramGet200Response other) {
    _$v = other as _$MwAccountSettingsTelegramGet200Response;
  }

  @override
  void update(
      void Function(MwAccountSettingsTelegramGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountSettingsTelegramGet200Response build() => _build();

  _$MwAccountSettingsTelegramGet200Response _build() {
    final _$result = _$v ??
        _$MwAccountSettingsTelegramGet200Response._(
          comments: comments,
          followers: followers,
          invites: invites,
          messages: messages,
          movedEntries: movedEntries,
          badges: badges,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
