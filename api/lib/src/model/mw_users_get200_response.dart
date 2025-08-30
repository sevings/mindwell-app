//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_friend.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_users_get200_response.g.dart';

/// MwUsersGet200Response
///
/// Properties:
/// * [top] 
/// * [query] 
/// * [users] 
@BuiltValue()
abstract class MwUsersGet200Response implements Built<MwUsersGet200Response, MwUsersGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'top')
  String? get top;

  @BuiltValueField(wireName: r'query')
  String? get query;

  @BuiltValueField(wireName: r'users')
  BuiltList<MwFriend>? get users;

  MwUsersGet200Response._();

  factory MwUsersGet200Response([void updates(MwUsersGet200ResponseBuilder b)]) = _$MwUsersGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwUsersGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwUsersGet200Response> get serializer => _$MwUsersGet200ResponseSerializer();
}

class _$MwUsersGet200ResponseSerializer implements PrimitiveSerializer<MwUsersGet200Response> {
  @override
  final Iterable<Type> types = const [MwUsersGet200Response, _$MwUsersGet200Response];

  @override
  final String wireName = r'MwUsersGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwUsersGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.top != null) {
      yield r'top';
      yield serializers.serialize(
        object.top,
        specifiedType: const FullType(String),
      );
    }
    if (object.query != null) {
      yield r'query';
      yield serializers.serialize(
        object.query,
        specifiedType: const FullType(String),
      );
    }
    if (object.users != null) {
      yield r'users';
      yield serializers.serialize(
        object.users,
        specifiedType: const FullType(BuiltList, [FullType(MwFriend)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwUsersGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwUsersGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'top':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.top = valueDes;
          break;
        case r'query':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.query = valueDes;
          break;
        case r'users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwFriend)]),
          ) as BuiltList<MwFriend>;
          result.users.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwUsersGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwUsersGet200ResponseBuilder();
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

