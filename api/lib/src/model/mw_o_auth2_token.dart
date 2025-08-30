//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_o_auth2_token.g.dart';

/// MwOAuth2Token
///
/// Properties:
/// * [accessToken] 
/// * [tokenType] 
/// * [expiresIn] 
/// * [refreshToken] 
/// * [scope] 
@BuiltValue()
abstract class MwOAuth2Token implements Built<MwOAuth2Token, MwOAuth2TokenBuilder> {
  @BuiltValueField(wireName: r'access_token')
  String? get accessToken;

  @BuiltValueField(wireName: r'token_type')
  MwOAuth2TokenTokenTypeEnum? get tokenType;
  // enum tokenTypeEnum {  bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  int? get expiresIn;

  @BuiltValueField(wireName: r'refresh_token')
  String? get refreshToken;

  @BuiltValueField(wireName: r'scope')
  BuiltList<String>? get scope;

  MwOAuth2Token._();

  factory MwOAuth2Token([void updates(MwOAuth2TokenBuilder b)]) = _$MwOAuth2Token;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwOAuth2TokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwOAuth2Token> get serializer => _$MwOAuth2TokenSerializer();
}

class _$MwOAuth2TokenSerializer implements PrimitiveSerializer<MwOAuth2Token> {
  @override
  final Iterable<Type> types = const [MwOAuth2Token, _$MwOAuth2Token];

  @override
  final String wireName = r'MwOAuth2Token';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwOAuth2Token object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accessToken != null) {
      yield r'access_token';
      yield serializers.serialize(
        object.accessToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.tokenType != null) {
      yield r'token_type';
      yield serializers.serialize(
        object.tokenType,
        specifiedType: const FullType(MwOAuth2TokenTokenTypeEnum),
      );
    }
    if (object.expiresIn != null) {
      yield r'expires_in';
      yield serializers.serialize(
        object.expiresIn,
        specifiedType: const FullType(int),
      );
    }
    if (object.refreshToken != null) {
      yield r'refresh_token';
      yield serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.scope != null) {
      yield r'scope';
      yield serializers.serialize(
        object.scope,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwOAuth2Token object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwOAuth2TokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwOAuth2TokenTokenTypeEnum),
          ) as MwOAuth2TokenTokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiresIn = valueDes;
          break;
        case r'refresh_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.scope.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwOAuth2Token deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwOAuth2TokenBuilder();
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

class MwOAuth2TokenTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bearer')
  static const MwOAuth2TokenTokenTypeEnum bearer = _$mwOAuth2TokenTokenTypeEnum_bearer;

  static Serializer<MwOAuth2TokenTokenTypeEnum> get serializer => _$mwOAuth2TokenTokenTypeEnumSerializer;

  const MwOAuth2TokenTokenTypeEnum._(String name): super(name);

  static BuiltSet<MwOAuth2TokenTokenTypeEnum> get values => _$mwOAuth2TokenTokenTypeEnumValues;
  static MwOAuth2TokenTokenTypeEnum valueOf(String name) => _$mwOAuth2TokenTokenTypeEnumValueOf(name);
}

