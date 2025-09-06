// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_adm_stat_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAdmStatGet200Response extends MwAdmStatGet200Response {
  @override
  final int? grandsons;
  @override
  final int? sent;
  @override
  final int? received;

  factory _$MwAdmStatGet200Response(
          [void Function(MwAdmStatGet200ResponseBuilder)? updates]) =>
      (MwAdmStatGet200ResponseBuilder()..update(updates))._build();

  _$MwAdmStatGet200Response._({this.grandsons, this.sent, this.received})
      : super._();
  @override
  MwAdmStatGet200Response rebuild(
          void Function(MwAdmStatGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAdmStatGet200ResponseBuilder toBuilder() =>
      MwAdmStatGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAdmStatGet200Response &&
        grandsons == other.grandsons &&
        sent == other.sent &&
        received == other.received;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, grandsons.hashCode);
    _$hash = $jc(_$hash, sent.hashCode);
    _$hash = $jc(_$hash, received.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAdmStatGet200Response')
          ..add('grandsons', grandsons)
          ..add('sent', sent)
          ..add('received', received))
        .toString();
  }
}

class MwAdmStatGet200ResponseBuilder
    implements
        Builder<MwAdmStatGet200Response, MwAdmStatGet200ResponseBuilder> {
  _$MwAdmStatGet200Response? _$v;

  int? _grandsons;
  int? get grandsons => _$this._grandsons;
  set grandsons(int? grandsons) => _$this._grandsons = grandsons;

  int? _sent;
  int? get sent => _$this._sent;
  set sent(int? sent) => _$this._sent = sent;

  int? _received;
  int? get received => _$this._received;
  set received(int? received) => _$this._received = received;

  MwAdmStatGet200ResponseBuilder() {
    MwAdmStatGet200Response._defaults(this);
  }

  MwAdmStatGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _grandsons = $v.grandsons;
      _sent = $v.sent;
      _received = $v.received;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAdmStatGet200Response other) {
    _$v = other as _$MwAdmStatGet200Response;
  }

  @override
  void update(void Function(MwAdmStatGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAdmStatGet200Response build() => _build();

  _$MwAdmStatGet200Response _build() {
    final _$result = _$v ??
        _$MwAdmStatGet200Response._(
          grandsons: grandsons,
          sent: sent,
          received: received,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
