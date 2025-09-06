// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_rating.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwRating extends MwRating {
  @override
  final int? id;
  @override
  final bool? isVotable;
  @override
  final int? upCount;
  @override
  final int? downCount;
  @override
  final double? rating;
  @override
  final int? vote;

  factory _$MwRating([void Function(MwRatingBuilder)? updates]) =>
      (MwRatingBuilder()..update(updates))._build();

  _$MwRating._(
      {this.id,
      this.isVotable,
      this.upCount,
      this.downCount,
      this.rating,
      this.vote})
      : super._();
  @override
  MwRating rebuild(void Function(MwRatingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwRatingBuilder toBuilder() => MwRatingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwRating &&
        id == other.id &&
        isVotable == other.isVotable &&
        upCount == other.upCount &&
        downCount == other.downCount &&
        rating == other.rating &&
        vote == other.vote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isVotable.hashCode);
    _$hash = $jc(_$hash, upCount.hashCode);
    _$hash = $jc(_$hash, downCount.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, vote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwRating')
          ..add('id', id)
          ..add('isVotable', isVotable)
          ..add('upCount', upCount)
          ..add('downCount', downCount)
          ..add('rating', rating)
          ..add('vote', vote))
        .toString();
  }
}

class MwRatingBuilder implements Builder<MwRating, MwRatingBuilder> {
  _$MwRating? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _isVotable;
  bool? get isVotable => _$this._isVotable;
  set isVotable(bool? isVotable) => _$this._isVotable = isVotable;

  int? _upCount;
  int? get upCount => _$this._upCount;
  set upCount(int? upCount) => _$this._upCount = upCount;

  int? _downCount;
  int? get downCount => _$this._downCount;
  set downCount(int? downCount) => _$this._downCount = downCount;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  int? _vote;
  int? get vote => _$this._vote;
  set vote(int? vote) => _$this._vote = vote;

  MwRatingBuilder() {
    MwRating._defaults(this);
  }

  MwRatingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _isVotable = $v.isVotable;
      _upCount = $v.upCount;
      _downCount = $v.downCount;
      _rating = $v.rating;
      _vote = $v.vote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwRating other) {
    _$v = other as _$MwRating;
  }

  @override
  void update(void Function(MwRatingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwRating build() => _build();

  _$MwRating _build() {
    final _$result = _$v ??
        _$MwRating._(
          id: id,
          isVotable: isVotable,
          upCount: upCount,
          downCount: downCount,
          rating: rating,
          vote: vote,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
