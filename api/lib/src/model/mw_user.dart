//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_avatar.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_user.g.dart';

/// MwUser
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [showName] 
/// * [isTheme] 
/// * [isOnline] 
/// * [avatar] 
@BuiltValue(instantiable: false)
abstract class MwUser  {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'showName')
  String? get showName;

  @BuiltValueField(wireName: r'isTheme')
  bool? get isTheme;

  @BuiltValueField(wireName: r'isOnline')
  bool? get isOnline;

  @BuiltValueField(wireName: r'avatar')
  MwAvatar? get avatar;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwUser> get serializer => _$MwUserSerializer();
}

class _$MwUserSerializer implements PrimitiveSerializer<MwUser> {
  @override
  final Iterable<Type> types = const [MwUser];

  @override
  final String wireName = r'MwUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.showName != null) {
      yield r'showName';
      yield serializers.serialize(
        object.showName,
        specifiedType: const FullType(String),
      );
    }
    if (object.isTheme != null) {
      yield r'isTheme';
      yield serializers.serialize(
        object.isTheme,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isOnline != null) {
      yield r'isOnline';
      yield serializers.serialize(
        object.isOnline,
        specifiedType: const FullType(bool),
      );
    }
    if (object.avatar != null) {
      yield r'avatar';
      yield serializers.serialize(
        object.avatar,
        specifiedType: const FullType(MwAvatar),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  MwUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($MwUser)) as $MwUser;
  }
}

/// a concrete implementation of [MwUser], since [MwUser] is not instantiable
@BuiltValue(instantiable: true)
abstract class $MwUser implements MwUser, Built<$MwUser, $MwUserBuilder> {
  $MwUser._();

  factory $MwUser([void Function($MwUserBuilder)? updates]) = _$$MwUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($MwUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$MwUser> get serializer => _$$MwUserSerializer();
}

class _$$MwUserSerializer implements PrimitiveSerializer<$MwUser> {
  @override
  final Iterable<Type> types = const [$MwUser, _$$MwUser];

  @override
  final String wireName = r'$MwUser';

  @override
  Object serialize(
    Serializers serializers,
    $MwUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(MwUser))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwUserBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'showName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.showName = valueDes;
          break;
        case r'isTheme':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isTheme = valueDes;
          break;
        case r'isOnline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isOnline = valueDes;
          break;
        case r'avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwAvatar),
          ) as MwAvatar;
          result.avatar.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $MwUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $MwUserBuilder();
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

