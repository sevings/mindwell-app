//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_message_rights.g.dart';

/// MwMessageRights
///
/// Properties:
/// * [edit] 
/// * [delete] 
/// * [complain] 
@BuiltValue()
abstract class MwMessageRights implements Built<MwMessageRights, MwMessageRightsBuilder> {
  @BuiltValueField(wireName: r'edit')
  bool? get edit;

  @BuiltValueField(wireName: r'delete')
  bool? get delete;

  @BuiltValueField(wireName: r'complain')
  bool? get complain;

  MwMessageRights._();

  factory MwMessageRights([void updates(MwMessageRightsBuilder b)]) = _$MwMessageRights;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwMessageRightsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwMessageRights> get serializer => _$MwMessageRightsSerializer();
}

class _$MwMessageRightsSerializer implements PrimitiveSerializer<MwMessageRights> {
  @override
  final Iterable<Type> types = const [MwMessageRights, _$MwMessageRights];

  @override
  final String wireName = r'MwMessageRights';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwMessageRights object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.edit != null) {
      yield r'edit';
      yield serializers.serialize(
        object.edit,
        specifiedType: const FullType(bool),
      );
    }
    if (object.delete != null) {
      yield r'delete';
      yield serializers.serialize(
        object.delete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.complain != null) {
      yield r'complain';
      yield serializers.serialize(
        object.complain,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwMessageRights object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwMessageRightsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'edit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.edit = valueDes;
          break;
        case r'delete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.delete = valueDes;
          break;
        case r'complain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.complain = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwMessageRights deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwMessageRightsBuilder();
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

