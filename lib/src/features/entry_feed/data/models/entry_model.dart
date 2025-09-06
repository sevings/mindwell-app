import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/entry.dart';

part 'entry_model.freezed.dart';
part 'entry_model.g.dart';

@freezed
class EntryModel with _$EntryModel {
  const factory EntryModel({
    required int id,
    required String title,
    required String content,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    required UserModel author,
    @JsonKey(name: 'comments_count') required int commentsCount,
    @JsonKey(name: 'votes_count') required int votesCount,
    @JsonKey(name: 'is_voted') required bool isVoted,
    @JsonKey(name: 'is_bookmarked') required bool isBookmarked,
    @JsonKey(name: 'is_in_diary') required bool isInDiary,
    @JsonKey(name: 'image_url') String? imageUrl,
    List<String>? tags,
    @JsonKey(name: 'is_watching') bool? isWatching,
    @JsonKey(name: 'can_comment') bool? canComment,
    @JsonKey(name: 'can_vote') bool? canVote,
    @JsonKey(name: 'vote_weight') int? voteWeight,
    String? privacy,
    @JsonKey(name: 'cut_pos') int? cutPos,
  }) = _EntryModel;

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  const EntryModel._();

  /// Converts this model to a domain entity
  Entry toDomain() {
    return Entry(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      author: author.toDomain(),
      commentsCount: commentsCount,
      votesCount: votesCount,
      isVoted: isVoted,
      isBookmarked: isBookmarked,
      isInDiary: isInDiary,
      imageUrl: imageUrl,
      tags: tags,
      isWatching: isWatching,
      canComment: canComment,
      canVote: canVote,
      voteWeight: voteWeight,
      privacy: privacy,
      cutPos: cutPos,
    );
  }

  /// Creates a model from a domain entity
  factory EntryModel.fromDomain(Entry entry) {
    return EntryModel(
      id: entry.id,
      title: entry.title,
      content: entry.content,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      author: UserModel.fromDomain(entry.author),
      commentsCount: entry.commentsCount,
      votesCount: entry.votesCount,
      isVoted: entry.isVoted,
      isBookmarked: entry.isBookmarked,
      isInDiary: entry.isInDiary,
      imageUrl: entry.imageUrl,
      tags: entry.tags,
      isWatching: entry.isWatching,
      canComment: entry.canComment,
      canVote: entry.canVote,
      voteWeight: entry.voteWeight,
      privacy: entry.privacy,
      cutPos: entry.cutPos,
    );
  }
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    @JsonKey(name: 'show_name') required String showName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'is_online') bool? isOnline,
    String? gender,
    @JsonKey(name: 'is_followed') bool? isFollowed,
    @JsonKey(name: 'is_ignored') bool? isIgnored,
    @JsonKey(name: 'is_private') bool? isPrivate,
    String? relation,
    @JsonKey(name: 'last_seen_at') DateTime? lastSeenAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  /// Converts this model to a domain entity
  User toDomain() {
    return User(
      id: id,
      name: name,
      showName: showName,
      avatarUrl: avatarUrl,
      isOnline: isOnline,
      gender: gender,
      isFollowed: isFollowed,
      isIgnored: isIgnored,
      isPrivate: isPrivate,
      relation: relation,
      lastSeenAt: lastSeenAt,
    );
  }

  /// Creates a model from a domain entity
  factory UserModel.fromDomain(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      showName: user.showName,
      avatarUrl: user.avatarUrl,
      isOnline: user.isOnline,
      gender: user.gender,
      isFollowed: user.isFollowed,
      isIgnored: user.isIgnored,
      isPrivate: user.isPrivate,
      relation: user.relation,
      lastSeenAt: user.lastSeenAt,
    );
  }
}

@freezed
class FeedResponse with _$FeedResponse {
  const factory FeedResponse({
    required List<EntryModel> entries,
    @JsonKey(name: 'total_count') int? totalCount,
    @JsonKey(name: 'has_more') bool? hasMore,
    @JsonKey(name: 'next_page') int? nextPage,
  }) = _FeedResponse;

  factory FeedResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedResponseFromJson(json);

  const FeedResponse._();

  /// Converts this response to domain entities
  List<Entry> toDomain() {
    return entries.map((model) => model.toDomain()).toList();
  }
}