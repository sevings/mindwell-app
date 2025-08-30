//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:mindwell/src/model/mw_tag_list_data_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_tag_list.g.dart';

/// MwTagList
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class MwTagList implements Built<MwTagList, MwTagListBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<MwTagListDataInner>? get data;

  MwTagList._();

  factory MwTagList([void updates(MwTagListBuilder b)]) = _$MwTagList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwTagListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwTagList> get serializer => _$MwTagListSerializer();
}

class _$MwTagListSerializer implements PrimitiveSerializer<MwTagList> {
  @override
  final Iterable<Type> types = const [MwTagList, _$MwTagList];

  @override
  final String wireName = r'MwTagList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwTagList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(MwTagListDataInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwTagList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwTagListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwTagListDataInner)]),
          ) as BuiltList<MwTagListDataInner>;
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
  MwTagList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwTagListBuilder();
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

