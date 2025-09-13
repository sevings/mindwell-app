// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FeedSettings {
  /// Number of entries to load per page
  int get entriesPerPage => throw _privateConstructorUsedError;

  /// Display format for entries (short or full)
  DisplayFormat get displayFormat => throw _privateConstructorUsedError;

  /// Sort order for entries
  SortOrder get sortOrder => throw _privateConstructorUsedError;

  /// Whether to show only entries with images
  bool get imagesOnly => throw _privateConstructorUsedError;

  /// Whether to show only favorited entries
  bool get favoritesOnly => throw _privateConstructorUsedError;

  /// Whether to show only entries from followed users
  bool get followedOnly => throw _privateConstructorUsedError;

  /// Whether to enable auto-refresh
  bool get autoRefresh => throw _privateConstructorUsedError;

  /// Auto-refresh interval in seconds
  int get autoRefreshInterval => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedSettingsCopyWith<FeedSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedSettingsCopyWith<$Res> {
  factory $FeedSettingsCopyWith(
          FeedSettings value, $Res Function(FeedSettings) then) =
      _$FeedSettingsCopyWithImpl<$Res, FeedSettings>;
  @useResult
  $Res call(
      {int entriesPerPage,
      DisplayFormat displayFormat,
      SortOrder sortOrder,
      bool imagesOnly,
      bool favoritesOnly,
      bool followedOnly,
      bool autoRefresh,
      int autoRefreshInterval});
}

/// @nodoc
class _$FeedSettingsCopyWithImpl<$Res, $Val extends FeedSettings>
    implements $FeedSettingsCopyWith<$Res> {
  _$FeedSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entriesPerPage = null,
    Object? displayFormat = null,
    Object? sortOrder = null,
    Object? imagesOnly = null,
    Object? favoritesOnly = null,
    Object? followedOnly = null,
    Object? autoRefresh = null,
    Object? autoRefreshInterval = null,
  }) {
    return _then(_value.copyWith(
      entriesPerPage: null == entriesPerPage
          ? _value.entriesPerPage
          : entriesPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      displayFormat: null == displayFormat
          ? _value.displayFormat
          : displayFormat // ignore: cast_nullable_to_non_nullable
              as DisplayFormat,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
      imagesOnly: null == imagesOnly
          ? _value.imagesOnly
          : imagesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      favoritesOnly: null == favoritesOnly
          ? _value.favoritesOnly
          : favoritesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      followedOnly: null == followedOnly
          ? _value.followedOnly
          : followedOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRefresh: null == autoRefresh
          ? _value.autoRefresh
          : autoRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRefreshInterval: null == autoRefreshInterval
          ? _value.autoRefreshInterval
          : autoRefreshInterval // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedSettingsImplCopyWith<$Res>
    implements $FeedSettingsCopyWith<$Res> {
  factory _$$FeedSettingsImplCopyWith(
          _$FeedSettingsImpl value, $Res Function(_$FeedSettingsImpl) then) =
      __$$FeedSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int entriesPerPage,
      DisplayFormat displayFormat,
      SortOrder sortOrder,
      bool imagesOnly,
      bool favoritesOnly,
      bool followedOnly,
      bool autoRefresh,
      int autoRefreshInterval});
}

/// @nodoc
class __$$FeedSettingsImplCopyWithImpl<$Res>
    extends _$FeedSettingsCopyWithImpl<$Res, _$FeedSettingsImpl>
    implements _$$FeedSettingsImplCopyWith<$Res> {
  __$$FeedSettingsImplCopyWithImpl(
      _$FeedSettingsImpl _value, $Res Function(_$FeedSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entriesPerPage = null,
    Object? displayFormat = null,
    Object? sortOrder = null,
    Object? imagesOnly = null,
    Object? favoritesOnly = null,
    Object? followedOnly = null,
    Object? autoRefresh = null,
    Object? autoRefreshInterval = null,
  }) {
    return _then(_$FeedSettingsImpl(
      entriesPerPage: null == entriesPerPage
          ? _value.entriesPerPage
          : entriesPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      displayFormat: null == displayFormat
          ? _value.displayFormat
          : displayFormat // ignore: cast_nullable_to_non_nullable
              as DisplayFormat,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as SortOrder,
      imagesOnly: null == imagesOnly
          ? _value.imagesOnly
          : imagesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      favoritesOnly: null == favoritesOnly
          ? _value.favoritesOnly
          : favoritesOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      followedOnly: null == followedOnly
          ? _value.followedOnly
          : followedOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRefresh: null == autoRefresh
          ? _value.autoRefresh
          : autoRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      autoRefreshInterval: null == autoRefreshInterval
          ? _value.autoRefreshInterval
          : autoRefreshInterval // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FeedSettingsImpl extends _FeedSettings {
  const _$FeedSettingsImpl(
      {this.entriesPerPage = 20,
      this.displayFormat = DisplayFormat.short,
      this.sortOrder = SortOrder.newest,
      this.imagesOnly = false,
      this.favoritesOnly = false,
      this.followedOnly = false,
      this.autoRefresh = true,
      this.autoRefreshInterval = 30})
      : super._();

  /// Number of entries to load per page
  @override
  @JsonKey()
  final int entriesPerPage;

  /// Display format for entries (short or full)
  @override
  @JsonKey()
  final DisplayFormat displayFormat;

  /// Sort order for entries
  @override
  @JsonKey()
  final SortOrder sortOrder;

  /// Whether to show only entries with images
  @override
  @JsonKey()
  final bool imagesOnly;

  /// Whether to show only favorited entries
  @override
  @JsonKey()
  final bool favoritesOnly;

  /// Whether to show only entries from followed users
  @override
  @JsonKey()
  final bool followedOnly;

  /// Whether to enable auto-refresh
  @override
  @JsonKey()
  final bool autoRefresh;

  /// Auto-refresh interval in seconds
  @override
  @JsonKey()
  final int autoRefreshInterval;

  @override
  String toString() {
    return 'FeedSettings(entriesPerPage: $entriesPerPage, displayFormat: $displayFormat, sortOrder: $sortOrder, imagesOnly: $imagesOnly, favoritesOnly: $favoritesOnly, followedOnly: $followedOnly, autoRefresh: $autoRefresh, autoRefreshInterval: $autoRefreshInterval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedSettingsImpl &&
            (identical(other.entriesPerPage, entriesPerPage) ||
                other.entriesPerPage == entriesPerPage) &&
            (identical(other.displayFormat, displayFormat) ||
                other.displayFormat == displayFormat) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.imagesOnly, imagesOnly) ||
                other.imagesOnly == imagesOnly) &&
            (identical(other.favoritesOnly, favoritesOnly) ||
                other.favoritesOnly == favoritesOnly) &&
            (identical(other.followedOnly, followedOnly) ||
                other.followedOnly == followedOnly) &&
            (identical(other.autoRefresh, autoRefresh) ||
                other.autoRefresh == autoRefresh) &&
            (identical(other.autoRefreshInterval, autoRefreshInterval) ||
                other.autoRefreshInterval == autoRefreshInterval));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      entriesPerPage,
      displayFormat,
      sortOrder,
      imagesOnly,
      favoritesOnly,
      followedOnly,
      autoRefresh,
      autoRefreshInterval);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedSettingsImplCopyWith<_$FeedSettingsImpl> get copyWith =>
      __$$FeedSettingsImplCopyWithImpl<_$FeedSettingsImpl>(this, _$identity);
}

abstract class _FeedSettings extends FeedSettings {
  const factory _FeedSettings(
      {final int entriesPerPage,
      final DisplayFormat displayFormat,
      final SortOrder sortOrder,
      final bool imagesOnly,
      final bool favoritesOnly,
      final bool followedOnly,
      final bool autoRefresh,
      final int autoRefreshInterval}) = _$FeedSettingsImpl;
  const _FeedSettings._() : super._();

  @override

  /// Number of entries to load per page
  int get entriesPerPage;
  @override

  /// Display format for entries (short or full)
  DisplayFormat get displayFormat;
  @override

  /// Sort order for entries
  SortOrder get sortOrder;
  @override

  /// Whether to show only entries with images
  bool get imagesOnly;
  @override

  /// Whether to show only favorited entries
  bool get favoritesOnly;
  @override

  /// Whether to show only entries from followed users
  bool get followedOnly;
  @override

  /// Whether to enable auto-refresh
  bool get autoRefresh;
  @override

  /// Auto-refresh interval in seconds
  int get autoRefreshInterval;
  @override
  @JsonKey(ignore: true)
  _$$FeedSettingsImplCopyWith<_$FeedSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
