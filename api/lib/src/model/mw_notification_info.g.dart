// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_notification_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwNotificationInfo extends MwNotificationInfo {
  @override
  final String? content;
  @override
  final String? link;

  factory _$MwNotificationInfo(
          [void Function(MwNotificationInfoBuilder)? updates]) =>
      (new MwNotificationInfoBuilder()..update(updates))._build();

  _$MwNotificationInfo._({this.content, this.link}) : super._();

  @override
  MwNotificationInfo rebuild(
          void Function(MwNotificationInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwNotificationInfoBuilder toBuilder() =>
      new MwNotificationInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwNotificationInfo &&
        content == other.content &&
        link == other.link;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, link.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwNotificationInfo')
          ..add('content', content)
          ..add('link', link))
        .toString();
  }
}

class MwNotificationInfoBuilder
    implements Builder<MwNotificationInfo, MwNotificationInfoBuilder> {
  _$MwNotificationInfo? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  MwNotificationInfoBuilder() {
    MwNotificationInfo._defaults(this);
  }

  MwNotificationInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _link = $v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwNotificationInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwNotificationInfo;
  }

  @override
  void update(void Function(MwNotificationInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwNotificationInfo build() => _build();

  _$MwNotificationInfo _build() {
    final _$result =
        _$v ?? new _$MwNotificationInfo._(content: content, link: link);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
