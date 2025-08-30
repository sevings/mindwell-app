// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_auth_profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwAuthProfileGenderEnum _$mwAuthProfileGenderEnum_male =
    const MwAuthProfileGenderEnum._('male');
const MwAuthProfileGenderEnum _$mwAuthProfileGenderEnum_female =
    const MwAuthProfileGenderEnum._('female');
const MwAuthProfileGenderEnum _$mwAuthProfileGenderEnum_notSet =
    const MwAuthProfileGenderEnum._('notSet');

MwAuthProfileGenderEnum _$mwAuthProfileGenderEnumValueOf(String name) {
  switch (name) {
    case 'male':
      return _$mwAuthProfileGenderEnum_male;
    case 'female':
      return _$mwAuthProfileGenderEnum_female;
    case 'notSet':
      return _$mwAuthProfileGenderEnum_notSet;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwAuthProfileGenderEnum> _$mwAuthProfileGenderEnumValues =
    new BuiltSet<MwAuthProfileGenderEnum>(const <MwAuthProfileGenderEnum>[
  _$mwAuthProfileGenderEnum_male,
  _$mwAuthProfileGenderEnum_female,
  _$mwAuthProfileGenderEnum_notSet,
]);

const MwAuthProfilePrivacyEnum _$mwAuthProfilePrivacyEnum_all =
    const MwAuthProfilePrivacyEnum._('all');
const MwAuthProfilePrivacyEnum _$mwAuthProfilePrivacyEnum_followers =
    const MwAuthProfilePrivacyEnum._('followers');
const MwAuthProfilePrivacyEnum _$mwAuthProfilePrivacyEnum_invited =
    const MwAuthProfilePrivacyEnum._('invited');
const MwAuthProfilePrivacyEnum _$mwAuthProfilePrivacyEnum_registered =
    const MwAuthProfilePrivacyEnum._('registered');

MwAuthProfilePrivacyEnum _$mwAuthProfilePrivacyEnumValueOf(String name) {
  switch (name) {
    case 'all':
      return _$mwAuthProfilePrivacyEnum_all;
    case 'followers':
      return _$mwAuthProfilePrivacyEnum_followers;
    case 'invited':
      return _$mwAuthProfilePrivacyEnum_invited;
    case 'registered':
      return _$mwAuthProfilePrivacyEnum_registered;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwAuthProfilePrivacyEnum> _$mwAuthProfilePrivacyEnumValues =
    new BuiltSet<MwAuthProfilePrivacyEnum>(const <MwAuthProfilePrivacyEnum>[
  _$mwAuthProfilePrivacyEnum_all,
  _$mwAuthProfilePrivacyEnum_followers,
  _$mwAuthProfilePrivacyEnum_invited,
  _$mwAuthProfilePrivacyEnum_registered,
]);

const MwAuthProfileChatPrivacyEnum _$mwAuthProfileChatPrivacyEnum_invited =
    const MwAuthProfileChatPrivacyEnum._('invited');
const MwAuthProfileChatPrivacyEnum _$mwAuthProfileChatPrivacyEnum_followers =
    const MwAuthProfileChatPrivacyEnum._('followers');
const MwAuthProfileChatPrivacyEnum _$mwAuthProfileChatPrivacyEnum_friends =
    const MwAuthProfileChatPrivacyEnum._('friends');
const MwAuthProfileChatPrivacyEnum _$mwAuthProfileChatPrivacyEnum_me =
    const MwAuthProfileChatPrivacyEnum._('me');

MwAuthProfileChatPrivacyEnum _$mwAuthProfileChatPrivacyEnumValueOf(
    String name) {
  switch (name) {
    case 'invited':
      return _$mwAuthProfileChatPrivacyEnum_invited;
    case 'followers':
      return _$mwAuthProfileChatPrivacyEnum_followers;
    case 'friends':
      return _$mwAuthProfileChatPrivacyEnum_friends;
    case 'me':
      return _$mwAuthProfileChatPrivacyEnum_me;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwAuthProfileChatPrivacyEnum>
    _$mwAuthProfileChatPrivacyEnumValues = new BuiltSet<
        MwAuthProfileChatPrivacyEnum>(const <MwAuthProfileChatPrivacyEnum>[
  _$mwAuthProfileChatPrivacyEnum_invited,
  _$mwAuthProfileChatPrivacyEnum_followers,
  _$mwAuthProfileChatPrivacyEnum_friends,
  _$mwAuthProfileChatPrivacyEnum_me,
]);

Serializer<MwAuthProfileGenderEnum> _$mwAuthProfileGenderEnumSerializer =
    new _$MwAuthProfileGenderEnumSerializer();
Serializer<MwAuthProfilePrivacyEnum> _$mwAuthProfilePrivacyEnumSerializer =
    new _$MwAuthProfilePrivacyEnumSerializer();
Serializer<MwAuthProfileChatPrivacyEnum>
    _$mwAuthProfileChatPrivacyEnumSerializer =
    new _$MwAuthProfileChatPrivacyEnumSerializer();

class _$MwAuthProfileGenderEnumSerializer
    implements PrimitiveSerializer<MwAuthProfileGenderEnum> {
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
  final Iterable<Type> types = const <Type>[MwAuthProfileGenderEnum];
  @override
  final String wireName = 'MwAuthProfileGenderEnum';

  @override
  Object serialize(Serializers serializers, MwAuthProfileGenderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwAuthProfileGenderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwAuthProfileGenderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwAuthProfilePrivacyEnumSerializer
    implements PrimitiveSerializer<MwAuthProfilePrivacyEnum> {
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
  final Iterable<Type> types = const <Type>[MwAuthProfilePrivacyEnum];
  @override
  final String wireName = 'MwAuthProfilePrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwAuthProfilePrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwAuthProfilePrivacyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwAuthProfilePrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwAuthProfileChatPrivacyEnumSerializer
    implements PrimitiveSerializer<MwAuthProfileChatPrivacyEnum> {
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
  final Iterable<Type> types = const <Type>[MwAuthProfileChatPrivacyEnum];
  @override
  final String wireName = 'MwAuthProfileChatPrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwAuthProfileChatPrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwAuthProfileChatPrivacyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwAuthProfileChatPrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwAuthProfile extends MwAuthProfile {
  @override
  final String? birthday;
  @override
  final bool? showInTops;
  @override
  final MwAuthProfileAllOfAccount? account;
  @override
  final MwAuthProfileAllOfBan? ban;
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

  factory _$MwAuthProfile([void Function(MwAuthProfileBuilder)? updates]) =>
      (new MwAuthProfileBuilder()..update(updates))._build();

  _$MwAuthProfile._(
      {this.birthday,
      this.showInTops,
      this.account,
      this.ban,
      this.createdAt,
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
  MwAuthProfile rebuild(void Function(MwAuthProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAuthProfileBuilder toBuilder() => new MwAuthProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAuthProfile &&
        birthday == other.birthday &&
        showInTops == other.showInTops &&
        account == other.account &&
        ban == other.ban &&
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
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jc(_$hash, showInTops.hashCode);
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, ban.hashCode);
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
    return (newBuiltValueToStringHelper(r'MwAuthProfile')
          ..add('birthday', birthday)
          ..add('showInTops', showInTops)
          ..add('account', account)
          ..add('ban', ban)
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

class MwAuthProfileBuilder
    implements Builder<MwAuthProfile, MwAuthProfileBuilder>, MwProfileBuilder {
  _$MwAuthProfile? _$v;

  String? _birthday;
  String? get birthday => _$this._birthday;
  set birthday(covariant String? birthday) => _$this._birthday = birthday;

  bool? _showInTops;
  bool? get showInTops => _$this._showInTops;
  set showInTops(covariant bool? showInTops) => _$this._showInTops = showInTops;

  MwAuthProfileAllOfAccountBuilder? _account;
  MwAuthProfileAllOfAccountBuilder get account =>
      _$this._account ??= new MwAuthProfileAllOfAccountBuilder();
  set account(covariant MwAuthProfileAllOfAccountBuilder? account) =>
      _$this._account = account;

  MwAuthProfileAllOfBanBuilder? _ban;
  MwAuthProfileAllOfBanBuilder get ban =>
      _$this._ban ??= new MwAuthProfileAllOfBanBuilder();
  set ban(covariant MwAuthProfileAllOfBanBuilder? ban) => _$this._ban = ban;

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

  MwAuthProfileBuilder() {
    MwAuthProfile._defaults(this);
  }

  MwAuthProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _birthday = $v.birthday;
      _showInTops = $v.showInTops;
      _account = $v.account?.toBuilder();
      _ban = $v.ban?.toBuilder();
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
  void replace(covariant MwAuthProfile other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAuthProfile;
  }

  @override
  void update(void Function(MwAuthProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAuthProfile build() => _build();

  _$MwAuthProfile _build() {
    _$MwAuthProfile _$result;
    try {
      _$result = _$v ??
          new _$MwAuthProfile._(
              birthday: birthday,
              showInTops: showInTops,
              account: _account?.build(),
              ban: _ban?.build(),
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
        _$failedField = 'account';
        _account?.build();
        _$failedField = 'ban';
        _ban?.build();

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
            r'MwAuthProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
