//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_account_name_name_get200_response.g.dart';

/// MwAccountNameNameGet200Response
///
/// Properties:
/// * [name] 
/// * [isFree] 
@BuiltValue()
abstract class MwAccountNameNameGet200Response implements Built<MwAccountNameNameGet200Response, MwAccountNameNameGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'isFree')
  bool? get isFree;

  MwAccountNameNameGet200Response._();

  factory MwAccountNameNameGet200Response([void updates(MwAccountNameNameGet200ResponseBuilder b)]) = _$MwAccountNameNameGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAccountNameNameGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAccountNameNameGet200Response> get serializer => _$MwAccountNameNameGet200ResponseSerializer();
}

class _$MwAccountNameNameGet200ResponseSerializer implements PrimitiveSerializer<MwAccountNameNameGet200Response> {
  @override
  final Iterable<Type> types = const [MwAccountNameNameGet200Response, _$MwAccountNameNameGet200Response];

  @override
  final String wireName = r'MwAccountNameNameGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAccountNameNameGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    MwAccountNameNameGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAccountNameNameGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
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
  MwAccountNameNameGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAccountNameNameGet200ResponseBuilder();
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

