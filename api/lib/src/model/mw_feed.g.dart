// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mw_feed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MwFeed extends MwFeed {
  @override
  final BuiltList<MwEntry>? entries;
  @override
  final String? nextAfter;
  @override
  final bool? hasAfter;
  @override
  final String? nextBefore;
  @override
  final bool? hasBefore;

  factory _$MwFeed([void Function(MwFeedBuilder)? updates]) =>
      (new MwFeedBuilder()..update(updates))._build();

  _$MwFeed._(
      {this.entries,
      this.nextAfter,
      this.hasAfter,
      this.nextBefore,
      this.hasBefore})
      : super._();

  @override
  MwFeed rebuild(void Function(MwFeedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MwFeedBuilder toBuilder() => new MwFeedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MwFeed &&
        entries == other.entries &&
        nextAfter == other.nextAfter &&
        hasAfter == other.hasAfter &&
        nextBefore == other.nextBefore &&
        hasBefore == other.hasBefore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, entries.hashCode);
    _$hash = $jc(_$hash, nextAfter.hashCode);
    _$hash = $jc(_$hash, hasAfter.hashCode);
    _$hash = $jc(_$hash, nextBefore.hashCode);
    _$hash = $jc(_$hash, hasBefore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MwFeed')
          ..add('entries', entries)
          ..add('nextAfter', nextAfter)
          ..add('hasAfter', hasAfter)
          ..add('nextBefore', nextBefore)
          ..add('hasBefore', hasBefore))
        .toString();
  }
}

class MwFeedBuilder implements Builder<MwFeed, MwFeedBuilder> {
  _$MwFeed? _$v;

  ListBuilder<MwEntry>? _entries;
  ListBuilder<MwEntry> get entries =>
      _$this._entries ??= new ListBuilder<MwEntry>();
  set entries(ListBuilder<MwEntry>? entries) => _$this._entries = entries;

  String? _nextAfter;
  String? get nextAfter => _$this._nextAfter;
  set nextAfter(String? nextAfter) => _$this._nextAfter = nextAfter;

  bool? _hasAfter;
  bool? get hasAfter => _$this._hasAfter;
  set hasAfter(bool? hasAfter) => _$this._hasAfter = hasAfter;

  String? _nextBefore;
  String? get nextBefore => _$this._nextBefore;
  set nextBefore(String? nextBefore) => _$this._nextBefore = nextBefore;

  bool? _hasBefore;
  bool? get hasBefore => _$this._hasBefore;
  set hasBefore(bool? hasBefore) => _$this._hasBefore = hasBefore;

  MwFeedBuilder() {
    MwFeed._defaults(this);
  }

  MwFeedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entries = $v.entries?.toBuilder();
      _nextAfter = $v.nextAfter;
      _hasAfter = $v.hasAfter;
      _nextBefore = $v.nextBefore;
      _hasBefore = $v.hasBefore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MwFeed other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MwFeed;
  }

  @override
  void update(void Function(MwFeedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MwFeed build() => _build();

  _$MwFeed _build() {
    _$MwFeed _$result;
    try {
      _$result = _$v ??
          new _$MwFeed._(
              entries: _entries?.build(),
              nextAfter: nextAfter,
              hasAfter: hasAfter,
              nextBefore: nextBefore,
              hasBefore: hasBefore);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'entries';
        _entries?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'MwFeed', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
