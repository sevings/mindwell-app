//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:mindwell_api/src/model/mw_chat_rights.dart';
import 'package:mindwell_api/src/model/mw_message.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_chat.g.dart';

/// MwChat
///
/// Properties:
/// * [id] 
/// * [partner] 
/// * [lastMessage] 
/// * [unreadCount] 
/// * [rights] 
@BuiltValue()
abstract class MwChat implements Built<MwChat, MwChatBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'partner')
  MwUser? get partner;

  @BuiltValueField(wireName: r'lastMessage')
  MwMessage? get lastMessage;

  @BuiltValueField(wireName: r'unreadCount')
  int? get unreadCount;

  @BuiltValueField(wireName: r'rights')
  MwChatRights? get rights;

  MwChat._();

  factory MwChat([void updates(MwChatBuilder b)]) = _$MwChat;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwChatBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwChat> get serializer => _$MwChatSerializer();
}

class _$MwChatSerializer implements PrimitiveSerializer<MwChat> {
  @override
  final Iterable<Type> types = const [MwChat, _$MwChat];

  @override
  final String wireName = r'MwChat';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwChat object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.partner != null) {
      yield r'partner';
      yield serializers.serialize(
        object.partner,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.lastMessage != null) {
      yield r'lastMessage';
      yield serializers.serialize(
        object.lastMessage,
        specifiedType: const FullType(MwMessage),
      );
    }
    if (object.unreadCount != null) {
      yield r'unreadCount';
      yield serializers.serialize(
        object.unreadCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.rights != null) {
      yield r'rights';
      yield serializers.serialize(
        object.rights,
        specifiedType: const FullType(MwChatRights),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwChat object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwChatBuilder result,
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
        case r'partner':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.partner = valueDes;
          break;
        case r'lastMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwMessage),
          ) as MwMessage;
          result.lastMessage.replace(valueDes);
          break;
        case r'unreadCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        case r'rights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwChatRights),
          ) as MwChatRights;
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
  MwChat deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwChatBuilder();
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

