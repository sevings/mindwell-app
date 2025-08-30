//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_friend_all_of_counts.dart';
import 'package:mindwell/src/model/mw_auth_profile_all_of_account.dart';
import 'package:mindwell/src/model/mw_design.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mindwell/src/model/mw_cover.dart';
import 'package:mindwell/src/model/mw_profile.dart';
import 'package:mindwell/src/model/mw_auth_profile_all_of_ban.dart';
import 'package:mindwell/src/model/mw_profile_all_of_relations.dart';
import 'package:mindwell/src/model/mw_profile_all_of_rights.dart';
import 'package:mindwell/src/model/mw_user.dart';
import 'package:mindwell/src/model/mw_friend.dart';
import 'package:mindwell/src/model/mw_avatar.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_auth_profile.g.dart';

/// MwAuthProfile
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [showName] 
/// * [isTheme] 
/// * [isOnline] 
/// * [avatar] 
/// * [gender] 
/// * [privacy] 
/// * [chatPrivacy] 
/// * [title] 
/// * [rank] 
/// * [lastSeenAt] 
/// * [cover] 
/// * [counts] 
/// * [isDaylog] 
/// * [createdAt] 
/// * [invitedBy] 
/// * [createdBy] 
/// * [ageLowerBound] 
/// * [ageUpperBound] 
/// * [country] 
/// * [city] 
/// * [design] 
/// * [relations] 
/// * [rights] 
/// * [birthday] 
/// * [showInTops] 
/// * [account] 
/// * [ban] 
@BuiltValue()
abstract class MwAuthProfile implements MwProfile, Built<MwAuthProfile, MwAuthProfileBuilder> {
  @BuiltValueField(wireName: r'birthday')
  String? get birthday;

  @BuiltValueField(wireName: r'showInTops')
  bool? get showInTops;

  @BuiltValueField(wireName: r'account')
  MwAuthProfileAllOfAccount? get account;

  @BuiltValueField(wireName: r'ban')
  MwAuthProfileAllOfBan? get ban;

  MwAuthProfile._();

  factory MwAuthProfile([void updates(MwAuthProfileBuilder b)]) = _$MwAuthProfile;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAuthProfileBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAuthProfile> get serializer => _$MwAuthProfileSerializer();
}

class _$MwAuthProfileSerializer implements PrimitiveSerializer<MwAuthProfile> {
  @override
  final Iterable<Type> types = const [MwAuthProfile, _$MwAuthProfile];

  @override
  final String wireName = r'MwAuthProfile';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAuthProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.birthday != null) {
      yield r'birthday';
      yield serializers.serialize(
        object.birthday,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastSeenAt != null) {
      yield r'lastSeenAt';
      yield serializers.serialize(
        object.lastSeenAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.country != null) {
      yield r'country';
      yield serializers.serialize(
        object.country,
        specifiedType: const FullType(String),
      );
    }
    if (object.isTheme != null) {
      yield r'isTheme';
      yield serializers.serialize(
        object.isTheme,
        specifiedType: const FullType(bool),
      );
    }
    if (object.invitedBy != null) {
      yield r'invitedBy';
      yield serializers.serialize(
        object.invitedBy,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.gender != null) {
      yield r'gender';
      yield serializers.serialize(
        object.gender,
        specifiedType: const FullType(MwFriendGenderEnum),
      );
    }
    if (object.city != null) {
      yield r'city';
      yield serializers.serialize(
        object.city,
        specifiedType: const FullType(String),
      );
    }
    if (object.counts != null) {
      yield r'counts';
      yield serializers.serialize(
        object.counts,
        specifiedType: const FullType(MwFriendAllOfCounts),
      );
    }
    if (object.privacy != null) {
      yield r'privacy';
      yield serializers.serialize(
        object.privacy,
        specifiedType: const FullType(MwFriendPrivacyEnum),
      );
    }
    if (object.isOnline != null) {
      yield r'isOnline';
      yield serializers.serialize(
        object.isOnline,
        specifiedType: const FullType(bool),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.ban != null) {
      yield r'ban';
      yield serializers.serialize(
        object.ban,
        specifiedType: const FullType(MwAuthProfileAllOfBan),
      );
    }
    if (object.cover != null) {
      yield r'cover';
      yield serializers.serialize(
        object.cover,
        specifiedType: const FullType(MwCover),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.isDaylog != null) {
      yield r'isDaylog';
      yield serializers.serialize(
        object.isDaylog,
        specifiedType: const FullType(bool),
      );
    }
    if (object.design != null) {
      yield r'design';
      yield serializers.serialize(
        object.design,
        specifiedType: const FullType(MwDesign),
      );
    }
    if (object.rights != null) {
      yield r'rights';
      yield serializers.serialize(
        object.rights,
        specifiedType: const FullType(MwProfileAllOfRights),
      );
    }
    if (object.rank != null) {
      yield r'rank';
      yield serializers.serialize(
        object.rank,
        specifiedType: const FullType(num),
      );
    }
    if (object.showInTops != null) {
      yield r'showInTops';
      yield serializers.serialize(
        object.showInTops,
        specifiedType: const FullType(bool),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.showName != null) {
      yield r'showName';
      yield serializers.serialize(
        object.showName,
        specifiedType: const FullType(String),
      );
    }
    if (object.chatPrivacy != null) {
      yield r'chatPrivacy';
      yield serializers.serialize(
        object.chatPrivacy,
        specifiedType: const FullType(MwFriendChatPrivacyEnum),
      );
    }
    if (object.avatar != null) {
      yield r'avatar';
      yield serializers.serialize(
        object.avatar,
        specifiedType: const FullType(MwAvatar),
      );
    }
    if (object.ageLowerBound != null) {
      yield r'ageLowerBound';
      yield serializers.serialize(
        object.ageLowerBound,
        specifiedType: const FullType(int),
      );
    }
    if (object.createdBy != null) {
      yield r'createdBy';
      yield serializers.serialize(
        object.createdBy,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.relations != null) {
      yield r'relations';
      yield serializers.serialize(
        object.relations,
        specifiedType: const FullType(MwProfileAllOfRelations),
      );
    }
    if (object.account != null) {
      yield r'account';
      yield serializers.serialize(
        object.account,
        specifiedType: const FullType(MwAuthProfileAllOfAccount),
      );
    }
    if (object.ageUpperBound != null) {
      yield r'ageUpperBound';
      yield serializers.serialize(
        object.ageUpperBound,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAuthProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAuthProfileBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'birthday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.birthday = valueDes;
          break;
        case r'lastSeenAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.lastSeenAt = valueDes;
          break;
        case r'country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.country = valueDes;
          break;
        case r'isTheme':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isTheme = valueDes;
          break;
        case r'invitedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.invitedBy = valueDes;
          break;
        case r'gender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendGenderEnum),
          ) as MwFriendGenderEnum;
          result.gender = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.city = valueDes;
          break;
        case r'counts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendAllOfCounts),
          ) as MwFriendAllOfCounts;
          result.counts.replace(valueDes);
          break;
        case r'privacy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendPrivacyEnum),
          ) as MwFriendPrivacyEnum;
          result.privacy = valueDes;
          break;
        case r'isOnline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isOnline = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'ban':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwAuthProfileAllOfBan),
          ) as MwAuthProfileAllOfBan;
          result.ban.replace(valueDes);
          break;
        case r'cover':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwCover),
          ) as MwCover;
          result.cover.replace(valueDes);
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.createdAt = valueDes;
          break;
        case r'isDaylog':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isDaylog = valueDes;
          break;
        case r'design':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwDesign),
          ) as MwDesign;
          result.design.replace(valueDes);
          break;
        case r'rights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwProfileAllOfRights),
          ) as MwProfileAllOfRights;
          result.rights.replace(valueDes);
          break;
        case r'rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.rank = valueDes;
          break;
        case r'showInTops':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.showInTops = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'showName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.showName = valueDes;
          break;
        case r'chatPrivacy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendChatPrivacyEnum),
          ) as MwFriendChatPrivacyEnum;
          result.chatPrivacy = valueDes;
          break;
        case r'avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwAvatar),
          ) as MwAvatar;
          result.avatar.replace(valueDes);
          break;
        case r'ageLowerBound':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ageLowerBound = valueDes;
          break;
        case r'createdBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.createdBy = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'relations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwProfileAllOfRelations),
          ) as MwProfileAllOfRelations;
          result.relations.replace(valueDes);
          break;
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwAuthProfileAllOfAccount),
          ) as MwAuthProfileAllOfAccount;
          result.account.replace(valueDes);
          break;
        case r'ageUpperBound':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ageUpperBound = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAuthProfile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAuthProfileBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class MwAuthProfileGenderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'male')
  static const MwAuthProfileGenderEnum male = _$mwAuthProfileGenderEnum_male;
  @BuiltValueEnumConst(wireName: r'female')
  static const MwAuthProfileGenderEnum female = _$mwAuthProfileGenderEnum_female;
  @BuiltValueEnumConst(wireName: r'not set')
  static const MwAuthProfileGenderEnum notSet = _$mwAuthProfileGenderEnum_notSet;

  static Serializer<MwAuthProfileGenderEnum> get serializer => _$mwAuthProfileGenderEnumSerializer;

  const MwAuthProfileGenderEnum._(String name): super(name);

  static BuiltSet<MwAuthProfileGenderEnum> get values => _$mwAuthProfileGenderEnumValues;
  static MwAuthProfileGenderEnum valueOf(String name) => _$mwAuthProfileGenderEnumValueOf(name);
}

class MwAuthProfilePrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'all')
  static const MwAuthProfilePrivacyEnum all = _$mwAuthProfilePrivacyEnum_all;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwAuthProfilePrivacyEnum followers = _$mwAuthProfilePrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'invited')
  static const MwAuthProfilePrivacyEnum invited = _$mwAuthProfilePrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'registered')
  static const MwAuthProfilePrivacyEnum registered = _$mwAuthProfilePrivacyEnum_registered;

  static Serializer<MwAuthProfilePrivacyEnum> get serializer => _$mwAuthProfilePrivacyEnumSerializer;

  const MwAuthProfilePrivacyEnum._(String name): super(name);

  static BuiltSet<MwAuthProfilePrivacyEnum> get values => _$mwAuthProfilePrivacyEnumValues;
  static MwAuthProfilePrivacyEnum valueOf(String name) => _$mwAuthProfilePrivacyEnumValueOf(name);
}

class MwAuthProfileChatPrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'invited')
  static const MwAuthProfileChatPrivacyEnum invited = _$mwAuthProfileChatPrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwAuthProfileChatPrivacyEnum followers = _$mwAuthProfileChatPrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'friends')
  static const MwAuthProfileChatPrivacyEnum friends = _$mwAuthProfileChatPrivacyEnum_friends;
  @BuiltValueEnumConst(wireName: r'me')
  static const MwAuthProfileChatPrivacyEnum me = _$mwAuthProfileChatPrivacyEnum_me;

  static Serializer<MwAuthProfileChatPrivacyEnum> get serializer => _$mwAuthProfileChatPrivacyEnumSerializer;

  const MwAuthProfileChatPrivacyEnum._(String name): super(name);

  static BuiltSet<MwAuthProfileChatPrivacyEnum> get values => _$mwAuthProfileChatPrivacyEnumValues;
  static MwAuthProfileChatPrivacyEnum valueOf(String name) => _$mwAuthProfileChatPrivacyEnumValueOf(name);
}

