//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/src/model/mw_badge.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_badge_list.g.dart';

/// MwBadgeList
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class MwBadgeList implements Built<MwBadgeList, MwBadgeListBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<MwBadge>? get data;

  MwBadgeList._();

  factory MwBadgeList([void updates(MwBadgeListBuilder b)]) = _$MwBadgeList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwBadgeListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwBadgeList> get serializer => _$MwBadgeListSerializer();
}

class _$MwBadgeListSerializer implements PrimitiveSerializer<MwBadgeList> {
  @override
  final Iterable<Type> types = const [MwBadgeList, _$MwBadgeList];

  @override
  final String wireName = r'MwBadgeList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwBadgeList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(MwBadge)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwBadgeList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwBadgeListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwBadge)]),
          ) as BuiltList<MwBadge>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwBadgeList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwBadgeListBuilder();
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

