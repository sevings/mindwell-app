// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_badge.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwBadge extends MwBadge {
  @override
  final String? code;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final int? level;
  @override
  final double? givenAt;

  factory _$MwBadge([void Function(MwBadgeBuilder)? updates]) =>
      (MwBadgeBuilder()..update(updates))._build();

  _$MwBadge._(
      {this.code,
      this.title,
      this.description,
      this.icon,
      this.level,
      this.givenAt})
      : super._();
  @override
  MwBadge rebuild(void Function(MwBadgeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwBadgeBuilder toBuilder() => MwBadgeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwBadge &&
        code == other.code &&
        title == other.title &&
        description == other.description &&
        icon == other.icon &&
        level == other.level &&
        givenAt == other.givenAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, givenAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwBadge')
          ..add('code', code)
          ..add('title', title)
          ..add('description', description)
          ..add('icon', icon)
          ..add('level', level)
          ..add('givenAt', givenAt))
        .toString();
  }
}

class MwBadgeBuilder implements Builder<MwBadge, MwBadgeBuilder> {
  _$MwBadge? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  int? _level;
  int? get level => _$this._level;
  set level(int? level) => _$this._level = level;

  double? _givenAt;
  double? get givenAt => _$this._givenAt;
  set givenAt(double? givenAt) => _$this._givenAt = givenAt;

  MwBadgeBuilder() {
    MwBadge._defaults(this);
  }

  MwBadgeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _title = $v.title;
      _description = $v.description;
      _icon = $v.icon;
      _level = $v.level;
      _givenAt = $v.givenAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwBadge other) {
    _$v = other as _$MwBadge;
  }

  @override
  void update(void Function(MwBadgeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwBadge build() => _build();

  _$MwBadge _build() {
    final _$result = _$v ??
        _$MwBadge._(
          code: code,
          title: title,
          description: description,
          icon: icon,
          level: level,
          givenAt: givenAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
