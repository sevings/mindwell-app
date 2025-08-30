//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_auth_profile_all_of_account.g.dart';

/// MwAuthProfileAllOfAccount
///
/// Properties:
/// * [email] 
/// * [verified] 
@BuiltValue()
abstract class MwAuthProfileAllOfAccount implements Built<MwAuthProfileAllOfAccount, MwAuthProfileAllOfAccountBuilder> {
  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'verified')
  bool? get verified;

  MwAuthProfileAllOfAccount._();

  factory MwAuthProfileAllOfAccount([void updates(MwAuthProfileAllOfAccountBuilder b)]) = _$MwAuthProfileAllOfAccount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAuthProfileAllOfAccountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAuthProfileAllOfAccount> get serializer => _$MwAuthProfileAllOfAccountSerializer();
}

class _$MwAuthProfileAllOfAccountSerializer implements PrimitiveSerializer<MwAuthProfileAllOfAccount> {
  @override
  final Iterable<Type> types = const [MwAuthProfileAllOfAccount, _$MwAuthProfileAllOfAccount];

  @override
  final String wireName = r'MwAuthProfileAllOfAccount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAuthProfileAllOfAccount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.verified != null) {
      yield r'verified';
      yield serializers.serialize(
        object.verified,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAuthProfileAllOfAccount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAuthProfileAllOfAccountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'verified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.verified = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAuthProfileAllOfAccount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAuthProfileAllOfAccountBuilder();
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

