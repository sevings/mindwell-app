//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_adm_grandson_get200_response.g.dart';

/// MwAdmGrandsonGet200Response
///
/// Properties:
/// * [postcode] 
/// * [country] 
/// * [address] 
/// * [phone] 
/// * [name] 
/// * [comment] 
/// * [anonymous] 
@BuiltValue()
abstract class MwAdmGrandsonGet200Response implements Built<MwAdmGrandsonGet200Response, MwAdmGrandsonGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'postcode')
  String? get postcode;

  @BuiltValueField(wireName: r'country')
  String? get country;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'anonymous')
  bool? get anonymous;

  MwAdmGrandsonGet200Response._();

  factory MwAdmGrandsonGet200Response([void updates(MwAdmGrandsonGet200ResponseBuilder b)]) = _$MwAdmGrandsonGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAdmGrandsonGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAdmGrandsonGet200Response> get serializer => _$MwAdmGrandsonGet200ResponseSerializer();
}

class _$MwAdmGrandsonGet200ResponseSerializer implements PrimitiveSerializer<MwAdmGrandsonGet200Response> {
  @override
  final Iterable<Type> types = const [MwAdmGrandsonGet200Response, _$MwAdmGrandsonGet200Response];

  @override
  final String wireName = r'MwAdmGrandsonGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAdmGrandsonGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.postcode != null) {
      yield r'postcode';
      yield serializers.serialize(
        object.postcode,
        specifiedType: const FullType(String),
      );
    }
    if (object.country != null) {
      yield r'country';
      yield serializers.serialize(
        object.country,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
    if (object.anonymous != null) {
      yield r'anonymous';
      yield serializers.serialize(
        object.anonymous,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAdmGrandsonGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAdmGrandsonGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'postcode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.postcode = valueDes;
          break;
        case r'country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.country = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        case r'anonymous':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.anonymous = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAdmGrandsonGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAdmGrandsonGet200ResponseBuilder();
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

