// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_notifications_read_put200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwNotificationsReadPut200Response
    extends MwNotificationsReadPut200Response {
  @override
  final int? unread;

  factory _$MwNotificationsReadPut200Response(
          [void Function(MwNotificationsReadPut200ResponseBuilder)? updates]) =>
      (MwNotificationsReadPut200ResponseBuilder()..update(updates))._build();

  _$MwNotificationsReadPut200Response._({this.unread}) : super._();
  @override
  MwNotificationsReadPut200Response rebuild(
          void Function(MwNotificationsReadPut200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwNotificationsReadPut200ResponseBuilder toBuilder() =>
      MwNotificationsReadPut200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwNotificationsReadPut200Response && unread == other.unread;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unread.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwNotificationsReadPut200Response')
          ..add('unread', unread))
        .toString();
  }
}

class MwNotificationsReadPut200ResponseBuilder
    implements
        Builder<MwNotificationsReadPut200Response,
            MwNotificationsReadPut200ResponseBuilder> {
  _$MwNotificationsReadPut200Response? _$v;

  int? _unread;
  int? get unread => _$this._unread;
  set unread(int? unread) => _$this._unread = unread;

  MwNotificationsReadPut200ResponseBuilder() {
    MwNotificationsReadPut200Response._defaults(this);
  }

  MwNotificationsReadPut200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unread = $v.unread;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwNotificationsReadPut200Response other) {
    _$v = other as _$MwNotificationsReadPut200Response;
  }

  @override
  void update(
      void Function(MwNotificationsReadPut200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwNotificationsReadPut200Response build() => _build();

  _$MwNotificationsReadPut200Response _build() {
    final _$result = _$v ??
        _$MwNotificationsReadPut200Response._(
          unread: unread,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
