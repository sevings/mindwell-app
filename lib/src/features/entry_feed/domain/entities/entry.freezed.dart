// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

/// @nodoc
mixin _$Entry {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  User get author => throw _privateConstructorUsedError;
  int get commentsCount => throw _privateConstructorUsedError;
  int get votesCount => throw _privateConstructorUsedError;
  bool get isVoted => throw _privateConstructorUsedError;
  bool get isBookmarked => throw _privateConstructorUsedError;
  bool get isInDiary => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_watching')
  bool? get isWatching => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_comment')
  bool? get canComment => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_vote')
  bool? get canVote => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_weight')
  int? get voteWeight => throw _privateConstructorUsedError;
  String? get privacy => throw _privateConstructorUsedError;
  @JsonKey(name: 'cut_pos')
  int? get cutPos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res, Entry>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      DateTime createdAt,
      DateTime? updatedAt,
      User author,
      int commentsCount,
      int votesCount,
      bool isVoted,
      bool isBookmarked,
      bool isInDiary,
      String? imageUrl,
      List<String>? tags,
      @JsonKey(name: 'is_watching') bool? isWatching,
      @JsonKey(name: 'can_comment') bool? canComment,
      @JsonKey(name: 'can_vote') bool? canVote,
      @JsonKey(name: 'vote_weight') int? voteWeight,
      String? privacy,
      @JsonKey(name: 'cut_pos') int? cutPos});

  $UserCopyWith<$Res> get author;
}

/// @nodoc
class _$EntryCopyWithImpl<$Res, $Val extends Entry>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? author = null,
    Object? commentsCount = null,
    Object? votesCount = null,
    Object? isVoted = null,
    Object? isBookmarked = null,
    Object? isInDiary = null,
    Object? imageUrl = freezed,
    Object? tags = freezed,
    Object? isWatching = freezed,
    Object? canComment = freezed,
    Object? canVote = freezed,
    Object? voteWeight = freezed,
    Object? privacy = freezed,
    Object? cutPos = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      votesCount: null == votesCount
          ? _value.votesCount
          : votesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isVoted: null == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      isInDiary: null == isInDiary
          ? _value.isInDiary
          : isInDiary // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isWatching: freezed == isWatching
          ? _value.isWatching
          : isWatching // ignore: cast_nullable_to_non_nullable
              as bool?,
      canComment: freezed == canComment
          ? _value.canComment
          : canComment // ignore: cast_nullable_to_non_nullable
              as bool?,
      canVote: freezed == canVote
          ? _value.canVote
          : canVote // ignore: cast_nullable_to_non_nullable
              as bool?,
      voteWeight: freezed == voteWeight
          ? _value.voteWeight
          : voteWeight // ignore: cast_nullable_to_non_nullable
              as int?,
      privacy: freezed == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      cutPos: freezed == cutPos
          ? _value.cutPos
          : cutPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get author {
    return $UserCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryImplCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$$EntryImplCopyWith(
          _$EntryImpl value, $Res Function(_$EntryImpl) then) =
      __$$EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      DateTime createdAt,
      DateTime? updatedAt,
      User author,
      int commentsCount,
      int votesCount,
      bool isVoted,
      bool isBookmarked,
      bool isInDiary,
      String? imageUrl,
      List<String>? tags,
      @JsonKey(name: 'is_watching') bool? isWatching,
      @JsonKey(name: 'can_comment') bool? canComment,
      @JsonKey(name: 'can_vote') bool? canVote,
      @JsonKey(name: 'vote_weight') int? voteWeight,
      String? privacy,
      @JsonKey(name: 'cut_pos') int? cutPos});

  @override
  $UserCopyWith<$Res> get author;
}

/// @nodoc
class __$$EntryImplCopyWithImpl<$Res>
    extends _$EntryCopyWithImpl<$Res, _$EntryImpl>
    implements _$$EntryImplCopyWith<$Res> {
  __$$EntryImplCopyWithImpl(
      _$EntryImpl _value, $Res Function(_$EntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? author = null,
    Object? commentsCount = null,
    Object? votesCount = null,
    Object? isVoted = null,
    Object? isBookmarked = null,
    Object? isInDiary = null,
    Object? imageUrl = freezed,
    Object? tags = freezed,
    Object? isWatching = freezed,
    Object? canComment = freezed,
    Object? canVote = freezed,
    Object? voteWeight = freezed,
    Object? privacy = freezed,
    Object? cutPos = freezed,
  }) {
    return _then(_$EntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      votesCount: null == votesCount
          ? _value.votesCount
          : votesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isVoted: null == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      isInDiary: null == isInDiary
          ? _value.isInDiary
          : isInDiary // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isWatching: freezed == isWatching
          ? _value.isWatching
          : isWatching // ignore: cast_nullable_to_non_nullable
              as bool?,
      canComment: freezed == canComment
          ? _value.canComment
          : canComment // ignore: cast_nullable_to_non_nullable
              as bool?,
      canVote: freezed == canVote
          ? _value.canVote
          : canVote // ignore: cast_nullable_to_non_nullable
              as bool?,
      voteWeight: freezed == voteWeight
          ? _value.voteWeight
          : voteWeight // ignore: cast_nullable_to_non_nullable
              as int?,
      privacy: freezed == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      cutPos: freezed == cutPos
          ? _value.cutPos
          : cutPos // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryImpl implements _Entry {
  const _$EntryImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      this.updatedAt,
      required this.author,
      required this.commentsCount,
      required this.votesCount,
      required this.isVoted,
      required this.isBookmarked,
      required this.isInDiary,
      this.imageUrl,
      final List<String>? tags,
      @JsonKey(name: 'is_watching') this.isWatching,
      @JsonKey(name: 'can_comment') this.canComment,
      @JsonKey(name: 'can_vote') this.canVote,
      @JsonKey(name: 'vote_weight') this.voteWeight,
      this.privacy,
      @JsonKey(name: 'cut_pos') this.cutPos})
      : _tags = tags;

  factory _$EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final User author;
  @override
  final int commentsCount;
  @override
  final int votesCount;
  @override
  final bool isVoted;
  @override
  final bool isBookmarked;
  @override
  final bool isInDiary;
  @override
  final String? imageUrl;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_watching')
  final bool? isWatching;
  @override
  @JsonKey(name: 'can_comment')
  final bool? canComment;
  @override
  @JsonKey(name: 'can_vote')
  final bool? canVote;
  @override
  @JsonKey(name: 'vote_weight')
  final int? voteWeight;
  @override
  final String? privacy;
  @override
  @JsonKey(name: 'cut_pos')
  final int? cutPos;

  @override
  String toString() {
    return 'Entry(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, author: $author, commentsCount: $commentsCount, votesCount: $votesCount, isVoted: $isVoted, isBookmarked: $isBookmarked, isInDiary: $isInDiary, imageUrl: $imageUrl, tags: $tags, isWatching: $isWatching, canComment: $canComment, canVote: $canVote, voteWeight: $voteWeight, privacy: $privacy, cutPos: $cutPos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.votesCount, votesCount) ||
                other.votesCount == votesCount) &&
            (identical(other.isVoted, isVoted) || other.isVoted == isVoted) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.isInDiary, isInDiary) ||
                other.isInDiary == isInDiary) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isWatching, isWatching) ||
                other.isWatching == isWatching) &&
            (identical(other.canComment, canComment) ||
                other.canComment == canComment) &&
            (identical(other.canVote, canVote) || other.canVote == canVote) &&
            (identical(other.voteWeight, voteWeight) ||
                other.voteWeight == voteWeight) &&
            (identical(other.privacy, privacy) || other.privacy == privacy) &&
            (identical(other.cutPos, cutPos) || other.cutPos == cutPos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        content,
        createdAt,
        updatedAt,
        author,
        commentsCount,
        votesCount,
        isVoted,
        isBookmarked,
        isInDiary,
        imageUrl,
        const DeepCollectionEquality().hash(_tags),
        isWatching,
        canComment,
        canVote,
        voteWeight,
        privacy,
        cutPos
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      __$$EntryImplCopyWithImpl<_$EntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryImplToJson(
      this,
    );
  }
}

abstract class _Entry implements Entry {
  const factory _Entry(
      {required final int id,
      required final String title,
      required final String content,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      required final User author,
      required final int commentsCount,
      required final int votesCount,
      required final bool isVoted,
      required final bool isBookmarked,
      required final bool isInDiary,
      final String? imageUrl,
      final List<String>? tags,
      @JsonKey(name: 'is_watching') final bool? isWatching,
      @JsonKey(name: 'can_comment') final bool? canComment,
      @JsonKey(name: 'can_vote') final bool? canVote,
      @JsonKey(name: 'vote_weight') final int? voteWeight,
      final String? privacy,
      @JsonKey(name: 'cut_pos') final int? cutPos}) = _$EntryImpl;

  factory _Entry.fromJson(Map<String, dynamic> json) = _$EntryImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  User get author;
  @override
  int get commentsCount;
  @override
  int get votesCount;
  @override
  bool get isVoted;
  @override
  bool get isBookmarked;
  @override
  bool get isInDiary;
  @override
  String? get imageUrl;
  @override
  List<String>? get tags;
  @override
  @JsonKey(name: 'is_watching')
  bool? get isWatching;
  @override
  @JsonKey(name: 'can_comment')
  bool? get canComment;
  @override
  @JsonKey(name: 'can_vote')
  bool? get canVote;
  @override
  @JsonKey(name: 'vote_weight')
  int? get voteWeight;
  @override
  String? get privacy;
  @override
  @JsonKey(name: 'cut_pos')
  int? get cutPos;
  @override
  @JsonKey(ignore: true)
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get showName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool? get isOnline => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_followed')
  bool? get isFollowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_ignored')
  bool? get isIgnored => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_private')
  bool? get isPrivate => throw _privateConstructorUsedError;
  String? get relation => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String name,
      String showName,
      String? avatarUrl,
      bool? isOnline,
      String? gender,
      @JsonKey(name: 'is_followed') bool? isFollowed,
      @JsonKey(name: 'is_ignored') bool? isIgnored,
      @JsonKey(name: 'is_private') bool? isPrivate,
      String? relation,
      DateTime? lastSeenAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? showName = null,
    Object? avatarUrl = freezed,
    Object? isOnline = freezed,
    Object? gender = freezed,
    Object? isFollowed = freezed,
    Object? isIgnored = freezed,
    Object? isPrivate = freezed,
    Object? relation = freezed,
    Object? lastSeenAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      showName: null == showName
          ? _value.showName
          : showName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: freezed == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollowed: freezed == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      isIgnored: freezed == isIgnored
          ? _value.isIgnored
          : isIgnored // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      relation: freezed == relation
          ? _value.relation
          : relation // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String showName,
      String? avatarUrl,
      bool? isOnline,
      String? gender,
      @JsonKey(name: 'is_followed') bool? isFollowed,
      @JsonKey(name: 'is_ignored') bool? isIgnored,
      @JsonKey(name: 'is_private') bool? isPrivate,
      String? relation,
      DateTime? lastSeenAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? showName = null,
    Object? avatarUrl = freezed,
    Object? isOnline = freezed,
    Object? gender = freezed,
    Object? isFollowed = freezed,
    Object? isIgnored = freezed,
    Object? isPrivate = freezed,
    Object? relation = freezed,
    Object? lastSeenAt = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      showName: null == showName
          ? _value.showName
          : showName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: freezed == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollowed: freezed == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      isIgnored: freezed == isIgnored
          ? _value.isIgnored
          : isIgnored // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      relation: freezed == relation
          ? _value.relation
          : relation // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.name,
      required this.showName,
      this.avatarUrl,
      this.isOnline,
      this.gender,
      @JsonKey(name: 'is_followed') this.isFollowed,
      @JsonKey(name: 'is_ignored') this.isIgnored,
      @JsonKey(name: 'is_private') this.isPrivate,
      this.relation,
      this.lastSeenAt});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String showName;
  @override
  final String? avatarUrl;
  @override
  final bool? isOnline;
  @override
  final String? gender;
  @override
  @JsonKey(name: 'is_followed')
  final bool? isFollowed;
  @override
  @JsonKey(name: 'is_ignored')
  final bool? isIgnored;
  @override
  @JsonKey(name: 'is_private')
  final bool? isPrivate;
  @override
  final String? relation;
  @override
  final DateTime? lastSeenAt;

  @override
  String toString() {
    return 'User(id: $id, name: $name, showName: $showName, avatarUrl: $avatarUrl, isOnline: $isOnline, gender: $gender, isFollowed: $isFollowed, isIgnored: $isIgnored, isPrivate: $isPrivate, relation: $relation, lastSeenAt: $lastSeenAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.showName, showName) ||
                other.showName == showName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.isFollowed, isFollowed) ||
                other.isFollowed == isFollowed) &&
            (identical(other.isIgnored, isIgnored) ||
                other.isIgnored == isIgnored) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.relation, relation) ||
                other.relation == relation) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, showName, avatarUrl,
      isOnline, gender, isFollowed, isIgnored, isPrivate, relation, lastSeenAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String name,
      required final String showName,
      final String? avatarUrl,
      final bool? isOnline,
      final String? gender,
      @JsonKey(name: 'is_followed') final bool? isFollowed,
      @JsonKey(name: 'is_ignored') final bool? isIgnored,
      @JsonKey(name: 'is_private') final bool? isPrivate,
      final String? relation,
      final DateTime? lastSeenAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get showName;
  @override
  String? get avatarUrl;
  @override
  bool? get isOnline;
  @override
  String? get gender;
  @override
  @JsonKey(name: 'is_followed')
  bool? get isFollowed;
  @override
  @JsonKey(name: 'is_ignored')
  bool? get isIgnored;
  @override
  @JsonKey(name: 'is_private')
  bool? get isPrivate;
  @override
  String? get relation;
  @override
  DateTime? get lastSeenAt;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedSettings _$FeedSettingsFromJson(Map<String, dynamic> json) {
  return _FeedSettings.fromJson(json);
}

/// @nodoc
mixin _$FeedSettings {
  int get entriesPerPage => throw _privateConstructorUsedError;
  Set<LoadSource> get loadFrom => throw _privateConstructorUsedError;
  DisplayFormat get displayFormat => throw _privateConstructorUsedError;
  SortBy get sortBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedSettingsCopyWith<FeedSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedSettingsCopyWith<$Res> {
  factory $FeedSettingsCopyWith(
          FeedSettings value, $Res Function(FeedSettings) then) =
      _$FeedSettingsCopyWithImpl<$Res, FeedSettings>;
  @useResult
  $Res call(
      {int entriesPerPage,
      Set<LoadSource> loadFrom,
      DisplayFormat displayFormat,
      SortBy sortBy});
}

/// @nodoc
class _$FeedSettingsCopyWithImpl<$Res, $Val extends FeedSettings>
    implements $FeedSettingsCopyWith<$Res> {
  _$FeedSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entriesPerPage = null,
    Object? loadFrom = null,
    Object? displayFormat = null,
    Object? sortBy = null,
  }) {
    return _then(_value.copyWith(
      entriesPerPage: null == entriesPerPage
          ? _value.entriesPerPage
          : entriesPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      loadFrom: null == loadFrom
          ? _value.loadFrom
          : loadFrom // ignore: cast_nullable_to_non_nullable
              as Set<LoadSource>,
      displayFormat: null == displayFormat
          ? _value.displayFormat
          : displayFormat // ignore: cast_nullable_to_non_nullable
              as DisplayFormat,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedSettingsImplCopyWith<$Res>
    implements $FeedSettingsCopyWith<$Res> {
  factory _$$FeedSettingsImplCopyWith(
          _$FeedSettingsImpl value, $Res Function(_$FeedSettingsImpl) then) =
      __$$FeedSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int entriesPerPage,
      Set<LoadSource> loadFrom,
      DisplayFormat displayFormat,
      SortBy sortBy});
}

/// @nodoc
class __$$FeedSettingsImplCopyWithImpl<$Res>
    extends _$FeedSettingsCopyWithImpl<$Res, _$FeedSettingsImpl>
    implements _$$FeedSettingsImplCopyWith<$Res> {
  __$$FeedSettingsImplCopyWithImpl(
      _$FeedSettingsImpl _value, $Res Function(_$FeedSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entriesPerPage = null,
    Object? loadFrom = null,
    Object? displayFormat = null,
    Object? sortBy = null,
  }) {
    return _then(_$FeedSettingsImpl(
      entriesPerPage: null == entriesPerPage
          ? _value.entriesPerPage
          : entriesPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      loadFrom: null == loadFrom
          ? _value._loadFrom
          : loadFrom // ignore: cast_nullable_to_non_nullable
              as Set<LoadSource>,
      displayFormat: null == displayFormat
          ? _value.displayFormat
          : displayFormat // ignore: cast_nullable_to_non_nullable
              as DisplayFormat,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedSettingsImpl implements _FeedSettings {
  const _$FeedSettingsImpl(
      {this.entriesPerPage = 20,
      final Set<LoadSource> loadFrom = const {
        LoadSource.diaries,
        LoadSource.themes
      },
      this.displayFormat = DisplayFormat.short,
      this.sortBy = SortBy.newest})
      : _loadFrom = loadFrom;

  factory _$FeedSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedSettingsImplFromJson(json);

  @override
  @JsonKey()
  final int entriesPerPage;
  final Set<LoadSource> _loadFrom;
  @override
  @JsonKey()
  Set<LoadSource> get loadFrom {
    if (_loadFrom is EqualUnmodifiableSetView) return _loadFrom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_loadFrom);
  }

  @override
  @JsonKey()
  final DisplayFormat displayFormat;
  @override
  @JsonKey()
  final SortBy sortBy;

  @override
  String toString() {
    return 'FeedSettings(entriesPerPage: $entriesPerPage, loadFrom: $loadFrom, displayFormat: $displayFormat, sortBy: $sortBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedSettingsImpl &&
            (identical(other.entriesPerPage, entriesPerPage) ||
                other.entriesPerPage == entriesPerPage) &&
            const DeepCollectionEquality().equals(other._loadFrom, _loadFrom) &&
            (identical(other.displayFormat, displayFormat) ||
                other.displayFormat == displayFormat) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, entriesPerPage,
      const DeepCollectionEquality().hash(_loadFrom), displayFormat, sortBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedSettingsImplCopyWith<_$FeedSettingsImpl> get copyWith =>
      __$$FeedSettingsImplCopyWithImpl<_$FeedSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedSettingsImplToJson(
      this,
    );
  }
}

abstract class _FeedSettings implements FeedSettings {
  const factory _FeedSettings(
      {final int entriesPerPage,
      final Set<LoadSource> loadFrom,
      final DisplayFormat displayFormat,
      final SortBy sortBy}) = _$FeedSettingsImpl;

  factory _FeedSettings.fromJson(Map<String, dynamic> json) =
      _$FeedSettingsImpl.fromJson;

  @override
  int get entriesPerPage;
  @override
  Set<LoadSource> get loadFrom;
  @override
  DisplayFormat get displayFormat;
  @override
  SortBy get sortBy;
  @override
  @JsonKey(ignore: true)
  _$$FeedSettingsImplCopyWith<_$FeedSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
