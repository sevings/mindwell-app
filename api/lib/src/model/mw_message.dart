//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_message_rights.dart';
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_message.g.dart';

/// MwMessage
///
/// Properties:
/// * [id] 
/// * [chatId] 
/// * [author] 
/// * [createdAt] 
/// * [read] 
/// * [content] 
/// * [editContent] 
/// * [rights] 
@BuiltValue()
abstract class MwMessage implements Built<MwMessage, MwMessageBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'chatId')
  int? get chatId;

  @BuiltValueField(wireName: r'author')
  MwUser? get author;

  @BuiltValueField(wireName: r'createdAt')
  double? get createdAt;

  @BuiltValueField(wireName: r'read')
  bool? get read;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'editContent')
  String? get editContent;

  @BuiltValueField(wireName: r'rights')
  MwMessageRights? get rights;

  MwMessage._();

  factory MwMessage([void updates(MwMessageBuilder b)]) = _$MwMessage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwMessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwMessage> get serializer => _$MwMessageSerializer();
}

class _$MwMessageSerializer implements PrimitiveSerializer<MwMessage> {
  @override
  final Iterable<Type> types = const [MwMessage, _$MwMessage];

  @override
  final String wireName = r'MwMessage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.chatId != null) {
      yield r'chatId';
      yield serializers.serialize(
        object.chatId,
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
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.read != null) {
      yield r'read';
      yield serializers.serialize(
        object.read,
        specifiedType: const FullType(bool),
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
    if (object.rights != null) {
      yield r'rights';
      yield serializers.serialize(
        object.rights,
        specifiedType: const FullType(MwMessageRights),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwMessageBuilder result,
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
        case r'chatId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chatId = valueDes;
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.author = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.createdAt = valueDes;
          break;
        case r'read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.read = valueDes;
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
        case r'rights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwMessageRights),
          ) as MwMessageRights;
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
  MwMessage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwMessageBuilder();
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

