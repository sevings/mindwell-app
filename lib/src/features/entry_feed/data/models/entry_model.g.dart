// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntryModelImpl _$$EntryModelImplFromJson(Map<String, dynamic> json) =>
    _$EntryModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      commentsCount: (json['comments_count'] as num).toInt(),
      votesCount: (json['votes_count'] as num).toInt(),
      isVoted: json['is_voted'] as bool,
      isBookmarked: json['is_bookmarked'] as bool,
      isInDiary: json['is_in_diary'] as bool,
      imageUrl: json['image_url'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isWatching: json['is_watching'] as bool?,
      canComment: json['can_comment'] as bool?,
      canVote: json['can_vote'] as bool?,
      voteWeight: (json['vote_weight'] as num?)?.toInt(),
      privacy: json['privacy'] as String?,
      cutPos: (json['cut_pos'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EntryModelImplToJson(_$EntryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'author': instance.author,
      'comments_count': instance.commentsCount,
      'votes_count': instance.votesCount,
      'is_voted': instance.isVoted,
      'is_bookmarked': instance.isBookmarked,
      'is_in_diary': instance.isInDiary,
      'image_url': instance.imageUrl,
      'tags': instance.tags,
      'is_watching': instance.isWatching,
      'can_comment': instance.canComment,
      'can_vote': instance.canVote,
      'vote_weight': instance.voteWeight,
      'privacy': instance.privacy,
      'cut_pos': instance.cutPos,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      showName: json['show_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      isOnline: json['is_online'] as bool?,
      gender: json['gender'] as String?,
      isFollowed: json['is_followed'] as bool?,
      isIgnored: json['is_ignored'] as bool?,
      isPrivate: json['is_private'] as bool?,
      relation: json['relation'] as String?,
      lastSeenAt: json['last_seen_at'] == null
          ? null
          : DateTime.parse(json['last_seen_at'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'show_name': instance.showName,
      'avatar_url': instance.avatarUrl,
      'is_online': instance.isOnline,
      'gender': instance.gender,
      'is_followed': instance.isFollowed,
      'is_ignored': instance.isIgnored,
      'is_private': instance.isPrivate,
      'relation': instance.relation,
      'last_seen_at': instance.lastSeenAt?.toIso8601String(),
    };

_$FeedResponseImpl _$$FeedResponseImplFromJson(Map<String, dynamic> json) =>
    _$FeedResponseImpl(
      entries: (json['entries'] as List<dynamic>)
          .map((e) => EntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['total_count'] as num?)?.toInt(),
      hasMore: json['has_more'] as bool?,
      nextPage: (json['next_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FeedResponseImplToJson(_$FeedResponseImpl instance) =>
    <String, dynamic>{
      'entries': instance.entries,
      'total_count': instance.totalCount,
      'has_more': instance.hasMore,
      'next_page': instance.nextPage,
    };
