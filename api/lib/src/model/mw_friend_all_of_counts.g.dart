// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_friend_all_of_counts.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwFriendAllOfCounts extends MwFriendAllOfCounts {
  @override
  final int? entries;
  @override
  final int? followings;
  @override
  final int? followers;
  @override
  final int? ignored;
  @override
  final int? invited;
  @override
  final int? comments;
  @override
  final int? favorites;
  @override
  final int? tags;
  @override
  final int? days;
  @override
  final int? badges;

  factory _$MwFriendAllOfCounts(
          [void Function(MwFriendAllOfCountsBuilder)? updates]) =>
      (MwFriendAllOfCountsBuilder()..update(updates))._build();

  _$MwFriendAllOfCounts._(
      {this.entries,
      this.followings,
      this.followers,
      this.ignored,
      this.invited,
      this.comments,
      this.favorites,
      this.tags,
      this.days,
      this.badges})
      : super._();
  @override
  MwFriendAllOfCounts rebuild(
          void Function(MwFriendAllOfCountsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwFriendAllOfCountsBuilder toBuilder() =>
      MwFriendAllOfCountsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwFriendAllOfCounts &&
        entries == other.entries &&
        followings == other.followings &&
        followers == other.followers &&
        ignored == other.ignored &&
        invited == other.invited &&
        comments == other.comments &&
        favorites == other.favorites &&
        tags == other.tags &&
        days == other.days &&
        badges == other.badges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, entries.hashCode);
    _$hash = $jc(_$hash, followings.hashCode);
    _$hash = $jc(_$hash, followers.hashCode);
    _$hash = $jc(_$hash, ignored.hashCode);
    _$hash = $jc(_$hash, invited.hashCode);
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, favorites.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jc(_$hash, badges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwFriendAllOfCounts')
          ..add('entries', entries)
          ..add('followings', followings)
          ..add('followers', followers)
          ..add('ignored', ignored)
          ..add('invited', invited)
          ..add('comments', comments)
          ..add('favorites', favorites)
          ..add('tags', tags)
          ..add('days', days)
          ..add('badges', badges))
        .toString();
  }
}

class MwFriendAllOfCountsBuilder
    implements Builder<MwFriendAllOfCounts, MwFriendAllOfCountsBuilder> {
  _$MwFriendAllOfCounts? _$v;

  int? _entries;
  int? get entries => _$this._entries;
  set entries(int? entries) => _$this._entries = entries;

  int? _followings;
  int? get followings => _$this._followings;
  set followings(int? followings) => _$this._followings = followings;

  int? _followers;
  int? get followers => _$this._followers;
  set followers(int? followers) => _$this._followers = followers;

  int? _ignored;
  int? get ignored => _$this._ignored;
  set ignored(int? ignored) => _$this._ignored = ignored;

  int? _invited;
  int? get invited => _$this._invited;
  set invited(int? invited) => _$this._invited = invited;

  int? _comments;
  int? get comments => _$this._comments;
  set comments(int? comments) => _$this._comments = comments;

  int? _favorites;
  int? get favorites => _$this._favorites;
  set favorites(int? favorites) => _$this._favorites = favorites;

  int? _tags;
  int? get tags => _$this._tags;
  set tags(int? tags) => _$this._tags = tags;

  int? _days;
  int? get days => _$this._days;
  set days(int? days) => _$this._days = days;

  int? _badges;
  int? get badges => _$this._badges;
  set badges(int? badges) => _$this._badges = badges;

  MwFriendAllOfCountsBuilder() {
    MwFriendAllOfCounts._defaults(this);
  }

  MwFriendAllOfCountsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entries = $v.entries;
      _followings = $v.followings;
      _followers = $v.followers;
      _ignored = $v.ignored;
      _invited = $v.invited;
      _comments = $v.comments;
      _favorites = $v.favorites;
      _tags = $v.tags;
      _days = $v.days;
      _badges = $v.badges;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwFriendAllOfCounts other) {
    _$v = other as _$MwFriendAllOfCounts;
  }

  @override
  void update(void Function(MwFriendAllOfCountsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwFriendAllOfCounts build() => _build();

  _$MwFriendAllOfCounts _build() {
    final _$result = _$v ??
        _$MwFriendAllOfCounts._(
          entries: entries,
          followings: followings,
          followers: followers,
          ignored: ignored,
          invited: invited,
          comments: comments,
          favorites: favorites,
          tags: tags,
          days: days,
          badges: badges,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
