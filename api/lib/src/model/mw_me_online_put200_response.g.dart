// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_me_online_put200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwMeOnlinePut200Response extends MwMeOnlinePut200Response {
  @override
  final int? notifications;
  @override
  final int? chats;

  factory _$MwMeOnlinePut200Response(
          [void Function(MwMeOnlinePut200ResponseBuilder)? updates]) =>
      (new MwMeOnlinePut200ResponseBuilder()..update(updates))._build();

  _$MwMeOnlinePut200Response._({this.notifications, this.chats}) : super._();

  @override
  MwMeOnlinePut200Response rebuild(
          void Function(MwMeOnlinePut200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwMeOnlinePut200ResponseBuilder toBuilder() =>
      new MwMeOnlinePut200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwMeOnlinePut200Response &&
        notifications == other.notifications &&
        chats == other.chats;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jc(_$hash, chats.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwMeOnlinePut200Response')
          ..add('notifications', notifications)
          ..add('chats', chats))
        .toString();
  }
}

class MwMeOnlinePut200ResponseBuilder
    implements
        Builder<MwMeOnlinePut200Response, MwMeOnlinePut200ResponseBuilder> {
  _$MwMeOnlinePut200Response? _$v;

  int? _notifications;
  int? get notifications => _$this._notifications;
  set notifications(int? notifications) =>
      _$this._notifications = notifications;

  int? _chats;
  int? get chats => _$this._chats;
  set chats(int? chats) => _$this._chats = chats;

  MwMeOnlinePut200ResponseBuilder() {
    MwMeOnlinePut200Response._defaults(this);
  }

  MwMeOnlinePut200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _notifications = $v.notifications;
      _chats = $v.chats;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwMeOnlinePut200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwMeOnlinePut200Response;
  }

  @override
  void update(void Function(MwMeOnlinePut200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwMeOnlinePut200Response build() => _build();

  _$MwMeOnlinePut200Response _build() {
    final _$result = _$v ??
        new _$MwMeOnlinePut200Response._(
            notifications: notifications, chats: chats);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
