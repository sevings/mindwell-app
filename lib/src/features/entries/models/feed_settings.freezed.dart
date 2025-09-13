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

  /// Whether to include entries from tlogs (diaries)
  bool get includeTlogs => throw _privateConstructorUsedError;

  /// Whether to include entries from themes
  bool get includeThemes => throw _privateConstructorUsedError;

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
      bool includeTlogs,
      bool includeThemes});
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
    Object? includeTlogs = null,
    Object? includeThemes = null,
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
      includeTlogs: null == includeTlogs
          ? _value.includeTlogs
          : includeTlogs // ignore: cast_nullable_to_non_nullable
              as bool,
      includeThemes: null == includeThemes
          ? _value.includeThemes
          : includeThemes // ignore: cast_nullable_to_non_nullable
              as bool,
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
      bool includeTlogs,
      bool includeThemes});
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
    Object? includeTlogs = null,
    Object? includeThemes = null,
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
      includeTlogs: null == includeTlogs
          ? _value.includeTlogs
          : includeTlogs // ignore: cast_nullable_to_non_nullable
              as bool,
      includeThemes: null == includeThemes
          ? _value.includeThemes
          : includeThemes // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FeedSettingsImpl extends _FeedSettings {
  const _$FeedSettingsImpl(
      {this.entriesPerPage = 20,
      this.displayFormat = DisplayFormat.short,
      this.sortOrder = SortOrder.newest,
      this.includeTlogs = true,
      this.includeThemes = true})
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

  /// Whether to include entries from tlogs (diaries)
  @override
  @JsonKey()
  final bool includeTlogs;

  /// Whether to include entries from themes
  @override
  @JsonKey()
  final bool includeThemes;

  @override
  String toString() {
    return 'FeedSettings(entriesPerPage: $entriesPerPage, displayFormat: $displayFormat, sortOrder: $sortOrder, includeTlogs: $includeTlogs, includeThemes: $includeThemes)';
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
            (identical(other.includeTlogs, includeTlogs) ||
                other.includeTlogs == includeTlogs) &&
            (identical(other.includeThemes, includeThemes) ||
                other.includeThemes == includeThemes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entriesPerPage, displayFormat,
      sortOrder, includeTlogs, includeThemes);

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
      final bool includeTlogs,
      final bool includeThemes}) = _$FeedSettingsImpl;
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

  /// Whether to include entries from tlogs (diaries)
  bool get includeTlogs;
  @override

  /// Whether to include entries from themes
  bool get includeThemes;
  @override
  @JsonKey(ignore: true)
  _$$FeedSettingsImplCopyWith<_$FeedSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
