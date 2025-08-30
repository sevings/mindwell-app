// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwProfileGenderEnum _$mwProfileGenderEnum_male =
    const MwProfileGenderEnum._('male');
const MwProfileGenderEnum _$mwProfileGenderEnum_female =
    const MwProfileGenderEnum._('female');
const MwProfileGenderEnum _$mwProfileGenderEnum_notSet =
    const MwProfileGenderEnum._('notSet');

MwProfileGenderEnum _$mwProfileGenderEnumValueOf(String name) {
  switch (name) {
    case 'male':
      return _$mwProfileGenderEnum_male;
    case 'female':
      return _$mwProfileGenderEnum_female;
    case 'notSet':
      return _$mwProfileGenderEnum_notSet;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwProfileGenderEnum> _$mwProfileGenderEnumValues =
    new BuiltSet<MwProfileGenderEnum>(const <MwProfileGenderEnum>[
  _$mwProfileGenderEnum_male,
  _$mwProfileGenderEnum_female,
  _$mwProfileGenderEnum_notSet,
]);

const MwProfilePrivacyEnum _$mwProfilePrivacyEnum_all =
    const MwProfilePrivacyEnum._('all');
const MwProfilePrivacyEnum _$mwProfilePrivacyEnum_followers =
    const MwProfilePrivacyEnum._('followers');
const MwProfilePrivacyEnum _$mwProfilePrivacyEnum_invited =
    const MwProfilePrivacyEnum._('invited');
const MwProfilePrivacyEnum _$mwProfilePrivacyEnum_registered =
    const MwProfilePrivacyEnum._('registered');

MwProfilePrivacyEnum _$mwProfilePrivacyEnumValueOf(String name) {
  switch (name) {
    case 'all':
      return _$mwProfilePrivacyEnum_all;
    case 'followers':
      return _$mwProfilePrivacyEnum_followers;
    case 'invited':
      return _$mwProfilePrivacyEnum_invited;
    case 'registered':
      return _$mwProfilePrivacyEnum_registered;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwProfilePrivacyEnum> _$mwProfilePrivacyEnumValues =
    new BuiltSet<MwProfilePrivacyEnum>(const <MwProfilePrivacyEnum>[
  _$mwProfilePrivacyEnum_all,
  _$mwProfilePrivacyEnum_followers,
  _$mwProfilePrivacyEnum_invited,
  _$mwProfilePrivacyEnum_registered,
]);

const MwProfileChatPrivacyEnum _$mwProfileChatPrivacyEnum_invited =
    const MwProfileChatPrivacyEnum._('invited');
const MwProfileChatPrivacyEnum _$mwProfileChatPrivacyEnum_followers =
    const MwProfileChatPrivacyEnum._('followers');
const MwProfileChatPrivacyEnum _$mwProfileChatPrivacyEnum_friends =
    const MwProfileChatPrivacyEnum._('friends');
const MwProfileChatPrivacyEnum _$mwProfileChatPrivacyEnum_me =
    const MwProfileChatPrivacyEnum._('me');

MwProfileChatPrivacyEnum _$mwProfileChatPrivacyEnumValueOf(String name) {
  switch (name) {
    case 'invited':
      return _$mwProfileChatPrivacyEnum_invited;
    case 'followers':
      return _$mwProfileChatPrivacyEnum_followers;
    case 'friends':
      return _$mwProfileChatPrivacyEnum_friends;
    case 'me':
      return _$mwProfileChatPrivacyEnum_me;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwProfileChatPrivacyEnum> _$mwProfileChatPrivacyEnumValues =
    new BuiltSet<MwProfileChatPrivacyEnum>(const <MwProfileChatPrivacyEnum>[
  _$mwProfileChatPrivacyEnum_invited,
  _$mwProfileChatPrivacyEnum_followers,
  _$mwProfileChatPrivacyEnum_friends,
  _$mwProfileChatPrivacyEnum_me,
]);

Serializer<MwProfileGenderEnum> _$mwProfileGenderEnumSerializer =
    new _$MwProfileGenderEnumSerializer();
Serializer<MwProfilePrivacyEnum> _$mwProfilePrivacyEnumSerializer =
    new _$MwProfilePrivacyEnumSerializer();
Serializer<MwProfileChatPrivacyEnum> _$mwProfileChatPrivacyEnumSerializer =
    new _$MwProfileChatPrivacyEnumSerializer();

class _$MwProfileGenderEnumSerializer
    implements PrimitiveSerializer<MwProfileGenderEnum> {
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
  final Iterable<Type> types = const <Type>[MwProfileGenderEnum];
  @override
  final String wireName = 'MwProfileGenderEnum';

  @override
  Object serialize(Serializers serializers, MwProfileGenderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwProfileGenderEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwProfileGenderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwProfilePrivacyEnumSerializer
    implements PrimitiveSerializer<MwProfilePrivacyEnum> {
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
  final Iterable<Type> types = const <Type>[MwProfilePrivacyEnum];
  @override
  final String wireName = 'MwProfilePrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwProfilePrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwProfilePrivacyEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwProfilePrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwProfileChatPrivacyEnumSerializer
    implements PrimitiveSerializer<MwProfileChatPrivacyEnum> {
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
  final Iterable<Type> types = const <Type>[MwProfileChatPrivacyEnum];
  @override
  final String wireName = 'MwProfileChatPrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwProfileChatPrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwProfileChatPrivacyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwProfileChatPrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class MwProfileBuilder implements MwFriendBuilder {
  void replace(covariant MwProfile other);
  void update(void Function(MwProfileBuilder) updates);
  double? get createdAt;
  set createdAt(covariant double? createdAt);

  String? get country;
  set country(covariant String? country);

  bool? get isDaylog;
  set isDaylog(covariant bool? isDaylog);

  MwUser? get invitedBy;
  set invitedBy(covariant MwUser? invitedBy);

  MwUser? get createdBy;
  set createdBy(covariant MwUser? createdBy);

  String? get city;
  set city(covariant String? city);

  MwDesignBuilder get design;
  set design(covariant MwDesignBuilder? design);

  MwProfileAllOfRightsBuilder get rights;
  set rights(covariant MwProfileAllOfRightsBuilder? rights);

  MwProfileAllOfRelationsBuilder get relations;
  set relations(covariant MwProfileAllOfRelationsBuilder? relations);

  int? get ageLowerBound;
  set ageLowerBound(covariant int? ageLowerBound);

  int? get ageUpperBound;
  set ageUpperBound(covariant int? ageUpperBound);

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

class _$$MwProfile extends $MwProfile {
  @override
  final double? createdAt;
  @override
  final String? country;
  @override
  final bool? isDaylog;
  @override
  final MwUser? invitedBy;
  @override
  final MwUser? createdBy;
  @override
  final String? city;
  @override
  final MwDesign? design;
  @override
  final MwProfileAllOfRights? rights;
  @override
  final MwProfileAllOfRelations? relations;
  @override
  final int? ageLowerBound;
  @override
  final int? ageUpperBound;
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

  factory _$$MwProfile([void Function($MwProfileBuilder)? updates]) =>
      (new $MwProfileBuilder()..update(updates))._build();

  _$$MwProfile._(
      {this.createdAt,
      this.country,
      this.isDaylog,
      this.invitedBy,
      this.createdBy,
      this.city,
      this.design,
      this.rights,
      this.relations,
      this.ageLowerBound,
      this.ageUpperBound,
      this.lastSeenAt,
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
  $MwProfile rebuild(void Function($MwProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $MwProfileBuilder toBuilder() => new $MwProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $MwProfile &&
        createdAt == other.createdAt &&
        country == other.country &&
        isDaylog == other.isDaylog &&
        invitedBy == other.invitedBy &&
        createdBy == other.createdBy &&
        city == other.city &&
        design == other.design &&
        rights == other.rights &&
        relations == other.relations &&
        ageLowerBound == other.ageLowerBound &&
        ageUpperBound == other.ageUpperBound &&
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
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, isDaylog.hashCode);
    _$hash = $jc(_$hash, invitedBy.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, design.hashCode);
    _$hash = $jc(_$hash, rights.hashCode);
    _$hash = $jc(_$hash, relations.hashCode);
    _$hash = $jc(_$hash, ageLowerBound.hashCode);
    _$hash = $jc(_$hash, ageUpperBound.hashCode);
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
    return (newBuiltValueToStringHelper(r'$MwProfile')
          ..add('createdAt', createdAt)
          ..add('country', country)
          ..add('isDaylog', isDaylog)
          ..add('invitedBy', invitedBy)
          ..add('createdBy', createdBy)
          ..add('city', city)
          ..add('design', design)
          ..add('rights', rights)
          ..add('relations', relations)
          ..add('ageLowerBound', ageLowerBound)
          ..add('ageUpperBound', ageUpperBound)
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

class $MwProfileBuilder
    implements Builder<$MwProfile, $MwProfileBuilder>, MwProfileBuilder {
  _$$MwProfile? _$v;

  double? _createdAt;
  double? get createdAt => _$this._createdAt;
  set createdAt(covariant double? createdAt) => _$this._createdAt = createdAt;

  String? _country;
  String? get country => _$this._country;
  set country(covariant String? country) => _$this._country = country;

  bool? _isDaylog;
  bool? get isDaylog => _$this._isDaylog;
  set isDaylog(covariant bool? isDaylog) => _$this._isDaylog = isDaylog;

  MwUser? _invitedBy;
  MwUser? get invitedBy => _$this._invitedBy;
  set invitedBy(covariant MwUser? invitedBy) => _$this._invitedBy = invitedBy;

  MwUser? _createdBy;
  MwUser? get createdBy => _$this._createdBy;
  set createdBy(covariant MwUser? createdBy) => _$this._createdBy = createdBy;

  String? _city;
  String? get city => _$this._city;
  set city(covariant String? city) => _$this._city = city;

  MwDesignBuilder? _design;
  MwDesignBuilder get design => _$this._design ??= new MwDesignBuilder();
  set design(covariant MwDesignBuilder? design) => _$this._design = design;

  MwProfileAllOfRightsBuilder? _rights;
  MwProfileAllOfRightsBuilder get rights =>
      _$this._rights ??= new MwProfileAllOfRightsBuilder();
  set rights(covariant MwProfileAllOfRightsBuilder? rights) =>
      _$this._rights = rights;

  MwProfileAllOfRelationsBuilder? _relations;
  MwProfileAllOfRelationsBuilder get relations =>
      _$this._relations ??= new MwProfileAllOfRelationsBuilder();
  set relations(covariant MwProfileAllOfRelationsBuilder? relations) =>
      _$this._relations = relations;

  int? _ageLowerBound;
  int? get ageLowerBound => _$this._ageLowerBound;
  set ageLowerBound(covariant int? ageLowerBound) =>
      _$this._ageLowerBound = ageLowerBound;

  int? _ageUpperBound;
  int? get ageUpperBound => _$this._ageUpperBound;
  set ageUpperBound(covariant int? ageUpperBound) =>
      _$this._ageUpperBound = ageUpperBound;

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

  $MwProfileBuilder() {
    $MwProfile._defaults(this);
  }

  $MwProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _country = $v.country;
      _isDaylog = $v.isDaylog;
      _invitedBy = $v.invitedBy;
      _createdBy = $v.createdBy;
      _city = $v.city;
      _design = $v.design?.toBuilder();
      _rights = $v.rights?.toBuilder();
      _relations = $v.relations?.toBuilder();
      _ageLowerBound = $v.ageLowerBound;
      _ageUpperBound = $v.ageUpperBound;
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
  void replace(covariant $MwProfile other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$$MwProfile;
  }

  @override
  void update(void Function($MwProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $MwProfile build() => _build();

  _$$MwProfile _build() {
    _$$MwProfile _$result;
    try {
      _$result = _$v ??
          new _$$MwProfile._(
              createdAt: createdAt,
              country: country,
              isDaylog: isDaylog,
              invitedBy: invitedBy,
              createdBy: createdBy,
              city: city,
              design: _design?.build(),
              rights: _rights?.build(),
              relations: _relations?.build(),
              ageLowerBound: ageLowerBound,
              ageUpperBound: ageUpperBound,
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
        _$failedField = 'design';
        _design?.build();
        _$failedField = 'rights';
        _rights?.build();
        _$failedField = 'relations';
        _relations?.build();

        _$failedField = 'cover';
        _cover?.build();

        _$failedField = 'counts';
        _counts?.build();

        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'$MwProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
