// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_profile_all_of_relations.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwProfileAllOfRelationsToMeEnum
    _$mwProfileAllOfRelationsToMeEnum_followed =
    const MwProfileAllOfRelationsToMeEnum._('followed');
const MwProfileAllOfRelationsToMeEnum
    _$mwProfileAllOfRelationsToMeEnum_requested =
    const MwProfileAllOfRelationsToMeEnum._('requested');
const MwProfileAllOfRelationsToMeEnum
    _$mwProfileAllOfRelationsToMeEnum_ignored =
    const MwProfileAllOfRelationsToMeEnum._('ignored');
const MwProfileAllOfRelationsToMeEnum _$mwProfileAllOfRelationsToMeEnum_hidden =
    const MwProfileAllOfRelationsToMeEnum._('hidden');
const MwProfileAllOfRelationsToMeEnum _$mwProfileAllOfRelationsToMeEnum_none =
    const MwProfileAllOfRelationsToMeEnum._('none');

MwProfileAllOfRelationsToMeEnum _$mwProfileAllOfRelationsToMeEnumValueOf(
    String name) {
  switch (name) {
    case 'followed':
      return _$mwProfileAllOfRelationsToMeEnum_followed;
    case 'requested':
      return _$mwProfileAllOfRelationsToMeEnum_requested;
    case 'ignored':
      return _$mwProfileAllOfRelationsToMeEnum_ignored;
    case 'hidden':
      return _$mwProfileAllOfRelationsToMeEnum_hidden;
    case 'none':
      return _$mwProfileAllOfRelationsToMeEnum_none;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwProfileAllOfRelationsToMeEnum>
    _$mwProfileAllOfRelationsToMeEnumValues = BuiltSet<
        MwProfileAllOfRelationsToMeEnum>(const <MwProfileAllOfRelationsToMeEnum>[
  _$mwProfileAllOfRelationsToMeEnum_followed,
  _$mwProfileAllOfRelationsToMeEnum_requested,
  _$mwProfileAllOfRelationsToMeEnum_ignored,
  _$mwProfileAllOfRelationsToMeEnum_hidden,
  _$mwProfileAllOfRelationsToMeEnum_none,
]);

const MwProfileAllOfRelationsFromMeEnum
    _$mwProfileAllOfRelationsFromMeEnum_followed =
    const MwProfileAllOfRelationsFromMeEnum._('followed');
const MwProfileAllOfRelationsFromMeEnum
    _$mwProfileAllOfRelationsFromMeEnum_requested =
    const MwProfileAllOfRelationsFromMeEnum._('requested');
const MwProfileAllOfRelationsFromMeEnum
    _$mwProfileAllOfRelationsFromMeEnum_ignored =
    const MwProfileAllOfRelationsFromMeEnum._('ignored');
const MwProfileAllOfRelationsFromMeEnum
    _$mwProfileAllOfRelationsFromMeEnum_hidden =
    const MwProfileAllOfRelationsFromMeEnum._('hidden');
const MwProfileAllOfRelationsFromMeEnum
    _$mwProfileAllOfRelationsFromMeEnum_none =
    const MwProfileAllOfRelationsFromMeEnum._('none');

MwProfileAllOfRelationsFromMeEnum _$mwProfileAllOfRelationsFromMeEnumValueOf(
    String name) {
  switch (name) {
    case 'followed':
      return _$mwProfileAllOfRelationsFromMeEnum_followed;
    case 'requested':
      return _$mwProfileAllOfRelationsFromMeEnum_requested;
    case 'ignored':
      return _$mwProfileAllOfRelationsFromMeEnum_ignored;
    case 'hidden':
      return _$mwProfileAllOfRelationsFromMeEnum_hidden;
    case 'none':
      return _$mwProfileAllOfRelationsFromMeEnum_none;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MwProfileAllOfRelationsFromMeEnum>
    _$mwProfileAllOfRelationsFromMeEnumValues = BuiltSet<
        MwProfileAllOfRelationsFromMeEnum>(const <MwProfileAllOfRelationsFromMeEnum>[
  _$mwProfileAllOfRelationsFromMeEnum_followed,
  _$mwProfileAllOfRelationsFromMeEnum_requested,
  _$mwProfileAllOfRelationsFromMeEnum_ignored,
  _$mwProfileAllOfRelationsFromMeEnum_hidden,
  _$mwProfileAllOfRelationsFromMeEnum_none,
]);

Serializer<MwProfileAllOfRelationsToMeEnum>
    _$mwProfileAllOfRelationsToMeEnumSerializer =
    _$MwProfileAllOfRelationsToMeEnumSerializer();
Serializer<MwProfileAllOfRelationsFromMeEnum>
    _$mwProfileAllOfRelationsFromMeEnumSerializer =
    _$MwProfileAllOfRelationsFromMeEnumSerializer();

class _$MwProfileAllOfRelationsToMeEnumSerializer
    implements PrimitiveSerializer<MwProfileAllOfRelationsToMeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'followed': 'followed',
    'requested': 'requested',
    'ignored': 'ignored',
    'hidden': 'hidden',
    'none': 'none',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'followed': 'followed',
    'requested': 'requested',
    'ignored': 'ignored',
    'hidden': 'hidden',
    'none': 'none',
  };

  @override
  final Iterable<Type> types = const <Type>[MwProfileAllOfRelationsToMeEnum];
  @override
  final String wireName = 'MwProfileAllOfRelationsToMeEnum';

  @override
  Object serialize(
          Serializers serializers, MwProfileAllOfRelationsToMeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwProfileAllOfRelationsToMeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwProfileAllOfRelationsToMeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwProfileAllOfRelationsFromMeEnumSerializer
    implements PrimitiveSerializer<MwProfileAllOfRelationsFromMeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'followed': 'followed',
    'requested': 'requested',
    'ignored': 'ignored',
    'hidden': 'hidden',
    'none': 'none',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'followed': 'followed',
    'requested': 'requested',
    'ignored': 'ignored',
    'hidden': 'hidden',
    'none': 'none',
  };

  @override
  final Iterable<Type> types = const <Type>[MwProfileAllOfRelationsFromMeEnum];
  @override
  final String wireName = 'MwProfileAllOfRelationsFromMeEnum';

  @override
  Object serialize(
          Serializers serializers, MwProfileAllOfRelationsFromMeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwProfileAllOfRelationsFromMeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwProfileAllOfRelationsFromMeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwProfileAllOfRelations extends MwProfileAllOfRelations {
  @override
  final bool? isOpenForMe;
  @override
  final MwProfileAllOfRelationsToMeEnum? toMe;
  @override
  final MwProfileAllOfRelationsFromMeEnum? fromMe;

  factory _$MwProfileAllOfRelations(
          [void Function(MwProfileAllOfRelationsBuilder)? updates]) =>
      (MwProfileAllOfRelationsBuilder()..update(updates))._build();

  _$MwProfileAllOfRelations._({this.isOpenForMe, this.toMe, this.fromMe})
      : super._();
  @override
  MwProfileAllOfRelations rebuild(
          void Function(MwProfileAllOfRelationsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwProfileAllOfRelationsBuilder toBuilder() =>
      MwProfileAllOfRelationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwProfileAllOfRelations &&
        isOpenForMe == other.isOpenForMe &&
        toMe == other.toMe &&
        fromMe == other.fromMe;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isOpenForMe.hashCode);
    _$hash = $jc(_$hash, toMe.hashCode);
    _$hash = $jc(_$hash, fromMe.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwProfileAllOfRelations')
          ..add('isOpenForMe', isOpenForMe)
          ..add('toMe', toMe)
          ..add('fromMe', fromMe))
        .toString();
  }
}

class MwProfileAllOfRelationsBuilder
    implements
        Builder<MwProfileAllOfRelations, MwProfileAllOfRelationsBuilder> {
  _$MwProfileAllOfRelations? _$v;

  bool? _isOpenForMe;
  bool? get isOpenForMe => _$this._isOpenForMe;
  set isOpenForMe(bool? isOpenForMe) => _$this._isOpenForMe = isOpenForMe;

  MwProfileAllOfRelationsToMeEnum? _toMe;
  MwProfileAllOfRelationsToMeEnum? get toMe => _$this._toMe;
  set toMe(MwProfileAllOfRelationsToMeEnum? toMe) => _$this._toMe = toMe;

  MwProfileAllOfRelationsFromMeEnum? _fromMe;
  MwProfileAllOfRelationsFromMeEnum? get fromMe => _$this._fromMe;
  set fromMe(MwProfileAllOfRelationsFromMeEnum? fromMe) =>
      _$this._fromMe = fromMe;

  MwProfileAllOfRelationsBuilder() {
    MwProfileAllOfRelations._defaults(this);
  }

  MwProfileAllOfRelationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isOpenForMe = $v.isOpenForMe;
      _toMe = $v.toMe;
      _fromMe = $v.fromMe;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwProfileAllOfRelations other) {
    _$v = other as _$MwProfileAllOfRelations;
  }

  @override
  void update(void Function(MwProfileAllOfRelationsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwProfileAllOfRelations build() => _build();

  _$MwProfileAllOfRelations _build() {
    final _$result = _$v ??
        _$MwProfileAllOfRelations._(
          isOpenForMe: isOpenForMe,
          toMe: toMe,
          fromMe: fromMe,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
