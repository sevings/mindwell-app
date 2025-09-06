//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_cover.dart';
import 'package:mindwell_api/src/model/mw_avatar.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/src/model/mw_profile_all_of_relations.dart';
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:mindwell_api/src/model/mw_design.dart';
import 'package:mindwell_api/src/model/mw_friend_all_of_counts.dart';
import 'package:mindwell_api/src/model/mw_friend.dart';
import 'package:mindwell_api/src/model/mw_profile_all_of_rights.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_profile.g.dart';

/// MwProfile
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
@BuiltValue(instantiable: false)
abstract class MwProfile implements MwFriend {
  @BuiltValueField(wireName: r'createdAt')
  double? get createdAt;

  @BuiltValueField(wireName: r'country')
  String? get country;

  @BuiltValueField(wireName: r'isDaylog')
  bool? get isDaylog;

  @BuiltValueField(wireName: r'invitedBy')
  MwUser? get invitedBy;

  @BuiltValueField(wireName: r'createdBy')
  MwUser? get createdBy;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'design')
  MwDesign? get design;

  @BuiltValueField(wireName: r'rights')
  MwProfileAllOfRights? get rights;

  @BuiltValueField(wireName: r'relations')
  MwProfileAllOfRelations? get relations;

  @BuiltValueField(wireName: r'ageLowerBound')
  int? get ageLowerBound;

  @BuiltValueField(wireName: r'ageUpperBound')
  int? get ageUpperBound;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwProfile> get serializer => _$MwProfileSerializer();
}

class _$MwProfileSerializer implements PrimitiveSerializer<MwProfile> {
  @override
  final Iterable<Type> types = const [MwProfile];

  @override
  final String wireName = r'MwProfile';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    if (object.invitedBy != null) {
      yield r'invitedBy';
      yield serializers.serialize(
        object.invitedBy,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.isTheme != null) {
      yield r'isTheme';
      yield serializers.serialize(
        object.isTheme,
        specifiedType: const FullType(bool),
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
    MwProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  MwProfile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($MwProfile)) as $MwProfile;
  }
}

/// a concrete implementation of [MwProfile], since [MwProfile] is not instantiable
@BuiltValue(instantiable: true)
abstract class $MwProfile implements MwProfile, Built<$MwProfile, $MwProfileBuilder> {
  $MwProfile._();

  factory $MwProfile([void Function($MwProfileBuilder)? updates]) = _$$MwProfile;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($MwProfileBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$MwProfile> get serializer => _$$MwProfileSerializer();
}

class _$$MwProfileSerializer implements PrimitiveSerializer<$MwProfile> {
  @override
  final Iterable<Type> types = const [$MwProfile, _$$MwProfile];

  @override
  final String wireName = r'$MwProfile';

  @override
  Object serialize(
    Serializers serializers,
    $MwProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(MwProfile))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwProfileBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'invitedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.invitedBy = valueDes;
          break;
        case r'isTheme':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isTheme = valueDes;
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
  $MwProfile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $MwProfileBuilder();
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

class MwProfileGenderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'male')
  static const MwProfileGenderEnum male = _$mwProfileGenderEnum_male;
  @BuiltValueEnumConst(wireName: r'female')
  static const MwProfileGenderEnum female = _$mwProfileGenderEnum_female;
  @BuiltValueEnumConst(wireName: r'not set')
  static const MwProfileGenderEnum notSet = _$mwProfileGenderEnum_notSet;

  static Serializer<MwProfileGenderEnum> get serializer => _$mwProfileGenderEnumSerializer;

  const MwProfileGenderEnum._(String name): super(name);

  static BuiltSet<MwProfileGenderEnum> get values => _$mwProfileGenderEnumValues;
  static MwProfileGenderEnum valueOf(String name) => _$mwProfileGenderEnumValueOf(name);
}

class MwProfilePrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'all')
  static const MwProfilePrivacyEnum all = _$mwProfilePrivacyEnum_all;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwProfilePrivacyEnum followers = _$mwProfilePrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'invited')
  static const MwProfilePrivacyEnum invited = _$mwProfilePrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'registered')
  static const MwProfilePrivacyEnum registered = _$mwProfilePrivacyEnum_registered;

  static Serializer<MwProfilePrivacyEnum> get serializer => _$mwProfilePrivacyEnumSerializer;

  const MwProfilePrivacyEnum._(String name): super(name);

  static BuiltSet<MwProfilePrivacyEnum> get values => _$mwProfilePrivacyEnumValues;
  static MwProfilePrivacyEnum valueOf(String name) => _$mwProfilePrivacyEnumValueOf(name);
}

class MwProfileChatPrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'invited')
  static const MwProfileChatPrivacyEnum invited = _$mwProfileChatPrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwProfileChatPrivacyEnum followers = _$mwProfileChatPrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'friends')
  static const MwProfileChatPrivacyEnum friends = _$mwProfileChatPrivacyEnum_friends;
  @BuiltValueEnumConst(wireName: r'me')
  static const MwProfileChatPrivacyEnum me = _$mwProfileChatPrivacyEnum_me;

  static Serializer<MwProfileChatPrivacyEnum> get serializer => _$mwProfileChatPrivacyEnumSerializer;

  const MwProfileChatPrivacyEnum._(String name): super(name);

  static BuiltSet<MwProfileChatPrivacyEnum> get values => _$mwProfileChatPrivacyEnumValues;
  static MwProfileChatPrivacyEnum valueOf(String name) => _$mwProfileChatPrivacyEnumValueOf(name);
}

