//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_account_email_email_get200_response.g.dart';

/// MwAccountEmailEmailGet200Response
///
/// Properties:
/// * [email] 
/// * [isFree] 
@BuiltValue()
abstract class MwAccountEmailEmailGet200Response implements Built<MwAccountEmailEmailGet200Response, MwAccountEmailEmailGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'isFree')
  bool? get isFree;

  MwAccountEmailEmailGet200Response._();

  factory MwAccountEmailEmailGet200Response([void updates(MwAccountEmailEmailGet200ResponseBuilder b)]) = _$MwAccountEmailEmailGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAccountEmailEmailGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAccountEmailEmailGet200Response> get serializer => _$MwAccountEmailEmailGet200ResponseSerializer();
}

class _$MwAccountEmailEmailGet200ResponseSerializer implements PrimitiveSerializer<MwAccountEmailEmailGet200Response> {
  @override
  final Iterable<Type> types = const [MwAccountEmailEmailGet200Response, _$MwAccountEmailEmailGet200Response];

  @override
  final String wireName = r'MwAccountEmailEmailGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAccountEmailEmailGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.isFree != null) {
      yield r'isFree';
      yield serializers.serialize(
        object.isFree,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAccountEmailEmailGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAccountEmailEmailGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'isFree':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFree = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAccountEmailEmailGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAccountEmailEmailGet200ResponseBuilder();
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

