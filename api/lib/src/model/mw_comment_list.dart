//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:mindwell/src/model/mw_comment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_comment_list.g.dart';

/// MwCommentList
///
/// Properties:
/// * [data] 
/// * [nextAfter] 
/// * [hasAfter] 
/// * [nextBefore] 
/// * [hasBefore] 
@BuiltValue()
abstract class MwCommentList implements Built<MwCommentList, MwCommentListBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<MwComment>? get data;

  @BuiltValueField(wireName: r'nextAfter')
  String? get nextAfter;

  @BuiltValueField(wireName: r'hasAfter')
  bool? get hasAfter;

  @BuiltValueField(wireName: r'nextBefore')
  String? get nextBefore;

  @BuiltValueField(wireName: r'hasBefore')
  bool? get hasBefore;

  MwCommentList._();

  factory MwCommentList([void updates(MwCommentListBuilder b)]) = _$MwCommentList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwCommentListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwCommentList> get serializer => _$MwCommentListSerializer();
}

class _$MwCommentListSerializer implements PrimitiveSerializer<MwCommentList> {
  @override
  final Iterable<Type> types = const [MwCommentList, _$MwCommentList];

  @override
  final String wireName = r'MwCommentList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwCommentList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(MwComment)]),
      );
    }
    if (object.nextAfter != null) {
      yield r'nextAfter';
      yield serializers.serialize(
        object.nextAfter,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasAfter != null) {
      yield r'hasAfter';
      yield serializers.serialize(
        object.hasAfter,
        specifiedType: const FullType(bool),
      );
    }
    if (object.nextBefore != null) {
      yield r'nextBefore';
      yield serializers.serialize(
        object.nextBefore,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasBefore != null) {
      yield r'hasBefore';
      yield serializers.serialize(
        object.hasBefore,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwCommentList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwCommentListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwComment)]),
          ) as BuiltList<MwComment>;
          result.data.replace(valueDes);
          break;
        case r'nextAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextAfter = valueDes;
          break;
        case r'hasAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAfter = valueDes;
          break;
        case r'nextBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextBefore = valueDes;
          break;
        case r'hasBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasBefore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwCommentList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwCommentListBuilder();
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

