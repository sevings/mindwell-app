//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_friend_all_of_counts.g.dart';

/// MwFriendAllOfCounts
///
/// Properties:
/// * [entries] 
/// * [followings] 
/// * [followers] 
/// * [ignored] 
/// * [invited] 
/// * [comments] 
/// * [favorites] 
/// * [tags] 
/// * [days] 
@BuiltValue()
abstract class MwFriendAllOfCounts implements Built<MwFriendAllOfCounts, MwFriendAllOfCountsBuilder> {
  @BuiltValueField(wireName: r'entries')
  int? get entries;

  @BuiltValueField(wireName: r'followings')
  int? get followings;

  @BuiltValueField(wireName: r'followers')
  int? get followers;

  @BuiltValueField(wireName: r'ignored')
  int? get ignored;

  @BuiltValueField(wireName: r'invited')
  int? get invited;

  @BuiltValueField(wireName: r'comments')
  int? get comments;

  @BuiltValueField(wireName: r'favorites')
  int? get favorites;

  @BuiltValueField(wireName: r'tags')
  int? get tags;

  @BuiltValueField(wireName: r'days')
  int? get days;

  MwFriendAllOfCounts._();

  factory MwFriendAllOfCounts([void updates(MwFriendAllOfCountsBuilder b)]) = _$MwFriendAllOfCounts;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwFriendAllOfCountsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwFriendAllOfCounts> get serializer => _$MwFriendAllOfCountsSerializer();
}

class _$MwFriendAllOfCountsSerializer implements PrimitiveSerializer<MwFriendAllOfCounts> {
  @override
  final Iterable<Type> types = const [MwFriendAllOfCounts, _$MwFriendAllOfCounts];

  @override
  final String wireName = r'MwFriendAllOfCounts';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwFriendAllOfCounts object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.entries != null) {
      yield r'entries';
      yield serializers.serialize(
        object.entries,
        specifiedType: const FullType(int),
      );
    }
    if (object.followings != null) {
      yield r'followings';
      yield serializers.serialize(
        object.followings,
        specifiedType: const FullType(int),
      );
    }
    if (object.followers != null) {
      yield r'followers';
      yield serializers.serialize(
        object.followers,
        specifiedType: const FullType(int),
      );
    }
    if (object.ignored != null) {
      yield r'ignored';
      yield serializers.serialize(
        object.ignored,
        specifiedType: const FullType(int),
      );
    }
    if (object.invited != null) {
      yield r'invited';
      yield serializers.serialize(
        object.invited,
        specifiedType: const FullType(int),
      );
    }
    if (object.comments != null) {
      yield r'comments';
      yield serializers.serialize(
        object.comments,
        specifiedType: const FullType(int),
      );
    }
    if (object.favorites != null) {
      yield r'favorites';
      yield serializers.serialize(
        object.favorites,
        specifiedType: const FullType(int),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(int),
      );
    }
    if (object.days != null) {
      yield r'days';
      yield serializers.serialize(
        object.days,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwFriendAllOfCounts object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwFriendAllOfCountsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'entries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.entries = valueDes;
          break;
        case r'followings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.followings = valueDes;
          break;
        case r'followers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.followers = valueDes;
          break;
        case r'ignored':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ignored = valueDes;
          break;
        case r'invited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.invited = valueDes;
          break;
        case r'comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.comments = valueDes;
          break;
        case r'favorites':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.favorites = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tags = valueDes;
          break;
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.days = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwFriendAllOfCounts deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwFriendAllOfCountsBuilder();
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

