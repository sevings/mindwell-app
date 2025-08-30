//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_me_online_put200_response.g.dart';

/// MwMeOnlinePut200Response
///
/// Properties:
/// * [notifications] 
/// * [chats] 
@BuiltValue()
abstract class MwMeOnlinePut200Response implements Built<MwMeOnlinePut200Response, MwMeOnlinePut200ResponseBuilder> {
  @BuiltValueField(wireName: r'notifications')
  int? get notifications;

  @BuiltValueField(wireName: r'chats')
  int? get chats;

  MwMeOnlinePut200Response._();

  factory MwMeOnlinePut200Response([void updates(MwMeOnlinePut200ResponseBuilder b)]) = _$MwMeOnlinePut200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwMeOnlinePut200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwMeOnlinePut200Response> get serializer => _$MwMeOnlinePut200ResponseSerializer();
}

class _$MwMeOnlinePut200ResponseSerializer implements PrimitiveSerializer<MwMeOnlinePut200Response> {
  @override
  final Iterable<Type> types = const [MwMeOnlinePut200Response, _$MwMeOnlinePut200Response];

  @override
  final String wireName = r'MwMeOnlinePut200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwMeOnlinePut200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.notifications != null) {
      yield r'notifications';
      yield serializers.serialize(
        object.notifications,
        specifiedType: const FullType(int),
      );
    }
    if (object.chats != null) {
      yield r'chats';
      yield serializers.serialize(
        object.chats,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwMeOnlinePut200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwMeOnlinePut200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'notifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.notifications = valueDes;
          break;
        case r'chats':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chats = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwMeOnlinePut200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwMeOnlinePut200ResponseBuilder();
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

