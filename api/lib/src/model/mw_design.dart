//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_design.g.dart';

/// MwDesign
///
/// Properties:
/// * [css] 
/// * [backgroundColor] - color in rgb
/// * [textColor] - color in rgb
/// * [fontFamily] 
/// * [fontSize] 
/// * [textAlignment] 
@BuiltValue()
abstract class MwDesign implements Built<MwDesign, MwDesignBuilder> {
  @BuiltValueField(wireName: r'css')
  String? get css;

  /// color in rgb
  @BuiltValueField(wireName: r'backgroundColor')
  String? get backgroundColor;

  /// color in rgb
  @BuiltValueField(wireName: r'textColor')
  String? get textColor;

  @BuiltValueField(wireName: r'fontFamily')
  String? get fontFamily;

  @BuiltValueField(wireName: r'fontSize')
  int? get fontSize;

  @BuiltValueField(wireName: r'textAlignment')
  MwDesignTextAlignmentEnum? get textAlignment;
  // enum textAlignmentEnum {  left,  right,  center,  justify,  };

  MwDesign._();

  factory MwDesign([void updates(MwDesignBuilder b)]) = _$MwDesign;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwDesignBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwDesign> get serializer => _$MwDesignSerializer();
}

class _$MwDesignSerializer implements PrimitiveSerializer<MwDesign> {
  @override
  final Iterable<Type> types = const [MwDesign, _$MwDesign];

  @override
  final String wireName = r'MwDesign';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwDesign object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.css != null) {
      yield r'css';
      yield serializers.serialize(
        object.css,
        specifiedType: const FullType(String),
      );
    }
    if (object.backgroundColor != null) {
      yield r'backgroundColor';
      yield serializers.serialize(
        object.backgroundColor,
        specifiedType: const FullType(String),
      );
    }
    if (object.textColor != null) {
      yield r'textColor';
      yield serializers.serialize(
        object.textColor,
        specifiedType: const FullType(String),
      );
    }
    if (object.fontFamily != null) {
      yield r'fontFamily';
      yield serializers.serialize(
        object.fontFamily,
        specifiedType: const FullType(String),
      );
    }
    if (object.fontSize != null) {
      yield r'fontSize';
      yield serializers.serialize(
        object.fontSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.textAlignment != null) {
      yield r'textAlignment';
      yield serializers.serialize(
        object.textAlignment,
        specifiedType: const FullType(MwDesignTextAlignmentEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwDesign object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwDesignBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'css':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.css = valueDes;
          break;
        case r'backgroundColor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.backgroundColor = valueDes;
          break;
        case r'textColor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.textColor = valueDes;
          break;
        case r'fontFamily':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fontFamily = valueDes;
          break;
        case r'fontSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fontSize = valueDes;
          break;
        case r'textAlignment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwDesignTextAlignmentEnum),
          ) as MwDesignTextAlignmentEnum;
          result.textAlignment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwDesign deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwDesignBuilder();
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

class MwDesignTextAlignmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'left')
  static const MwDesignTextAlignmentEnum left = _$mwDesignTextAlignmentEnum_left;
  @BuiltValueEnumConst(wireName: r'right')
  static const MwDesignTextAlignmentEnum right = _$mwDesignTextAlignmentEnum_right;
  @BuiltValueEnumConst(wireName: r'center')
  static const MwDesignTextAlignmentEnum center = _$mwDesignTextAlignmentEnum_center;
  @BuiltValueEnumConst(wireName: r'justify')
  static const MwDesignTextAlignmentEnum justify = _$mwDesignTextAlignmentEnum_justify;

  static Serializer<MwDesignTextAlignmentEnum> get serializer => _$mwDesignTextAlignmentEnumSerializer;

  const MwDesignTextAlignmentEnum._(String name): super(name);

  static BuiltSet<MwDesignTextAlignmentEnum> get values => _$mwDesignTextAlignmentEnumValues;
  static MwDesignTextAlignmentEnum valueOf(String name) => _$mwDesignTextAlignmentEnumValueOf(name);
}

