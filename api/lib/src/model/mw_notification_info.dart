//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_notification_info.g.dart';

/// MwNotificationInfo
///
/// Properties:
/// * [content] 
/// * [link] 
@BuiltValue()
abstract class MwNotificationInfo implements Built<MwNotificationInfo, MwNotificationInfoBuilder> {
  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'link')
  String? get link;

  MwNotificationInfo._();

  factory MwNotificationInfo([void updates(MwNotificationInfoBuilder b)]) = _$MwNotificationInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwNotificationInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwNotificationInfo> get serializer => _$MwNotificationInfoSerializer();
}

class _$MwNotificationInfoSerializer implements PrimitiveSerializer<MwNotificationInfo> {
  @override
  final Iterable<Type> types = const [MwNotificationInfo, _$MwNotificationInfo];

  @override
  final String wireName = r'MwNotificationInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwNotificationInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
    if (object.link != null) {
      yield r'link';
      yield serializers.serialize(
        object.link,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwNotificationInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwNotificationInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'link':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.link = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwNotificationInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwNotificationInfoBuilder();
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

