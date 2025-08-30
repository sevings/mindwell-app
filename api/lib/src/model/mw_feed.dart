//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:mindwell/src/model/mw_entry.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_feed.g.dart';

/// MwFeed
///
/// Properties:
/// * [entries] 
/// * [nextAfter] 
/// * [hasAfter] 
/// * [nextBefore] 
/// * [hasBefore] 
@BuiltValue()
abstract class MwFeed implements Built<MwFeed, MwFeedBuilder> {
  @BuiltValueField(wireName: r'entries')
  BuiltList<MwEntry>? get entries;

  @BuiltValueField(wireName: r'nextAfter')
  String? get nextAfter;

  @BuiltValueField(wireName: r'hasAfter')
  bool? get hasAfter;

  @BuiltValueField(wireName: r'nextBefore')
  String? get nextBefore;

  @BuiltValueField(wireName: r'hasBefore')
  bool? get hasBefore;

  MwFeed._();

  factory MwFeed([void updates(MwFeedBuilder b)]) = _$MwFeed;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwFeedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwFeed> get serializer => _$MwFeedSerializer();
}

class _$MwFeedSerializer implements PrimitiveSerializer<MwFeed> {
  @override
  final Iterable<Type> types = const [MwFeed, _$MwFeed];

  @override
  final String wireName = r'MwFeed';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwFeed object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.entries != null) {
      yield r'entries';
      yield serializers.serialize(
        object.entries,
        specifiedType: const FullType(BuiltList, [FullType(MwEntry)]),
      );
    }
    if (object.nextAfter != null) {
      yield r'nextAfter';
      yield serializers.serialize(
        object.nextAfter,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasAfter != null) {
      yield r'hasAfter';
      yield serializers.serialize(
        object.hasAfter,
        specifiedType: const FullType(bool),
      );
    }
    if (object.nextBefore != null) {
      yield r'nextBefore';
      yield serializers.serialize(
        object.nextBefore,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasBefore != null) {
      yield r'hasBefore';
      yield serializers.serialize(
        object.hasBefore,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwFeed object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwFeedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'entries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwEntry)]),
          ) as BuiltList<MwEntry>;
          result.entries.replace(valueDes);
          break;
        case r'nextAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextAfter = valueDes;
          break;
        case r'hasAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAfter = valueDes;
          break;
        case r'nextBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nextBefore = valueDes;
          break;
        case r'hasBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasBefore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwFeed deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwFeedBuilder();
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

