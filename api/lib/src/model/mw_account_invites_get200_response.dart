//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_account_invites_get200_response.g.dart';

/// MwAccountInvitesGet200Response
///
/// Properties:
/// * [invites] 
@BuiltValue()
abstract class MwAccountInvitesGet200Response implements Built<MwAccountInvitesGet200Response, MwAccountInvitesGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'invites')
  BuiltList<String>? get invites;

  MwAccountInvitesGet200Response._();

  factory MwAccountInvitesGet200Response([void updates(MwAccountInvitesGet200ResponseBuilder b)]) = _$MwAccountInvitesGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAccountInvitesGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAccountInvitesGet200Response> get serializer => _$MwAccountInvitesGet200ResponseSerializer();
}

class _$MwAccountInvitesGet200ResponseSerializer implements PrimitiveSerializer<MwAccountInvitesGet200Response> {
  @override
  final Iterable<Type> types = const [MwAccountInvitesGet200Response, _$MwAccountInvitesGet200Response];

  @override
  final String wireName = r'MwAccountInvitesGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAccountInvitesGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.invites != null) {
      yield r'invites';
      yield serializers.serialize(
        object.invites,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAccountInvitesGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAccountInvitesGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invites':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.invites.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAccountInvitesGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAccountInvitesGet200ResponseBuilder();
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

