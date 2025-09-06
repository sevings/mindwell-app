// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_friend_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwFriendListRelationEnum _$mwFriendListRelationEnum_followers =
    const MwFriendListRelationEnum._('followers');
const MwFriendListRelationEnum _$mwFriendListRelationEnum_followings =
    const MwFriendListRelationEnum._('followings');
const MwFriendListRelationEnum _$mwFriendListRelationEnum_requested =
    const MwFriendListRelationEnum._('requested');
const MwFriendListRelationEnum _$mwFriendListRelationEnum_ignored =
    const MwFriendListRelationEnum._('ignored');
const MwFriendListRelationEnum _$mwFriendListRelationEnum_hidden =
    const MwFriendListRelationEnum._('hidden');
const MwFriendListRelationEnum _$mwFriendListRelationEnum_invited =
    const MwFriendListRelationEnum._('invited');

MwFriendListRelationEnum _$mwFriendListRelationEnumValueOf(String name) {
  switch (name) {
    case 'followers':
      return _$mwFriendListRelationEnum_followers;
    case 'followings':
      return _$mwFriendListRelationEnum_followings;
    case 'requested':
      return _$mwFriendListRelationEnum_requested;
    case 'ignored':
      return _$mwFriendListRelationEnum_ignored;
    case 'hidden':
      return _$mwFriendListRelationEnum_hidden;
    case 'invited':
      return _$mwFriendListRelationEnum_invited;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwFriendListRelationEnum> _$mwFriendListRelationEnumValues =
    BuiltSet<MwFriendListRelationEnum>(const <MwFriendListRelationEnum>[
  _$mwFriendListRelationEnum_followers,
  _$mwFriendListRelationEnum_followings,
  _$mwFriendListRelationEnum_requested,
  _$mwFriendListRelationEnum_ignored,
  _$mwFriendListRelationEnum_hidden,
  _$mwFriendListRelationEnum_invited,
]);

Serializer<MwFriendListRelationEnum> _$mwFriendListRelationEnumSerializer =
    _$MwFriendListRelationEnumSerializer();

class _$MwFriendListRelationEnumSerializer
    implements PrimitiveSerializer<MwFriendListRelationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'followers': 'followers',
    'followings': 'followings',
    'requested': 'requested',
    'ignored': 'ignored',
    'hidden': 'hidden',
    'invited': 'invited',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'followers': 'followers',
    'followings': 'followings',
    'requested': 'requested',
    'ignored': 'ignored',
    'hidden': 'hidden',
    'invited': 'invited',
  };

  @override
  final Iterable<Type> types = const <Type>[MwFriendListRelationEnum];
  @override
  final String wireName = 'MwFriendListRelationEnum';

  @override
  Object serialize(Serializers serializers, MwFriendListRelationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwFriendListRelationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwFriendListRelationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwFriendList extends MwFriendList {
  @override
  final MwUser? subject;
  @override
  final MwFriendListRelationEnum? relation;
  @override
  final BuiltList<MwFriend>? users;
  @override
  final String? nextAfter;
  @override
  final bool? hasAfter;
  @override
  final String? nextBefore;
  @override
  final bool? hasBefore;

  factory _$MwFriendList([void Function(MwFriendListBuilder)? updates]) =>
      (MwFriendListBuilder()..update(updates))._build();

  _$MwFriendList._(
      {this.subject,
      this.relation,
      this.users,
      this.nextAfter,
      this.hasAfter,
      this.nextBefore,
      this.hasBefore})
      : super._();
  @override
  MwFriendList rebuild(void Function(MwFriendListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwFriendListBuilder toBuilder() => MwFriendListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwFriendList &&
        subject == other.subject &&
        relation == other.relation &&
        users == other.users &&
        nextAfter == other.nextAfter &&
        hasAfter == other.hasAfter &&
        nextBefore == other.nextBefore &&
        hasBefore == other.hasBefore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, relation.hashCode);
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, nextAfter.hashCode);
    _$hash = $jc(_$hash, hasAfter.hashCode);
    _$hash = $jc(_$hash, nextBefore.hashCode);
    _$hash = $jc(_$hash, hasBefore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwFriendList')
          ..add('subject', subject)
          ..add('relation', relation)
          ..add('users', users)
          ..add('nextAfter', nextAfter)
          ..add('hasAfter', hasAfter)
          ..add('nextBefore', nextBefore)
          ..add('hasBefore', hasBefore))
        .toString();
  }
}

class MwFriendListBuilder
    implements Builder<MwFriendList, MwFriendListBuilder> {
  _$MwFriendList? _$v;

  MwUser? _subject;
  MwUser? get subject => _$this._subject;
  set subject(MwUser? subject) => _$this._subject = subject;

  MwFriendListRelationEnum? _relation;
  MwFriendListRelationEnum? get relation => _$this._relation;
  set relation(MwFriendListRelationEnum? relation) =>
      _$this._relation = relation;

  ListBuilder<MwFriend>? _users;
  ListBuilder<MwFriend> get users => _$this._users ??= ListBuilder<MwFriend>();
  set users(ListBuilder<MwFriend>? users) => _$this._users = users;

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

  MwFriendListBuilder() {
    MwFriendList._defaults(this);
  }

  MwFriendListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subject = $v.subject;
      _relation = $v.relation;
      _users = $v.users?.toBuilder();
      _nextAfter = $v.nextAfter;
      _hasAfter = $v.hasAfter;
      _nextBefore = $v.nextBefore;
      _hasBefore = $v.hasBefore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwFriendList other) {
    _$v = other as _$MwFriendList;
  }

  @override
  void update(void Function(MwFriendListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwFriendList build() => _build();

  _$MwFriendList _build() {
    _$MwFriendList _$result;
    try {
      _$result = _$v ??
          _$MwFriendList._(
            subject: subject,
            relation: relation,
            users: _users?.build(),
            nextAfter: nextAfter,
            hasAfter: hasAfter,
            nextBefore: nextBefore,
            hasBefore: hasBefore,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        _users?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwFriendList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
