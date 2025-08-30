// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_comment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwComment extends MwComment {
  @override
  final int? id;
  @override
  final MwUser? author;
  @override
  final int? entryId;
  @override
  final double? createdAt;
  @override
  final String? content;
  @override
  final String? editContent;
  @override
  final MwRating? rating;
  @override
  final MwCommentRights? rights;

  factory _$MwComment([void Function(MwCommentBuilder)? updates]) =>
      (new MwCommentBuilder()..update(updates))._build();

  _$MwComment._(
      {this.id,
      this.author,
      this.entryId,
      this.createdAt,
      this.content,
      this.editContent,
      this.rating,
      this.rights})
      : super._();

  @override
  MwComment rebuild(void Function(MwCommentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwCommentBuilder toBuilder() => new MwCommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwComment &&
        id == other.id &&
        author == other.author &&
        entryId == other.entryId &&
        createdAt == other.createdAt &&
        content == other.content &&
        editContent == other.editContent &&
        rating == other.rating &&
        rights == other.rights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, entryId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, editContent.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, rights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwComment')
          ..add('id', id)
          ..add('author', author)
          ..add('entryId', entryId)
          ..add('createdAt', createdAt)
          ..add('content', content)
          ..add('editContent', editContent)
          ..add('rating', rating)
          ..add('rights', rights))
        .toString();
  }
}

class MwCommentBuilder implements Builder<MwComment, MwCommentBuilder> {
  _$MwComment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MwUser? _author;
  MwUser? get author => _$this._author;
  set author(MwUser? author) => _$this._author = author;

  int? _entryId;
  int? get entryId => _$this._entryId;
  set entryId(int? entryId) => _$this._entryId = entryId;

  double? _createdAt;
  double? get createdAt => _$this._createdAt;
  set createdAt(double? createdAt) => _$this._createdAt = createdAt;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _editContent;
  String? get editContent => _$this._editContent;
  set editContent(String? editContent) => _$this._editContent = editContent;

  MwRatingBuilder? _rating;
  MwRatingBuilder get rating => _$this._rating ??= new MwRatingBuilder();
  set rating(MwRatingBuilder? rating) => _$this._rating = rating;

  MwCommentRightsBuilder? _rights;
  MwCommentRightsBuilder get rights =>
      _$this._rights ??= new MwCommentRightsBuilder();
  set rights(MwCommentRightsBuilder? rights) => _$this._rights = rights;

  MwCommentBuilder() {
    MwComment._defaults(this);
  }

  MwCommentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _author = $v.author;
      _entryId = $v.entryId;
      _createdAt = $v.createdAt;
      _content = $v.content;
      _editContent = $v.editContent;
      _rating = $v.rating?.toBuilder();
      _rights = $v.rights?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwComment other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwComment;
  }

  @override
  void update(void Function(MwCommentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwComment build() => _build();

  _$MwComment _build() {
    _$MwComment _$result;
    try {
      _$result = _$v ??
          new _$MwComment._(
              id: id,
              author: author,
              entryId: entryId,
              createdAt: createdAt,
              content: content,
              editContent: editContent,
              rating: _rating?.build(),
              rights: _rights?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rating';
        _rating?.build();
        _$failedField = 'rights';
        _rights?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwComment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
