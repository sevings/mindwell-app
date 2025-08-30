//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_adm_grandfather_get200_response.g.dart';

/// MwAdmGrandfatherGet200Response
///
/// Properties:
/// * [postcode] 
/// * [country] 
/// * [address] 
/// * [phone] 
/// * [fullname] 
/// * [comment] 
/// * [name] 
@BuiltValue()
abstract class MwAdmGrandfatherGet200Response implements Built<MwAdmGrandfatherGet200Response, MwAdmGrandfatherGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'postcode')
  String? get postcode;

  @BuiltValueField(wireName: r'country')
  String? get country;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'fullname')
  String? get fullname;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'name')
  String? get name;

  MwAdmGrandfatherGet200Response._();

  factory MwAdmGrandfatherGet200Response([void updates(MwAdmGrandfatherGet200ResponseBuilder b)]) = _$MwAdmGrandfatherGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAdmGrandfatherGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAdmGrandfatherGet200Response> get serializer => _$MwAdmGrandfatherGet200ResponseSerializer();
}

class _$MwAdmGrandfatherGet200ResponseSerializer implements PrimitiveSerializer<MwAdmGrandfatherGet200Response> {
  @override
  final Iterable<Type> types = const [MwAdmGrandfatherGet200Response, _$MwAdmGrandfatherGet200Response];

  @override
  final String wireName = r'MwAdmGrandfatherGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAdmGrandfatherGet200Response object, {
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
    if (object.fullname != null) {
      yield r'fullname';
      yield serializers.serialize(
        object.fullname,
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
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAdmGrandfatherGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAdmGrandfatherGet200ResponseBuilder result,
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
        case r'fullname':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullname = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAdmGrandfatherGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAdmGrandfatherGet200ResponseBuilder();
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

