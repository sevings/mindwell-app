//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_adm_stat_get200_response.g.dart';

/// MwAdmStatGet200Response
///
/// Properties:
/// * [grandsons] 
/// * [sent] 
/// * [received] 
@BuiltValue()
abstract class MwAdmStatGet200Response implements Built<MwAdmStatGet200Response, MwAdmStatGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'grandsons')
  int? get grandsons;

  @BuiltValueField(wireName: r'sent')
  int? get sent;

  @BuiltValueField(wireName: r'received')
  int? get received;

  MwAdmStatGet200Response._();

  factory MwAdmStatGet200Response([void updates(MwAdmStatGet200ResponseBuilder b)]) = _$MwAdmStatGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAdmStatGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAdmStatGet200Response> get serializer => _$MwAdmStatGet200ResponseSerializer();
}

class _$MwAdmStatGet200ResponseSerializer implements PrimitiveSerializer<MwAdmStatGet200Response> {
  @override
  final Iterable<Type> types = const [MwAdmStatGet200Response, _$MwAdmStatGet200Response];

  @override
  final String wireName = r'MwAdmStatGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAdmStatGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.grandsons != null) {
      yield r'grandsons';
      yield serializers.serialize(
        object.grandsons,
        specifiedType: const FullType(int),
      );
    }
    if (object.sent != null) {
      yield r'sent';
      yield serializers.serialize(
        object.sent,
        specifiedType: const FullType(int),
      );
    }
    if (object.received != null) {
      yield r'received';
      yield serializers.serialize(
        object.received,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAdmStatGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAdmStatGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'grandsons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.grandsons = valueDes;
          break;
        case r'sent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sent = valueDes;
          break;
        case r'received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.received = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAdmStatGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAdmStatGet200ResponseBuilder();
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

