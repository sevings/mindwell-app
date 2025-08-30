//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_user_id_ban.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_user_id.g.dart';

/// MwUserID
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [negKarma] 
/// * [followersCount] 
/// * [isInvited] 
/// * [verified] 
/// * [authority] 
/// * [ban] 
@BuiltValue()
abstract class MwUserID implements Built<MwUserID, MwUserIDBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'negKarma')
  bool? get negKarma;

  @BuiltValueField(wireName: r'followersCount')
  int? get followersCount;

  @BuiltValueField(wireName: r'isInvited')
  bool? get isInvited;

  @BuiltValueField(wireName: r'verified')
  bool? get verified;

  @BuiltValueField(wireName: r'authority')
  MwUserIDAuthorityEnum? get authority;
  // enum authorityEnum {  user,  admin,  moderator,  };

  @BuiltValueField(wireName: r'ban')
  MwUserIDBan? get ban;

  MwUserID._();

  factory MwUserID([void updates(MwUserIDBuilder b)]) = _$MwUserID;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwUserIDBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwUserID> get serializer => _$MwUserIDSerializer();
}

class _$MwUserIDSerializer implements PrimitiveSerializer<MwUserID> {
  @override
  final Iterable<Type> types = const [MwUserID, _$MwUserID];

  @override
  final String wireName = r'MwUserID';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwUserID object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.negKarma != null) {
      yield r'negKarma';
      yield serializers.serialize(
        object.negKarma,
        specifiedType: const FullType(bool),
      );
    }
    if (object.followersCount != null) {
      yield r'followersCount';
      yield serializers.serialize(
        object.followersCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.isInvited != null) {
      yield r'isInvited';
      yield serializers.serialize(
        object.isInvited,
        specifiedType: const FullType(bool),
      );
    }
    if (object.verified != null) {
      yield r'verified';
      yield serializers.serialize(
        object.verified,
        specifiedType: const FullType(bool),
      );
    }
    if (object.authority != null) {
      yield r'authority';
      yield serializers.serialize(
        object.authority,
        specifiedType: const FullType(MwUserIDAuthorityEnum),
      );
    }
    if (object.ban != null) {
      yield r'ban';
      yield serializers.serialize(
        object.ban,
        specifiedType: const FullType(MwUserIDBan),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwUserID object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwUserIDBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'negKarma':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.negKarma = valueDes;
          break;
        case r'followersCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.followersCount = valueDes;
          break;
        case r'isInvited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isInvited = valueDes;
          break;
        case r'verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.verified = valueDes;
          break;
        case r'authority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUserIDAuthorityEnum),
          ) as MwUserIDAuthorityEnum;
          result.authority = valueDes;
          break;
        case r'ban':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUserIDBan),
          ) as MwUserIDBan;
          result.ban.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwUserID deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwUserIDBuilder();
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

class MwUserIDAuthorityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'user')
  static const MwUserIDAuthorityEnum user = _$mwUserIDAuthorityEnum_user;
  @BuiltValueEnumConst(wireName: r'admin')
  static const MwUserIDAuthorityEnum admin = _$mwUserIDAuthorityEnum_admin;
  @BuiltValueEnumConst(wireName: r'moderator')
  static const MwUserIDAuthorityEnum moderator = _$mwUserIDAuthorityEnum_moderator;

  static Serializer<MwUserIDAuthorityEnum> get serializer => _$mwUserIDAuthorityEnumSerializer;

  const MwUserIDAuthorityEnum._(String name): super(name);

  static BuiltSet<MwUserIDAuthorityEnum> get values => _$mwUserIDAuthorityEnumValues;
  static MwUserIDAuthorityEnum valueOf(String name) => _$mwUserIDAuthorityEnumValueOf(name);
}

