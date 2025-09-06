// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_adm_grandfather_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAdmGrandfatherGet200Response extends MwAdmGrandfatherGet200Response {
  @override
  final String? postcode;
  @override
  final String? country;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? fullname;
  @override
  final String? comment;
  @override
  final String? name;

  factory _$MwAdmGrandfatherGet200Response(
          [void Function(MwAdmGrandfatherGet200ResponseBuilder)? updates]) =>
      (MwAdmGrandfatherGet200ResponseBuilder()..update(updates))._build();

  _$MwAdmGrandfatherGet200Response._(
      {this.postcode,
      this.country,
      this.address,
      this.phone,
      this.fullname,
      this.comment,
      this.name})
      : super._();
  @override
  MwAdmGrandfatherGet200Response rebuild(
          void Function(MwAdmGrandfatherGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAdmGrandfatherGet200ResponseBuilder toBuilder() =>
      MwAdmGrandfatherGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAdmGrandfatherGet200Response &&
        postcode == other.postcode &&
        country == other.country &&
        address == other.address &&
        phone == other.phone &&
        fullname == other.fullname &&
        comment == other.comment &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, postcode.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, fullname.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAdmGrandfatherGet200Response')
          ..add('postcode', postcode)
          ..add('country', country)
          ..add('address', address)
          ..add('phone', phone)
          ..add('fullname', fullname)
          ..add('comment', comment)
          ..add('name', name))
        .toString();
  }
}

class MwAdmGrandfatherGet200ResponseBuilder
    implements
        Builder<MwAdmGrandfatherGet200Response,
            MwAdmGrandfatherGet200ResponseBuilder> {
  _$MwAdmGrandfatherGet200Response? _$v;

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

  String? _fullname;
  String? get fullname => _$this._fullname;
  set fullname(String? fullname) => _$this._fullname = fullname;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  MwAdmGrandfatherGet200ResponseBuilder() {
    MwAdmGrandfatherGet200Response._defaults(this);
  }

  MwAdmGrandfatherGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _postcode = $v.postcode;
      _country = $v.country;
      _address = $v.address;
      _phone = $v.phone;
      _fullname = $v.fullname;
      _comment = $v.comment;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAdmGrandfatherGet200Response other) {
    _$v = other as _$MwAdmGrandfatherGet200Response;
  }

  @override
  void update(void Function(MwAdmGrandfatherGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAdmGrandfatherGet200Response build() => _build();

  _$MwAdmGrandfatherGet200Response _build() {
    final _$result = _$v ??
        _$MwAdmGrandfatherGet200Response._(
          postcode: postcode,
          country: country,
          address: address,
          phone: phone,
          fullname: fullname,
          comment: comment,
          name: name,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
