//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_account_settings_email_get200_response.g.dart';

/// MwAccountSettingsEmailGet200Response
///
/// Properties:
/// * [comments] 
/// * [followers] 
/// * [invites] 
/// * [movedEntries] 
/// * [badges] 
@BuiltValue()
abstract class MwAccountSettingsEmailGet200Response implements Built<MwAccountSettingsEmailGet200Response, MwAccountSettingsEmailGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'comments')
  bool? get comments;

  @BuiltValueField(wireName: r'followers')
  bool? get followers;

  @BuiltValueField(wireName: r'invites')
  bool? get invites;

  @BuiltValueField(wireName: r'movedEntries')
  bool? get movedEntries;

  @BuiltValueField(wireName: r'badges')
  bool? get badges;

  MwAccountSettingsEmailGet200Response._();

  factory MwAccountSettingsEmailGet200Response([void updates(MwAccountSettingsEmailGet200ResponseBuilder b)]) = _$MwAccountSettingsEmailGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAccountSettingsEmailGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAccountSettingsEmailGet200Response> get serializer => _$MwAccountSettingsEmailGet200ResponseSerializer();
}

class _$MwAccountSettingsEmailGet200ResponseSerializer implements PrimitiveSerializer<MwAccountSettingsEmailGet200Response> {
  @override
  final Iterable<Type> types = const [MwAccountSettingsEmailGet200Response, _$MwAccountSettingsEmailGet200Response];

  @override
  final String wireName = r'MwAccountSettingsEmailGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAccountSettingsEmailGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.comments != null) {
      yield r'comments';
      yield serializers.serialize(
        object.comments,
        specifiedType: const FullType(bool),
      );
    }
    if (object.followers != null) {
      yield r'followers';
      yield serializers.serialize(
        object.followers,
        specifiedType: const FullType(bool),
      );
    }
    if (object.invites != null) {
      yield r'invites';
      yield serializers.serialize(
        object.invites,
        specifiedType: const FullType(bool),
      );
    }
    if (object.movedEntries != null) {
      yield r'movedEntries';
      yield serializers.serialize(
        object.movedEntries,
        specifiedType: const FullType(bool),
      );
    }
    if (object.badges != null) {
      yield r'badges';
      yield serializers.serialize(
        object.badges,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAccountSettingsEmailGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAccountSettingsEmailGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.comments = valueDes;
          break;
        case r'followers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.followers = valueDes;
          break;
        case r'invites':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.invites = valueDes;
          break;
        case r'movedEntries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.movedEntries = valueDes;
          break;
        case r'badges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.badges = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAccountSettingsEmailGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAccountSettingsEmailGet200ResponseBuilder();
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

