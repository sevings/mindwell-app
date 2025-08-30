//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_auth_profile_all_of_ban.g.dart';

/// MwAuthProfileAllOfBan
///
/// Properties:
/// * [invite] 
/// * [vote] 
/// * [comment] 
/// * [live] 
@BuiltValue()
abstract class MwAuthProfileAllOfBan implements Built<MwAuthProfileAllOfBan, MwAuthProfileAllOfBanBuilder> {
  @BuiltValueField(wireName: r'invite')
  double? get invite;

  @BuiltValueField(wireName: r'vote')
  double? get vote;

  @BuiltValueField(wireName: r'comment')
  double? get comment;

  @BuiltValueField(wireName: r'live')
  double? get live;

  MwAuthProfileAllOfBan._();

  factory MwAuthProfileAllOfBan([void updates(MwAuthProfileAllOfBanBuilder b)]) = _$MwAuthProfileAllOfBan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAuthProfileAllOfBanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAuthProfileAllOfBan> get serializer => _$MwAuthProfileAllOfBanSerializer();
}

class _$MwAuthProfileAllOfBanSerializer implements PrimitiveSerializer<MwAuthProfileAllOfBan> {
  @override
  final Iterable<Type> types = const [MwAuthProfileAllOfBan, _$MwAuthProfileAllOfBan];

  @override
  final String wireName = r'MwAuthProfileAllOfBan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAuthProfileAllOfBan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.invite != null) {
      yield r'invite';
      yield serializers.serialize(
        object.invite,
        specifiedType: const FullType(double),
      );
    }
    if (object.vote != null) {
      yield r'vote';
      yield serializers.serialize(
        object.vote,
        specifiedType: const FullType(double),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(double),
      );
    }
    if (object.live != null) {
      yield r'live';
      yield serializers.serialize(
        object.live,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAuthProfileAllOfBan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAuthProfileAllOfBanBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'invite':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.invite = valueDes;
          break;
        case r'vote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.vote = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.comment = valueDes;
          break;
        case r'live':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.live = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAuthProfileAllOfBan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAuthProfileAllOfBanBuilder();
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

