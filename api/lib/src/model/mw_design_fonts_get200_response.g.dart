// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_design_fonts_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwDesignFontsGet200Response extends MwDesignFontsGet200Response {
  @override
  final BuiltList<String>? fonts;

  factory _$MwDesignFontsGet200Response(
          [void Function(MwDesignFontsGet200ResponseBuilder)? updates]) =>
      (new MwDesignFontsGet200ResponseBuilder()..update(updates))._build();

  _$MwDesignFontsGet200Response._({this.fonts}) : super._();

  @override
  MwDesignFontsGet200Response rebuild(
          void Function(MwDesignFontsGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwDesignFontsGet200ResponseBuilder toBuilder() =>
      new MwDesignFontsGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwDesignFontsGet200Response && fonts == other.fonts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fonts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwDesignFontsGet200Response')
          ..add('fonts', fonts))
        .toString();
  }
}

class MwDesignFontsGet200ResponseBuilder
    implements
        Builder<MwDesignFontsGet200Response,
            MwDesignFontsGet200ResponseBuilder> {
  _$MwDesignFontsGet200Response? _$v;

  ListBuilder<String>? _fonts;
  ListBuilder<String> get fonts => _$this._fonts ??= new ListBuilder<String>();
  set fonts(ListBuilder<String>? fonts) => _$this._fonts = fonts;

  MwDesignFontsGet200ResponseBuilder() {
    MwDesignFontsGet200Response._defaults(this);
  }

  MwDesignFontsGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fonts = $v.fonts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwDesignFontsGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwDesignFontsGet200Response;
  }

  @override
  void update(void Function(MwDesignFontsGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwDesignFontsGet200Response build() => _build();

  _$MwDesignFontsGet200Response _build() {
    _$MwDesignFontsGet200Response _$result;
    try {
      _$result =
          _$v ?? new _$MwDesignFontsGet200Response._(fonts: _fonts?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'fonts';
        _fonts?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwDesignFontsGet200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
