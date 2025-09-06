// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwMessage extends MwMessage {
  @override
  final int? id;
  @override
  final int? chatId;
  @override
  final MwUser? author;
  @override
  final double? createdAt;
  @override
  final bool? read;
  @override
  final String? content;
  @override
  final String? editContent;
  @override
  final MwMessageRights? rights;

  factory _$MwMessage([void Function(MwMessageBuilder)? updates]) =>
      (MwMessageBuilder()..update(updates))._build();

  _$MwMessage._(
      {this.id,
      this.chatId,
      this.author,
      this.createdAt,
      this.read,
      this.content,
      this.editContent,
      this.rights})
      : super._();
  @override
  MwMessage rebuild(void Function(MwMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwMessageBuilder toBuilder() => MwMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwMessage &&
        id == other.id &&
        chatId == other.chatId &&
        author == other.author &&
        createdAt == other.createdAt &&
        read == other.read &&
        content == other.content &&
        editContent == other.editContent &&
        rights == other.rights;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, chatId.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, editContent.hashCode);
    _$hash = $jc(_$hash, rights.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwMessage')
          ..add('id', id)
          ..add('chatId', chatId)
          ..add('author', author)
          ..add('createdAt', createdAt)
          ..add('read', read)
          ..add('content', content)
          ..add('editContent', editContent)
          ..add('rights', rights))
        .toString();
  }
}

class MwMessageBuilder implements Builder<MwMessage, MwMessageBuilder> {
  _$MwMessage? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _chatId;
  int? get chatId => _$this._chatId;
  set chatId(int? chatId) => _$this._chatId = chatId;

  MwUser? _author;
  MwUser? get author => _$this._author;
  set author(MwUser? author) => _$this._author = author;

  double? _createdAt;
  double? get createdAt => _$this._createdAt;
  set createdAt(double? createdAt) => _$this._createdAt = createdAt;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _editContent;
  String? get editContent => _$this._editContent;
  set editContent(String? editContent) => _$this._editContent = editContent;

  MwMessageRightsBuilder? _rights;
  MwMessageRightsBuilder get rights =>
      _$this._rights ??= MwMessageRightsBuilder();
  set rights(MwMessageRightsBuilder? rights) => _$this._rights = rights;

  MwMessageBuilder() {
    MwMessage._defaults(this);
  }

  MwMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _chatId = $v.chatId;
      _author = $v.author;
      _createdAt = $v.createdAt;
      _read = $v.read;
      _content = $v.content;
      _editContent = $v.editContent;
      _rights = $v.rights?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwMessage other) {
    _$v = other as _$MwMessage;
  }

  @override
  void update(void Function(MwMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwMessage build() => _build();

  _$MwMessage _build() {
    _$MwMessage _$result;
    try {
      _$result = _$v ??
          _$MwMessage._(
            id: id,
            chatId: chatId,
            author: author,
            createdAt: createdAt,
            read: read,
            content: content,
            editContent: editContent,
            rights: _rights?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rights';
        _rights?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwMessage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
