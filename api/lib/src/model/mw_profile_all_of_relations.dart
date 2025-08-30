//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_profile_all_of_relations.g.dart';

/// MwProfileAllOfRelations
///
/// Properties:
/// * [isOpenForMe] 
/// * [toMe] 
/// * [fromMe] 
@BuiltValue()
abstract class MwProfileAllOfRelations implements Built<MwProfileAllOfRelations, MwProfileAllOfRelationsBuilder> {
  @BuiltValueField(wireName: r'isOpenForMe')
  bool? get isOpenForMe;

  @BuiltValueField(wireName: r'toMe')
  MwProfileAllOfRelationsToMeEnum? get toMe;
  // enum toMeEnum {  followed,  requested,  ignored,  hidden,  none,  };

  @BuiltValueField(wireName: r'fromMe')
  MwProfileAllOfRelationsFromMeEnum? get fromMe;
  // enum fromMeEnum {  followed,  requested,  ignored,  hidden,  none,  };

  MwProfileAllOfRelations._();

  factory MwProfileAllOfRelations([void updates(MwProfileAllOfRelationsBuilder b)]) = _$MwProfileAllOfRelations;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwProfileAllOfRelationsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwProfileAllOfRelations> get serializer => _$MwProfileAllOfRelationsSerializer();
}

class _$MwProfileAllOfRelationsSerializer implements PrimitiveSerializer<MwProfileAllOfRelations> {
  @override
  final Iterable<Type> types = const [MwProfileAllOfRelations, _$MwProfileAllOfRelations];

  @override
  final String wireName = r'MwProfileAllOfRelations';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwProfileAllOfRelations object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.isOpenForMe != null) {
      yield r'isOpenForMe';
      yield serializers.serialize(
        object.isOpenForMe,
        specifiedType: const FullType(bool),
      );
    }
    if (object.toMe != null) {
      yield r'toMe';
      yield serializers.serialize(
        object.toMe,
        specifiedType: const FullType(MwProfileAllOfRelationsToMeEnum),
      );
    }
    if (object.fromMe != null) {
      yield r'fromMe';
      yield serializers.serialize(
        object.fromMe,
        specifiedType: const FullType(MwProfileAllOfRelationsFromMeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwProfileAllOfRelations object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwProfileAllOfRelationsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'isOpenForMe':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isOpenForMe = valueDes;
          break;
        case r'toMe':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwProfileAllOfRelationsToMeEnum),
          ) as MwProfileAllOfRelationsToMeEnum;
          result.toMe = valueDes;
          break;
        case r'fromMe':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwProfileAllOfRelationsFromMeEnum),
          ) as MwProfileAllOfRelationsFromMeEnum;
          result.fromMe = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwProfileAllOfRelations deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwProfileAllOfRelationsBuilder();
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

class MwProfileAllOfRelationsToMeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'followed')
  static const MwProfileAllOfRelationsToMeEnum followed = _$mwProfileAllOfRelationsToMeEnum_followed;
  @BuiltValueEnumConst(wireName: r'requested')
  static const MwProfileAllOfRelationsToMeEnum requested = _$mwProfileAllOfRelationsToMeEnum_requested;
  @BuiltValueEnumConst(wireName: r'ignored')
  static const MwProfileAllOfRelationsToMeEnum ignored = _$mwProfileAllOfRelationsToMeEnum_ignored;
  @BuiltValueEnumConst(wireName: r'hidden')
  static const MwProfileAllOfRelationsToMeEnum hidden = _$mwProfileAllOfRelationsToMeEnum_hidden;
  @BuiltValueEnumConst(wireName: r'none')
  static const MwProfileAllOfRelationsToMeEnum none = _$mwProfileAllOfRelationsToMeEnum_none;

  static Serializer<MwProfileAllOfRelationsToMeEnum> get serializer => _$mwProfileAllOfRelationsToMeEnumSerializer;

  const MwProfileAllOfRelationsToMeEnum._(String name): super(name);

  static BuiltSet<MwProfileAllOfRelationsToMeEnum> get values => _$mwProfileAllOfRelationsToMeEnumValues;
  static MwProfileAllOfRelationsToMeEnum valueOf(String name) => _$mwProfileAllOfRelationsToMeEnumValueOf(name);
}

class MwProfileAllOfRelationsFromMeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'followed')
  static const MwProfileAllOfRelationsFromMeEnum followed = _$mwProfileAllOfRelationsFromMeEnum_followed;
  @BuiltValueEnumConst(wireName: r'requested')
  static const MwProfileAllOfRelationsFromMeEnum requested = _$mwProfileAllOfRelationsFromMeEnum_requested;
  @BuiltValueEnumConst(wireName: r'ignored')
  static const MwProfileAllOfRelationsFromMeEnum ignored = _$mwProfileAllOfRelationsFromMeEnum_ignored;
  @BuiltValueEnumConst(wireName: r'hidden')
  static const MwProfileAllOfRelationsFromMeEnum hidden = _$mwProfileAllOfRelationsFromMeEnum_hidden;
  @BuiltValueEnumConst(wireName: r'none')
  static const MwProfileAllOfRelationsFromMeEnum none = _$mwProfileAllOfRelationsFromMeEnum_none;

  static Serializer<MwProfileAllOfRelationsFromMeEnum> get serializer => _$mwProfileAllOfRelationsFromMeEnumSerializer;

  const MwProfileAllOfRelationsFromMeEnum._(String name): super(name);

  static BuiltSet<MwProfileAllOfRelationsFromMeEnum> get values => _$mwProfileAllOfRelationsFromMeEnumValues;
  static MwProfileAllOfRelationsFromMeEnum valueOf(String name) => _$mwProfileAllOfRelationsFromMeEnumValueOf(name);
}

