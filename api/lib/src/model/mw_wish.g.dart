// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_wish.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MwWishStateEnum _$mwWishStateEnum_new_ = const MwWishStateEnum._('new_');
const MwWishStateEnum _$mwWishStateEnum_sent = const MwWishStateEnum._('sent');
const MwWishStateEnum _$mwWishStateEnum_expired =
    const MwWishStateEnum._('expired');
const MwWishStateEnum _$mwWishStateEnum_declined =
    const MwWishStateEnum._('declined');
const MwWishStateEnum _$mwWishStateEnum_thanked =
    const MwWishStateEnum._('thanked');
const MwWishStateEnum _$mwWishStateEnum_complained =
    const MwWishStateEnum._('complained');

MwWishStateEnum _$mwWishStateEnumValueOf(String name) {
  switch (name) {
    case 'new_':
      return _$mwWishStateEnum_new_;
    case 'sent':
      return _$mwWishStateEnum_sent;
    case 'expired':
      return _$mwWishStateEnum_expired;
    case 'declined':
      return _$mwWishStateEnum_declined;
    case 'thanked':
      return _$mwWishStateEnum_thanked;
    case 'complained':
      return _$mwWishStateEnum_complained;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MwWishStateEnum> _$mwWishStateEnumValues =
    new BuiltSet<MwWishStateEnum>(const <MwWishStateEnum>[
  _$mwWishStateEnum_new_,
  _$mwWishStateEnum_sent,
  _$mwWishStateEnum_expired,
  _$mwWishStateEnum_declined,
  _$mwWishStateEnum_thanked,
  _$mwWishStateEnum_complained,
]);

Serializer<MwWishStateEnum> _$mwWishStateEnumSerializer =
    new _$MwWishStateEnumSerializer();

class _$MwWishStateEnumSerializer
    implements PrimitiveSerializer<MwWishStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'new_': 'new',
    'sent': 'sent',
    'expired': 'expired',
    'declined': 'declined',
    'thanked': 'thanked',
    'complained': 'complained',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'new': 'new_',
    'sent': 'sent',
    'expired': 'expired',
    'declined': 'declined',
    'thanked': 'thanked',
    'complained': 'complained',
  };

  @override
  final Iterable<Type> types = const <Type>[MwWishStateEnum];
  @override
  final String wireName = 'MwWishStateEnum';

  @override
  Object serialize(Serializers serializers, MwWishStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MwWishStateEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MwWishStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MwWish extends MwWish {
  @override
  final int? id;
  @override
  final String? content;
  @override
  final MwWishStateEnum? state;
  @override
  final double? sendUntil;
  @override
  final MwUser? receiver;

  factory _$MwWish([void Function(MwWishBuilder)? updates]) =>
      (new MwWishBuilder()..update(updates))._build();

  _$MwWish._({this.id, this.content, this.state, this.sendUntil, this.receiver})
      : super._();

  @override
  MwWish rebuild(void Function(MwWishBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwWishBuilder toBuilder() => new MwWishBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwWish &&
        id == other.id &&
        content == other.content &&
        state == other.state &&
        sendUntil == other.sendUntil &&
        receiver == other.receiver;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, sendUntil.hashCode);
    _$hash = $jc(_$hash, receiver.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwWish')
          ..add('id', id)
          ..add('content', content)
          ..add('state', state)
          ..add('sendUntil', sendUntil)
          ..add('receiver', receiver))
        .toString();
  }
}

class MwWishBuilder implements Builder<MwWish, MwWishBuilder> {
  _$MwWish? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  MwWishStateEnum? _state;
  MwWishStateEnum? get state => _$this._state;
  set state(MwWishStateEnum? state) => _$this._state = state;

  double? _sendUntil;
  double? get sendUntil => _$this._sendUntil;
  set sendUntil(double? sendUntil) => _$this._sendUntil = sendUntil;

  MwUser? _receiver;
  MwUser? get receiver => _$this._receiver;
  set receiver(MwUser? receiver) => _$this._receiver = receiver;

  MwWishBuilder() {
    MwWish._defaults(this);
  }

  MwWishBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _content = $v.content;
      _state = $v.state;
      _sendUntil = $v.sendUntil;
      _receiver = $v.receiver;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwWish other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwWish;
  }

  @override
  void update(void Function(MwWishBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwWish build() => _build();

  _$MwWish _build() {
    final _$result = _$v ??
        new _$MwWish._(
            id: id,
            content: content,
            state: state,
            sendUntil: sendUntil,
            receiver: receiver);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
