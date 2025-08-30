// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_user_id_ban.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwUserIDBan extends MwUserIDBan {
  @override
  final bool? account;
  @override
  final bool? shadow;
  @override
  final bool? invite;
  @override
  final bool? vote;
  @override
  final bool? comment;
  @override
  final bool? live;
  @override
  final bool? complain;

  factory _$MwUserIDBan([void Function(MwUserIDBanBuilder)? updates]) =>
      (new MwUserIDBanBuilder()..update(updates))._build();

  _$MwUserIDBan._(
      {this.account,
      this.shadow,
      this.invite,
      this.vote,
      this.comment,
      this.live,
      this.complain})
      : super._();

  @override
  MwUserIDBan rebuild(void Function(MwUserIDBanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwUserIDBanBuilder toBuilder() => new MwUserIDBanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwUserIDBan &&
        account == other.account &&
        shadow == other.shadow &&
        invite == other.invite &&
        vote == other.vote &&
        comment == other.comment &&
        live == other.live &&
        complain == other.complain;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, shadow.hashCode);
    _$hash = $jc(_$hash, invite.hashCode);
    _$hash = $jc(_$hash, vote.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, live.hashCode);
    _$hash = $jc(_$hash, complain.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwUserIDBan')
          ..add('account', account)
          ..add('shadow', shadow)
          ..add('invite', invite)
          ..add('vote', vote)
          ..add('comment', comment)
          ..add('live', live)
          ..add('complain', complain))
        .toString();
  }
}

class MwUserIDBanBuilder implements Builder<MwUserIDBan, MwUserIDBanBuilder> {
  _$MwUserIDBan? _$v;

  bool? _account;
  bool? get account => _$this._account;
  set account(bool? account) => _$this._account = account;

  bool? _shadow;
  bool? get shadow => _$this._shadow;
  set shadow(bool? shadow) => _$this._shadow = shadow;

  bool? _invite;
  bool? get invite => _$this._invite;
  set invite(bool? invite) => _$this._invite = invite;

  bool? _vote;
  bool? get vote => _$this._vote;
  set vote(bool? vote) => _$this._vote = vote;

  bool? _comment;
  bool? get comment => _$this._comment;
  set comment(bool? comment) => _$this._comment = comment;

  bool? _live;
  bool? get live => _$this._live;
  set live(bool? live) => _$this._live = live;

  bool? _complain;
  bool? get complain => _$this._complain;
  set complain(bool? complain) => _$this._complain = complain;

  MwUserIDBanBuilder() {
    MwUserIDBan._defaults(this);
  }

  MwUserIDBanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _account = $v.account;
      _shadow = $v.shadow;
      _invite = $v.invite;
      _vote = $v.vote;
      _comment = $v.comment;
      _live = $v.live;
      _complain = $v.complain;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwUserIDBan other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwUserIDBan;
  }

  @override
  void update(void Function(MwUserIDBanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwUserIDBan build() => _build();

  _$MwUserIDBan _build() {
    final _$result = _$v ??
        new _$MwUserIDBan._(
            account: account,
            shadow: shadow,
            invite: invite,
            vote: vote,
            comment: comment,
            live: live,
            complain: complain);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
