//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_rating.g.dart';

/// MwRating
///
/// Properties:
/// * [id] 
/// * [isVotable] 
/// * [upCount] 
/// * [downCount] 
/// * [rating] 
/// * [vote] 
@BuiltValue()
abstract class MwRating implements Built<MwRating, MwRatingBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'isVotable')
  bool? get isVotable;

  @BuiltValueField(wireName: r'upCount')
  int? get upCount;

  @BuiltValueField(wireName: r'downCount')
  int? get downCount;

  @BuiltValueField(wireName: r'rating')
  double? get rating;

  @BuiltValueField(wireName: r'vote')
  int? get vote;

  MwRating._();

  factory MwRating([void updates(MwRatingBuilder b)]) = _$MwRating;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwRatingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwRating> get serializer => _$MwRatingSerializer();
}

class _$MwRatingSerializer implements PrimitiveSerializer<MwRating> {
  @override
  final Iterable<Type> types = const [MwRating, _$MwRating];

  @override
  final String wireName = r'MwRating';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwRating object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.isVotable != null) {
      yield r'isVotable';
      yield serializers.serialize(
        object.isVotable,
        specifiedType: const FullType(bool),
      );
    }
    if (object.upCount != null) {
      yield r'upCount';
      yield serializers.serialize(
        object.upCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.downCount != null) {
      yield r'downCount';
      yield serializers.serialize(
        object.downCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(double),
      );
    }
    if (object.vote != null) {
      yield r'vote';
      yield serializers.serialize(
        object.vote,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwRating object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwRatingBuilder result,
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
        case r'isVotable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isVotable = valueDes;
          break;
        case r'upCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.upCount = valueDes;
          break;
        case r'downCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.downCount = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.rating = valueDes;
          break;
        case r'vote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.vote = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwRating deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwRatingBuilder();
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

