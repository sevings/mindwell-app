// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_calendar.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwCalendar extends MwCalendar {
  @override
  final BuiltList<MwCalendarEntry>? entries;
  @override
  final num? start;
  @override
  final num? end;
  @override
  final int? limit;

  factory _$MwCalendar([void Function(MwCalendarBuilder)? updates]) =>
      (MwCalendarBuilder()..update(updates))._build();

  _$MwCalendar._({this.entries, this.start, this.end, this.limit}) : super._();
  @override
  MwCalendar rebuild(void Function(MwCalendarBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwCalendarBuilder toBuilder() => MwCalendarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwCalendar &&
        entries == other.entries &&
        start == other.start &&
        end == other.end &&
        limit == other.limit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, entries.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwCalendar')
          ..add('entries', entries)
          ..add('start', start)
          ..add('end', end)
          ..add('limit', limit))
        .toString();
  }
}

class MwCalendarBuilder implements Builder<MwCalendar, MwCalendarBuilder> {
  _$MwCalendar? _$v;

  ListBuilder<MwCalendarEntry>? _entries;
  ListBuilder<MwCalendarEntry> get entries =>
      _$this._entries ??= ListBuilder<MwCalendarEntry>();
  set entries(ListBuilder<MwCalendarEntry>? entries) =>
      _$this._entries = entries;

  num? _start;
  num? get start => _$this._start;
  set start(num? start) => _$this._start = start;

  num? _end;
  num? get end => _$this._end;
  set end(num? end) => _$this._end = end;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  MwCalendarBuilder() {
    MwCalendar._defaults(this);
  }

  MwCalendarBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entries = $v.entries?.toBuilder();
      _start = $v.start;
      _end = $v.end;
      _limit = $v.limit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwCalendar other) {
    _$v = other as _$MwCalendar;
  }

  @override
  void update(void Function(MwCalendarBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwCalendar build() => _build();

  _$MwCalendar _build() {
    _$MwCalendar _$result;
    try {
      _$result = _$v ??
          _$MwCalendar._(
            entries: _entries?.build(),
            start: start,
            end: end,
            limit: limit,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'entries';
        _entries?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MwCalendar', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
