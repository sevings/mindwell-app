// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_chat_list.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwChatList extends MwChatList {
  @override
  final BuiltList<MwChat>? data;
  @override
  final int? unreadCount;
  @override
  final String? nextAfter;
  @override
  final bool? hasAfter;
  @override
  final String? nextBefore;
  @override
  final bool? hasBefore;

  factory _$MwChatList([void Function(MwChatListBuilder)? updates]) =>
      (MwChatListBuilder()..update(updates))._build();

  _$MwChatList._(
      {this.data,
      this.unreadCount,
      this.nextAfter,
      this.hasAfter,
      this.nextBefore,
      this.hasBefore})
      : super._();
  @override
  MwChatList rebuild(void Function(MwChatListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwChatListBuilder toBuilder() => MwChatListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwChatList &&
        data == other.data &&
        unreadCount == other.unreadCount &&
        nextAfter == other.nextAfter &&
        hasAfter == other.hasAfter &&
        nextBefore == other.nextBefore &&
        hasBefore == other.hasBefore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, nextAfter.hashCode);
    _$hash = $jc(_$hash, hasAfter.hashCode);
    _$hash = $jc(_$hash, nextBefore.hashCode);
    _$hash = $jc(_$hash, hasBefore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwChatList')
          ..add('data', data)
          ..add('unreadCount', unreadCount)
          ..add('nextAfter', nextAfter)
          ..add('hasAfter', hasAfter)
          ..add('nextBefore', nextBefore)
          ..add('hasBefore', hasBefore))
        .toString();
  }
}

class MwChatListBuilder implements Builder<MwChatList, MwChatListBuilder> {
  _$MwChatList? _$v;

  ListBuilder<MwChat>? _data;
  ListBuilder<MwChat> get data => _$this._data ??= ListBuilder<MwChat>();
  set data(ListBuilder<MwChat>? data) => _$this._data = data;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  String? _nextAfter;
  String? get nextAfter => _$this._nextAfter;
  set nextAfter(String? nextAfter) => _$this._nextAfter = nextAfter;

  bool? _hasAfter;
  bool? get hasAfter => _$this._hasAfter;
  set hasAfter(bool? hasAfter) => _$this._hasAfter = hasAfter;

  String? _nextBefore;
  String? get nextBefore => _$this._nextBefore;
  set nextBefore(String? nextBefore) => _$this._nextBefore = nextBefore;

  bool? _hasBefore;
  bool? get hasBefore => _$this._hasBefore;
  set hasBefore(bool? hasBefore) => _$this._hasBefore = hasBefore;

  MwChatListBuilder() {
    MwChatList._defaults(this);
  }

  MwChatListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _unreadCount = $v.unreadCount;
      _nextAfter = $v.nextAfter;
      _hasAfter = $v.hasAfter;
      _nextBefore = $v.nextBefore;
      _hasBefore = $v.hasBefore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwChatList other) {
    _$v = other as _$MwChatList;
  }

  @override
  void update(void Function(MwChatListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwChatList build() => _build();

  _$MwChatList _build() {
    _$MwChatList _$result;
    try {
      _$result = _$v ??
          _$MwChatList._(
            data: _data?.build(),
            unreadCount: unreadCount,
            nextAfter: nextAfter,
            hasAfter: hasAfter,
            nextBefore: nextBefore,
            hasBefore: hasBefore,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwChatList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
