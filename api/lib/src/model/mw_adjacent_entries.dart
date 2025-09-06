//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_calendar_entry.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_adjacent_entries.g.dart';

/// MwAdjacentEntries
///
/// Properties:
/// * [older] 
/// * [newer] 
/// * [id] 
@BuiltValue()
abstract class MwAdjacentEntries implements Built<MwAdjacentEntries, MwAdjacentEntriesBuilder> {
  @BuiltValueField(wireName: r'older')
  MwCalendarEntry? get older;

  @BuiltValueField(wireName: r'newer')
  MwCalendarEntry? get newer;

  @BuiltValueField(wireName: r'id')
  int? get id;

  MwAdjacentEntries._();

  factory MwAdjacentEntries([void updates(MwAdjacentEntriesBuilder b)]) = _$MwAdjacentEntries;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwAdjacentEntriesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwAdjacentEntries> get serializer => _$MwAdjacentEntriesSerializer();
}

class _$MwAdjacentEntriesSerializer implements PrimitiveSerializer<MwAdjacentEntries> {
  @override
  final Iterable<Type> types = const [MwAdjacentEntries, _$MwAdjacentEntries];

  @override
  final String wireName = r'MwAdjacentEntries';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwAdjacentEntries object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.older != null) {
      yield r'older';
      yield serializers.serialize(
        object.older,
        specifiedType: const FullType(MwCalendarEntry),
      );
    }
    if (object.newer != null) {
      yield r'newer';
      yield serializers.serialize(
        object.newer,
        specifiedType: const FullType(MwCalendarEntry),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwAdjacentEntries object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwAdjacentEntriesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'older':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwCalendarEntry),
          ) as MwCalendarEntry;
          result.older.replace(valueDes);
          break;
        case r'newer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwCalendarEntry),
          ) as MwCalendarEntry;
          result.newer.replace(valueDes);
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwAdjacentEntries deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwAdjacentEntriesBuilder();
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

