//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_image_size.g.dart';

/// MwImageSize
///
/// Properties:
/// * [width] 
/// * [height] 
/// * [url] 
/// * [preview] 
@BuiltValue()
abstract class MwImageSize implements Built<MwImageSize, MwImageSizeBuilder> {
  @BuiltValueField(wireName: r'width')
  int? get width;

  @BuiltValueField(wireName: r'height')
  int? get height;

  @BuiltValueField(wireName: r'url')
  String? get url;

  @BuiltValueField(wireName: r'preview')
  String? get preview;

  MwImageSize._();

  factory MwImageSize([void updates(MwImageSizeBuilder b)]) = _$MwImageSize;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwImageSizeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwImageSize> get serializer => _$MwImageSizeSerializer();
}

class _$MwImageSizeSerializer implements PrimitiveSerializer<MwImageSize> {
  @override
  final Iterable<Type> types = const [MwImageSize, _$MwImageSize];

  @override
  final String wireName = r'MwImageSize';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwImageSize object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.width != null) {
      yield r'width';
      yield serializers.serialize(
        object.width,
        specifiedType: const FullType(int),
      );
    }
    if (object.height != null) {
      yield r'height';
      yield serializers.serialize(
        object.height,
        specifiedType: const FullType(int),
      );
    }
    if (object.url != null) {
      yield r'url';
      yield serializers.serialize(
        object.url,
        specifiedType: const FullType(String),
      );
    }
    if (object.preview != null) {
      yield r'preview';
      yield serializers.serialize(
        object.preview,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwImageSize object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwImageSizeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'width':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.width = valueDes;
          break;
        case r'height':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.height = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.preview = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwImageSize deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwImageSizeBuilder();
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

