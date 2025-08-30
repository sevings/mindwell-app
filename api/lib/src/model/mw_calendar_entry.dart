//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_calendar_entry.g.dart';

/// MwCalendarEntry
///
/// Properties:
/// * [id] 
/// * [createdAt] 
/// * [title] 
@BuiltValue()
abstract class MwCalendarEntry implements Built<MwCalendarEntry, MwCalendarEntryBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'createdAt')
  double? get createdAt;

  @BuiltValueField(wireName: r'title')
  String? get title;

  MwCalendarEntry._();

  factory MwCalendarEntry([void updates(MwCalendarEntryBuilder b)]) = _$MwCalendarEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwCalendarEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwCalendarEntry> get serializer => _$MwCalendarEntrySerializer();
}

class _$MwCalendarEntrySerializer implements PrimitiveSerializer<MwCalendarEntry> {
  @override
  final Iterable<Type> types = const [MwCalendarEntry, _$MwCalendarEntry];

  @override
  final String wireName = r'MwCalendarEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwCalendarEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwCalendarEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwCalendarEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.createdAt = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwCalendarEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwCalendarEntryBuilder();
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

