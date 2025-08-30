//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_favorite_status.g.dart';

/// MwFavoriteStatus
///
/// Properties:
/// * [id] 
/// * [isFavorited] 
/// * [count] 
@BuiltValue()
abstract class MwFavoriteStatus implements Built<MwFavoriteStatus, MwFavoriteStatusBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'isFavorited')
  bool? get isFavorited;

  @BuiltValueField(wireName: r'count')
  int? get count;

  MwFavoriteStatus._();

  factory MwFavoriteStatus([void updates(MwFavoriteStatusBuilder b)]) = _$MwFavoriteStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwFavoriteStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwFavoriteStatus> get serializer => _$MwFavoriteStatusSerializer();
}

class _$MwFavoriteStatusSerializer implements PrimitiveSerializer<MwFavoriteStatus> {
  @override
  final Iterable<Type> types = const [MwFavoriteStatus, _$MwFavoriteStatus];

  @override
  final String wireName = r'MwFavoriteStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwFavoriteStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.isFavorited != null) {
      yield r'isFavorited';
      yield serializers.serialize(
        object.isFavorited,
        specifiedType: const FullType(bool),
      );
    }
    if (object.count != null) {
      yield r'count';
      yield serializers.serialize(
        object.count,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwFavoriteStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwFavoriteStatusBuilder result,
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
        case r'isFavorited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFavorited = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwFavoriteStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwFavoriteStatusBuilder();
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

