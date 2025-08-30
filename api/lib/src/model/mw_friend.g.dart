// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_friend.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwFriendGenderEnum _$mwFriendGenderEnum_male =
    const MwFriendGenderEnum._('male');
const MwFriendGenderEnum _$mwFriendGenderEnum_female =
    const MwFriendGenderEnum._('female');
const MwFriendGenderEnum _$mwFriendGenderEnum_notSet =
    const MwFriendGenderEnum._('notSet');

MwFriendGenderEnum _$mwFriendGenderEnumValueOf(String name) {
  switch (name) {
    case 'male':
      return _$mwFriendGenderEnum_male;
    case 'female':
      return _$mwFriendGenderEnum_female;
    case 'notSet':
      return _$mwFriendGenderEnum_notSet;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwFriendGenderEnum> _$mwFriendGenderEnumValues =
    new BuiltSet<MwFriendGenderEnum>(const <MwFriendGenderEnum>[
  _$mwFriendGenderEnum_male,
  _$mwFriendGenderEnum_female,
  _$mwFriendGenderEnum_notSet,
]);

const MwFriendPrivacyEnum _$mwFriendPrivacyEnum_all =
    const MwFriendPrivacyEnum._('all');
const MwFriendPrivacyEnum _$mwFriendPrivacyEnum_followers =
    const MwFriendPrivacyEnum._('followers');
const MwFriendPrivacyEnum _$mwFriendPrivacyEnum_invited =
    const MwFriendPrivacyEnum._('invited');
const MwFriendPrivacyEnum _$mwFriendPrivacyEnum_registered =
    const MwFriendPrivacyEnum._('registered');

MwFriendPrivacyEnum _$mwFriendPrivacyEnumValueOf(String name) {
  switch (name) {
    case 'all':
      return _$mwFriendPrivacyEnum_all;
    case 'followers':
      return _$mwFriendPrivacyEnum_followers;
    case 'invited':
      return _$mwFriendPrivacyEnum_invited;
    case 'registered':
      return _$mwFriendPrivacyEnum_registered;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwFriendPrivacyEnum> _$mwFriendPrivacyEnumValues =
    new BuiltSet<MwFriendPrivacyEnum>(const <MwFriendPrivacyEnum>[
  _$mwFriendPrivacyEnum_all,
  _$mwFriendPrivacyEnum_followers,
  _$mwFriendPrivacyEnum_invited,
  _$mwFriendPrivacyEnum_registered,
]);

const MwFriendChatPrivacyEnum _$mwFriendChatPrivacyEnum_invited =
    const MwFriendChatPrivacyEnum._('invited');
const MwFriendChatPrivacyEnum _$mwFriendChatPrivacyEnum_followers =
    const MwFriendChatPrivacyEnum._('followers');
const MwFriendChatPrivacyEnum _$mwFriendChatPrivacyEnum_friends =
    const MwFriendChatPrivacyEnum._('friends');
const MwFriendChatPrivacyEnum _$mwFriendChatPrivacyEnum_me =
    const MwFriendChatPrivacyEnum._('me');

MwFriendChatPrivacyEnum _$mwFriendChatPrivacyEnumValueOf(String name) {
  switch (name) {
    case 'invited':
      return _$mwFriendChatPrivacyEnum_invited;
    case 'followers':
      return _$mwFriendChatPrivacyEnum_followers;
    case 'friends':
      return _$mwFriendChatPrivacyEnum_friends;
    case 'me':
      return _$mwFriendChatPrivacyEnum_me;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwFriendChatPrivacyEnum> _$mwFriendChatPrivacyEnumValues =
    new BuiltSet<MwFriendChatPrivacyEnum>(const <MwFriendChatPrivacyEnum>[
  _$mwFriendChatPrivacyEnum_invited,
  _$mwFriendChatPrivacyEnum_followers,
  _$mwFriendChatPrivacyEnum_friends,
  _$mwFriendChatPrivacyEnum_me,
]);

Serializer<MwFriendGenderEnum> _$mwFriendGenderEnumSerializer =
    new _$MwFriendGenderEnumSerializer();
Serializer<MwFriendPrivacyEnum> _$mwFriendPrivacyEnumSerializer =
    new _$MwFriendPrivacyEnumSerializer();
Serializer<MwFriendChatPrivacyEnum> _$mwFriendChatPrivacyEnumSerializer =
    new _$MwFriendChatPrivacyEnumSerializer();

class _$MwFriendGenderEnumSerializer
    implements PrimitiveSerializer<MwFriendGenderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'male': 'male',
    'female': 'female',
    'notSet': 'not set',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'male': 'male',
    'female': 'female',
    'not set': 'notSet',
  };

  @override
  final Iterable<Type> types = const <Type>[MwFriendGenderEnum];
  @override
  final String wireName = 'MwFriendGenderEnum';

  @override
  Object serialize(Serializers serializers, MwFriendGenderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwFriendGenderEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwFriendGenderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwFriendPrivacyEnumSerializer
    implements PrimitiveSerializer<MwFriendPrivacyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'all': 'all',
    'followers': 'followers',
    'invited': 'invited',
    'registered': 'registered',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'all': 'all',
    'followers': 'followers',
    'invited': 'invited',
    'registered': 'registered',
  };

  @override
  final Iterable<Type> types = const <Type>[MwFriendPrivacyEnum];
  @override
  final String wireName = 'MwFriendPrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwFriendPrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwFriendPrivacyEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwFriendPrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwFriendChatPrivacyEnumSerializer
    implements PrimitiveSerializer<MwFriendChatPrivacyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'invited': 'invited',
    'followers': 'followers',
    'friends': 'friends',
    'me': 'me',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'invited': 'invited',
    'followers': 'followers',
    'friends': 'friends',
    'me': 'me',
  };

  @override
  final Iterable<Type> types = const <Type>[MwFriendChatPrivacyEnum];
  @override
  final String wireName = 'MwFriendChatPrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwFriendChatPrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwFriendChatPrivacyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwFriendChatPrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class MwFriendBuilder implements MwUserBuilder {
  void replace(covariant MwFriend other);
  void update(void Function(MwFriendBuilder) updates);
  double? get lastSeenAt;
  set lastSeenAt(covariant double? lastSeenAt);

  MwCoverBuilder get cover;
  set cover(covariant MwCoverBuilder? cover);

  MwFriendGenderEnum? get gender;
  set gender(covariant MwFriendGenderEnum? gender);

  MwFriendAllOfCountsBuilder get counts;
  set counts(covariant MwFriendAllOfCountsBuilder? counts);

  MwFriendChatPrivacyEnum? get chatPrivacy;
  set chatPrivacy(covariant MwFriendChatPrivacyEnum? chatPrivacy);

  MwFriendPrivacyEnum? get privacy;
  set privacy(covariant MwFriendPrivacyEnum? privacy);

  num? get rank;
  set rank(covariant num? rank);

  String? get title;
  set title(covariant String? title);

  int? get id;
  set id(covariant int? id);

  String? get name;
  set name(covariant String? name);

  String? get showName;
  set showName(covariant String? showName);

  bool? get isTheme;
  set isTheme(covariant bool? isTheme);

  bool? get isOnline;
  set isOnline(covariant bool? isOnline);

  MwAvatarBuilder get avatar;
  set avatar(covariant MwAvatarBuilder? avatar);
}

class _$$MwFriend extends $MwFriend {
  @override
  final double? lastSeenAt;
  @override
  final MwCover? cover;
  @override
  final MwFriendGenderEnum? gender;
  @override
  final MwFriendAllOfCounts? counts;
  @override
  final MwFriendChatPrivacyEnum? chatPrivacy;
  @override
  final MwFriendPrivacyEnum? privacy;
  @override
  final num? rank;
  @override
  final String? title;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? showName;
  @override
  final bool? isTheme;
  @override
  final bool? isOnline;
  @override
  final MwAvatar? avatar;

  factory _$$MwFriend([void Function($MwFriendBuilder)? updates]) =>
      (new $MwFriendBuilder()..update(updates))._build();

  _$$MwFriend._(
      {this.lastSeenAt,
      this.cover,
      this.gender,
      this.counts,
      this.chatPrivacy,
      this.privacy,
      this.rank,
      this.title,
      this.id,
      this.name,
      this.showName,
      this.isTheme,
      this.isOnline,
      this.avatar})
      : super._();

  @override
  $MwFriend rebuild(void Function($MwFriendBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $MwFriendBuilder toBuilder() => new $MwFriendBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $MwFriend &&
        lastSeenAt == other.lastSeenAt &&
        cover == other.cover &&
        gender == other.gender &&
        counts == other.counts &&
        chatPrivacy == other.chatPrivacy &&
        privacy == other.privacy &&
        rank == other.rank &&
        title == other.title &&
        id == other.id &&
        name == other.name &&
        showName == other.showName &&
        isTheme == other.isTheme &&
        isOnline == other.isOnline &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jc(_$hash, cover.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, counts.hashCode);
    _$hash = $jc(_$hash, chatPrivacy.hashCode);
    _$hash = $jc(_$hash, privacy.hashCode);
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, showName.hashCode);
    _$hash = $jc(_$hash, isTheme.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$MwFriend')
          ..add('lastSeenAt', lastSeenAt)
          ..add('cover', cover)
          ..add('gender', gender)
          ..add('counts', counts)
          ..add('chatPrivacy', chatPrivacy)
          ..add('privacy', privacy)
          ..add('rank', rank)
          ..add('title', title)
          ..add('id', id)
          ..add('name', name)
          ..add('showName', showName)
          ..add('isTheme', isTheme)
          ..add('isOnline', isOnline)
          ..add('avatar', avatar))
        .toString();
  }
}

class $MwFriendBuilder
    implements Builder<$MwFriend, $MwFriendBuilder>, MwFriendBuilder {
  _$$MwFriend? _$v;

  double? _lastSeenAt;
  double? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(covariant double? lastSeenAt) =>
      _$this._lastSeenAt = lastSeenAt;

  MwCoverBuilder? _cover;
  MwCoverBuilder get cover => _$this._cover ??= new MwCoverBuilder();
  set cover(covariant MwCoverBuilder? cover) => _$this._cover = cover;

  MwFriendGenderEnum? _gender;
  MwFriendGenderEnum? get gender => _$this._gender;
  set gender(covariant MwFriendGenderEnum? gender) => _$this._gender = gender;

  MwFriendAllOfCountsBuilder? _counts;
  MwFriendAllOfCountsBuilder get counts =>
      _$this._counts ??= new MwFriendAllOfCountsBuilder();
  set counts(covariant MwFriendAllOfCountsBuilder? counts) =>
      _$this._counts = counts;

  MwFriendChatPrivacyEnum? _chatPrivacy;
  MwFriendChatPrivacyEnum? get chatPrivacy => _$this._chatPrivacy;
  set chatPrivacy(covariant MwFriendChatPrivacyEnum? chatPrivacy) =>
      _$this._chatPrivacy = chatPrivacy;

  MwFriendPrivacyEnum? _privacy;
  MwFriendPrivacyEnum? get privacy => _$this._privacy;
  set privacy(covariant MwFriendPrivacyEnum? privacy) =>
      _$this._privacy = privacy;

  num? _rank;
  num? get rank => _$this._rank;
  set rank(covariant num? rank) => _$this._rank = rank;

  String? _title;
  String? get title => _$this._title;
  set title(covariant String? title) => _$this._title = title;

  int? _id;
  int? get id => _$this._id;
  set id(covariant int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _showName;
  String? get showName => _$this._showName;
  set showName(covariant String? showName) => _$this._showName = showName;

  bool? _isTheme;
  bool? get isTheme => _$this._isTheme;
  set isTheme(covariant bool? isTheme) => _$this._isTheme = isTheme;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(covariant bool? isOnline) => _$this._isOnline = isOnline;

  MwAvatarBuilder? _avatar;
  MwAvatarBuilder get avatar => _$this._avatar ??= new MwAvatarBuilder();
  set avatar(covariant MwAvatarBuilder? avatar) => _$this._avatar = avatar;

  $MwFriendBuilder() {
    $MwFriend._defaults(this);
  }

  $MwFriendBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastSeenAt = $v.lastSeenAt;
      _cover = $v.cover?.toBuilder();
      _gender = $v.gender;
      _counts = $v.counts?.toBuilder();
      _chatPrivacy = $v.chatPrivacy;
      _privacy = $v.privacy;
      _rank = $v.rank;
      _title = $v.title;
      _id = $v.id;
      _name = $v.name;
      _showName = $v.showName;
      _isTheme = $v.isTheme;
      _isOnline = $v.isOnline;
      _avatar = $v.avatar?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $MwFriend other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$$MwFriend;
  }

  @override
  void update(void Function($MwFriendBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $MwFriend build() => _build();

  _$$MwFriend _build() {
    _$$MwFriend _$result;
    try {
      _$result = _$v ??
          new _$$MwFriend._(
              lastSeenAt: lastSeenAt,
              cover: _cover?.build(),
              gender: gender,
              counts: _counts?.build(),
              chatPrivacy: chatPrivacy,
              privacy: privacy,
              rank: rank,
              title: title,
              id: id,
              name: name,
              showName: showName,
              isTheme: isTheme,
              isOnline: isOnline,
              avatar: _avatar?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cover';
        _cover?.build();

        _$failedField = 'counts';
        _counts?.build();

        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'$MwFriend', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
