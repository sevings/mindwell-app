//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_image_size.dart';
import 'package:mindwell/src/model/mw_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_image.g.dart';

/// MwImage
///
/// Properties:
/// * [id] 
/// * [author] 
/// * [isAnimated] 
/// * [processing] 
/// * [thumbnail] 
/// * [small] 
/// * [medium] 
/// * [large] 
@BuiltValue()
abstract class MwImage implements Built<MwImage, MwImageBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'author')
  MwUser? get author;

  @BuiltValueField(wireName: r'isAnimated')
  bool? get isAnimated;

  @BuiltValueField(wireName: r'processing')
  bool? get processing;

  @BuiltValueField(wireName: r'thumbnail')
  MwImageSize? get thumbnail;

  @BuiltValueField(wireName: r'small')
  MwImageSize? get small;

  @BuiltValueField(wireName: r'medium')
  MwImageSize? get medium;

  @BuiltValueField(wireName: r'large')
  MwImageSize? get large;

  MwImage._();

  factory MwImage([void updates(MwImageBuilder b)]) = _$MwImage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwImageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwImage> get serializer => _$MwImageSerializer();
}

class _$MwImageSerializer implements PrimitiveSerializer<MwImage> {
  @override
  final Iterable<Type> types = const [MwImage, _$MwImage];

  @override
  final String wireName = r'MwImage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwImage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.isAnimated != null) {
      yield r'isAnimated';
      yield serializers.serialize(
        object.isAnimated,
        specifiedType: const FullType(bool),
      );
    }
    if (object.processing != null) {
      yield r'processing';
      yield serializers.serialize(
        object.processing,
        specifiedType: const FullType(bool),
      );
    }
    if (object.thumbnail != null) {
      yield r'thumbnail';
      yield serializers.serialize(
        object.thumbnail,
        specifiedType: const FullType(MwImageSize),
      );
    }
    if (object.small != null) {
      yield r'small';
      yield serializers.serialize(
        object.small,
        specifiedType: const FullType(MwImageSize),
      );
    }
    if (object.medium != null) {
      yield r'medium';
      yield serializers.serialize(
        object.medium,
        specifiedType: const FullType(MwImageSize),
      );
    }
    if (object.large != null) {
      yield r'large';
      yield serializers.serialize(
        object.large,
        specifiedType: const FullType(MwImageSize),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwImage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwImageBuilder result,
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
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.author = valueDes;
          break;
        case r'isAnimated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isAnimated = valueDes;
          break;
        case r'processing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.processing = valueDes;
          break;
        case r'thumbnail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwImageSize),
          ) as MwImageSize;
          result.thumbnail.replace(valueDes);
          break;
        case r'small':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwImageSize),
          ) as MwImageSize;
          result.small.replace(valueDes);
          break;
        case r'medium':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwImageSize),
          ) as MwImageSize;
          result.medium.replace(valueDes);
          break;
        case r'large':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwImageSize),
          ) as MwImageSize;
          result.large.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwImage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwImageBuilder();
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

