// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_adm_grandson_status_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAdmGrandsonStatusGet200Response
    extends MwAdmGrandsonStatusGet200Response {
  @override
  final bool? sent;
  @override
  final bool? received;
  @override
  final String? tracking;
  @override
  final String? comment;

  factory _$MwAdmGrandsonStatusGet200Response(
          [void Function(MwAdmGrandsonStatusGet200ResponseBuilder)? updates]) =>
      (new MwAdmGrandsonStatusGet200ResponseBuilder()..update(updates))
          ._build();

  _$MwAdmGrandsonStatusGet200Response._(
      {this.sent, this.received, this.tracking, this.comment})
      : super._();

  @override
  MwAdmGrandsonStatusGet200Response rebuild(
          void Function(MwAdmGrandsonStatusGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAdmGrandsonStatusGet200ResponseBuilder toBuilder() =>
      new MwAdmGrandsonStatusGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAdmGrandsonStatusGet200Response &&
        sent == other.sent &&
        received == other.received &&
        tracking == other.tracking &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sent.hashCode);
    _$hash = $jc(_$hash, received.hashCode);
    _$hash = $jc(_$hash, tracking.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAdmGrandsonStatusGet200Response')
          ..add('sent', sent)
          ..add('received', received)
          ..add('tracking', tracking)
          ..add('comment', comment))
        .toString();
  }
}

class MwAdmGrandsonStatusGet200ResponseBuilder
    implements
        Builder<MwAdmGrandsonStatusGet200Response,
            MwAdmGrandsonStatusGet200ResponseBuilder> {
  _$MwAdmGrandsonStatusGet200Response? _$v;

  bool? _sent;
  bool? get sent => _$this._sent;
  set sent(bool? sent) => _$this._sent = sent;

  bool? _received;
  bool? get received => _$this._received;
  set received(bool? received) => _$this._received = received;

  String? _tracking;
  String? get tracking => _$this._tracking;
  set tracking(String? tracking) => _$this._tracking = tracking;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  MwAdmGrandsonStatusGet200ResponseBuilder() {
    MwAdmGrandsonStatusGet200Response._defaults(this);
  }

  MwAdmGrandsonStatusGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sent = $v.sent;
      _received = $v.received;
      _tracking = $v.tracking;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAdmGrandsonStatusGet200Response other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAdmGrandsonStatusGet200Response;
  }

  @override
  void update(
      void Function(MwAdmGrandsonStatusGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAdmGrandsonStatusGet200Response build() => _build();

  _$MwAdmGrandsonStatusGet200Response _build() {
    final _$result = _$v ??
        new _$MwAdmGrandsonStatusGet200Response._(
            sent: sent,
            received: received,
            tracking: tracking,
            comment: comment);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
