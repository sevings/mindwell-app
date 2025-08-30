//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_notification.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_notification_list.g.dart';

/// MwNotificationList
///
/// Properties:
/// * [notifications] 
/// * [unreadCount] 
/// * [nextAfter] 
/// * [hasAfter] 
/// * [nextBefore] 
/// * [hasBefore] 
@BuiltValue()
abstract class MwNotificationList implements Built<MwNotificationList, MwNotificationListBuilder> {
  @BuiltValueField(wireName: r'notifications')
  BuiltList<MwNotification>? get notifications;

  @BuiltValueField(wireName: r'unreadCount')
  int? get unreadCount;

  @BuiltValueField(wireName: r'nextAfter')
  String? get nextAfter;

  @BuiltValueField(wireName: r'hasAfter')
  bool? get hasAfter;

  @BuiltValueField(wireName: r'nextBefore')
  String? get nextBefore;

  @BuiltValueField(wireName: r'hasBefore')
  bool? get hasBefore;

  MwNotificationList._();

  factory MwNotificationList([void updates(MwNotificationListBuilder b)]) = _$MwNotificationList;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwNotificationListBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwNotificationList> get serializer => _$MwNotificationListSerializer();
}

class _$MwNotificationListSerializer implements PrimitiveSerializer<MwNotificationList> {
  @override
  final Iterable<Type> types = const [MwNotificationList, _$MwNotificationList];

  @override
  final String wireName = r'MwNotificationList';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwNotificationList object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.notifications != null) {
      yield r'notifications';
      yield serializers.serialize(
        object.notifications,
        specifiedType: const FullType(BuiltList, [FullType(MwNotification)]),
      );
    }
    if (object.unreadCount != null) {
      yield r'unreadCount';
      yield serializers.serialize(
        object.unreadCount,
        specifiedType: const FullType(int),
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
    MwNotificationList object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwNotificationListBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'notifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwNotification)]),
          ) as BuiltList<MwNotification>;
          result.notifications.replace(valueDes);
          break;
        case r'unreadCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
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
  MwNotificationList deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwNotificationListBuilder();
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

