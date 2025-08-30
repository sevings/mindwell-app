// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_user_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwUserIDAuthorityEnum _$mwUserIDAuthorityEnum_user =
    const MwUserIDAuthorityEnum._('user');
const MwUserIDAuthorityEnum _$mwUserIDAuthorityEnum_admin =
    const MwUserIDAuthorityEnum._('admin');
const MwUserIDAuthorityEnum _$mwUserIDAuthorityEnum_moderator =
    const MwUserIDAuthorityEnum._('moderator');

MwUserIDAuthorityEnum _$mwUserIDAuthorityEnumValueOf(String name) {
  switch (name) {
    case 'user':
      return _$mwUserIDAuthorityEnum_user;
    case 'admin':
      return _$mwUserIDAuthorityEnum_admin;
    case 'moderator':
      return _$mwUserIDAuthorityEnum_moderator;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwUserIDAuthorityEnum> _$mwUserIDAuthorityEnumValues =
    new BuiltSet<MwUserIDAuthorityEnum>(const <MwUserIDAuthorityEnum>[
  _$mwUserIDAuthorityEnum_user,
  _$mwUserIDAuthorityEnum_admin,
  _$mwUserIDAuthorityEnum_moderator,
]);

Serializer<MwUserIDAuthorityEnum> _$mwUserIDAuthorityEnumSerializer =
    new _$MwUserIDAuthorityEnumSerializer();

class _$MwUserIDAuthorityEnumSerializer
    implements PrimitiveSerializer<MwUserIDAuthorityEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'user': 'user',
    'admin': 'admin',
    'moderator': 'moderator',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user': 'user',
    'admin': 'admin',
    'moderator': 'moderator',
  };

  @override
  final Iterable<Type> types = const <Type>[MwUserIDAuthorityEnum];
  @override
  final String wireName = 'MwUserIDAuthorityEnum';

  @override
  Object serialize(Serializers serializers, MwUserIDAuthorityEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwUserIDAuthorityEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwUserIDAuthorityEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwUserID extends MwUserID {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final bool? negKarma;
  @override
  final int? followersCount;
  @override
  final bool? isInvited;
  @override
  final bool? verified;
  @override
  final MwUserIDAuthorityEnum? authority;
  @override
  final MwUserIDBan? ban;

  factory _$MwUserID([void Function(MwUserIDBuilder)? updates]) =>
      (new MwUserIDBuilder()..update(updates))._build();

  _$MwUserID._(
      {this.id,
      this.name,
      this.negKarma,
      this.followersCount,
      this.isInvited,
      this.verified,
      this.authority,
      this.ban})
      : super._();

  @override
  MwUserID rebuild(void Function(MwUserIDBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwUserIDBuilder toBuilder() => new MwUserIDBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwUserID &&
        id == other.id &&
        name == other.name &&
        negKarma == other.negKarma &&
        followersCount == other.followersCount &&
        isInvited == other.isInvited &&
        verified == other.verified &&
        authority == other.authority &&
        ban == other.ban;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, negKarma.hashCode);
    _$hash = $jc(_$hash, followersCount.hashCode);
    _$hash = $jc(_$hash, isInvited.hashCode);
    _$hash = $jc(_$hash, verified.hashCode);
    _$hash = $jc(_$hash, authority.hashCode);
    _$hash = $jc(_$hash, ban.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwUserID')
          ..add('id', id)
          ..add('name', name)
          ..add('negKarma', negKarma)
          ..add('followersCount', followersCount)
          ..add('isInvited', isInvited)
          ..add('verified', verified)
          ..add('authority', authority)
          ..add('ban', ban))
        .toString();
  }
}

class MwUserIDBuilder implements Builder<MwUserID, MwUserIDBuilder> {
  _$MwUserID? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _negKarma;
  bool? get negKarma => _$this._negKarma;
  set negKarma(bool? negKarma) => _$this._negKarma = negKarma;

  int? _followersCount;
  int? get followersCount => _$this._followersCount;
  set followersCount(int? followersCount) =>
      _$this._followersCount = followersCount;

  bool? _isInvited;
  bool? get isInvited => _$this._isInvited;
  set isInvited(bool? isInvited) => _$this._isInvited = isInvited;

  bool? _verified;
  bool? get verified => _$this._verified;
  set verified(bool? verified) => _$this._verified = verified;

  MwUserIDAuthorityEnum? _authority;
  MwUserIDAuthorityEnum? get authority => _$this._authority;
  set authority(MwUserIDAuthorityEnum? authority) =>
      _$this._authority = authority;

  MwUserIDBanBuilder? _ban;
  MwUserIDBanBuilder get ban => _$this._ban ??= new MwUserIDBanBuilder();
  set ban(MwUserIDBanBuilder? ban) => _$this._ban = ban;

  MwUserIDBuilder() {
    MwUserID._defaults(this);
  }

  MwUserIDBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _negKarma = $v.negKarma;
      _followersCount = $v.followersCount;
      _isInvited = $v.isInvited;
      _verified = $v.verified;
      _authority = $v.authority;
      _ban = $v.ban?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwUserID other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwUserID;
  }

  @override
  void update(void Function(MwUserIDBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwUserID build() => _build();

  _$MwUserID _build() {
    _$MwUserID _$result;
    try {
      _$result = _$v ??
          new _$MwUserID._(
              id: id,
              name: name,
              negKarma: negKarma,
              followersCount: followersCount,
              isInvited: isInvited,
              verified: verified,
              authority: authority,
              ban: _ban?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ban';
        _ban?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwUserID', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
