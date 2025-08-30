//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_watching_status.g.dart';

/// MwWatchingStatus
///
/// Properties:
/// * [id] 
/// * [isWatching] 
@BuiltValue()
abstract class MwWatchingStatus implements Built<MwWatchingStatus, MwWatchingStatusBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'isWatching')
  bool? get isWatching;

  MwWatchingStatus._();

  factory MwWatchingStatus([void updates(MwWatchingStatusBuilder b)]) = _$MwWatchingStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwWatchingStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwWatchingStatus> get serializer => _$MwWatchingStatusSerializer();
}

class _$MwWatchingStatusSerializer implements PrimitiveSerializer<MwWatchingStatus> {
  @override
  final Iterable<Type> types = const [MwWatchingStatus, _$MwWatchingStatus];

  @override
  final String wireName = r'MwWatchingStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwWatchingStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.isWatching != null) {
      yield r'isWatching';
      yield serializers.serialize(
        object.isWatching,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwWatchingStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwWatchingStatusBuilder result,
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
        case r'isWatching':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isWatching = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwWatchingStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwWatchingStatusBuilder();
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

