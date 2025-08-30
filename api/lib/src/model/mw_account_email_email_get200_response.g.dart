// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_email_email_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountEmailEmailGet200Response
    extends MwAccountEmailEmailGet200Response {
  @override
  final String? email;
  @override
  final bool? isFree;

  factory _$MwAccountEmailEmailGet200Response(
          [void Function(MwAccountEmailEmailGet200ResponseBuilder)? updates]) =>
      (new MwAccountEmailEmailGet200ResponseBuilder()..update(updates))
          ._build();

  _$MwAccountEmailEmailGet200Response._({this.email, this.isFree}) : super._();

  @override
  MwAccountEmailEmailGet200Response rebuild(
          void Function(MwAccountEmailEmailGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountEmailEmailGet200ResponseBuilder toBuilder() =>
      new MwAccountEmailEmailGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountEmailEmailGet200Response &&
        email == other.email &&
        isFree == other.isFree;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, isFree.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAccountEmailEmailGet200Response')
          ..add('email', email)
          ..add('isFree', isFree))
        .toString();
  }
}

class MwAccountEmailEmailGet200ResponseBuilder
    implements
        Builder<MwAccountEmailEmailGet200Response,
            MwAccountEmailEmailGet200ResponseBuilder> {
  _$MwAccountEmailEmailGet200Response? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _isFree;
  bool? get isFree => _$this._isFree;
  set isFree(bool? isFree) => _$this._isFree = isFree;

  MwAccountEmailEmailGet200ResponseBuilder() {
    MwAccountEmailEmailGet200Response._defaults(this);
  }

  MwAccountEmailEmailGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _isFree = $v.isFree;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountEmailEmailGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAccountEmailEmailGet200Response;
  }

  @override
  void update(
      void Function(MwAccountEmailEmailGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountEmailEmailGet200Response build() => _build();

  _$MwAccountEmailEmailGet200Response _build() {
    final _$result = _$v ??
        new _$MwAccountEmailEmailGet200Response._(email: email, isFree: isFree);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
