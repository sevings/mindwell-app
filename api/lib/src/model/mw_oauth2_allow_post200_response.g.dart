// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_oauth2_allow_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwOauth2AllowPost200Response extends MwOauth2AllowPost200Response {
  @override
  final String? code;
  @override
  final String? state;

  factory _$MwOauth2AllowPost200Response(
          [void Function(MwOauth2AllowPost200ResponseBuilder)? updates]) =>
      (MwOauth2AllowPost200ResponseBuilder()..update(updates))._build();

  _$MwOauth2AllowPost200Response._({this.code, this.state}) : super._();
  @override
  MwOauth2AllowPost200Response rebuild(
          void Function(MwOauth2AllowPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwOauth2AllowPost200ResponseBuilder toBuilder() =>
      MwOauth2AllowPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwOauth2AllowPost200Response &&
        code == other.code &&
        state == other.state;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwOauth2AllowPost200Response')
          ..add('code', code)
          ..add('state', state))
        .toString();
  }
}

class MwOauth2AllowPost200ResponseBuilder
    implements
        Builder<MwOauth2AllowPost200Response,
            MwOauth2AllowPost200ResponseBuilder> {
  _$MwOauth2AllowPost200Response? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  MwOauth2AllowPost200ResponseBuilder() {
    MwOauth2AllowPost200Response._defaults(this);
  }

  MwOauth2AllowPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _state = $v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwOauth2AllowPost200Response other) {
    _$v = other as _$MwOauth2AllowPost200Response;
  }

  @override
  void update(void Function(MwOauth2AllowPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwOauth2AllowPost200Response build() => _build();

  _$MwOauth2AllowPost200Response _build() {
    final _$result = _$v ??
        _$MwOauth2AllowPost200Response._(
          code: code,
          state: state,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
