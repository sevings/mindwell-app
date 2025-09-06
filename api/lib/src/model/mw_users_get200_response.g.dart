// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_users_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwUsersGet200Response extends MwUsersGet200Response {
  @override
  final String? top;
  @override
  final String? query;
  @override
  final BuiltList<MwFriend>? users;

  factory _$MwUsersGet200Response(
          [void Function(MwUsersGet200ResponseBuilder)? updates]) =>
      (MwUsersGet200ResponseBuilder()..update(updates))._build();

  _$MwUsersGet200Response._({this.top, this.query, this.users}) : super._();
  @override
  MwUsersGet200Response rebuild(
          void Function(MwUsersGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwUsersGet200ResponseBuilder toBuilder() =>
      MwUsersGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwUsersGet200Response &&
        top == other.top &&
        query == other.query &&
        users == other.users;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, top.hashCode);
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwUsersGet200Response')
          ..add('top', top)
          ..add('query', query)
          ..add('users', users))
        .toString();
  }
}

class MwUsersGet200ResponseBuilder
    implements Builder<MwUsersGet200Response, MwUsersGet200ResponseBuilder> {
  _$MwUsersGet200Response? _$v;

  String? _top;
  String? get top => _$this._top;
  set top(String? top) => _$this._top = top;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  ListBuilder<MwFriend>? _users;
  ListBuilder<MwFriend> get users => _$this._users ??= ListBuilder<MwFriend>();
  set users(ListBuilder<MwFriend>? users) => _$this._users = users;

  MwUsersGet200ResponseBuilder() {
    MwUsersGet200Response._defaults(this);
  }

  MwUsersGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _top = $v.top;
      _query = $v.query;
      _users = $v.users?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwUsersGet200Response other) {
    _$v = other as _$MwUsersGet200Response;
  }

  @override
  void update(void Function(MwUsersGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwUsersGet200Response build() => _build();

  _$MwUsersGet200Response _build() {
    _$MwUsersGet200Response _$result;
    try {
      _$result = _$v ??
          _$MwUsersGet200Response._(
            top: top,
            query: query,
            users: _users?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        _users?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwUsersGet200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
