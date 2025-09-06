//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_pin_status.g.dart';

/// MwPinStatus
///
/// Properties:
/// * [id] 
/// * [isPinned] 
@BuiltValue()
abstract class MwPinStatus implements Built<MwPinStatus, MwPinStatusBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'isPinned')
  bool? get isPinned;

  MwPinStatus._();

  factory MwPinStatus([void updates(MwPinStatusBuilder b)]) = _$MwPinStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwPinStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwPinStatus> get serializer => _$MwPinStatusSerializer();
}

class _$MwPinStatusSerializer implements PrimitiveSerializer<MwPinStatus> {
  @override
  final Iterable<Type> types = const [MwPinStatus, _$MwPinStatus];

  @override
  final String wireName = r'MwPinStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwPinStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.isPinned != null) {
      yield r'isPinned';
      yield serializers.serialize(
        object.isPinned,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwPinStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwPinStatusBuilder result,
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
        case r'isPinned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPinned = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwPinStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwPinStatusBuilder();
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

