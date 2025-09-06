// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class MwUserBuilder {
  void replace(MwUser other);
  void update(void Function(MwUserBuilder) updates);
  int? get id;
  set id(int? id);

  String? get name;
  set name(String? name);

  String? get showName;
  set showName(String? showName);

  bool? get isTheme;
  set isTheme(bool? isTheme);

  bool? get isOnline;
  set isOnline(bool? isOnline);

  MwAvatarBuilder get avatar;
  set avatar(MwAvatarBuilder? avatar);
}

class _$$MwUser extends $MwUser {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? showName;
  @override
  final bool? isTheme;
  @override
  final bool? isOnline;
  @override
  final MwAvatar? avatar;

  factory _$$MwUser([void Function($MwUserBuilder)? updates]) =>
      ($MwUserBuilder()..update(updates))._build();

  _$$MwUser._(
      {this.id,
      this.name,
      this.showName,
      this.isTheme,
      this.isOnline,
      this.avatar})
      : super._();
  @override
  $MwUser rebuild(void Function($MwUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $MwUserBuilder toBuilder() => $MwUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $MwUser &&
        id == other.id &&
        name == other.name &&
        showName == other.showName &&
        isTheme == other.isTheme &&
        isOnline == other.isOnline &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, showName.hashCode);
    _$hash = $jc(_$hash, isTheme.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$MwUser')
          ..add('id', id)
          ..add('name', name)
          ..add('showName', showName)
          ..add('isTheme', isTheme)
          ..add('isOnline', isOnline)
          ..add('avatar', avatar))
        .toString();
  }
}

class $MwUserBuilder
    implements Builder<$MwUser, $MwUserBuilder>, MwUserBuilder {
  _$$MwUser? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(covariant int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _showName;
  String? get showName => _$this._showName;
  set showName(covariant String? showName) => _$this._showName = showName;

  bool? _isTheme;
  bool? get isTheme => _$this._isTheme;
  set isTheme(covariant bool? isTheme) => _$this._isTheme = isTheme;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(covariant bool? isOnline) => _$this._isOnline = isOnline;

  MwAvatarBuilder? _avatar;
  MwAvatarBuilder get avatar => _$this._avatar ??= MwAvatarBuilder();
  set avatar(covariant MwAvatarBuilder? avatar) => _$this._avatar = avatar;

  $MwUserBuilder() {
    $MwUser._defaults(this);
  }

  $MwUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _showName = $v.showName;
      _isTheme = $v.isTheme;
      _isOnline = $v.isOnline;
      _avatar = $v.avatar?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $MwUser other) {
    _$v = other as _$$MwUser;
  }

  @override
  void update(void Function($MwUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $MwUser build() => _build();

  _$$MwUser _build() {
    _$$MwUser _$result;
    try {
      _$result = _$v ??
          _$$MwUser._(
            id: id,
            name: name,
            showName: showName,
            isTheme: isTheme,
            isOnline: isOnline,
            avatar: _avatar?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'$MwUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
