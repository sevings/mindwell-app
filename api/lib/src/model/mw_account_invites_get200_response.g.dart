// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_invites_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountInvitesGet200Response extends MwAccountInvitesGet200Response {
  @override
  final BuiltList<String>? invites;

  factory _$MwAccountInvitesGet200Response(
          [void Function(MwAccountInvitesGet200ResponseBuilder)? updates]) =>
      (MwAccountInvitesGet200ResponseBuilder()..update(updates))._build();

  _$MwAccountInvitesGet200Response._({this.invites}) : super._();
  @override
  MwAccountInvitesGet200Response rebuild(
          void Function(MwAccountInvitesGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountInvitesGet200ResponseBuilder toBuilder() =>
      MwAccountInvitesGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountInvitesGet200Response && invites == other.invites;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, invites.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAccountInvitesGet200Response')
          ..add('invites', invites))
        .toString();
  }
}

class MwAccountInvitesGet200ResponseBuilder
    implements
        Builder<MwAccountInvitesGet200Response,
            MwAccountInvitesGet200ResponseBuilder> {
  _$MwAccountInvitesGet200Response? _$v;

  ListBuilder<String>? _invites;
  ListBuilder<String> get invites => _$this._invites ??= ListBuilder<String>();
  set invites(ListBuilder<String>? invites) => _$this._invites = invites;

  MwAccountInvitesGet200ResponseBuilder() {
    MwAccountInvitesGet200Response._defaults(this);
  }

  MwAccountInvitesGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invites = $v.invites?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountInvitesGet200Response other) {
    _$v = other as _$MwAccountInvitesGet200Response;
  }

  @override
  void update(void Function(MwAccountInvitesGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountInvitesGet200Response build() => _build();

  _$MwAccountInvitesGet200Response _build() {
    _$MwAccountInvitesGet200Response _$result;
    try {
      _$result = _$v ??
          _$MwAccountInvitesGet200Response._(
            invites: _invites?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invites';
        _invites?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwAccountInvitesGet200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
