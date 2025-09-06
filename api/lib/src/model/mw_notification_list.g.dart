// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_notification_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwNotificationList extends MwNotificationList {
  @override
  final BuiltList<MwNotification>? notifications;
  @override
  final int? unreadCount;
  @override
  final String? nextAfter;
  @override
  final bool? hasAfter;
  @override
  final String? nextBefore;
  @override
  final bool? hasBefore;

  factory _$MwNotificationList(
          [void Function(MwNotificationListBuilder)? updates]) =>
      (MwNotificationListBuilder()..update(updates))._build();

  _$MwNotificationList._(
      {this.notifications,
      this.unreadCount,
      this.nextAfter,
      this.hasAfter,
      this.nextBefore,
      this.hasBefore})
      : super._();
  @override
  MwNotificationList rebuild(
          void Function(MwNotificationListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwNotificationListBuilder toBuilder() =>
      MwNotificationListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwNotificationList &&
        notifications == other.notifications &&
        unreadCount == other.unreadCount &&
        nextAfter == other.nextAfter &&
        hasAfter == other.hasAfter &&
        nextBefore == other.nextBefore &&
        hasBefore == other.hasBefore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, nextAfter.hashCode);
    _$hash = $jc(_$hash, hasAfter.hashCode);
    _$hash = $jc(_$hash, nextBefore.hashCode);
    _$hash = $jc(_$hash, hasBefore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwNotificationList')
          ..add('notifications', notifications)
          ..add('unreadCount', unreadCount)
          ..add('nextAfter', nextAfter)
          ..add('hasAfter', hasAfter)
          ..add('nextBefore', nextBefore)
          ..add('hasBefore', hasBefore))
        .toString();
  }
}

class MwNotificationListBuilder
    implements Builder<MwNotificationList, MwNotificationListBuilder> {
  _$MwNotificationList? _$v;

  ListBuilder<MwNotification>? _notifications;
  ListBuilder<MwNotification> get notifications =>
      _$this._notifications ??= ListBuilder<MwNotification>();
  set notifications(ListBuilder<MwNotification>? notifications) =>
      _$this._notifications = notifications;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  String? _nextAfter;
  String? get nextAfter => _$this._nextAfter;
  set nextAfter(String? nextAfter) => _$this._nextAfter = nextAfter;

  bool? _hasAfter;
  bool? get hasAfter => _$this._hasAfter;
  set hasAfter(bool? hasAfter) => _$this._hasAfter = hasAfter;

  String? _nextBefore;
  String? get nextBefore => _$this._nextBefore;
  set nextBefore(String? nextBefore) => _$this._nextBefore = nextBefore;

  bool? _hasBefore;
  bool? get hasBefore => _$this._hasBefore;
  set hasBefore(bool? hasBefore) => _$this._hasBefore = hasBefore;

  MwNotificationListBuilder() {
    MwNotificationList._defaults(this);
  }

  MwNotificationListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _notifications = $v.notifications?.toBuilder();
      _unreadCount = $v.unreadCount;
      _nextAfter = $v.nextAfter;
      _hasAfter = $v.hasAfter;
      _nextBefore = $v.nextBefore;
      _hasBefore = $v.hasBefore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwNotificationList other) {
    _$v = other as _$MwNotificationList;
  }

  @override
  void update(void Function(MwNotificationListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwNotificationList build() => _build();

  _$MwNotificationList _build() {
    _$MwNotificationList _$result;
    try {
      _$result = _$v ??
          _$MwNotificationList._(
            notifications: _notifications?.build(),
            unreadCount: unreadCount,
            nextAfter: nextAfter,
            hasAfter: hasAfter,
            nextBefore: nextBefore,
            hasBefore: hasBefore,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        _notifications?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwNotificationList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
