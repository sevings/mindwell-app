//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_tag_list_data_inner.g.dart';

/// MwTagListDataInner
///
/// Properties:
/// * [tag] 
/// * [count] 
@BuiltValue()
abstract class MwTagListDataInner implements Built<MwTagListDataInner, MwTagListDataInnerBuilder> {
  @BuiltValueField(wireName: r'tag')
  String? get tag;

  @BuiltValueField(wireName: r'count')
  int? get count;

  MwTagListDataInner._();

  factory MwTagListDataInner([void updates(MwTagListDataInnerBuilder b)]) = _$MwTagListDataInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwTagListDataInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwTagListDataInner> get serializer => _$MwTagListDataInnerSerializer();
}

class _$MwTagListDataInnerSerializer implements PrimitiveSerializer<MwTagListDataInner> {
  @override
  final Iterable<Type> types = const [MwTagListDataInner, _$MwTagListDataInner];

  @override
  final String wireName = r'MwTagListDataInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwTagListDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tag != null) {
      yield r'tag';
      yield serializers.serialize(
        object.tag,
        specifiedType: const FullType(String),
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
    MwTagListDataInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwTagListDataInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tag':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tag = valueDes;
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
  MwTagListDataInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwTagListDataInnerBuilder();
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

