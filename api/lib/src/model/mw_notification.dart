//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/src/model/mw_badge.dart';
import 'package:mindwell_api/src/model/mw_entry.dart';
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:mindwell_api/src/model/mw_comment.dart';
import 'package:mindwell_api/src/model/mw_notification_info.dart';
import 'package:mindwell_api/src/model/mw_wish.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_notification.g.dart';

/// MwNotification
///
/// Properties:
/// * [id] 
/// * [type] 
/// * [read] 
/// * [createdAt] 
/// * [user] 
/// * [comment] 
/// * [entry] 
/// * [wish] 
/// * [badge] 
/// * [info] 
@BuiltValue()
abstract class MwNotification implements Built<MwNotification, MwNotificationBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'type')
  MwNotificationTypeEnum? get type;
  // enum typeEnum {  comment,  follower,  request,  accept,  invite,  welcome,  invited,  badge,  adm_sent,  adm_received,  wish_created,  wish_received,  entry_moved,  info,  };

  @BuiltValueField(wireName: r'read')
  bool? get read;

  @BuiltValueField(wireName: r'createdAt')
  double? get createdAt;

  @BuiltValueField(wireName: r'user')
  MwUser? get user;

  @BuiltValueField(wireName: r'comment')
  MwComment? get comment;

  @BuiltValueField(wireName: r'entry')
  MwEntry? get entry;

  @BuiltValueField(wireName: r'wish')
  MwWish? get wish;

  @BuiltValueField(wireName: r'badge')
  MwBadge? get badge;

  @BuiltValueField(wireName: r'info')
  MwNotificationInfo? get info;

  MwNotification._();

  factory MwNotification([void updates(MwNotificationBuilder b)]) = _$MwNotification;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwNotificationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwNotification> get serializer => _$MwNotificationSerializer();
}

class _$MwNotificationSerializer implements PrimitiveSerializer<MwNotification> {
  @override
  final Iterable<Type> types = const [MwNotification, _$MwNotification];

  @override
  final String wireName = r'MwNotification';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwNotification object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(MwNotificationTypeEnum),
      );
    }
    if (object.read != null) {
      yield r'read';
      yield serializers.serialize(
        object.read,
        specifiedType: const FullType(bool),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(MwComment),
      );
    }
    if (object.entry != null) {
      yield r'entry';
      yield serializers.serialize(
        object.entry,
        specifiedType: const FullType(MwEntry),
      );
    }
    if (object.wish != null) {
      yield r'wish';
      yield serializers.serialize(
        object.wish,
        specifiedType: const FullType(MwWish),
      );
    }
    if (object.badge != null) {
      yield r'badge';
      yield serializers.serialize(
        object.badge,
        specifiedType: const FullType(MwBadge),
      );
    }
    if (object.info != null) {
      yield r'info';
      yield serializers.serialize(
        object.info,
        specifiedType: const FullType(MwNotificationInfo),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwNotification object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwNotificationBuilder result,
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwNotificationTypeEnum),
          ) as MwNotificationTypeEnum;
          result.type = valueDes;
          break;
        case r'read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.read = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.createdAt = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.user = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwComment),
          ) as MwComment;
          result.comment.replace(valueDes);
          break;
        case r'entry':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwEntry),
          ) as MwEntry;
          result.entry.replace(valueDes);
          break;
        case r'wish':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwWish),
          ) as MwWish;
          result.wish.replace(valueDes);
          break;
        case r'badge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwBadge),
          ) as MwBadge;
          result.badge.replace(valueDes);
          break;
        case r'info':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwNotificationInfo),
          ) as MwNotificationInfo;
          result.info.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwNotification deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwNotificationBuilder();
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

class MwNotificationTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'comment')
  static const MwNotificationTypeEnum comment = _$mwNotificationTypeEnum_comment;
  @BuiltValueEnumConst(wireName: r'follower')
  static const MwNotificationTypeEnum follower = _$mwNotificationTypeEnum_follower;
  @BuiltValueEnumConst(wireName: r'request')
  static const MwNotificationTypeEnum request = _$mwNotificationTypeEnum_request;
  @BuiltValueEnumConst(wireName: r'accept')
  static const MwNotificationTypeEnum accept = _$mwNotificationTypeEnum_accept;
  @BuiltValueEnumConst(wireName: r'invite')
  static const MwNotificationTypeEnum invite = _$mwNotificationTypeEnum_invite;
  @BuiltValueEnumConst(wireName: r'welcome')
  static const MwNotificationTypeEnum welcome = _$mwNotificationTypeEnum_welcome;
  @BuiltValueEnumConst(wireName: r'invited')
  static const MwNotificationTypeEnum invited = _$mwNotificationTypeEnum_invited;
  @BuiltValueEnumConst(wireName: r'badge')
  static const MwNotificationTypeEnum badge = _$mwNotificationTypeEnum_badge;
  @BuiltValueEnumConst(wireName: r'adm_sent')
  static const MwNotificationTypeEnum admSent = _$mwNotificationTypeEnum_admSent;
  @BuiltValueEnumConst(wireName: r'adm_received')
  static const MwNotificationTypeEnum admReceived = _$mwNotificationTypeEnum_admReceived;
  @BuiltValueEnumConst(wireName: r'wish_created')
  static const MwNotificationTypeEnum wishCreated = _$mwNotificationTypeEnum_wishCreated;
  @BuiltValueEnumConst(wireName: r'wish_received')
  static const MwNotificationTypeEnum wishReceived = _$mwNotificationTypeEnum_wishReceived;
  @BuiltValueEnumConst(wireName: r'entry_moved')
  static const MwNotificationTypeEnum entryMoved = _$mwNotificationTypeEnum_entryMoved;
  @BuiltValueEnumConst(wireName: r'info')
  static const MwNotificationTypeEnum info = _$mwNotificationTypeEnum_info;

  static Serializer<MwNotificationTypeEnum> get serializer => _$mwNotificationTypeEnumSerializer;

  const MwNotificationTypeEnum._(String name): super(name);

  static BuiltSet<MwNotificationTypeEnum> get values => _$mwNotificationTypeEnumValues;
  static MwNotificationTypeEnum valueOf(String name) => _$mwNotificationTypeEnumValueOf(name);
}

