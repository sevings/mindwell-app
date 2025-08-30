//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_avatar.g.dart';

/// MwAvatar
///
/// Properties:
/// * [x124] 
/// * [x92] 
/// * [x42] 
@BuiltValue()
abstract class MwAvatar implements Built<MwAvatar, MwAvatarBuilder> {
  @BuiltValueField(wireName: r'x124')
  String? get x124;

  @BuiltValueField(wireName: r'x92')
  String? get x92;

  @BuiltValueField(wireName: r'x42')
  String? get x42;

  MwAvatar._();

  factory MwAvatar([void updates(MwAvatarBuilder b)]) = _$MwAvatar;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAvatarBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAvatar> get serializer => _$MwAvatarSerializer();
}

class _$MwAvatarSerializer implements PrimitiveSerializer<MwAvatar> {
  @override
  final Iterable<Type> types = const [MwAvatar, _$MwAvatar];

  @override
  final String wireName = r'MwAvatar';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAvatar object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.x124 != null) {
      yield r'x124';
      yield serializers.serialize(
        object.x124,
        specifiedType: const FullType(String),
      );
    }
    if (object.x92 != null) {
      yield r'x92';
      yield serializers.serialize(
        object.x92,
        specifiedType: const FullType(String),
      );
    }
    if (object.x42 != null) {
      yield r'x42';
      yield serializers.serialize(
        object.x42,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAvatar object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAvatarBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'x124':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.x124 = valueDes;
          break;
        case r'x92':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.x92 = valueDes;
          break;
        case r'x42':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.x42 = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAvatar deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAvatarBuilder();
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

