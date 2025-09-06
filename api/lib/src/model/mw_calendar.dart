//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_calendar_entry.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_calendar.g.dart';

/// MwCalendar
///
/// Properties:
/// * [entries] 
/// * [start] 
/// * [end] 
/// * [limit] 
@BuiltValue()
abstract class MwCalendar implements Built<MwCalendar, MwCalendarBuilder> {
  @BuiltValueField(wireName: r'entries')
  BuiltList<MwCalendarEntry>? get entries;

  @BuiltValueField(wireName: r'start')
  num? get start;

  @BuiltValueField(wireName: r'end')
  num? get end;

  @BuiltValueField(wireName: r'limit')
  int? get limit;

  MwCalendar._();

  factory MwCalendar([void updates(MwCalendarBuilder b)]) = _$MwCalendar;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwCalendarBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwCalendar> get serializer => _$MwCalendarSerializer();
}

class _$MwCalendarSerializer implements PrimitiveSerializer<MwCalendar> {
  @override
  final Iterable<Type> types = const [MwCalendar, _$MwCalendar];

  @override
  final String wireName = r'MwCalendar';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwCalendar object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.entries != null) {
      yield r'entries';
      yield serializers.serialize(
        object.entries,
        specifiedType: const FullType(BuiltList, [FullType(MwCalendarEntry)]),
      );
    }
    if (object.start != null) {
      yield r'start';
      yield serializers.serialize(
        object.start,
        specifiedType: const FullType(num),
      );
    }
    if (object.end != null) {
      yield r'end';
      yield serializers.serialize(
        object.end,
        specifiedType: const FullType(num),
      );
    }
    if (object.limit != null) {
      yield r'limit';
      yield serializers.serialize(
        object.limit,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwCalendar object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwCalendarBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'entries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwCalendarEntry)]),
          ) as BuiltList<MwCalendarEntry>;
          result.entries.replace(valueDes);
          break;
        case r'start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.start = valueDes;
          break;
        case r'end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.end = valueDes;
          break;
        case r'limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.limit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwCalendar deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwCalendarBuilder();
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

