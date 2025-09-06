// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_subscribe_token_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountSubscribeTokenGet200Response
    extends MwAccountSubscribeTokenGet200Response {
  @override
  final String? token;

  factory _$MwAccountSubscribeTokenGet200Response(
          [void Function(MwAccountSubscribeTokenGet200ResponseBuilder)?
              updates]) =>
      (MwAccountSubscribeTokenGet200ResponseBuilder()..update(updates))
          ._build();

  _$MwAccountSubscribeTokenGet200Response._({this.token}) : super._();
  @override
  MwAccountSubscribeTokenGet200Response rebuild(
          void Function(MwAccountSubscribeTokenGet200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountSubscribeTokenGet200ResponseBuilder toBuilder() =>
      MwAccountSubscribeTokenGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountSubscribeTokenGet200Response &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'MwAccountSubscribeTokenGet200Response')
          ..add('token', token))
        .toString();
  }
}

class MwAccountSubscribeTokenGet200ResponseBuilder
    implements
        Builder<MwAccountSubscribeTokenGet200Response,
            MwAccountSubscribeTokenGet200ResponseBuilder> {
  _$MwAccountSubscribeTokenGet200Response? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  MwAccountSubscribeTokenGet200ResponseBuilder() {
    MwAccountSubscribeTokenGet200Response._defaults(this);
  }

  MwAccountSubscribeTokenGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountSubscribeTokenGet200Response other) {
    _$v = other as _$MwAccountSubscribeTokenGet200Response;
  }

  @override
  void update(
      void Function(MwAccountSubscribeTokenGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountSubscribeTokenGet200Response build() => _build();

  _$MwAccountSubscribeTokenGet200Response _build() {
    final _$result = _$v ??
        _$MwAccountSubscribeTokenGet200Response._(
          token: token,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
