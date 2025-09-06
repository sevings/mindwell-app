// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_o_auth2_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_accessDenied =
    const MwOAuth2ErrorErrorEnum._('accessDenied');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_invalidClient =
    const MwOAuth2ErrorErrorEnum._('invalidClient');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_invalidGrant =
    const MwOAuth2ErrorErrorEnum._('invalidGrant');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_invalidRedirect =
    const MwOAuth2ErrorErrorEnum._('invalidRedirect');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_invalidRequest =
    const MwOAuth2ErrorErrorEnum._('invalidRequest');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_invalidScope =
    const MwOAuth2ErrorErrorEnum._('invalidScope');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_invalidToken =
    const MwOAuth2ErrorErrorEnum._('invalidToken');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_serverError =
    const MwOAuth2ErrorErrorEnum._('serverError');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_temporarilyUnavailable =
    const MwOAuth2ErrorErrorEnum._('temporarilyUnavailable');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_unauthorizedClient =
    const MwOAuth2ErrorErrorEnum._('unauthorizedClient');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_unrecognizedClient =
    const MwOAuth2ErrorErrorEnum._('unrecognizedClient');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_unsupportedGrantType =
    const MwOAuth2ErrorErrorEnum._('unsupportedGrantType');
const MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnum_unsupportedResponseType =
    const MwOAuth2ErrorErrorEnum._('unsupportedResponseType');

MwOAuth2ErrorErrorEnum _$mwOAuth2ErrorErrorEnumValueOf(String name) {
  switch (name) {
    case 'accessDenied':
      return _$mwOAuth2ErrorErrorEnum_accessDenied;
    case 'invalidClient':
      return _$mwOAuth2ErrorErrorEnum_invalidClient;
    case 'invalidGrant':
      return _$mwOAuth2ErrorErrorEnum_invalidGrant;
    case 'invalidRedirect':
      return _$mwOAuth2ErrorErrorEnum_invalidRedirect;
    case 'invalidRequest':
      return _$mwOAuth2ErrorErrorEnum_invalidRequest;
    case 'invalidScope':
      return _$mwOAuth2ErrorErrorEnum_invalidScope;
    case 'invalidToken':
      return _$mwOAuth2ErrorErrorEnum_invalidToken;
    case 'serverError':
      return _$mwOAuth2ErrorErrorEnum_serverError;
    case 'temporarilyUnavailable':
      return _$mwOAuth2ErrorErrorEnum_temporarilyUnavailable;
    case 'unauthorizedClient':
      return _$mwOAuth2ErrorErrorEnum_unauthorizedClient;
    case 'unrecognizedClient':
      return _$mwOAuth2ErrorErrorEnum_unrecognizedClient;
    case 'unsupportedGrantType':
      return _$mwOAuth2ErrorErrorEnum_unsupportedGrantType;
    case 'unsupportedResponseType':
      return _$mwOAuth2ErrorErrorEnum_unsupportedResponseType;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwOAuth2ErrorErrorEnum> _$mwOAuth2ErrorErrorEnumValues =
    BuiltSet<MwOAuth2ErrorErrorEnum>(const <MwOAuth2ErrorErrorEnum>[
  _$mwOAuth2ErrorErrorEnum_accessDenied,
  _$mwOAuth2ErrorErrorEnum_invalidClient,
  _$mwOAuth2ErrorErrorEnum_invalidGrant,
  _$mwOAuth2ErrorErrorEnum_invalidRedirect,
  _$mwOAuth2ErrorErrorEnum_invalidRequest,
  _$mwOAuth2ErrorErrorEnum_invalidScope,
  _$mwOAuth2ErrorErrorEnum_invalidToken,
  _$mwOAuth2ErrorErrorEnum_serverError,
  _$mwOAuth2ErrorErrorEnum_temporarilyUnavailable,
  _$mwOAuth2ErrorErrorEnum_unauthorizedClient,
  _$mwOAuth2ErrorErrorEnum_unrecognizedClient,
  _$mwOAuth2ErrorErrorEnum_unsupportedGrantType,
  _$mwOAuth2ErrorErrorEnum_unsupportedResponseType,
]);

Serializer<MwOAuth2ErrorErrorEnum> _$mwOAuth2ErrorErrorEnumSerializer =
    _$MwOAuth2ErrorErrorEnumSerializer();

class _$MwOAuth2ErrorErrorEnumSerializer
    implements PrimitiveSerializer<MwOAuth2ErrorErrorEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'accessDenied': 'access_denied',
    'invalidClient': 'invalid_client',
    'invalidGrant': 'invalid_grant',
    'invalidRedirect': 'invalid_redirect',
    'invalidRequest': 'invalid_request',
    'invalidScope': 'invalid_scope',
    'invalidToken': 'invalid_token',
    'serverError': 'server_error',
    'temporarilyUnavailable': 'temporarily_unavailable',
    'unauthorizedClient': 'unauthorized_client',
    'unrecognizedClient': 'unrecognized_client',
    'unsupportedGrantType': 'unsupported_grant_type',
    'unsupportedResponseType': 'unsupported_response_type',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'access_denied': 'accessDenied',
    'invalid_client': 'invalidClient',
    'invalid_grant': 'invalidGrant',
    'invalid_redirect': 'invalidRedirect',
    'invalid_request': 'invalidRequest',
    'invalid_scope': 'invalidScope',
    'invalid_token': 'invalidToken',
    'server_error': 'serverError',
    'temporarily_unavailable': 'temporarilyUnavailable',
    'unauthorized_client': 'unauthorizedClient',
    'unrecognized_client': 'unrecognizedClient',
    'unsupported_grant_type': 'unsupportedGrantType',
    'unsupported_response_type': 'unsupportedResponseType',
  };

  @override
  final Iterable<Type> types = const <Type>[MwOAuth2ErrorErrorEnum];
  @override
  final String wireName = 'MwOAuth2ErrorErrorEnum';

  @override
  Object serialize(Serializers serializers, MwOAuth2ErrorErrorEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwOAuth2ErrorErrorEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwOAuth2ErrorErrorEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwOAuth2Error extends MwOAuth2Error {
  @override
  final MwOAuth2ErrorErrorEnum? error;

  factory _$MwOAuth2Error([void Function(MwOAuth2ErrorBuilder)? updates]) =>
      (MwOAuth2ErrorBuilder()..update(updates))._build();

  _$MwOAuth2Error._({this.error}) : super._();
  @override
  MwOAuth2Error rebuild(void Function(MwOAuth2ErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwOAuth2ErrorBuilder toBuilder() => MwOAuth2ErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwOAuth2Error && error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwOAuth2Error')..add('error', error))
        .toString();
  }
}

class MwOAuth2ErrorBuilder
    implements Builder<MwOAuth2Error, MwOAuth2ErrorBuilder> {
  _$MwOAuth2Error? _$v;

  MwOAuth2ErrorErrorEnum? _error;
  MwOAuth2ErrorErrorEnum? get error => _$this._error;
  set error(MwOAuth2ErrorErrorEnum? error) => _$this._error = error;

  MwOAuth2ErrorBuilder() {
    MwOAuth2Error._defaults(this);
  }

  MwOAuth2ErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwOAuth2Error other) {
    _$v = other as _$MwOAuth2Error;
  }

  @override
  void update(void Function(MwOAuth2ErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwOAuth2Error build() => _build();

  _$MwOAuth2Error _build() {
    final _$result = _$v ??
        _$MwOAuth2Error._(
          error: error,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
