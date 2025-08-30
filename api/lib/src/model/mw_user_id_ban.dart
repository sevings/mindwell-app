//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_user_id_ban.g.dart';

/// MwUserIDBan
///
/// Properties:
/// * [account] 
/// * [shadow] 
/// * [invite] 
/// * [vote] 
/// * [comment] 
/// * [live] 
/// * [complain] 
@BuiltValue()
abstract class MwUserIDBan implements Built<MwUserIDBan, MwUserIDBanBuilder> {
  @BuiltValueField(wireName: r'account')
  bool? get account;

  @BuiltValueField(wireName: r'shadow')
  bool? get shadow;

  @BuiltValueField(wireName: r'invite')
  bool? get invite;

  @BuiltValueField(wireName: r'vote')
  bool? get vote;

  @BuiltValueField(wireName: r'comment')
  bool? get comment;

  @BuiltValueField(wireName: r'live')
  bool? get live;

  @BuiltValueField(wireName: r'complain')
  bool? get complain;

  MwUserIDBan._();

  factory MwUserIDBan([void updates(MwUserIDBanBuilder b)]) = _$MwUserIDBan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwUserIDBanBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwUserIDBan> get serializer => _$MwUserIDBanSerializer();
}

class _$MwUserIDBanSerializer implements PrimitiveSerializer<MwUserIDBan> {
  @override
  final Iterable<Type> types = const [MwUserIDBan, _$MwUserIDBan];

  @override
  final String wireName = r'MwUserIDBan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwUserIDBan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.account != null) {
      yield r'account';
      yield serializers.serialize(
        object.account,
        specifiedType: const FullType(bool),
      );
    }
    if (object.shadow != null) {
      yield r'shadow';
      yield serializers.serialize(
        object.shadow,
        specifiedType: const FullType(bool),
      );
    }
    if (object.invite != null) {
      yield r'invite';
      yield serializers.serialize(
        object.invite,
        specifiedType: const FullType(bool),
      );
    }
    if (object.vote != null) {
      yield r'vote';
      yield serializers.serialize(
        object.vote,
        specifiedType: const FullType(bool),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(bool),
      );
    }
    if (object.live != null) {
      yield r'live';
      yield serializers.serialize(
        object.live,
        specifiedType: const FullType(bool),
      );
    }
    if (object.complain != null) {
      yield r'complain';
      yield serializers.serialize(
        object.complain,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwUserIDBan object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwUserIDBanBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.account = valueDes;
          break;
        case r'shadow':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.shadow = valueDes;
          break;
        case r'invite':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.invite = valueDes;
          break;
        case r'vote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.vote = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.comment = valueDes;
          break;
        case r'live':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.live = valueDes;
          break;
        case r'complain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.complain = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwUserIDBan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwUserIDBanBuilder();
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

