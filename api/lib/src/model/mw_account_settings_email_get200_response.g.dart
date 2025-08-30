// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_settings_email_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountSettingsEmailGet200Response
    extends MwAccountSettingsEmailGet200Response {
  @override
  final bool? comments;
  @override
  final bool? followers;
  @override
  final bool? invites;

  factory _$MwAccountSettingsEmailGet200Response(
          [void Function(MwAccountSettingsEmailGet200ResponseBuilder)?
              updates]) =>
      (new MwAccountSettingsEmailGet200ResponseBuilder()..update(updates))
          ._build();

  _$MwAccountSettingsEmailGet200Response._(
      {this.comments, this.followers, this.invites})
      : super._();

  @override
  MwAccountSettingsEmailGet200Response rebuild(
          void Function(MwAccountSettingsEmailGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountSettingsEmailGet200ResponseBuilder toBuilder() =>
      new MwAccountSettingsEmailGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountSettingsEmailGet200Response &&
        comments == other.comments &&
        followers == other.followers &&
        invites == other.invites;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, followers.hashCode);
    _$hash = $jc(_$hash, invites.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAccountSettingsEmailGet200Response')
          ..add('comments', comments)
          ..add('followers', followers)
          ..add('invites', invites))
        .toString();
  }
}

class MwAccountSettingsEmailGet200ResponseBuilder
    implements
        Builder<MwAccountSettingsEmailGet200Response,
            MwAccountSettingsEmailGet200ResponseBuilder> {
  _$MwAccountSettingsEmailGet200Response? _$v;

  bool? _comments;
  bool? get comments => _$this._comments;
  set comments(bool? comments) => _$this._comments = comments;

  bool? _followers;
  bool? get followers => _$this._followers;
  set followers(bool? followers) => _$this._followers = followers;

  bool? _invites;
  bool? get invites => _$this._invites;
  set invites(bool? invites) => _$this._invites = invites;

  MwAccountSettingsEmailGet200ResponseBuilder() {
    MwAccountSettingsEmailGet200Response._defaults(this);
  }

  MwAccountSettingsEmailGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comments = $v.comments;
      _followers = $v.followers;
      _invites = $v.invites;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountSettingsEmailGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAccountSettingsEmailGet200Response;
  }

  @override
  void update(
      void Function(MwAccountSettingsEmailGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountSettingsEmailGet200Response build() => _build();

  _$MwAccountSettingsEmailGet200Response _build() {
    final _$result = _$v ??
        new _$MwAccountSettingsEmailGet200Response._(
            comments: comments, followers: followers, invites: invites);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
