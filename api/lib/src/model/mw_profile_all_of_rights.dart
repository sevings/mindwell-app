//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_profile_all_of_rights.g.dart';

/// MwProfileAllOfRights
///
/// Properties:
/// * [chat] 
/// * [ignore] 
/// * [complain] 
@BuiltValue()
abstract class MwProfileAllOfRights implements Built<MwProfileAllOfRights, MwProfileAllOfRightsBuilder> {
  @BuiltValueField(wireName: r'chat')
  bool? get chat;

  @BuiltValueField(wireName: r'ignore')
  bool? get ignore;

  @BuiltValueField(wireName: r'complain')
  bool? get complain;

  MwProfileAllOfRights._();

  factory MwProfileAllOfRights([void updates(MwProfileAllOfRightsBuilder b)]) = _$MwProfileAllOfRights;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwProfileAllOfRightsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwProfileAllOfRights> get serializer => _$MwProfileAllOfRightsSerializer();
}

class _$MwProfileAllOfRightsSerializer implements PrimitiveSerializer<MwProfileAllOfRights> {
  @override
  final Iterable<Type> types = const [MwProfileAllOfRights, _$MwProfileAllOfRights];

  @override
  final String wireName = r'MwProfileAllOfRights';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwProfileAllOfRights object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.chat != null) {
      yield r'chat';
      yield serializers.serialize(
        object.chat,
        specifiedType: const FullType(bool),
      );
    }
    if (object.ignore != null) {
      yield r'ignore';
      yield serializers.serialize(
        object.ignore,
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
    MwProfileAllOfRights object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwProfileAllOfRightsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.chat = valueDes;
          break;
        case r'ignore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.ignore = valueDes;
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
  MwProfileAllOfRights deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwProfileAllOfRightsBuilder();
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

