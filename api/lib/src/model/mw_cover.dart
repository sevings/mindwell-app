//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_cover.g.dart';

/// MwCover
///
/// Properties:
/// * [id] - user id
/// * [x1920] 
/// * [x318] 
@BuiltValue()
abstract class MwCover implements Built<MwCover, MwCoverBuilder> {
  /// user id
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'x1920')
  String? get x1920;

  @BuiltValueField(wireName: r'x318')
  String? get x318;

  MwCover._();

  factory MwCover([void updates(MwCoverBuilder b)]) = _$MwCover;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwCoverBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwCover> get serializer => _$MwCoverSerializer();
}

class _$MwCoverSerializer implements PrimitiveSerializer<MwCover> {
  @override
  final Iterable<Type> types = const [MwCover, _$MwCover];

  @override
  final String wireName = r'MwCover';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwCover object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.x1920 != null) {
      yield r'x1920';
      yield serializers.serialize(
        object.x1920,
        specifiedType: const FullType(String),
      );
    }
    if (object.x318 != null) {
      yield r'x318';
      yield serializers.serialize(
        object.x318,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwCover object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwCoverBuilder result,
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
        case r'x1920':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.x1920 = valueDes;
          break;
        case r'x318':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.x318 = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwCover deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwCoverBuilder();
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

