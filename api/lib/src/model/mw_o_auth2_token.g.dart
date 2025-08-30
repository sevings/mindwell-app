// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_o_auth2_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwOAuth2TokenTokenTypeEnum _$mwOAuth2TokenTokenTypeEnum_bearer =
    const MwOAuth2TokenTokenTypeEnum._('bearer');

MwOAuth2TokenTokenTypeEnum _$mwOAuth2TokenTokenTypeEnumValueOf(String name) {
  switch (name) {
    case 'bearer':
      return _$mwOAuth2TokenTokenTypeEnum_bearer;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwOAuth2TokenTokenTypeEnum> _$mwOAuth2TokenTokenTypeEnumValues =
    new BuiltSet<MwOAuth2TokenTokenTypeEnum>(const <MwOAuth2TokenTokenTypeEnum>[
  _$mwOAuth2TokenTokenTypeEnum_bearer,
]);

Serializer<MwOAuth2TokenTokenTypeEnum> _$mwOAuth2TokenTokenTypeEnumSerializer =
    new _$MwOAuth2TokenTokenTypeEnumSerializer();

class _$MwOAuth2TokenTokenTypeEnumSerializer
    implements PrimitiveSerializer<MwOAuth2TokenTokenTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bearer': 'bearer',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bearer': 'bearer',
  };

  @override
  final Iterable<Type> types = const <Type>[MwOAuth2TokenTokenTypeEnum];
  @override
  final String wireName = 'MwOAuth2TokenTokenTypeEnum';

  @override
  Object serialize(Serializers serializers, MwOAuth2TokenTokenTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwOAuth2TokenTokenTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwOAuth2TokenTokenTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwOAuth2Token extends MwOAuth2Token {
  @override
  final String? accessToken;
  @override
  final MwOAuth2TokenTokenTypeEnum? tokenType;
  @override
  final int? expiresIn;
  @override
  final String? refreshToken;
  @override
  final BuiltList<String>? scope;

  factory _$MwOAuth2Token([void Function(MwOAuth2TokenBuilder)? updates]) =>
      (new MwOAuth2TokenBuilder()..update(updates))._build();

  _$MwOAuth2Token._(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.refreshToken,
      this.scope})
      : super._();

  @override
  MwOAuth2Token rebuild(void Function(MwOAuth2TokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwOAuth2TokenBuilder toBuilder() => new MwOAuth2TokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwOAuth2Token &&
        accessToken == other.accessToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        refreshToken == other.refreshToken &&
        scope == other.scope;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwOAuth2Token')
          ..add('accessToken', accessToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('refreshToken', refreshToken)
          ..add('scope', scope))
        .toString();
  }
}

class MwOAuth2TokenBuilder
    implements Builder<MwOAuth2Token, MwOAuth2TokenBuilder> {
  _$MwOAuth2Token? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  MwOAuth2TokenTokenTypeEnum? _tokenType;
  MwOAuth2TokenTokenTypeEnum? get tokenType => _$this._tokenType;
  set tokenType(MwOAuth2TokenTokenTypeEnum? tokenType) =>
      _$this._tokenType = tokenType;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  ListBuilder<String>? _scope;
  ListBuilder<String> get scope => _$this._scope ??= new ListBuilder<String>();
  set scope(ListBuilder<String>? scope) => _$this._scope = scope;

  MwOAuth2TokenBuilder() {
    MwOAuth2Token._defaults(this);
  }

  MwOAuth2TokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _refreshToken = $v.refreshToken;
      _scope = $v.scope?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwOAuth2Token other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwOAuth2Token;
  }

  @override
  void update(void Function(MwOAuth2TokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwOAuth2Token build() => _build();

  _$MwOAuth2Token _build() {
    _$MwOAuth2Token _$result;
    try {
      _$result = _$v ??
          new _$MwOAuth2Token._(
              accessToken: accessToken,
              tokenType: tokenType,
              expiresIn: expiresIn,
              refreshToken: refreshToken,
              scope: _scope?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'scope';
        _scope?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwOAuth2Token', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
