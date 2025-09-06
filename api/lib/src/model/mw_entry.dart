//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:mindwell_api/src/model/mw_comment_list.dart';
import 'package:mindwell_api/src/model/mw_entry_rights.dart';
import 'package:mindwell_api/src/model/mw_rating.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/src/model/mw_user.dart';
import 'package:mindwell_api/src/model/mw_image.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mw_entry.g.dart';

/// MwEntry
///
/// Properties:
/// * [id] 
/// * [author] 
/// * [user] 
/// * [createdAt] 
/// * [rating] 
/// * [title] 
/// * [cutTitle] 
/// * [content] 
/// * [cutContent] 
/// * [editContent] 
/// * [hasCut] 
/// * [images] 
/// * [insertedImages] 
/// * [tags] 
/// * [wordCount] 
/// * [privacy] 
/// * [visibleFor] 
/// * [isCommentable] 
/// * [inLive] 
/// * [isAnonymous] 
/// * [isShared] 
/// * [isPinned] 
/// * [commentCount] 
/// * [favoriteCount] 
/// * [isFavorited] 
/// * [isWatching] 
/// * [comments] 
/// * [rights] 
@BuiltValue()
abstract class MwEntry implements Built<MwEntry, MwEntryBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'author')
  MwUser? get author;

  @BuiltValueField(wireName: r'user')
  MwUser? get user;

  @BuiltValueField(wireName: r'createdAt')
  double? get createdAt;

  @BuiltValueField(wireName: r'rating')
  MwRating? get rating;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'cutTitle')
  String? get cutTitle;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'cutContent')
  String? get cutContent;

  @BuiltValueField(wireName: r'editContent')
  String? get editContent;

  @BuiltValueField(wireName: r'hasCut')
  bool? get hasCut;

  @BuiltValueField(wireName: r'images')
  BuiltList<MwImage>? get images;

  @BuiltValueField(wireName: r'insertedImages')
  BuiltList<MwImage>? get insertedImages;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  @BuiltValueField(wireName: r'wordCount')
  int? get wordCount;

  @BuiltValueField(wireName: r'privacy')
  MwEntryPrivacyEnum? get privacy;
  // enum privacyEnum {  all,  registered,  invited,  followers,  some,  me,  };

  @BuiltValueField(wireName: r'visibleFor')
  BuiltList<MwUser>? get visibleFor;

  @BuiltValueField(wireName: r'isCommentable')
  bool? get isCommentable;

  @BuiltValueField(wireName: r'inLive')
  bool? get inLive;

  @BuiltValueField(wireName: r'isAnonymous')
  bool? get isAnonymous;

  @BuiltValueField(wireName: r'isShared')
  bool? get isShared;

  @BuiltValueField(wireName: r'isPinned')
  bool? get isPinned;

  @BuiltValueField(wireName: r'commentCount')
  int? get commentCount;

  @BuiltValueField(wireName: r'favoriteCount')
  int? get favoriteCount;

  @BuiltValueField(wireName: r'isFavorited')
  bool? get isFavorited;

  @BuiltValueField(wireName: r'isWatching')
  bool? get isWatching;

  @BuiltValueField(wireName: r'comments')
  MwCommentList? get comments;

  @BuiltValueField(wireName: r'rights')
  MwEntryRights? get rights;

  MwEntry._();

  factory MwEntry([void updates(MwEntryBuilder b)]) = _$MwEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MwEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MwEntry> get serializer => _$MwEntrySerializer();
}

class _$MwEntrySerializer implements PrimitiveSerializer<MwEntry> {
  @override
  final Iterable<Type> types = const [MwEntry, _$MwEntry];

  @override
  final String wireName = r'MwEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MwEntry object, {
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
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(MwUser),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(double),
      );
    }
    if (object.rating != null) {
      yield r'rating';
      yield serializers.serialize(
        object.rating,
        specifiedType: const FullType(MwRating),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.cutTitle != null) {
      yield r'cutTitle';
      yield serializers.serialize(
        object.cutTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
    if (object.cutContent != null) {
      yield r'cutContent';
      yield serializers.serialize(
        object.cutContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.editContent != null) {
      yield r'editContent';
      yield serializers.serialize(
        object.editContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.hasCut != null) {
      yield r'hasCut';
      yield serializers.serialize(
        object.hasCut,
        specifiedType: const FullType(bool),
      );
    }
    if (object.images != null) {
      yield r'images';
      yield serializers.serialize(
        object.images,
        specifiedType: const FullType(BuiltList, [FullType(MwImage)]),
      );
    }
    if (object.insertedImages != null) {
      yield r'insertedImages';
      yield serializers.serialize(
        object.insertedImages,
        specifiedType: const FullType(BuiltList, [FullType(MwImage)]),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.wordCount != null) {
      yield r'wordCount';
      yield serializers.serialize(
        object.wordCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.privacy != null) {
      yield r'privacy';
      yield serializers.serialize(
        object.privacy,
        specifiedType: const FullType(MwEntryPrivacyEnum),
      );
    }
    if (object.visibleFor != null) {
      yield r'visibleFor';
      yield serializers.serialize(
        object.visibleFor,
        specifiedType: const FullType(BuiltList, [FullType(MwUser)]),
      );
    }
    if (object.isCommentable != null) {
      yield r'isCommentable';
      yield serializers.serialize(
        object.isCommentable,
        specifiedType: const FullType(bool),
      );
    }
    if (object.inLive != null) {
      yield r'inLive';
      yield serializers.serialize(
        object.inLive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isAnonymous != null) {
      yield r'isAnonymous';
      yield serializers.serialize(
        object.isAnonymous,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isShared != null) {
      yield r'isShared';
      yield serializers.serialize(
        object.isShared,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isPinned != null) {
      yield r'isPinned';
      yield serializers.serialize(
        object.isPinned,
        specifiedType: const FullType(bool),
      );
    }
    if (object.commentCount != null) {
      yield r'commentCount';
      yield serializers.serialize(
        object.commentCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.favoriteCount != null) {
      yield r'favoriteCount';
      yield serializers.serialize(
        object.favoriteCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.isFavorited != null) {
      yield r'isFavorited';
      yield serializers.serialize(
        object.isFavorited,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isWatching != null) {
      yield r'isWatching';
      yield serializers.serialize(
        object.isWatching,
        specifiedType: const FullType(bool),
      );
    }
    if (object.comments != null) {
      yield r'comments';
      yield serializers.serialize(
        object.comments,
        specifiedType: const FullType(MwCommentList),
      );
    }
    if (object.rights != null) {
      yield r'rights';
      yield serializers.serialize(
        object.rights,
        specifiedType: const FullType(MwEntryRights),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MwEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MwEntryBuilder result,
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
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwUser),
          ) as MwUser;
          result.user = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.createdAt = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwRating),
          ) as MwRating;
          result.rating.replace(valueDes);
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'cutTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cutTitle = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'cutContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cutContent = valueDes;
          break;
        case r'editContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.editContent = valueDes;
          break;
        case r'hasCut':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasCut = valueDes;
          break;
        case r'images':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwImage)]),
          ) as BuiltList<MwImage>;
          result.images.replace(valueDes);
          break;
        case r'insertedImages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwImage)]),
          ) as BuiltList<MwImage>;
          result.insertedImages.replace(valueDes);
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'wordCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wordCount = valueDes;
          break;
        case r'privacy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwEntryPrivacyEnum),
          ) as MwEntryPrivacyEnum;
          result.privacy = valueDes;
          break;
        case r'visibleFor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MwUser)]),
          ) as BuiltList<MwUser>;
          result.visibleFor.replace(valueDes);
          break;
        case r'isCommentable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCommentable = valueDes;
          break;
        case r'inLive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.inLive = valueDes;
          break;
        case r'isAnonymous':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isAnonymous = valueDes;
          break;
        case r'isShared':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isShared = valueDes;
          break;
        case r'isPinned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPinned = valueDes;
          break;
        case r'commentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.commentCount = valueDes;
          break;
        case r'favoriteCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.favoriteCount = valueDes;
          break;
        case r'isFavorited':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFavorited = valueDes;
          break;
        case r'isWatching':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isWatching = valueDes;
          break;
        case r'comments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwCommentList),
          ) as MwCommentList;
          result.comments.replace(valueDes);
          break;
        case r'rights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MwEntryRights),
          ) as MwEntryRights;
          result.rights.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MwEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MwEntryBuilder();
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

class MwEntryPrivacyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'all')
  static const MwEntryPrivacyEnum all = _$mwEntryPrivacyEnum_all;
  @BuiltValueEnumConst(wireName: r'registered')
  static const MwEntryPrivacyEnum registered = _$mwEntryPrivacyEnum_registered;
  @BuiltValueEnumConst(wireName: r'invited')
  static const MwEntryPrivacyEnum invited = _$mwEntryPrivacyEnum_invited;
  @BuiltValueEnumConst(wireName: r'followers')
  static const MwEntryPrivacyEnum followers = _$mwEntryPrivacyEnum_followers;
  @BuiltValueEnumConst(wireName: r'some')
  static const MwEntryPrivacyEnum some = _$mwEntryPrivacyEnum_some;
  @BuiltValueEnumConst(wireName: r'me')
  static const MwEntryPrivacyEnum me = _$mwEntryPrivacyEnum_me;

  static Serializer<MwEntryPrivacyEnum> get serializer => _$mwEntryPrivacyEnumSerializer;

  const MwEntryPrivacyEnum._(String name): super(name);

  static BuiltSet<MwEntryPrivacyEnum> get values => _$mwEntryPrivacyEnumValues;
  static MwEntryPrivacyEnum valueOf(String name) => _$mwEntryPrivacyEnumValueOf(name);
}

