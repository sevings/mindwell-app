// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_themes_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwThemesGet200Response extends MwThemesGet200Response {
  @override
  final String? top;
  @override
  final String? query;
  @override
  final BuiltList<MwFriend>? themes;

  factory _$MwThemesGet200Response(
          [void Function(MwThemesGet200ResponseBuilder)? updates]) =>
      (MwThemesGet200ResponseBuilder()..update(updates))._build();

  _$MwThemesGet200Response._({this.top, this.query, this.themes}) : super._();
  @override
  MwThemesGet200Response rebuild(
          void Function(MwThemesGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwThemesGet200ResponseBuilder toBuilder() =>
      MwThemesGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwThemesGet200Response &&
        top == other.top &&
        query == other.query &&
        themes == other.themes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, top.hashCode);
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, themes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwThemesGet200Response')
          ..add('top', top)
          ..add('query', query)
          ..add('themes', themes))
        .toString();
  }
}

class MwThemesGet200ResponseBuilder
    implements Builder<MwThemesGet200Response, MwThemesGet200ResponseBuilder> {
  _$MwThemesGet200Response? _$v;

  String? _top;
  String? get top => _$this._top;
  set top(String? top) => _$this._top = top;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  ListBuilder<MwFriend>? _themes;
  ListBuilder<MwFriend> get themes =>
      _$this._themes ??= ListBuilder<MwFriend>();
  set themes(ListBuilder<MwFriend>? themes) => _$this._themes = themes;

  MwThemesGet200ResponseBuilder() {
    MwThemesGet200Response._defaults(this);
  }

  MwThemesGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _top = $v.top;
      _query = $v.query;
      _themes = $v.themes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwThemesGet200Response other) {
    _$v = other as _$MwThemesGet200Response;
  }

  @override
  void update(void Function(MwThemesGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwThemesGet200Response build() => _build();

  _$MwThemesGet200Response _build() {
    _$MwThemesGet200Response _$result;
    try {
      _$result = _$v ??
          _$MwThemesGet200Response._(
            top: top,
            query: query,
            themes: _themes?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'themes';
        _themes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwThemesGet200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
