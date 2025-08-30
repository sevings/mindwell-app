// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_relationship.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwRelationshipRelationEnum _$mwRelationshipRelationEnum_followed =
    const MwRelationshipRelationEnum._('followed');
const MwRelationshipRelationEnum _$mwRelationshipRelationEnum_requested =
    const MwRelationshipRelationEnum._('requested');
const MwRelationshipRelationEnum _$mwRelationshipRelationEnum_ignored =
    const MwRelationshipRelationEnum._('ignored');
const MwRelationshipRelationEnum _$mwRelationshipRelationEnum_hidden =
    const MwRelationshipRelationEnum._('hidden');
const MwRelationshipRelationEnum _$mwRelationshipRelationEnum_none =
    const MwRelationshipRelationEnum._('none');

MwRelationshipRelationEnum _$mwRelationshipRelationEnumValueOf(String name) {
  switch (name) {
    case 'followed':
      return _$mwRelationshipRelationEnum_followed;
    case 'requested':
      return _$mwRelationshipRelationEnum_requested;
    case 'ignored':
      return _$mwRelationshipRelationEnum_ignored;
    case 'hidden':
      return _$mwRelationshipRelationEnum_hidden;
    case 'none':
      return _$mwRelationshipRelationEnum_none;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwRelationshipRelationEnum> _$mwRelationshipRelationEnumValues =
    new BuiltSet<MwRelationshipRelationEnum>(const <MwRelationshipRelationEnum>[
  _$mwRelationshipRelationEnum_followed,
  _$mwRelationshipRelationEnum_requested,
  _$mwRelationshipRelationEnum_ignored,
  _$mwRelationshipRelationEnum_hidden,
  _$mwRelationshipRelationEnum_none,
]);

Serializer<MwRelationshipRelationEnum> _$mwRelationshipRelationEnumSerializer =
    new _$MwRelationshipRelationEnumSerializer();

class _$MwRelationshipRelationEnumSerializer
    implements PrimitiveSerializer<MwRelationshipRelationEnum> {
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
  final Iterable<Type> types = const <Type>[MwRelationshipRelationEnum];
  @override
  final String wireName = 'MwRelationshipRelationEnum';

  @override
  Object serialize(Serializers serializers, MwRelationshipRelationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwRelationshipRelationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwRelationshipRelationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwRelationship extends MwRelationship {
  @override
  final String? from;
  @override
  final String? to;
  @override
  final MwRelationshipRelationEnum? relation;

  factory _$MwRelationship([void Function(MwRelationshipBuilder)? updates]) =>
      (new MwRelationshipBuilder()..update(updates))._build();

  _$MwRelationship._({this.from, this.to, this.relation}) : super._();

  @override
  MwRelationship rebuild(void Function(MwRelationshipBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwRelationshipBuilder toBuilder() =>
      new MwRelationshipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwRelationship &&
        from == other.from &&
        to == other.to &&
        relation == other.relation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, relation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwRelationship')
          ..add('from', from)
          ..add('to', to)
          ..add('relation', relation))
        .toString();
  }
}

class MwRelationshipBuilder
    implements Builder<MwRelationship, MwRelationshipBuilder> {
  _$MwRelationship? _$v;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  MwRelationshipRelationEnum? _relation;
  MwRelationshipRelationEnum? get relation => _$this._relation;
  set relation(MwRelationshipRelationEnum? relation) =>
      _$this._relation = relation;

  MwRelationshipBuilder() {
    MwRelationship._defaults(this);
  }

  MwRelationshipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _relation = $v.relation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwRelationship other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwRelationship;
  }

  @override
  void update(void Function(MwRelationshipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwRelationship build() => _build();

  _$MwRelationship _build() {
    final _$result =
        _$v ?? new _$MwRelationship._(from: from, to: to, relation: relation);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
