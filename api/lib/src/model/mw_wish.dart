//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_wish.g.dart';

/// MwWish
///
/// Properties:
/// * [id] 
/// * [content] 
/// * [state] 
/// * [sendUntil] 
/// * [receiver] 
@BuiltValue()
abstract class MwWish implements Built<MwWish, MwWishBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'state')
  MwWishStateEnum? get state;
  // enum stateEnum {  new,  sent,  expired,  declined,  thanked,  complained,  };

  @BuiltValueField(wireName: r'sendUntil')
  double? get sendUntil;

  @BuiltValueField(wireName: r'receiver')
  MwUser? get receiver;

  MwWish._();

  factory MwWish([void updates(MwWishBuilder b)]) = _$MwWish;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwWishBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwWish> get serializer => _$MwWishSerializer();
}

class _$MwWishSerializer implements PrimitiveSerializer<MwWish> {
  @override
  final Iterable<Type> types = const [MwWish, _$MwWish];

  @override
  final String wireName = r'MwWish';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwWish object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(MwWishStateEnum),
      );
    }
    if (object.sendUntil != null) {
      yield r'sendUntil';
      yield serializers.serialize(
        object.sendUntil,
        specifiedType: const FullType(double),
      );
    }
    if (object.receiver != null) {
      yield r'receiver';
      yield serializers.serialize(
        object.receiver,
        specifiedType: const FullType(MwUser),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwWish object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwWishBuilder result,
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
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwWishStateEnum),
          ) as MwWishStateEnum;
          result.state = valueDes;
          break;
        case r'sendUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.sendUntil = valueDes;
          break;
        case r'receiver':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.receiver = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwWish deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwWishBuilder();
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

class MwWishStateEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'new')
  static const MwWishStateEnum new_ = _$mwWishStateEnum_new_;
  @BuiltValueEnumConst(wireName: r'sent')
  static const MwWishStateEnum sent = _$mwWishStateEnum_sent;
  @BuiltValueEnumConst(wireName: r'expired')
  static const MwWishStateEnum expired = _$mwWishStateEnum_expired;
  @BuiltValueEnumConst(wireName: r'declined')
  static const MwWishStateEnum declined = _$mwWishStateEnum_declined;
  @BuiltValueEnumConst(wireName: r'thanked')
  static const MwWishStateEnum thanked = _$mwWishStateEnum_thanked;
  @BuiltValueEnumConst(wireName: r'complained')
  static const MwWishStateEnum complained = _$mwWishStateEnum_complained;

  static Serializer<MwWishStateEnum> get serializer => _$mwWishStateEnumSerializer;

  const MwWishStateEnum._(String name): super(name);

  static BuiltSet<MwWishStateEnum> get values => _$mwWishStateEnumValues;
  static MwWishStateEnum valueOf(String name) => _$mwWishStateEnumValueOf(name);
}

