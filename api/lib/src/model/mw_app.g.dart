// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_app.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwApp extends MwApp {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? showName;
  @override
  final String? platform;
  @override
  final String? info;

  factory _$MwApp([void Function(MwAppBuilder)? updates]) =>
      (MwAppBuilder()..update(updates))._build();

  _$MwApp._({this.id, this.name, this.showName, this.platform, this.info})
      : super._();
  @override
  MwApp rebuild(void Function(MwAppBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAppBuilder toBuilder() => MwAppBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwApp &&
        id == other.id &&
        name == other.name &&
        showName == other.showName &&
        platform == other.platform &&
        info == other.info;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, showName.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, info.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwApp')
          ..add('id', id)
          ..add('name', name)
          ..add('showName', showName)
          ..add('platform', platform)
          ..add('info', info))
        .toString();
  }
}

class MwAppBuilder implements Builder<MwApp, MwAppBuilder> {
  _$MwApp? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _showName;
  String? get showName => _$this._showName;
  set showName(String? showName) => _$this._showName = showName;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _info;
  String? get info => _$this._info;
  set info(String? info) => _$this._info = info;

  MwAppBuilder() {
    MwApp._defaults(this);
  }

  MwAppBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _showName = $v.showName;
      _platform = $v.platform;
      _info = $v.info;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwApp other) {
    _$v = other as _$MwApp;
  }

  @override
  void update(void Function(MwAppBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwApp build() => _build();

  _$MwApp _build() {
    final _$result = _$v ??
        _$MwApp._(
          id: id,
          name: name,
          showName: showName,
          platform: platform,
          info: info,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
