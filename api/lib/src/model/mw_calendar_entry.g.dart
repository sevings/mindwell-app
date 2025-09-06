// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_calendar_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwCalendarEntry extends MwCalendarEntry {
  @override
  final int? id;
  @override
  final double? createdAt;
  @override
  final String? title;

  factory _$MwCalendarEntry([void Function(MwCalendarEntryBuilder)? updates]) =>
      (MwCalendarEntryBuilder()..update(updates))._build();

  _$MwCalendarEntry._({this.id, this.createdAt, this.title}) : super._();
  @override
  MwCalendarEntry rebuild(void Function(MwCalendarEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwCalendarEntryBuilder toBuilder() => MwCalendarEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwCalendarEntry &&
        id == other.id &&
        createdAt == other.createdAt &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwCalendarEntry')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('title', title))
        .toString();
  }
}

class MwCalendarEntryBuilder
    implements Builder<MwCalendarEntry, MwCalendarEntryBuilder> {
  _$MwCalendarEntry? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _createdAt;
  double? get createdAt => _$this._createdAt;
  set createdAt(double? createdAt) => _$this._createdAt = createdAt;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  MwCalendarEntryBuilder() {
    MwCalendarEntry._defaults(this);
  }

  MwCalendarEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdAt = $v.createdAt;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwCalendarEntry other) {
    _$v = other as _$MwCalendarEntry;
  }

  @override
  void update(void Function(MwCalendarEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwCalendarEntry build() => _build();

  _$MwCalendarEntry _build() {
    final _$result = _$v ??
        _$MwCalendarEntry._(
          id: id,
          createdAt: createdAt,
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
