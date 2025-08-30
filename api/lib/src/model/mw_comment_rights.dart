//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_comment_rights.g.dart';

/// MwCommentRights
///
/// Properties:
/// * [edit] 
/// * [delete] 
/// * [vote] 
/// * [complain] 
@BuiltValue()
abstract class MwCommentRights implements Built<MwCommentRights, MwCommentRightsBuilder> {
  @BuiltValueField(wireName: r'edit')
  bool? get edit;

  @BuiltValueField(wireName: r'delete')
  bool? get delete;

  @BuiltValueField(wireName: r'vote')
  bool? get vote;

  @BuiltValueField(wireName: r'complain')
  bool? get complain;

  MwCommentRights._();

  factory MwCommentRights([void updates(MwCommentRightsBuilder b)]) = _$MwCommentRights;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwCommentRightsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwCommentRights> get serializer => _$MwCommentRightsSerializer();
}

class _$MwCommentRightsSerializer implements PrimitiveSerializer<MwCommentRights> {
  @override
  final Iterable<Type> types = const [MwCommentRights, _$MwCommentRights];

  @override
  final String wireName = r'MwCommentRights';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwCommentRights object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.edit != null) {
      yield r'edit';
      yield serializers.serialize(
        object.edit,
        specifiedType: const FullType(bool),
      );
    }
    if (object.delete != null) {
      yield r'delete';
      yield serializers.serialize(
        object.delete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.vote != null) {
      yield r'vote';
      yield serializers.serialize(
        object.vote,
        specifiedType: const FullType(bool),
      );
    }
    if (object.complain != null) {
      yield r'complain';
      yield serializers.serialize(
        object.complain,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwCommentRights object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwCommentRightsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'edit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.edit = valueDes;
          break;
        case r'delete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.delete = valueDes;
          break;
        case r'vote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.vote = valueDes;
          break;
        case r'complain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.complain = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwCommentRights deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwCommentRightsBuilder();
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

