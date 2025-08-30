//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_design_fonts_get200_response.g.dart';

/// MwDesignFontsGet200Response
///
/// Properties:
/// * [fonts] 
@BuiltValue()
abstract class MwDesignFontsGet200Response implements Built<MwDesignFontsGet200Response, MwDesignFontsGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'fonts')
  BuiltList<String>? get fonts;

  MwDesignFontsGet200Response._();

  factory MwDesignFontsGet200Response([void updates(MwDesignFontsGet200ResponseBuilder b)]) = _$MwDesignFontsGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwDesignFontsGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwDesignFontsGet200Response> get serializer => _$MwDesignFontsGet200ResponseSerializer();
}

class _$MwDesignFontsGet200ResponseSerializer implements PrimitiveSerializer<MwDesignFontsGet200Response> {
  @override
  final Iterable<Type> types = const [MwDesignFontsGet200Response, _$MwDesignFontsGet200Response];

  @override
  final String wireName = r'MwDesignFontsGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwDesignFontsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.fonts != null) {
      yield r'fonts';
      yield serializers.serialize(
        object.fonts,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwDesignFontsGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwDesignFontsGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fonts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.fonts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwDesignFontsGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwDesignFontsGet200ResponseBuilder();
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

