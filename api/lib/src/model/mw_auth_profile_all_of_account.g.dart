// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_auth_profile_all_of_account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAuthProfileAllOfAccount extends MwAuthProfileAllOfAccount {
  @override
  final String? email;
  @override
  final bool? verified;

  factory _$MwAuthProfileAllOfAccount(
          [void Function(MwAuthProfileAllOfAccountBuilder)? updates]) =>
      (MwAuthProfileAllOfAccountBuilder()..update(updates))._build();

  _$MwAuthProfileAllOfAccount._({this.email, this.verified}) : super._();
  @override
  MwAuthProfileAllOfAccount rebuild(
          void Function(MwAuthProfileAllOfAccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAuthProfileAllOfAccountBuilder toBuilder() =>
      MwAuthProfileAllOfAccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAuthProfileAllOfAccount &&
        email == other.email &&
        verified == other.verified;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, verified.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAuthProfileAllOfAccount')
          ..add('email', email)
          ..add('verified', verified))
        .toString();
  }
}

class MwAuthProfileAllOfAccountBuilder
    implements
        Builder<MwAuthProfileAllOfAccount, MwAuthProfileAllOfAccountBuilder> {
  _$MwAuthProfileAllOfAccount? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _verified;
  bool? get verified => _$this._verified;
  set verified(bool? verified) => _$this._verified = verified;

  MwAuthProfileAllOfAccountBuilder() {
    MwAuthProfileAllOfAccount._defaults(this);
  }

  MwAuthProfileAllOfAccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _verified = $v.verified;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAuthProfileAllOfAccount other) {
    _$v = other as _$MwAuthProfileAllOfAccount;
  }

  @override
  void update(void Function(MwAuthProfileAllOfAccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAuthProfileAllOfAccount build() => _build();

  _$MwAuthProfileAllOfAccount _build() {
    final _$result = _$v ??
        _$MwAuthProfileAllOfAccount._(
          email: email,
          verified: verified,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
