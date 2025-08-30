// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_adm_grandson_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAdmGrandsonGet200Response extends MwAdmGrandsonGet200Response {
  @override
  final String? postcode;
  @override
  final String? country;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? name;
  @override
  final String? comment;
  @override
  final bool? anonymous;

  factory _$MwAdmGrandsonGet200Response(
          [void Function(MwAdmGrandsonGet200ResponseBuilder)? updates]) =>
      (new MwAdmGrandsonGet200ResponseBuilder()..update(updates))._build();

  _$MwAdmGrandsonGet200Response._(
      {this.postcode,
      this.country,
      this.address,
      this.phone,
      this.name,
      this.comment,
      this.anonymous})
      : super._();

  @override
  MwAdmGrandsonGet200Response rebuild(
          void Function(MwAdmGrandsonGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAdmGrandsonGet200ResponseBuilder toBuilder() =>
      new MwAdmGrandsonGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAdmGrandsonGet200Response &&
        postcode == other.postcode &&
        country == other.country &&
        address == other.address &&
        phone == other.phone &&
        name == other.name &&
        comment == other.comment &&
        anonymous == other.anonymous;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postcode.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, anonymous.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAdmGrandsonGet200Response')
          ..add('postcode', postcode)
          ..add('country', country)
          ..add('address', address)
          ..add('phone', phone)
          ..add('name', name)
          ..add('comment', comment)
          ..add('anonymous', anonymous))
        .toString();
  }
}

class MwAdmGrandsonGet200ResponseBuilder
    implements
        Builder<MwAdmGrandsonGet200Response,
            MwAdmGrandsonGet200ResponseBuilder> {
  _$MwAdmGrandsonGet200Response? _$v;

  String? _postcode;
  String? get postcode => _$this._postcode;
  set postcode(String? postcode) => _$this._postcode = postcode;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  bool? _anonymous;
  bool? get anonymous => _$this._anonymous;
  set anonymous(bool? anonymous) => _$this._anonymous = anonymous;

  MwAdmGrandsonGet200ResponseBuilder() {
    MwAdmGrandsonGet200Response._defaults(this);
  }

  MwAdmGrandsonGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postcode = $v.postcode;
      _country = $v.country;
      _address = $v.address;
      _phone = $v.phone;
      _name = $v.name;
      _comment = $v.comment;
      _anonymous = $v.anonymous;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAdmGrandsonGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAdmGrandsonGet200Response;
  }

  @override
  void update(void Function(MwAdmGrandsonGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAdmGrandsonGet200Response build() => _build();

  _$MwAdmGrandsonGet200Response _build() {
    final _$result = _$v ??
        new _$MwAdmGrandsonGet200Response._(
            postcode: postcode,
            country: country,
            address: address,
            phone: phone,
            name: name,
            comment: comment,
            anonymous: anonymous);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
