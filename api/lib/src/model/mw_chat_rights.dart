//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_chat_rights.g.dart';

/// MwChatRights
///
/// Properties:
/// * [send] 
@BuiltValue()
abstract class MwChatRights implements Built<MwChatRights, MwChatRightsBuilder> {
  @BuiltValueField(wireName: r'send')
  bool? get send;

  MwChatRights._();

  factory MwChatRights([void updates(MwChatRightsBuilder b)]) = _$MwChatRights;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwChatRightsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwChatRights> get serializer => _$MwChatRightsSerializer();
}

class _$MwChatRightsSerializer implements PrimitiveSerializer<MwChatRights> {
  @override
  final Iterable<Type> types = const [MwChatRights, _$MwChatRights];

  @override
  final String wireName = r'MwChatRights';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwChatRights object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.send != null) {
      yield r'send';
      yield serializers.serialize(
        object.send,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwChatRights object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwChatRightsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'send':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.send = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwChatRights deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwChatRightsBuilder();
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

