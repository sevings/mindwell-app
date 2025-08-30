//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_friend.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mindwell/src/model/mw_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_friend_list.g.dart';

/// MwFriendList
///
/// Properties:
/// * [subject] 
/// * [relation] 
/// * [users] 
/// * [nextAfter] 
/// * [hasAfter] 
/// * [nextBefore] 
/// * [hasBefore] 
@BuiltValue()
abstract class MwFriendList implements Built<MwFriendList, MwFriendListBuilder> {
  @BuiltValueField(wireName: r'subject')
  MwUser? get subject;

  @BuiltValueField(wireName: r'relation')
  MwFriendListRelationEnum? get relation;
  // enum relationEnum {  followers,  followings,  requested,  ignored,  hidden,  invited,  };

  @BuiltValueField(wireName: r'users')
  BuiltList<MwFriend>? get users;

  @BuiltValueField(wireName: r'nextAfter')
  String? get nextAfter;

  @BuiltValueField(wireName: r'hasAfter')
  bool? get hasAfter;

  @BuiltValueField(wireName: r'nextBefore')
  String? get nextBefore;

  @BuiltValueField(wireName: r'hasBefore')
  bool? get hasBefore;

  MwFriendList._();

  factory MwFriendList([void updates(MwFriendListBuilder b)]) = _$MwFriendList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwFriendListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwFriendList> get serializer => _$MwFriendListSerializer();
}

class _$MwFriendListSerializer implements PrimitiveSerializer<MwFriendList> {
  @override
  final Iterable<Type> types = const [MwFriendList, _$MwFriendList];

  @override
  final String wireName = r'MwFriendList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwFriendList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.subject != null) {
      yield r'subject';
      yield serializers.serialize(
        object.subject,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.relation != null) {
      yield r'relation';
      yield serializers.serialize(
        object.relation,
        specifiedType: const FullType(MwFriendListRelationEnum),
      );
    }
    if (object.users != null) {
      yield r'users';
      yield serializers.serialize(
        object.users,
        specifiedType: const FullType(BuiltList, [FullType(MwFriend)]),
      );
    }
    if (object.nextAfter != null) {
      yield r'nextAfter';
      yield serializers.serialize(
        object.nextAfter,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasAfter != null) {
      yield r'hasAfter';
      yield serializers.serialize(
        object.hasAfter,
        specifiedType: const FullType(bool),
      );
    }
    if (object.nextBefore != null) {
      yield r'nextBefore';
      yield serializers.serialize(
        object.nextBefore,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasBefore != null) {
      yield r'hasBefore';
      yield serializers.serialize(
        object.hasBefore,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwFriendList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwFriendListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.subject = valueDes;
          break;
        case r'relation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwFriendListRelationEnum),
          ) as MwFriendListRelationEnum;
          result.relation = valueDes;
          break;
        case r'users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwFriend)]),
          ) as BuiltList<MwFriend>;
          result.users.replace(valueDes);
          break;
        case r'nextAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextAfter = valueDes;
          break;
        case r'hasAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAfter = valueDes;
          break;
        case r'nextBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextBefore = valueDes;
          break;
        case r'hasBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasBefore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwFriendList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwFriendListBuilder();
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

class MwFriendListRelationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'followers')
  static const MwFriendListRelationEnum followers = _$mwFriendListRelationEnum_followers;
  @BuiltValueEnumConst(wireName: r'followings')
  static const MwFriendListRelationEnum followings = _$mwFriendListRelationEnum_followings;
  @BuiltValueEnumConst(wireName: r'requested')
  static const MwFriendListRelationEnum requested = _$mwFriendListRelationEnum_requested;
  @BuiltValueEnumConst(wireName: r'ignored')
  static const MwFriendListRelationEnum ignored = _$mwFriendListRelationEnum_ignored;
  @BuiltValueEnumConst(wireName: r'hidden')
  static const MwFriendListRelationEnum hidden = _$mwFriendListRelationEnum_hidden;
  @BuiltValueEnumConst(wireName: r'invited')
  static const MwFriendListRelationEnum invited = _$mwFriendListRelationEnum_invited;

  static Serializer<MwFriendListRelationEnum> get serializer => _$mwFriendListRelationEnumSerializer;

  const MwFriendListRelationEnum._(String name): super(name);

  static BuiltSet<MwFriendListRelationEnum> get values => _$mwFriendListRelationEnumValues;
  static MwFriendListRelationEnum valueOf(String name) => _$mwFriendListRelationEnumValueOf(name);
}

