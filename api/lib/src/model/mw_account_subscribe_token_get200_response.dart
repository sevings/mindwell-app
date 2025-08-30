//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_account_subscribe_token_get200_response.g.dart';

/// MwAccountSubscribeTokenGet200Response
///
/// Properties:
/// * [token] 
@BuiltValue()
abstract class MwAccountSubscribeTokenGet200Response implements Built<MwAccountSubscribeTokenGet200Response, MwAccountSubscribeTokenGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'token')
  String? get token;

  MwAccountSubscribeTokenGet200Response._();

  factory MwAccountSubscribeTokenGet200Response([void updates(MwAccountSubscribeTokenGet200ResponseBuilder b)]) = _$MwAccountSubscribeTokenGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAccountSubscribeTokenGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAccountSubscribeTokenGet200Response> get serializer => _$MwAccountSubscribeTokenGet200ResponseSerializer();
}

class _$MwAccountSubscribeTokenGet200ResponseSerializer implements PrimitiveSerializer<MwAccountSubscribeTokenGet200Response> {
  @override
  final Iterable<Type> types = const [MwAccountSubscribeTokenGet200Response, _$MwAccountSubscribeTokenGet200Response];

  @override
  final String wireName = r'MwAccountSubscribeTokenGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAccountSubscribeTokenGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAccountSubscribeTokenGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAccountSubscribeTokenGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAccountSubscribeTokenGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAccountSubscribeTokenGet200ResponseBuilder();
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

