// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_adjacent_entries.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwAdjacentEntries extends MwAdjacentEntries {
  @override
  final MwCalendarEntry? older;
  @override
  final MwCalendarEntry? newer;
  @override
  final int? id;

  factory _$MwAdjacentEntries(
          [void Function(MwAdjacentEntriesBuilder)? updates]) =>
      (new MwAdjacentEntriesBuilder()..update(updates))._build();

  _$MwAdjacentEntries._({this.older, this.newer, this.id}) : super._();

  @override
  MwAdjacentEntries rebuild(void Function(MwAdjacentEntriesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwAdjacentEntriesBuilder toBuilder() =>
      new MwAdjacentEntriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwAdjacentEntries &&
        older == other.older &&
        newer == other.newer &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, older.hashCode);
    _$hash = $jc(_$hash, newer.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwAdjacentEntries')
          ..add('older', older)
          ..add('newer', newer)
          ..add('id', id))
        .toString();
  }
}

class MwAdjacentEntriesBuilder
    implements Builder<MwAdjacentEntries, MwAdjacentEntriesBuilder> {
  _$MwAdjacentEntries? _$v;

  MwCalendarEntryBuilder? _older;
  MwCalendarEntryBuilder get older =>
      _$this._older ??= new MwCalendarEntryBuilder();
  set older(MwCalendarEntryBuilder? older) => _$this._older = older;

  MwCalendarEntryBuilder? _newer;
  MwCalendarEntryBuilder get newer =>
      _$this._newer ??= new MwCalendarEntryBuilder();
  set newer(MwCalendarEntryBuilder? newer) => _$this._newer = newer;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  MwAdjacentEntriesBuilder() {
    MwAdjacentEntries._defaults(this);
  }

  MwAdjacentEntriesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _older = $v.older?.toBuilder();
      _newer = $v.newer?.toBuilder();
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwAdjacentEntries other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwAdjacentEntries;
  }

  @override
  void update(void Function(MwAdjacentEntriesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwAdjacentEntries build() => _build();

  _$MwAdjacentEntries _build() {
    _$MwAdjacentEntries _$result;
    try {
      _$result = _$v ??
          new _$MwAdjacentEntries._(
              older: _older?.build(), newer: _newer?.build(), id: id);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'older';
        _older?.build();
        _$failedField = 'newer';
        _newer?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwAdjacentEntries', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
