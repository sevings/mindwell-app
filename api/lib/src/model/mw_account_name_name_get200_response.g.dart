// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_name_name_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountNameNameGet200Response
    extends MwAccountNameNameGet200Response {
  @override
  final String? name;
  @override
  final bool? isFree;

  factory _$MwAccountNameNameGet200Response(
          [void Function(MwAccountNameNameGet200ResponseBuilder)? updates]) =>
      (new MwAccountNameNameGet200ResponseBuilder()..update(updates))._build();

  _$MwAccountNameNameGet200Response._({this.name, this.isFree}) : super._();

  @override
  MwAccountNameNameGet200Response rebuild(
          void Function(MwAccountNameNameGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountNameNameGet200ResponseBuilder toBuilder() =>
      new MwAccountNameNameGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountNameNameGet200Response &&
        name == other.name &&
        isFree == other.isFree;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, isFree.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAccountNameNameGet200Response')
          ..add('name', name)
          ..add('isFree', isFree))
        .toString();
  }
}

class MwAccountNameNameGet200ResponseBuilder
    implements
        Builder<MwAccountNameNameGet200Response,
            MwAccountNameNameGet200ResponseBuilder> {
  _$MwAccountNameNameGet200Response? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _isFree;
  bool? get isFree => _$this._isFree;
  set isFree(bool? isFree) => _$this._isFree = isFree;

  MwAccountNameNameGet200ResponseBuilder() {
    MwAccountNameNameGet200Response._defaults(this);
  }

  MwAccountNameNameGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _isFree = $v.isFree;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountNameNameGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAccountNameNameGet200Response;
  }

  @override
  void update(void Function(MwAccountNameNameGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountNameNameGet200Response build() => _build();

  _$MwAccountNameNameGet200Response _build() {
    final _$result = _$v ??
        new _$MwAccountNameNameGet200Response._(name: name, isFree: isFree);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
