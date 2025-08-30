//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_friend_all_of_counts.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mindwell/src/model/mw_cover.dart';
import 'package:mindwell/src/model/mw_user.dart';
import 'package:mindwell/src/model/mw_avatar.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_friend.g.dart';

/// MwFriend
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
@BuiltValue(instantiable: false)
abstract class MwFriend implements MwUser {
  @BuiltValueField(wireName: r'lastSeenAt')
  double? get lastSeenAt;

  @BuiltValueField(wireName: r'cover')
  MwCover? get cover;

  @BuiltValueField(wireName: r'gender')
  MwFriendGenderEnum? get gender;
  // enum genderEnum {  male,  female,  not set,  };

  @BuiltValueField(wireName: r'counts')
  MwFriendAllOfCounts? get counts;

  @BuiltValueField(wireName: r'chatPrivacy')
  MwFriendChatPrivacyEnum? get chatPrivacy;
  // enum chatPrivacyEnum {  invited,  followers,  friends,  me,  };

  @BuiltValueField(wireName: r'privacy')
  MwFriendPrivacyEnum? get privacy;
  // enum privacyEnum {  all,  followers,  invited,  registered,  };

  @BuiltValueField(wireName: r'rank')
  num? get rank;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwFriend> get serializer => _$MwFriendSerializer();
}

class _$MwFriendSerializer implements PrimitiveSerializer<MwFriend> {
  @override
  final Iterable<Type> types = const [MwFriend];

  @override
  final String wireName = r'MwFriend';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwFriend object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.lastSeenAt != null) {
      yield r'lastSeenAt';
      yield serializers.serialize(
        object.lastSeenAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.showName != null) {
      yield r'showName';
      yield serializers.serialize(
        object.showName,
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
    if (object.gender != null) {
      yield r'gender';
      yield serializers.serialize(
        object.gender,
        specifiedType: const FullType(MwFriendGenderEnum),
      );
    }
    if (object.counts != null) {
      yield r'counts';
      yield serializers.serialize(
        object.counts,
        specifiedType: const FullType(MwFriendAllOfCounts),
      );
    }
    if (object.chatPrivacy != null) {
      yield r'chatPrivacy';
      yield serializers.serialize(
        object.chatPrivacy,
        specifiedType: const FullType(MwFriendChatPrivacyEnum),
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
    if (object.avatar != null) {
      yield r'avatar';
      yield serializers.serialize(
        object.avatar,
        specifiedType: const FullType(MwAvatar),
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
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    MwFriend object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  MwFriend deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($MwFriend)) as $MwFriend;
  }
}

/// a concrete implementation of [MwFriend], since [MwFriend] is not instantiable
@BuiltValue(instantiable: true)
abstract class $MwFriend implements MwFriend, Built<$MwFriend, $MwFriendBuilder> {
  $MwFriend._();

  factory $MwFriend([void Function($MwFriendBuilder)? updates]) = _$$MwFriend;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($MwFriendBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$MwFriend> get serializer => _$$MwFriendSerializer();
}

class _$$MwFriendSerializer implements PrimitiveSerializer<$MwFriend> {
  @override
  final Iterable<Type> types = const [$MwFriend, _$$MwFriend];

  @override
  final String wireName = r'$MwFriend';

  @override
  Object serialize(
    Serializers serializers,
    $MwFriend object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(MwFriend))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwFriendBuilder result,
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
        case r'showName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.showName = valueDes;
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
        case r'counts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendAllOfCounts),
          ) as MwFriendAllOfCounts;
          result.counts.replace(valueDes);
          break;
        case r'chatPrivacy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendChatPrivacyEnum),
          ) as MwFriendChatPrivacyEnum;
          result.chatPrivacy = valueDes;
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
        case r'avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwAvatar),
          ) as MwAvatar;
          result.avatar.replace(valueDes);
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $MwFriend deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $MwFriendBuilder();
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

class MwFriendGenderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'male')
  static const MwFriendGenderEnum male = _$mwFriendGenderEnum_male;
  @BuiltValueEnumConst(wireName: r'female')
  static const MwFriendGenderEnum female = _$mwFriendGenderEnum_female;
  @BuiltValueEnumConst(wireName: r'not set')
  static const MwFriendGenderEnum notSet = _$mwFriendGenderEnum_notSet;

  static Serializer<MwFriendGenderEnum> get serializer => _$mwFriendGenderEnumSerializer;

  const MwFriendGenderEnum._(String name): super(name);

  static BuiltSet<MwFriendGenderEnum> get values => _$mwFriendGenderEnumValues;
  static MwFriendGenderEnum valueOf(String name) => _$mwFriendGenderEnumValueOf(name);
}

class MwFriendPrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'all')
  static const MwFriendPrivacyEnum all = _$mwFriendPrivacyEnum_all;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwFriendPrivacyEnum followers = _$mwFriendPrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'invited')
  static const MwFriendPrivacyEnum invited = _$mwFriendPrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'registered')
  static const MwFriendPrivacyEnum registered = _$mwFriendPrivacyEnum_registered;

  static Serializer<MwFriendPrivacyEnum> get serializer => _$mwFriendPrivacyEnumSerializer;

  const MwFriendPrivacyEnum._(String name): super(name);

  static BuiltSet<MwFriendPrivacyEnum> get values => _$mwFriendPrivacyEnumValues;
  static MwFriendPrivacyEnum valueOf(String name) => _$mwFriendPrivacyEnumValueOf(name);
}

class MwFriendChatPrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'invited')
  static const MwFriendChatPrivacyEnum invited = _$mwFriendChatPrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwFriendChatPrivacyEnum followers = _$mwFriendChatPrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'friends')
  static const MwFriendChatPrivacyEnum friends = _$mwFriendChatPrivacyEnum_friends;
  @BuiltValueEnumConst(wireName: r'me')
  static const MwFriendChatPrivacyEnum me = _$mwFriendChatPrivacyEnum_me;

  static Serializer<MwFriendChatPrivacyEnum> get serializer => _$mwFriendChatPrivacyEnumSerializer;

  const MwFriendChatPrivacyEnum._(String name): super(name);

  static BuiltSet<MwFriendChatPrivacyEnum> get values => _$mwFriendChatPrivacyEnumValues;
  static MwFriendChatPrivacyEnum valueOf(String name) => _$mwFriendChatPrivacyEnumValueOf(name);
}

