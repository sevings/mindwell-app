// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwError extends MwError {
  @override
  final String? message;

  factory _$MwError([void Function(MwErrorBuilder)? updates]) =>
      (MwErrorBuilder()..update(updates))._build();

  _$MwError._({this.message}) : super._();
  @override
  MwError rebuild(void Function(MwErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwErrorBuilder toBuilder() => MwErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwError && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwError')..add('message', message))
        .toString();
  }
}

class MwErrorBuilder implements Builder<MwError, MwErrorBuilder> {
  _$MwError? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MwErrorBuilder() {
    MwError._defaults(this);
  }

  MwErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwError other) {
    _$v = other as _$MwError;
  }

  @override
  void update(void Function(MwErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwError build() => _build();

  _$MwError _build() {
    final _$result = _$v ??
        _$MwError._(
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
