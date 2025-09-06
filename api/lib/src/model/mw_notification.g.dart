// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_notification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwNotificationTypeEnum _$mwNotificationTypeEnum_comment =
    const MwNotificationTypeEnum._('comment');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_follower =
    const MwNotificationTypeEnum._('follower');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_request =
    const MwNotificationTypeEnum._('request');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_accept =
    const MwNotificationTypeEnum._('accept');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_invite =
    const MwNotificationTypeEnum._('invite');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_welcome =
    const MwNotificationTypeEnum._('welcome');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_invited =
    const MwNotificationTypeEnum._('invited');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_badge =
    const MwNotificationTypeEnum._('badge');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_admSent =
    const MwNotificationTypeEnum._('admSent');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_admReceived =
    const MwNotificationTypeEnum._('admReceived');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_wishCreated =
    const MwNotificationTypeEnum._('wishCreated');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_wishReceived =
    const MwNotificationTypeEnum._('wishReceived');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_entryMoved =
    const MwNotificationTypeEnum._('entryMoved');
const MwNotificationTypeEnum _$mwNotificationTypeEnum_info =
    const MwNotificationTypeEnum._('info');

MwNotificationTypeEnum _$mwNotificationTypeEnumValueOf(String name) {
  switch (name) {
    case 'comment':
      return _$mwNotificationTypeEnum_comment;
    case 'follower':
      return _$mwNotificationTypeEnum_follower;
    case 'request':
      return _$mwNotificationTypeEnum_request;
    case 'accept':
      return _$mwNotificationTypeEnum_accept;
    case 'invite':
      return _$mwNotificationTypeEnum_invite;
    case 'welcome':
      return _$mwNotificationTypeEnum_welcome;
    case 'invited':
      return _$mwNotificationTypeEnum_invited;
    case 'badge':
      return _$mwNotificationTypeEnum_badge;
    case 'admSent':
      return _$mwNotificationTypeEnum_admSent;
    case 'admReceived':
      return _$mwNotificationTypeEnum_admReceived;
    case 'wishCreated':
      return _$mwNotificationTypeEnum_wishCreated;
    case 'wishReceived':
      return _$mwNotificationTypeEnum_wishReceived;
    case 'entryMoved':
      return _$mwNotificationTypeEnum_entryMoved;
    case 'info':
      return _$mwNotificationTypeEnum_info;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwNotificationTypeEnum> _$mwNotificationTypeEnumValues =
    BuiltSet<MwNotificationTypeEnum>(const <MwNotificationTypeEnum>[
  _$mwNotificationTypeEnum_comment,
  _$mwNotificationTypeEnum_follower,
  _$mwNotificationTypeEnum_request,
  _$mwNotificationTypeEnum_accept,
  _$mwNotificationTypeEnum_invite,
  _$mwNotificationTypeEnum_welcome,
  _$mwNotificationTypeEnum_invited,
  _$mwNotificationTypeEnum_badge,
  _$mwNotificationTypeEnum_admSent,
  _$mwNotificationTypeEnum_admReceived,
  _$mwNotificationTypeEnum_wishCreated,
  _$mwNotificationTypeEnum_wishReceived,
  _$mwNotificationTypeEnum_entryMoved,
  _$mwNotificationTypeEnum_info,
]);

Serializer<MwNotificationTypeEnum> _$mwNotificationTypeEnumSerializer =
    _$MwNotificationTypeEnumSerializer();

class _$MwNotificationTypeEnumSerializer
    implements PrimitiveSerializer<MwNotificationTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'comment': 'comment',
    'follower': 'follower',
    'request': 'request',
    'accept': 'accept',
    'invite': 'invite',
    'welcome': 'welcome',
    'invited': 'invited',
    'badge': 'badge',
    'admSent': 'adm_sent',
    'admReceived': 'adm_received',
    'wishCreated': 'wish_created',
    'wishReceived': 'wish_received',
    'entryMoved': 'entry_moved',
    'info': 'info',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'comment': 'comment',
    'follower': 'follower',
    'request': 'request',
    'accept': 'accept',
    'invite': 'invite',
    'welcome': 'welcome',
    'invited': 'invited',
    'badge': 'badge',
    'adm_sent': 'admSent',
    'adm_received': 'admReceived',
    'wish_created': 'wishCreated',
    'wish_received': 'wishReceived',
    'entry_moved': 'entryMoved',
    'info': 'info',
  };

  @override
  final Iterable<Type> types = const <Type>[MwNotificationTypeEnum];
  @override
  final String wireName = 'MwNotificationTypeEnum';

  @override
  Object serialize(Serializers serializers, MwNotificationTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwNotificationTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwNotificationTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwNotification extends MwNotification {
  @override
  final int? id;
  @override
  final MwNotificationTypeEnum? type;
  @override
  final bool? read;
  @override
  final double? createdAt;
  @override
  final MwUser? user;
  @override
  final MwComment? comment;
  @override
  final MwEntry? entry;
  @override
  final MwWish? wish;
  @override
  final MwBadge? badge;
  @override
  final MwNotificationInfo? info;

  factory _$MwNotification([void Function(MwNotificationBuilder)? updates]) =>
      (MwNotificationBuilder()..update(updates))._build();

  _$MwNotification._(
      {this.id,
      this.type,
      this.read,
      this.createdAt,
      this.user,
      this.comment,
      this.entry,
      this.wish,
      this.badge,
      this.info})
      : super._();
  @override
  MwNotification rebuild(void Function(MwNotificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwNotificationBuilder toBuilder() => MwNotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwNotification &&
        id == other.id &&
        type == other.type &&
        read == other.read &&
        createdAt == other.createdAt &&
        user == other.user &&
        comment == other.comment &&
        entry == other.entry &&
        wish == other.wish &&
        badge == other.badge &&
        info == other.info;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, entry.hashCode);
    _$hash = $jc(_$hash, wish.hashCode);
    _$hash = $jc(_$hash, badge.hashCode);
    _$hash = $jc(_$hash, info.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwNotification')
          ..add('id', id)
          ..add('type', type)
          ..add('read', read)
          ..add('createdAt', createdAt)
          ..add('user', user)
          ..add('comment', comment)
          ..add('entry', entry)
          ..add('wish', wish)
          ..add('badge', badge)
          ..add('info', info))
        .toString();
  }
}

class MwNotificationBuilder
    implements Builder<MwNotification, MwNotificationBuilder> {
  _$MwNotification? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MwNotificationTypeEnum? _type;
  MwNotificationTypeEnum? get type => _$this._type;
  set type(MwNotificationTypeEnum? type) => _$this._type = type;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  double? _createdAt;
  double? get createdAt => _$this._createdAt;
  set createdAt(double? createdAt) => _$this._createdAt = createdAt;

  MwUser? _user;
  MwUser? get user => _$this._user;
  set user(MwUser? user) => _$this._user = user;

  MwCommentBuilder? _comment;
  MwCommentBuilder get comment => _$this._comment ??= MwCommentBuilder();
  set comment(MwCommentBuilder? comment) => _$this._comment = comment;

  MwEntryBuilder? _entry;
  MwEntryBuilder get entry => _$this._entry ??= MwEntryBuilder();
  set entry(MwEntryBuilder? entry) => _$this._entry = entry;

  MwWishBuilder? _wish;
  MwWishBuilder get wish => _$this._wish ??= MwWishBuilder();
  set wish(MwWishBuilder? wish) => _$this._wish = wish;

  MwBadgeBuilder? _badge;
  MwBadgeBuilder get badge => _$this._badge ??= MwBadgeBuilder();
  set badge(MwBadgeBuilder? badge) => _$this._badge = badge;

  MwNotificationInfoBuilder? _info;
  MwNotificationInfoBuilder get info =>
      _$this._info ??= MwNotificationInfoBuilder();
  set info(MwNotificationInfoBuilder? info) => _$this._info = info;

  MwNotificationBuilder() {
    MwNotification._defaults(this);
  }

  MwNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _read = $v.read;
      _createdAt = $v.createdAt;
      _user = $v.user;
      _comment = $v.comment?.toBuilder();
      _entry = $v.entry?.toBuilder();
      _wish = $v.wish?.toBuilder();
      _badge = $v.badge?.toBuilder();
      _info = $v.info?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwNotification other) {
    _$v = other as _$MwNotification;
  }

  @override
  void update(void Function(MwNotificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwNotification build() => _build();

  _$MwNotification _build() {
    _$MwNotification _$result;
    try {
      _$result = _$v ??
          _$MwNotification._(
            id: id,
            type: type,
            read: read,
            createdAt: createdAt,
            user: user,
            comment: _comment?.build(),
            entry: _entry?.build(),
            wish: _wish?.build(),
            badge: _badge?.build(),
            info: _info?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'comment';
        _comment?.build();
        _$failedField = 'entry';
        _entry?.build();
        _$failedField = 'wish';
        _wish?.build();
        _$failedField = 'badge';
        _badge?.build();
        _$failedField = 'info';
        _info?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwNotification', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
