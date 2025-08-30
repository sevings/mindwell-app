// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_account_settings_onsite_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAccountSettingsOnsiteGet200Response
    extends MwAccountSettingsOnsiteGet200Response {
  @override
  final bool? wishes;

  factory _$MwAccountSettingsOnsiteGet200Response(
          [void Function(MwAccountSettingsOnsiteGet200ResponseBuilder)?
              updates]) =>
      (new MwAccountSettingsOnsiteGet200ResponseBuilder()..update(updates))
          ._build();

  _$MwAccountSettingsOnsiteGet200Response._({this.wishes}) : super._();

  @override
  MwAccountSettingsOnsiteGet200Response rebuild(
          void Function(MwAccountSettingsOnsiteGet200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAccountSettingsOnsiteGet200ResponseBuilder toBuilder() =>
      new MwAccountSettingsOnsiteGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAccountSettingsOnsiteGet200Response &&
        wishes == other.wishes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, wishes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'MwAccountSettingsOnsiteGet200Response')
          ..add('wishes', wishes))
        .toString();
  }
}

class MwAccountSettingsOnsiteGet200ResponseBuilder
    implements
        Builder<MwAccountSettingsOnsiteGet200Response,
            MwAccountSettingsOnsiteGet200ResponseBuilder> {
  _$MwAccountSettingsOnsiteGet200Response? _$v;

  bool? _wishes;
  bool? get wishes => _$this._wishes;
  set wishes(bool? wishes) => _$this._wishes = wishes;

  MwAccountSettingsOnsiteGet200ResponseBuilder() {
    MwAccountSettingsOnsiteGet200Response._defaults(this);
  }

  MwAccountSettingsOnsiteGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _wishes = $v.wishes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAccountSettingsOnsiteGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAccountSettingsOnsiteGet200Response;
  }

  @override
  void update(
      void Function(MwAccountSettingsOnsiteGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAccountSettingsOnsiteGet200Response build() => _build();

  _$MwAccountSettingsOnsiteGet200Response _build() {
    final _$result =
        _$v ?? new _$MwAccountSettingsOnsiteGet200Response._(wishes: wishes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
