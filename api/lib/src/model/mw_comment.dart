//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_rating.dart';
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:mindwell_api/src/model/mw_comment_rights.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_comment.g.dart';

/// MwComment
///
/// Properties:
/// * [id] 
/// * [author] 
/// * [entryId] 
/// * [createdAt] 
/// * [content] 
/// * [editContent] 
/// * [rating] 
/// * [rights] 
@BuiltValue()
abstract class MwComment implements Built<MwComment, MwCommentBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'author')
  MwUser? get author;

  @BuiltValueField(wireName: r'entryId')
  int? get entryId;

  @BuiltValueField(wireName: r'createdAt')
  double? get createdAt;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'editContent')
  String? get editContent;

  @BuiltValueField(wireName: r'rating')
  MwRating? get rating;

  @BuiltValueField(wireName: r'rights')
  MwCommentRights? get rights;

  MwComment._();

  factory MwComment([void updates(MwCommentBuilder b)]) = _$MwComment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwCommentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwComment> get serializer => _$MwCommentSerializer();
}

class _$MwCommentSerializer implements PrimitiveSerializer<MwComment> {
  @override
  final Iterable<Type> types = const [MwComment, _$MwComment];

  @override
  final String wireName = r'MwComment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwComment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.entryId != null) {
      yield r'entryId';
      yield serializers.serialize(
        object.entryId,
        specifiedType: const FullType(int),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
    if (object.editContent != null) {
      yield r'editContent';
      yield serializers.serialize(
        object.editContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(MwRating),
      );
    }
    if (object.rights != null) {
      yield r'rights';
      yield serializers.serialize(
        object.rights,
        specifiedType: const FullType(MwCommentRights),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwComment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwCommentBuilder result,
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
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.author = valueDes;
          break;
        case r'entryId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.entryId = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.createdAt = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'editContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.editContent = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwRating),
          ) as MwRating;
          result.rating.replace(valueDes);
          break;
        case r'rights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwCommentRights),
          ) as MwCommentRights;
          result.rights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwComment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwCommentBuilder();
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

