// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntryImpl _$$EntryImplFromJson(Map<String, dynamic> json) => _$EntryImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      commentsCount: (json['commentsCount'] as num).toInt(),
      votesCount: (json['votesCount'] as num).toInt(),
      isVoted: json['isVoted'] as bool,
      isBookmarked: json['isBookmarked'] as bool,
      isInDiary: json['isInDiary'] as bool,
      imageUrl: json['imageUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isWatching: json['is_watching'] as bool?,
      canComment: json['can_comment'] as bool?,
      canVote: json['can_vote'] as bool?,
      voteWeight: (json['vote_weight'] as num?)?.toInt(),
      privacy: json['privacy'] as String?,
      cutPos: (json['cut_pos'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EntryImplToJson(_$EntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'author': instance.author,
      'commentsCount': instance.commentsCount,
      'votesCount': instance.votesCount,
      'isVoted': instance.isVoted,
      'isBookmarked': instance.isBookmarked,
      'isInDiary': instance.isInDiary,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'is_watching': instance.isWatching,
      'can_comment': instance.canComment,
      'can_vote': instance.canVote,
      'vote_weight': instance.voteWeight,
      'privacy': instance.privacy,
      'cut_pos': instance.cutPos,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      showName: json['showName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool?,
      gender: json['gender'] as String?,
      isFollowed: json['is_followed'] as bool?,
      isIgnored: json['is_ignored'] as bool?,
      isPrivate: json['is_private'] as bool?,
      relation: json['relation'] as String?,
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'showName': instance.showName,
      'avatarUrl': instance.avatarUrl,
      'isOnline': instance.isOnline,
      'gender': instance.gender,
      'is_followed': instance.isFollowed,
      'is_ignored': instance.isIgnored,
      'is_private': instance.isPrivate,
      'relation': instance.relation,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
    };

_$FeedSettingsImpl _$$FeedSettingsImplFromJson(Map<String, dynamic> json) =>
    _$FeedSettingsImpl(
      entriesPerPage: (json['entriesPerPage'] as num?)?.toInt() ?? 20,
      loadFrom: (json['loadFrom'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$LoadSourceEnumMap, e))
              .toSet() ??
          const {LoadSource.diaries, LoadSource.themes},
      displayFormat:
          $enumDecodeNullable(_$DisplayFormatEnumMap, json['displayFormat']) ??
              DisplayFormat.short,
      sortBy:
          $enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ?? SortBy.newest,
    );

Map<String, dynamic> _$$FeedSettingsImplToJson(_$FeedSettingsImpl instance) =>
    <String, dynamic>{
      'entriesPerPage': instance.entriesPerPage,
      'loadFrom':
          instance.loadFrom.map((e) => _$LoadSourceEnumMap[e]!).toList(),
      'displayFormat': _$DisplayFormatEnumMap[instance.displayFormat]!,
      'sortBy': _$SortByEnumMap[instance.sortBy]!,
    };

const _$LoadSourceEnumMap = {
  LoadSource.diaries: 'diaries',
  LoadSource.themes: 'themes',
};

const _$DisplayFormatEnumMap = {
  DisplayFormat.short: 'short',
  DisplayFormat.full: 'full',
};

const _$SortByEnumMap = {
  SortBy.newest: 'newest',
  SortBy.oldest: 'oldest',
  SortBy.best: 'best',
};
