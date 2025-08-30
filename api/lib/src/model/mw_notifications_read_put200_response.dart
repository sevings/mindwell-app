//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_notifications_read_put200_response.g.dart';

/// MwNotificationsReadPut200Response
///
/// Properties:
/// * [unread] 
@BuiltValue()
abstract class MwNotificationsReadPut200Response implements Built<MwNotificationsReadPut200Response, MwNotificationsReadPut200ResponseBuilder> {
  @BuiltValueField(wireName: r'unread')
  int? get unread;

  MwNotificationsReadPut200Response._();

  factory MwNotificationsReadPut200Response([void updates(MwNotificationsReadPut200ResponseBuilder b)]) = _$MwNotificationsReadPut200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwNotificationsReadPut200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwNotificationsReadPut200Response> get serializer => _$MwNotificationsReadPut200ResponseSerializer();
}

class _$MwNotificationsReadPut200ResponseSerializer implements PrimitiveSerializer<MwNotificationsReadPut200Response> {
  @override
  final Iterable<Type> types = const [MwNotificationsReadPut200Response, _$MwNotificationsReadPut200Response];

  @override
  final String wireName = r'MwNotificationsReadPut200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwNotificationsReadPut200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.unread != null) {
      yield r'unread';
      yield serializers.serialize(
        object.unread,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwNotificationsReadPut200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwNotificationsReadPut200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'unread':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unread = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwNotificationsReadPut200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwNotificationsReadPut200ResponseBuilder();
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

