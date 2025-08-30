//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_adm_grandson_status_get200_response.g.dart';

/// MwAdmGrandsonStatusGet200Response
///
/// Properties:
/// * [sent] 
/// * [received] 
/// * [tracking] 
/// * [comment] 
@BuiltValue()
abstract class MwAdmGrandsonStatusGet200Response implements Built<MwAdmGrandsonStatusGet200Response, MwAdmGrandsonStatusGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'sent')
  bool? get sent;

  @BuiltValueField(wireName: r'received')
  bool? get received;

  @BuiltValueField(wireName: r'tracking')
  String? get tracking;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  MwAdmGrandsonStatusGet200Response._();

  factory MwAdmGrandsonStatusGet200Response([void updates(MwAdmGrandsonStatusGet200ResponseBuilder b)]) = _$MwAdmGrandsonStatusGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAdmGrandsonStatusGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAdmGrandsonStatusGet200Response> get serializer => _$MwAdmGrandsonStatusGet200ResponseSerializer();
}

class _$MwAdmGrandsonStatusGet200ResponseSerializer implements PrimitiveSerializer<MwAdmGrandsonStatusGet200Response> {
  @override
  final Iterable<Type> types = const [MwAdmGrandsonStatusGet200Response, _$MwAdmGrandsonStatusGet200Response];

  @override
  final String wireName = r'MwAdmGrandsonStatusGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAdmGrandsonStatusGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sent != null) {
      yield r'sent';
      yield serializers.serialize(
        object.sent,
        specifiedType: const FullType(bool),
      );
    }
    if (object.received != null) {
      yield r'received';
      yield serializers.serialize(
        object.received,
        specifiedType: const FullType(bool),
      );
    }
    if (object.tracking != null) {
      yield r'tracking';
      yield serializers.serialize(
        object.tracking,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAdmGrandsonStatusGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAdmGrandsonStatusGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.sent = valueDes;
          break;
        case r'received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.received = valueDes;
          break;
        case r'tracking':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tracking = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAdmGrandsonStatusGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAdmGrandsonStatusGet200ResponseBuilder();
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

