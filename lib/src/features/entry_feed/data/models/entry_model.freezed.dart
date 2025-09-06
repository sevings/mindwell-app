// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) {
  return _EntryModel.fromJson(json);
}

/// @nodoc
mixin _$EntryModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  UserModel get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'votes_count')
  int get votesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_voted')
  bool get isVoted => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_bookmarked')
  bool get isBookmarked => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_in_diary')
  bool get isInDiary => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
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
  $EntryModelCopyWith<EntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryModelCopyWith<$Res> {
  factory $EntryModelCopyWith(
          EntryModel value, $Res Function(EntryModel) then) =
      _$EntryModelCopyWithImpl<$Res, EntryModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      UserModel author,
      @JsonKey(name: 'comments_count') int commentsCount,
      @JsonKey(name: 'votes_count') int votesCount,
      @JsonKey(name: 'is_voted') bool isVoted,
      @JsonKey(name: 'is_bookmarked') bool isBookmarked,
      @JsonKey(name: 'is_in_diary') bool isInDiary,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<String>? tags,
      @JsonKey(name: 'is_watching') bool? isWatching,
      @JsonKey(name: 'can_comment') bool? canComment,
      @JsonKey(name: 'can_vote') bool? canVote,
      @JsonKey(name: 'vote_weight') int? voteWeight,
      String? privacy,
      @JsonKey(name: 'cut_pos') int? cutPos});

  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$EntryModelCopyWithImpl<$Res, $Val extends EntryModel>
    implements $EntryModelCopyWith<$Res> {
  _$EntryModelCopyWithImpl(this._value, this._then);

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
              as UserModel,
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
  $UserModelCopyWith<$Res> get author {
    return $UserModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EntryModelImplCopyWith<$Res>
    implements $EntryModelCopyWith<$Res> {
  factory _$$EntryModelImplCopyWith(
          _$EntryModelImpl value, $Res Function(_$EntryModelImpl) then) =
      __$$EntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      UserModel author,
      @JsonKey(name: 'comments_count') int commentsCount,
      @JsonKey(name: 'votes_count') int votesCount,
      @JsonKey(name: 'is_voted') bool isVoted,
      @JsonKey(name: 'is_bookmarked') bool isBookmarked,
      @JsonKey(name: 'is_in_diary') bool isInDiary,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<String>? tags,
      @JsonKey(name: 'is_watching') bool? isWatching,
      @JsonKey(name: 'can_comment') bool? canComment,
      @JsonKey(name: 'can_vote') bool? canVote,
      @JsonKey(name: 'vote_weight') int? voteWeight,
      String? privacy,
      @JsonKey(name: 'cut_pos') int? cutPos});

  @override
  $UserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$$EntryModelImplCopyWithImpl<$Res>
    extends _$EntryModelCopyWithImpl<$Res, _$EntryModelImpl>
    implements _$$EntryModelImplCopyWith<$Res> {
  __$$EntryModelImplCopyWithImpl(
      _$EntryModelImpl _value, $Res Function(_$EntryModelImpl) _then)
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
    return _then(_$EntryModelImpl(
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
              as UserModel,
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
class _$EntryModelImpl extends _EntryModel {
  const _$EntryModelImpl(
      {required this.id,
      required this.title,
      required this.content,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      required this.author,
      @JsonKey(name: 'comments_count') required this.commentsCount,
      @JsonKey(name: 'votes_count') required this.votesCount,
      @JsonKey(name: 'is_voted') required this.isVoted,
      @JsonKey(name: 'is_bookmarked') required this.isBookmarked,
      @JsonKey(name: 'is_in_diary') required this.isInDiary,
      @JsonKey(name: 'image_url') this.imageUrl,
      final List<String>? tags,
      @JsonKey(name: 'is_watching') this.isWatching,
      @JsonKey(name: 'can_comment') this.canComment,
      @JsonKey(name: 'can_vote') this.canVote,
      @JsonKey(name: 'vote_weight') this.voteWeight,
      this.privacy,
      @JsonKey(name: 'cut_pos') this.cutPos})
      : _tags = tags,
        super._();

  factory _$EntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  final UserModel author;
  @override
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @override
  @JsonKey(name: 'votes_count')
  final int votesCount;
  @override
  @JsonKey(name: 'is_voted')
  final bool isVoted;
  @override
  @JsonKey(name: 'is_bookmarked')
  final bool isBookmarked;
  @override
  @JsonKey(name: 'is_in_diary')
  final bool isInDiary;
  @override
  @JsonKey(name: 'image_url')
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
    return 'EntryModel(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, author: $author, commentsCount: $commentsCount, votesCount: $votesCount, isVoted: $isVoted, isBookmarked: $isBookmarked, isInDiary: $isInDiary, imageUrl: $imageUrl, tags: $tags, isWatching: $isWatching, canComment: $canComment, canVote: $canVote, voteWeight: $voteWeight, privacy: $privacy, cutPos: $cutPos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryModelImpl &&
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
  _$$EntryModelImplCopyWith<_$EntryModelImpl> get copyWith =>
      __$$EntryModelImplCopyWithImpl<_$EntryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryModelImplToJson(
      this,
    );
  }
}

abstract class _EntryModel extends EntryModel {
  const factory _EntryModel(
      {required final int id,
      required final String title,
      required final String content,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      required final UserModel author,
      @JsonKey(name: 'comments_count') required final int commentsCount,
      @JsonKey(name: 'votes_count') required final int votesCount,
      @JsonKey(name: 'is_voted') required final bool isVoted,
      @JsonKey(name: 'is_bookmarked') required final bool isBookmarked,
      @JsonKey(name: 'is_in_diary') required final bool isInDiary,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final List<String>? tags,
      @JsonKey(name: 'is_watching') final bool? isWatching,
      @JsonKey(name: 'can_comment') final bool? canComment,
      @JsonKey(name: 'can_vote') final bool? canVote,
      @JsonKey(name: 'vote_weight') final int? voteWeight,
      final String? privacy,
      @JsonKey(name: 'cut_pos') final int? cutPos}) = _$EntryModelImpl;
  const _EntryModel._() : super._();

  factory _EntryModel.fromJson(Map<String, dynamic> json) =
      _$EntryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  UserModel get author;
  @override
  @JsonKey(name: 'comments_count')
  int get commentsCount;
  @override
  @JsonKey(name: 'votes_count')
  int get votesCount;
  @override
  @JsonKey(name: 'is_voted')
  bool get isVoted;
  @override
  @JsonKey(name: 'is_bookmarked')
  bool get isBookmarked;
  @override
  @JsonKey(name: 'is_in_diary')
  bool get isInDiary;
  @override
  @JsonKey(name: 'image_url')
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
  _$$EntryModelImplCopyWith<_$EntryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_name')
  String get showName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool? get isOnline => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_followed')
  bool? get isFollowed => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_ignored')
  bool? get isIgnored => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_private')
  bool? get isPrivate => throw _privateConstructorUsedError;
  String? get relation => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_seen_at')
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'show_name') String showName,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'is_online') bool? isOnline,
      String? gender,
      @JsonKey(name: 'is_followed') bool? isFollowed,
      @JsonKey(name: 'is_ignored') bool? isIgnored,
      @JsonKey(name: 'is_private') bool? isPrivate,
      String? relation,
      @JsonKey(name: 'last_seen_at') DateTime? lastSeenAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

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
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'show_name') String showName,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'is_online') bool? isOnline,
      String? gender,
      @JsonKey(name: 'is_followed') bool? isFollowed,
      @JsonKey(name: 'is_ignored') bool? isIgnored,
      @JsonKey(name: 'is_private') bool? isPrivate,
      String? relation,
      @JsonKey(name: 'last_seen_at') DateTime? lastSeenAt});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
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
    return _then(_$UserModelImpl(
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
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'show_name') required this.showName,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'is_online') this.isOnline,
      this.gender,
      @JsonKey(name: 'is_followed') this.isFollowed,
      @JsonKey(name: 'is_ignored') this.isIgnored,
      @JsonKey(name: 'is_private') this.isPrivate,
      this.relation,
      @JsonKey(name: 'last_seen_at') this.lastSeenAt})
      : super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'show_name')
  final String showName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'is_online')
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
  @JsonKey(name: 'last_seen_at')
  final DateTime? lastSeenAt;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, showName: $showName, avatarUrl: $avatarUrl, isOnline: $isOnline, gender: $gender, isFollowed: $isFollowed, isIgnored: $isIgnored, isPrivate: $isPrivate, relation: $relation, lastSeenAt: $lastSeenAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
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
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
          {required final int id,
          required final String name,
          @JsonKey(name: 'show_name') required final String showName,
          @JsonKey(name: 'avatar_url') final String? avatarUrl,
          @JsonKey(name: 'is_online') final bool? isOnline,
          final String? gender,
          @JsonKey(name: 'is_followed') final bool? isFollowed,
          @JsonKey(name: 'is_ignored') final bool? isIgnored,
          @JsonKey(name: 'is_private') final bool? isPrivate,
          final String? relation,
          @JsonKey(name: 'last_seen_at') final DateTime? lastSeenAt}) =
      _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'show_name')
  String get showName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'is_online')
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
  @JsonKey(name: 'last_seen_at')
  DateTime? get lastSeenAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedResponse _$FeedResponseFromJson(Map<String, dynamic> json) {
  return _FeedResponse.fromJson(json);
}

/// @nodoc
mixin _$FeedResponse {
  List<EntryModel> get entries => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_count')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool? get hasMore => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page')
  int? get nextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedResponseCopyWith<FeedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedResponseCopyWith<$Res> {
  factory $FeedResponseCopyWith(
          FeedResponse value, $Res Function(FeedResponse) then) =
      _$FeedResponseCopyWithImpl<$Res, FeedResponse>;
  @useResult
  $Res call(
      {List<EntryModel> entries,
      @JsonKey(name: 'total_count') int? totalCount,
      @JsonKey(name: 'has_more') bool? hasMore,
      @JsonKey(name: 'next_page') int? nextPage});
}

/// @nodoc
class _$FeedResponseCopyWithImpl<$Res, $Val extends FeedResponse>
    implements $FeedResponseCopyWith<$Res> {
  _$FeedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? totalCount = freezed,
    Object? hasMore = freezed,
    Object? nextPage = freezed,
  }) {
    return _then(_value.copyWith(
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<EntryModel>,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMore: freezed == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool?,
      nextPage: freezed == nextPage
          ? _value.nextPage
          : nextPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedResponseImplCopyWith<$Res>
    implements $FeedResponseCopyWith<$Res> {
  factory _$$FeedResponseImplCopyWith(
          _$FeedResponseImpl value, $Res Function(_$FeedResponseImpl) then) =
      __$$FeedResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EntryModel> entries,
      @JsonKey(name: 'total_count') int? totalCount,
      @JsonKey(name: 'has_more') bool? hasMore,
      @JsonKey(name: 'next_page') int? nextPage});
}

/// @nodoc
class __$$FeedResponseImplCopyWithImpl<$Res>
    extends _$FeedResponseCopyWithImpl<$Res, _$FeedResponseImpl>
    implements _$$FeedResponseImplCopyWith<$Res> {
  __$$FeedResponseImplCopyWithImpl(
      _$FeedResponseImpl _value, $Res Function(_$FeedResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? totalCount = freezed,
    Object? hasMore = freezed,
    Object? nextPage = freezed,
  }) {
    return _then(_$FeedResponseImpl(
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<EntryModel>,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMore: freezed == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool?,
      nextPage: freezed == nextPage
          ? _value.nextPage
          : nextPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedResponseImpl extends _FeedResponse {
  const _$FeedResponseImpl(
      {required final List<EntryModel> entries,
      @JsonKey(name: 'total_count') this.totalCount,
      @JsonKey(name: 'has_more') this.hasMore,
      @JsonKey(name: 'next_page') this.nextPage})
      : _entries = entries,
        super._();

  factory _$FeedResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedResponseImplFromJson(json);

  final List<EntryModel> _entries;
  @override
  List<EntryModel> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey(name: 'total_count')
  final int? totalCount;
  @override
  @JsonKey(name: 'has_more')
  final bool? hasMore;
  @override
  @JsonKey(name: 'next_page')
  final int? nextPage;

  @override
  String toString() {
    return 'FeedResponse(entries: $entries, totalCount: $totalCount, hasMore: $hasMore, nextPage: $nextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedResponseImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.nextPage, nextPage) ||
                other.nextPage == nextPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entries),
      totalCount,
      hasMore,
      nextPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedResponseImplCopyWith<_$FeedResponseImpl> get copyWith =>
      __$$FeedResponseImplCopyWithImpl<_$FeedResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedResponseImplToJson(
      this,
    );
  }
}

abstract class _FeedResponse extends FeedResponse {
  const factory _FeedResponse(
      {required final List<EntryModel> entries,
      @JsonKey(name: 'total_count') final int? totalCount,
      @JsonKey(name: 'has_more') final bool? hasMore,
      @JsonKey(name: 'next_page') final int? nextPage}) = _$FeedResponseImpl;
  const _FeedResponse._() : super._();

  factory _FeedResponse.fromJson(Map<String, dynamic> json) =
      _$FeedResponseImpl.fromJson;

  @override
  List<EntryModel> get entries;
  @override
  @JsonKey(name: 'total_count')
  int? get totalCount;
  @override
  @JsonKey(name: 'has_more')
  bool? get hasMore;
  @override
  @JsonKey(name: 'next_page')
  int? get nextPage;
  @override
  @JsonKey(ignore: true)
  _$$FeedResponseImplCopyWith<_$FeedResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
