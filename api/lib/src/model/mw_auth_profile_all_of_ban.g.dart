// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_auth_profile_all_of_ban.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAuthProfileAllOfBan extends MwAuthProfileAllOfBan {
  @override
  final double? invite;
  @override
  final double? vote;
  @override
  final double? comment;
  @override
  final double? live;

  factory _$MwAuthProfileAllOfBan(
          [void Function(MwAuthProfileAllOfBanBuilder)? updates]) =>
      (MwAuthProfileAllOfBanBuilder()..update(updates))._build();

  _$MwAuthProfileAllOfBan._({this.invite, this.vote, this.comment, this.live})
      : super._();
  @override
  MwAuthProfileAllOfBan rebuild(
          void Function(MwAuthProfileAllOfBanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAuthProfileAllOfBanBuilder toBuilder() =>
      MwAuthProfileAllOfBanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAuthProfileAllOfBan &&
        invite == other.invite &&
        vote == other.vote &&
        comment == other.comment &&
        live == other.live;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, invite.hashCode);
    _$hash = $jc(_$hash, vote.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, live.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAuthProfileAllOfBan')
          ..add('invite', invite)
          ..add('vote', vote)
          ..add('comment', comment)
          ..add('live', live))
        .toString();
  }
}

class MwAuthProfileAllOfBanBuilder
    implements Builder<MwAuthProfileAllOfBan, MwAuthProfileAllOfBanBuilder> {
  _$MwAuthProfileAllOfBan? _$v;

  double? _invite;
  double? get invite => _$this._invite;
  set invite(double? invite) => _$this._invite = invite;

  double? _vote;
  double? get vote => _$this._vote;
  set vote(double? vote) => _$this._vote = vote;

  double? _comment;
  double? get comment => _$this._comment;
  set comment(double? comment) => _$this._comment = comment;

  double? _live;
  double? get live => _$this._live;
  set live(double? live) => _$this._live = live;

  MwAuthProfileAllOfBanBuilder() {
    MwAuthProfileAllOfBan._defaults(this);
  }

  MwAuthProfileAllOfBanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invite = $v.invite;
      _vote = $v.vote;
      _comment = $v.comment;
      _live = $v.live;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAuthProfileAllOfBan other) {
    _$v = other as _$MwAuthProfileAllOfBan;
  }

  @override
  void update(void Function(MwAuthProfileAllOfBanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAuthProfileAllOfBan build() => _build();

  _$MwAuthProfileAllOfBan _build() {
    final _$result = _$v ??
        _$MwAuthProfileAllOfBan._(
          invite: invite,
          vote: vote,
          comment: comment,
          live: live,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
