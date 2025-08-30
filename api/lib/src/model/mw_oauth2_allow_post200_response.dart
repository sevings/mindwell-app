//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_oauth2_allow_post200_response.g.dart';

/// MwOauth2AllowPost200Response
///
/// Properties:
/// * [code] 
/// * [state] 
@BuiltValue()
abstract class MwOauth2AllowPost200Response implements Built<MwOauth2AllowPost200Response, MwOauth2AllowPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'state')
  String? get state;

  MwOauth2AllowPost200Response._();

  factory MwOauth2AllowPost200Response([void updates(MwOauth2AllowPost200ResponseBuilder b)]) = _$MwOauth2AllowPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwOauth2AllowPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwOauth2AllowPost200Response> get serializer => _$MwOauth2AllowPost200ResponseSerializer();
}

class _$MwOauth2AllowPost200ResponseSerializer implements PrimitiveSerializer<MwOauth2AllowPost200Response> {
  @override
  final Iterable<Type> types = const [MwOauth2AllowPost200Response, _$MwOauth2AllowPost200Response];

  @override
  final String wireName = r'MwOauth2AllowPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwOauth2AllowPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwOauth2AllowPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwOauth2AllowPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwOauth2AllowPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwOauth2AllowPost200ResponseBuilder();
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

