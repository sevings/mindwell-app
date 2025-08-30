//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_relationship.g.dart';

/// MwRelationship
///
/// Properties:
/// * [from] 
/// * [to] 
/// * [relation] 
@BuiltValue()
abstract class MwRelationship implements Built<MwRelationship, MwRelationshipBuilder> {
  @BuiltValueField(wireName: r'from')
  String? get from;

  @BuiltValueField(wireName: r'to')
  String? get to;

  @BuiltValueField(wireName: r'relation')
  MwRelationshipRelationEnum? get relation;
  // enum relationEnum {  followed,  requested,  ignored,  hidden,  none,  };

  MwRelationship._();

  factory MwRelationship([void updates(MwRelationshipBuilder b)]) = _$MwRelationship;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwRelationshipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwRelationship> get serializer => _$MwRelationshipSerializer();
}

class _$MwRelationshipSerializer implements PrimitiveSerializer<MwRelationship> {
  @override
  final Iterable<Type> types = const [MwRelationship, _$MwRelationship];

  @override
  final String wireName = r'MwRelationship';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwRelationship object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.from != null) {
      yield r'from';
      yield serializers.serialize(
        object.from,
        specifiedType: const FullType(String),
      );
    }
    if (object.to != null) {
      yield r'to';
      yield serializers.serialize(
        object.to,
        specifiedType: const FullType(String),
      );
    }
    if (object.relation != null) {
      yield r'relation';
      yield serializers.serialize(
        object.relation,
        specifiedType: const FullType(MwRelationshipRelationEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwRelationship object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwRelationshipBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'relation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwRelationshipRelationEnum),
          ) as MwRelationshipRelationEnum;
          result.relation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwRelationship deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwRelationshipBuilder();
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

class MwRelationshipRelationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'followed')
  static const MwRelationshipRelationEnum followed = _$mwRelationshipRelationEnum_followed;
  @BuiltValueEnumConst(wireName: r'requested')
  static const MwRelationshipRelationEnum requested = _$mwRelationshipRelationEnum_requested;
  @BuiltValueEnumConst(wireName: r'ignored')
  static const MwRelationshipRelationEnum ignored = _$mwRelationshipRelationEnum_ignored;
  @BuiltValueEnumConst(wireName: r'hidden')
  static const MwRelationshipRelationEnum hidden = _$mwRelationshipRelationEnum_hidden;
  @BuiltValueEnumConst(wireName: r'none')
  static const MwRelationshipRelationEnum none = _$mwRelationshipRelationEnum_none;

  static Serializer<MwRelationshipRelationEnum> get serializer => _$mwRelationshipRelationEnumSerializer;

  const MwRelationshipRelationEnum._(String name): super(name);

  static BuiltSet<MwRelationshipRelationEnum> get values => _$mwRelationshipRelationEnumValues;
  static MwRelationshipRelationEnum valueOf(String name) => _$mwRelationshipRelationEnumValueOf(name);
}

