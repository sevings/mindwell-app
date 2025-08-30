//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_account_settings_onsite_get200_response.g.dart';

/// MwAccountSettingsOnsiteGet200Response
///
/// Properties:
/// * [wishes] 
@BuiltValue()
abstract class MwAccountSettingsOnsiteGet200Response implements Built<MwAccountSettingsOnsiteGet200Response, MwAccountSettingsOnsiteGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'wishes')
  bool? get wishes;

  MwAccountSettingsOnsiteGet200Response._();

  factory MwAccountSettingsOnsiteGet200Response([void updates(MwAccountSettingsOnsiteGet200ResponseBuilder b)]) = _$MwAccountSettingsOnsiteGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAccountSettingsOnsiteGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAccountSettingsOnsiteGet200Response> get serializer => _$MwAccountSettingsOnsiteGet200ResponseSerializer();
}

class _$MwAccountSettingsOnsiteGet200ResponseSerializer implements PrimitiveSerializer<MwAccountSettingsOnsiteGet200Response> {
  @override
  final Iterable<Type> types = const [MwAccountSettingsOnsiteGet200Response, _$MwAccountSettingsOnsiteGet200Response];

  @override
  final String wireName = r'MwAccountSettingsOnsiteGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAccountSettingsOnsiteGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.wishes != null) {
      yield r'wishes';
      yield serializers.serialize(
        object.wishes,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAccountSettingsOnsiteGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAccountSettingsOnsiteGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'wishes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.wishes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAccountSettingsOnsiteGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAccountSettingsOnsiteGet200ResponseBuilder();
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

