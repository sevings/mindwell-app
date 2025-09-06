import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

@freezed
class Entry with _$Entry {
  const factory Entry({
    required int id,
    required String title,
    required String content,
    required DateTime createdAt,
    DateTime? updatedAt,
    required User author,
    required int commentsCount,
    required int votesCount,
    required bool isVoted,
    required bool isBookmarked,
    required bool isInDiary,
    String? imageUrl,
    List<String>? tags,
    @JsonKey(name: 'is_watching') bool? isWatching,
    @JsonKey(name: 'can_comment') bool? canComment,
    @JsonKey(name: 'can_vote') bool? canVote,
    @JsonKey(name: 'vote_weight') int? voteWeight,
    String? privacy,
    @JsonKey(name: 'cut_pos') int? cutPos,
  }) = _Entry;

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String showName,
    String? avatarUrl,
    bool? isOnline,
    String? gender,
    @JsonKey(name: 'is_followed') bool? isFollowed,
    @JsonKey(name: 'is_ignored') bool? isIgnored,
    @JsonKey(name: 'is_private') bool? isPrivate,
    String? relation,
    DateTime? lastSeenAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

enum FeedType {
  live,
  best,
  followings,
  profile,
}

enum DisplayFormat {
  short,
  full,
}

enum SortBy {
  newest,
  oldest,
  best,
}

@freezed
class FeedSettings with _$FeedSettings {
  const factory FeedSettings({
    @Default(20) int entriesPerPage,
    @Default({LoadSource.diaries, LoadSource.themes}) Set<LoadSource> loadFrom,
    @Default(DisplayFormat.short) DisplayFormat displayFormat,
    @Default(SortBy.newest) SortBy sortBy,
  }) = _FeedSettings;

  factory FeedSettings.fromJson(Map<String, dynamic> json) => _$FeedSettingsFromJson(json);
}

enum LoadSource {
  diaries,
  themes,
}