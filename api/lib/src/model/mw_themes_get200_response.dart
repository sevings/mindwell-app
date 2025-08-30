//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell/src/model/mw_friend.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_themes_get200_response.g.dart';

/// MwThemesGet200Response
///
/// Properties:
/// * [top] 
/// * [query] 
/// * [themes] 
@BuiltValue()
abstract class MwThemesGet200Response implements Built<MwThemesGet200Response, MwThemesGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'top')
  String? get top;

  @BuiltValueField(wireName: r'query')
  String? get query;

  @BuiltValueField(wireName: r'themes')
  BuiltList<MwFriend>? get themes;

  MwThemesGet200Response._();

  factory MwThemesGet200Response([void updates(MwThemesGet200ResponseBuilder b)]) = _$MwThemesGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwThemesGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwThemesGet200Response> get serializer => _$MwThemesGet200ResponseSerializer();
}

class _$MwThemesGet200ResponseSerializer implements PrimitiveSerializer<MwThemesGet200Response> {
  @override
  final Iterable<Type> types = const [MwThemesGet200Response, _$MwThemesGet200Response];

  @override
  final String wireName = r'MwThemesGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwThemesGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.top != null) {
      yield r'top';
      yield serializers.serialize(
        object.top,
        specifiedType: const FullType(String),
      );
    }
    if (object.query != null) {
      yield r'query';
      yield serializers.serialize(
        object.query,
        specifiedType: const FullType(String),
      );
    }
    if (object.themes != null) {
      yield r'themes';
      yield serializers.serialize(
        object.themes,
        specifiedType: const FullType(BuiltList, [FullType(MwFriend)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwThemesGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwThemesGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'top':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.top = valueDes;
          break;
        case r'query':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.query = valueDes;
          break;
        case r'themes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwFriend)]),
          ) as BuiltList<MwFriend>;
          result.themes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwThemesGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwThemesGet200ResponseBuilder();
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

