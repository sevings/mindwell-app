//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_o_auth2_error.g.dart';

/// MwOAuth2Error
///
/// Properties:
/// * [error] 
@BuiltValue()
abstract class MwOAuth2Error implements Built<MwOAuth2Error, MwOAuth2ErrorBuilder> {
  @BuiltValueField(wireName: r'error')
  MwOAuth2ErrorErrorEnum? get error;
  // enum errorEnum {  access_denied,  invalid_client,  invalid_grant,  invalid_redirect,  invalid_request,  invalid_scope,  invalid_token,  server_error,  temporarily_unavailable,  unauthorized_client,  unrecognized_client,  unsupported_grant_type,  unsupported_response_type,  };

  MwOAuth2Error._();

  factory MwOAuth2Error([void updates(MwOAuth2ErrorBuilder b)]) = _$MwOAuth2Error;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwOAuth2ErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwOAuth2Error> get serializer => _$MwOAuth2ErrorSerializer();
}

class _$MwOAuth2ErrorSerializer implements PrimitiveSerializer<MwOAuth2Error> {
  @override
  final Iterable<Type> types = const [MwOAuth2Error, _$MwOAuth2Error];

  @override
  final String wireName = r'MwOAuth2Error';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwOAuth2Error object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType(MwOAuth2ErrorErrorEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwOAuth2Error object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwOAuth2ErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwOAuth2ErrorErrorEnum),
          ) as MwOAuth2ErrorErrorEnum;
          result.error = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwOAuth2Error deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwOAuth2ErrorBuilder();
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

class MwOAuth2ErrorErrorEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'access_denied')
  static const MwOAuth2ErrorErrorEnum accessDenied = _$mwOAuth2ErrorErrorEnum_accessDenied;
  @BuiltValueEnumConst(wireName: r'invalid_client')
  static const MwOAuth2ErrorErrorEnum invalidClient = _$mwOAuth2ErrorErrorEnum_invalidClient;
  @BuiltValueEnumConst(wireName: r'invalid_grant')
  static const MwOAuth2ErrorErrorEnum invalidGrant = _$mwOAuth2ErrorErrorEnum_invalidGrant;
  @BuiltValueEnumConst(wireName: r'invalid_redirect')
  static const MwOAuth2ErrorErrorEnum invalidRedirect = _$mwOAuth2ErrorErrorEnum_invalidRedirect;
  @BuiltValueEnumConst(wireName: r'invalid_request')
  static const MwOAuth2ErrorErrorEnum invalidRequest = _$mwOAuth2ErrorErrorEnum_invalidRequest;
  @BuiltValueEnumConst(wireName: r'invalid_scope')
  static const MwOAuth2ErrorErrorEnum invalidScope = _$mwOAuth2ErrorErrorEnum_invalidScope;
  @BuiltValueEnumConst(wireName: r'invalid_token')
  static const MwOAuth2ErrorErrorEnum invalidToken = _$mwOAuth2ErrorErrorEnum_invalidToken;
  @BuiltValueEnumConst(wireName: r'server_error')
  static const MwOAuth2ErrorErrorEnum serverError = _$mwOAuth2ErrorErrorEnum_serverError;
  @BuiltValueEnumConst(wireName: r'temporarily_unavailable')
  static const MwOAuth2ErrorErrorEnum temporarilyUnavailable = _$mwOAuth2ErrorErrorEnum_temporarilyUnavailable;
  @BuiltValueEnumConst(wireName: r'unauthorized_client')
  static const MwOAuth2ErrorErrorEnum unauthorizedClient = _$mwOAuth2ErrorErrorEnum_unauthorizedClient;
  @BuiltValueEnumConst(wireName: r'unrecognized_client')
  static const MwOAuth2ErrorErrorEnum unrecognizedClient = _$mwOAuth2ErrorErrorEnum_unrecognizedClient;
  @BuiltValueEnumConst(wireName: r'unsupported_grant_type')
  static const MwOAuth2ErrorErrorEnum unsupportedGrantType = _$mwOAuth2ErrorErrorEnum_unsupportedGrantType;
  @BuiltValueEnumConst(wireName: r'unsupported_response_type')
  static const MwOAuth2ErrorErrorEnum unsupportedResponseType = _$mwOAuth2ErrorErrorEnum_unsupportedResponseType;

  static Serializer<MwOAuth2ErrorErrorEnum> get serializer => _$mwOAuth2ErrorErrorEnumSerializer;

  const MwOAuth2ErrorErrorEnum._(String name): super(name);

  static BuiltSet<MwOAuth2ErrorErrorEnum> get values => _$mwOAuth2ErrorErrorEnumValues;
  static MwOAuth2ErrorErrorEnum valueOf(String name) => _$mwOAuth2ErrorErrorEnumValueOf(name);
}

