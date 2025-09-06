// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwEntryPrivacyEnum _$mwEntryPrivacyEnum_all =
    const MwEntryPrivacyEnum._('all');
const MwEntryPrivacyEnum _$mwEntryPrivacyEnum_registered =
    const MwEntryPrivacyEnum._('registered');
const MwEntryPrivacyEnum _$mwEntryPrivacyEnum_invited =
    const MwEntryPrivacyEnum._('invited');
const MwEntryPrivacyEnum _$mwEntryPrivacyEnum_followers =
    const MwEntryPrivacyEnum._('followers');
const MwEntryPrivacyEnum _$mwEntryPrivacyEnum_some =
    const MwEntryPrivacyEnum._('some');
const MwEntryPrivacyEnum _$mwEntryPrivacyEnum_me =
    const MwEntryPrivacyEnum._('me');

MwEntryPrivacyEnum _$mwEntryPrivacyEnumValueOf(String name) {
  switch (name) {
    case 'all':
      return _$mwEntryPrivacyEnum_all;
    case 'registered':
      return _$mwEntryPrivacyEnum_registered;
    case 'invited':
      return _$mwEntryPrivacyEnum_invited;
    case 'followers':
      return _$mwEntryPrivacyEnum_followers;
    case 'some':
      return _$mwEntryPrivacyEnum_some;
    case 'me':
      return _$mwEntryPrivacyEnum_me;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwEntryPrivacyEnum> _$mwEntryPrivacyEnumValues =
    BuiltSet<MwEntryPrivacyEnum>(const <MwEntryPrivacyEnum>[
  _$mwEntryPrivacyEnum_all,
  _$mwEntryPrivacyEnum_registered,
  _$mwEntryPrivacyEnum_invited,
  _$mwEntryPrivacyEnum_followers,
  _$mwEntryPrivacyEnum_some,
  _$mwEntryPrivacyEnum_me,
]);

Serializer<MwEntryPrivacyEnum> _$mwEntryPrivacyEnumSerializer =
    _$MwEntryPrivacyEnumSerializer();

class _$MwEntryPrivacyEnumSerializer
    implements PrimitiveSerializer<MwEntryPrivacyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'all': 'all',
    'registered': 'registered',
    'invited': 'invited',
    'followers': 'followers',
    'some': 'some',
    'me': 'me',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'all': 'all',
    'registered': 'registered',
    'invited': 'invited',
    'followers': 'followers',
    'some': 'some',
    'me': 'me',
  };

  @override
  final Iterable<Type> types = const <Type>[MwEntryPrivacyEnum];
  @override
  final String wireName = 'MwEntryPrivacyEnum';

  @override
  Object serialize(Serializers serializers, MwEntryPrivacyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwEntryPrivacyEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwEntryPrivacyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwEntry extends MwEntry {
  @override
  final int? id;
  @override
  final MwUser? author;
  @override
  final MwUser? user;
  @override
  final double? createdAt;
  @override
  final MwRating? rating;
  @override
  final String? title;
  @override
  final String? cutTitle;
  @override
  final String? content;
  @override
  final String? cutContent;
  @override
  final String? editContent;
  @override
  final bool? hasCut;
  @override
  final BuiltList<MwImage>? images;
  @override
  final BuiltList<MwImage>? insertedImages;
  @override
  final BuiltList<String>? tags;
  @override
  final int? wordCount;
  @override
  final MwEntryPrivacyEnum? privacy;
  @override
  final BuiltList<MwUser>? visibleFor;
  @override
  final bool? isCommentable;
  @override
  final bool? inLive;
  @override
  final bool? isAnonymous;
  @override
  final bool? isShared;
  @override
  final bool? isPinned;
  @override
  final int? commentCount;
  @override
  final int? favoriteCount;
  @override
  final bool? isFavorited;
  @override
  final bool? isWatching;
  @override
  final MwCommentList? comments;
  @override
  final MwEntryRights? rights;

  factory _$MwEntry([void Function(MwEntryBuilder)? updates]) =>
      (MwEntryBuilder()..update(updates))._build();

  _$MwEntry._(
      {this.id,
      this.author,
      this.user,
      this.createdAt,
      this.rating,
      this.title,
      this.cutTitle,
      this.content,
      this.cutContent,
      this.editContent,
      this.hasCut,
      this.images,
      this.insertedImages,
      this.tags,
      this.wordCount,
      this.privacy,
      this.visibleFor,
      this.isCommentable,
      this.inLive,
      this.isAnonymous,
      this.isShared,
      this.isPinned,
      this.commentCount,
      this.favoriteCount,
      this.isFavorited,
      this.isWatching,
      this.comments,
      this.rights})
      : super._();
  @override
  MwEntry rebuild(void Function(MwEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwEntryBuilder toBuilder() => MwEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwEntry &&
        id == other.id &&
        author == other.author &&
        user == other.user &&
        createdAt == other.createdAt &&
        rating == other.rating &&
        title == other.title &&
        cutTitle == other.cutTitle &&
        content == other.content &&
        cutContent == other.cutContent &&
        editContent == other.editContent &&
        hasCut == other.hasCut &&
        images == other.images &&
        insertedImages == other.insertedImages &&
        tags == other.tags &&
        wordCount == other.wordCount &&
        privacy == other.privacy &&
        visibleFor == other.visibleFor &&
        isCommentable == other.isCommentable &&
        inLive == other.inLive &&
        isAnonymous == other.isAnonymous &&
        isShared == other.isShared &&
        isPinned == other.isPinned &&
        commentCount == other.commentCount &&
        favoriteCount == other.favoriteCount &&
        isFavorited == other.isFavorited &&
        isWatching == other.isWatching &&
        comments == other.comments &&
        rights == other.rights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, cutTitle.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, cutContent.hashCode);
    _$hash = $jc(_$hash, editContent.hashCode);
    _$hash = $jc(_$hash, hasCut.hashCode);
    _$hash = $jc(_$hash, images.hashCode);
    _$hash = $jc(_$hash, insertedImages.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, wordCount.hashCode);
    _$hash = $jc(_$hash, privacy.hashCode);
    _$hash = $jc(_$hash, visibleFor.hashCode);
    _$hash = $jc(_$hash, isCommentable.hashCode);
    _$hash = $jc(_$hash, inLive.hashCode);
    _$hash = $jc(_$hash, isAnonymous.hashCode);
    _$hash = $jc(_$hash, isShared.hashCode);
    _$hash = $jc(_$hash, isPinned.hashCode);
    _$hash = $jc(_$hash, commentCount.hashCode);
    _$hash = $jc(_$hash, favoriteCount.hashCode);
    _$hash = $jc(_$hash, isFavorited.hashCode);
    _$hash = $jc(_$hash, isWatching.hashCode);
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, rights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwEntry')
          ..add('id', id)
          ..add('author', author)
          ..add('user', user)
          ..add('createdAt', createdAt)
          ..add('rating', rating)
          ..add('title', title)
          ..add('cutTitle', cutTitle)
          ..add('content', content)
          ..add('cutContent', cutContent)
          ..add('editContent', editContent)
          ..add('hasCut', hasCut)
          ..add('images', images)
          ..add('insertedImages', insertedImages)
          ..add('tags', tags)
          ..add('wordCount', wordCount)
          ..add('privacy', privacy)
          ..add('visibleFor', visibleFor)
          ..add('isCommentable', isCommentable)
          ..add('inLive', inLive)
          ..add('isAnonymous', isAnonymous)
          ..add('isShared', isShared)
          ..add('isPinned', isPinned)
          ..add('commentCount', commentCount)
          ..add('favoriteCount', favoriteCount)
          ..add('isFavorited', isFavorited)
          ..add('isWatching', isWatching)
          ..add('comments', comments)
          ..add('rights', rights))
        .toString();
  }
}

class MwEntryBuilder implements Builder<MwEntry, MwEntryBuilder> {
  _$MwEntry? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MwUser? _author;
  MwUser? get author => _$this._author;
  set author(MwUser? author) => _$this._author = author;

  MwUser? _user;
  MwUser? get user => _$this._user;
  set user(MwUser? user) => _$this._user = user;

  double? _createdAt;
  double? get createdAt => _$this._createdAt;
  set createdAt(double? createdAt) => _$this._createdAt = createdAt;

  MwRatingBuilder? _rating;
  MwRatingBuilder get rating => _$this._rating ??= MwRatingBuilder();
  set rating(MwRatingBuilder? rating) => _$this._rating = rating;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _cutTitle;
  String? get cutTitle => _$this._cutTitle;
  set cutTitle(String? cutTitle) => _$this._cutTitle = cutTitle;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _cutContent;
  String? get cutContent => _$this._cutContent;
  set cutContent(String? cutContent) => _$this._cutContent = cutContent;

  String? _editContent;
  String? get editContent => _$this._editContent;
  set editContent(String? editContent) => _$this._editContent = editContent;

  bool? _hasCut;
  bool? get hasCut => _$this._hasCut;
  set hasCut(bool? hasCut) => _$this._hasCut = hasCut;

  ListBuilder<MwImage>? _images;
  ListBuilder<MwImage> get images => _$this._images ??= ListBuilder<MwImage>();
  set images(ListBuilder<MwImage>? images) => _$this._images = images;

  ListBuilder<MwImage>? _insertedImages;
  ListBuilder<MwImage> get insertedImages =>
      _$this._insertedImages ??= ListBuilder<MwImage>();
  set insertedImages(ListBuilder<MwImage>? insertedImages) =>
      _$this._insertedImages = insertedImages;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  int? _wordCount;
  int? get wordCount => _$this._wordCount;
  set wordCount(int? wordCount) => _$this._wordCount = wordCount;

  MwEntryPrivacyEnum? _privacy;
  MwEntryPrivacyEnum? get privacy => _$this._privacy;
  set privacy(MwEntryPrivacyEnum? privacy) => _$this._privacy = privacy;

  ListBuilder<MwUser>? _visibleFor;
  ListBuilder<MwUser> get visibleFor =>
      _$this._visibleFor ??= ListBuilder<MwUser>();
  set visibleFor(ListBuilder<MwUser>? visibleFor) =>
      _$this._visibleFor = visibleFor;

  bool? _isCommentable;
  bool? get isCommentable => _$this._isCommentable;
  set isCommentable(bool? isCommentable) =>
      _$this._isCommentable = isCommentable;

  bool? _inLive;
  bool? get inLive => _$this._inLive;
  set inLive(bool? inLive) => _$this._inLive = inLive;

  bool? _isAnonymous;
  bool? get isAnonymous => _$this._isAnonymous;
  set isAnonymous(bool? isAnonymous) => _$this._isAnonymous = isAnonymous;

  bool? _isShared;
  bool? get isShared => _$this._isShared;
  set isShared(bool? isShared) => _$this._isShared = isShared;

  bool? _isPinned;
  bool? get isPinned => _$this._isPinned;
  set isPinned(bool? isPinned) => _$this._isPinned = isPinned;

  int? _commentCount;
  int? get commentCount => _$this._commentCount;
  set commentCount(int? commentCount) => _$this._commentCount = commentCount;

  int? _favoriteCount;
  int? get favoriteCount => _$this._favoriteCount;
  set favoriteCount(int? favoriteCount) =>
      _$this._favoriteCount = favoriteCount;

  bool? _isFavorited;
  bool? get isFavorited => _$this._isFavorited;
  set isFavorited(bool? isFavorited) => _$this._isFavorited = isFavorited;

  bool? _isWatching;
  bool? get isWatching => _$this._isWatching;
  set isWatching(bool? isWatching) => _$this._isWatching = isWatching;

  MwCommentListBuilder? _comments;
  MwCommentListBuilder get comments =>
      _$this._comments ??= MwCommentListBuilder();
  set comments(MwCommentListBuilder? comments) => _$this._comments = comments;

  MwEntryRightsBuilder? _rights;
  MwEntryRightsBuilder get rights => _$this._rights ??= MwEntryRightsBuilder();
  set rights(MwEntryRightsBuilder? rights) => _$this._rights = rights;

  MwEntryBuilder() {
    MwEntry._defaults(this);
  }

  MwEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _author = $v.author;
      _user = $v.user;
      _createdAt = $v.createdAt;
      _rating = $v.rating?.toBuilder();
      _title = $v.title;
      _cutTitle = $v.cutTitle;
      _content = $v.content;
      _cutContent = $v.cutContent;
      _editContent = $v.editContent;
      _hasCut = $v.hasCut;
      _images = $v.images?.toBuilder();
      _insertedImages = $v.insertedImages?.toBuilder();
      _tags = $v.tags?.toBuilder();
      _wordCount = $v.wordCount;
      _privacy = $v.privacy;
      _visibleFor = $v.visibleFor?.toBuilder();
      _isCommentable = $v.isCommentable;
      _inLive = $v.inLive;
      _isAnonymous = $v.isAnonymous;
      _isShared = $v.isShared;
      _isPinned = $v.isPinned;
      _commentCount = $v.commentCount;
      _favoriteCount = $v.favoriteCount;
      _isFavorited = $v.isFavorited;
      _isWatching = $v.isWatching;
      _comments = $v.comments?.toBuilder();
      _rights = $v.rights?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwEntry other) {
    _$v = other as _$MwEntry;
  }

  @override
  void update(void Function(MwEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwEntry build() => _build();

  _$MwEntry _build() {
    _$MwEntry _$result;
    try {
      _$result = _$v ??
          _$MwEntry._(
            id: id,
            author: author,
            user: user,
            createdAt: createdAt,
            rating: _rating?.build(),
            title: title,
            cutTitle: cutTitle,
            content: content,
            cutContent: cutContent,
            editContent: editContent,
            hasCut: hasCut,
            images: _images?.build(),
            insertedImages: _insertedImages?.build(),
            tags: _tags?.build(),
            wordCount: wordCount,
            privacy: privacy,
            visibleFor: _visibleFor?.build(),
            isCommentable: isCommentable,
            inLive: inLive,
            isAnonymous: isAnonymous,
            isShared: isShared,
            isPinned: isPinned,
            commentCount: commentCount,
            favoriteCount: favoriteCount,
            isFavorited: isFavorited,
            isWatching: isWatching,
            comments: _comments?.build(),
            rights: _rights?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rating';
        _rating?.build();

        _$failedField = 'images';
        _images?.build();
        _$failedField = 'insertedImages';
        _insertedImages?.build();
        _$failedField = 'tags';
        _tags?.build();

        _$failedField = 'visibleFor';
        _visibleFor?.build();

        _$failedField = 'comments';
        _comments?.build();
        _$failedField = 'rights';
        _rights?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
