// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EntryFeedState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Entry> entries, bool isFetchingMore,
            bool hasMore, FeedSettings settings, int? currentPage)
        loaded,
    required TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult? Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EntryFeedLoading value) loading,
    required TResult Function(EntryFeedLoaded value) loaded,
    required TResult Function(EntryFeedError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EntryFeedLoading value)? loading,
    TResult? Function(EntryFeedLoaded value)? loaded,
    TResult? Function(EntryFeedError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EntryFeedLoading value)? loading,
    TResult Function(EntryFeedLoaded value)? loaded,
    TResult Function(EntryFeedError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryFeedStateCopyWith<$Res> {
  factory $EntryFeedStateCopyWith(
          EntryFeedState value, $Res Function(EntryFeedState) then) =
      _$EntryFeedStateCopyWithImpl<$Res, EntryFeedState>;
}

/// @nodoc
class _$EntryFeedStateCopyWithImpl<$Res, $Val extends EntryFeedState>
    implements $EntryFeedStateCopyWith<$Res> {
  _$EntryFeedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EntryFeedLoadingImplCopyWith<$Res> {
  factory _$$EntryFeedLoadingImplCopyWith(_$EntryFeedLoadingImpl value,
          $Res Function(_$EntryFeedLoadingImpl) then) =
      __$$EntryFeedLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EntryFeedLoadingImplCopyWithImpl<$Res>
    extends _$EntryFeedStateCopyWithImpl<$Res, _$EntryFeedLoadingImpl>
    implements _$$EntryFeedLoadingImplCopyWith<$Res> {
  __$$EntryFeedLoadingImplCopyWithImpl(_$EntryFeedLoadingImpl _value,
      $Res Function(_$EntryFeedLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EntryFeedLoadingImpl implements EntryFeedLoading {
  const _$EntryFeedLoadingImpl();

  @override
  String toString() {
    return 'EntryFeedState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EntryFeedLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Entry> entries, bool isFetchingMore,
            bool hasMore, FeedSettings settings, int? currentPage)
        loaded,
    required TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)
        error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult? Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EntryFeedLoading value) loading,
    required TResult Function(EntryFeedLoaded value) loaded,
    required TResult Function(EntryFeedError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EntryFeedLoading value)? loading,
    TResult? Function(EntryFeedLoaded value)? loaded,
    TResult? Function(EntryFeedError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EntryFeedLoading value)? loading,
    TResult Function(EntryFeedLoaded value)? loaded,
    TResult Function(EntryFeedError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EntryFeedLoading implements EntryFeedState {
  const factory EntryFeedLoading() = _$EntryFeedLoadingImpl;
}

/// @nodoc
abstract class _$$EntryFeedLoadedImplCopyWith<$Res> {
  factory _$$EntryFeedLoadedImplCopyWith(_$EntryFeedLoadedImpl value,
          $Res Function(_$EntryFeedLoadedImpl) then) =
      __$$EntryFeedLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Entry> entries,
      bool isFetchingMore,
      bool hasMore,
      FeedSettings settings,
      int? currentPage});

  $FeedSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$EntryFeedLoadedImplCopyWithImpl<$Res>
    extends _$EntryFeedStateCopyWithImpl<$Res, _$EntryFeedLoadedImpl>
    implements _$$EntryFeedLoadedImplCopyWith<$Res> {
  __$$EntryFeedLoadedImplCopyWithImpl(
      _$EntryFeedLoadedImpl _value, $Res Function(_$EntryFeedLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? isFetchingMore = null,
    Object? hasMore = null,
    Object? settings = null,
    Object? currentPage = freezed,
  }) {
    return _then(_$EntryFeedLoadedImpl(
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
      isFetchingMore: null == isFetchingMore
          ? _value.isFetchingMore
          : isFetchingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as FeedSettings,
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FeedSettingsCopyWith<$Res> get settings {
    return $FeedSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc

class _$EntryFeedLoadedImpl implements EntryFeedLoaded {
  const _$EntryFeedLoadedImpl(
      {required final List<Entry> entries,
      this.isFetchingMore = false,
      this.hasMore = true,
      required this.settings,
      this.currentPage})
      : _entries = entries;

  final List<Entry> _entries;
  @override
  List<Entry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey()
  final bool isFetchingMore;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final FeedSettings settings;
  @override
  final int? currentPage;

  @override
  String toString() {
    return 'EntryFeedState.loaded(entries: $entries, isFetchingMore: $isFetchingMore, hasMore: $hasMore, settings: $settings, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryFeedLoadedImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.isFetchingMore, isFetchingMore) ||
                other.isFetchingMore == isFetchingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entries),
      isFetchingMore,
      hasMore,
      settings,
      currentPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryFeedLoadedImplCopyWith<_$EntryFeedLoadedImpl> get copyWith =>
      __$$EntryFeedLoadedImplCopyWithImpl<_$EntryFeedLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Entry> entries, bool isFetchingMore,
            bool hasMore, FeedSettings settings, int? currentPage)
        loaded,
    required TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)
        error,
  }) {
    return loaded(entries, isFetchingMore, hasMore, settings, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult? Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
  }) {
    return loaded?.call(
        entries, isFetchingMore, hasMore, settings, currentPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(entries, isFetchingMore, hasMore, settings, currentPage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EntryFeedLoading value) loading,
    required TResult Function(EntryFeedLoaded value) loaded,
    required TResult Function(EntryFeedError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EntryFeedLoading value)? loading,
    TResult? Function(EntryFeedLoaded value)? loaded,
    TResult? Function(EntryFeedError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EntryFeedLoading value)? loading,
    TResult Function(EntryFeedLoaded value)? loaded,
    TResult Function(EntryFeedError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class EntryFeedLoaded implements EntryFeedState {
  const factory EntryFeedLoaded(
      {required final List<Entry> entries,
      final bool isFetchingMore,
      final bool hasMore,
      required final FeedSettings settings,
      final int? currentPage}) = _$EntryFeedLoadedImpl;

  List<Entry> get entries;
  bool get isFetchingMore;
  bool get hasMore;
  FeedSettings get settings;
  int? get currentPage;
  @JsonKey(ignore: true)
  _$$EntryFeedLoadedImplCopyWith<_$EntryFeedLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EntryFeedErrorImplCopyWith<$Res> {
  factory _$$EntryFeedErrorImplCopyWith(_$EntryFeedErrorImpl value,
          $Res Function(_$EntryFeedErrorImpl) then) =
      __$$EntryFeedErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String errorMessage,
      List<Entry>? previousEntries,
      FeedSettings? settings});

  $FeedSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$EntryFeedErrorImplCopyWithImpl<$Res>
    extends _$EntryFeedStateCopyWithImpl<$Res, _$EntryFeedErrorImpl>
    implements _$$EntryFeedErrorImplCopyWith<$Res> {
  __$$EntryFeedErrorImplCopyWithImpl(
      _$EntryFeedErrorImpl _value, $Res Function(_$EntryFeedErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
    Object? previousEntries = freezed,
    Object? settings = freezed,
  }) {
    return _then(_$EntryFeedErrorImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      previousEntries: freezed == previousEntries
          ? _value._previousEntries
          : previousEntries // ignore: cast_nullable_to_non_nullable
              as List<Entry>?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as FeedSettings?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FeedSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $FeedSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc

class _$EntryFeedErrorImpl implements EntryFeedError {
  const _$EntryFeedErrorImpl(
      {required this.errorMessage,
      final List<Entry>? previousEntries,
      this.settings})
      : _previousEntries = previousEntries;

  @override
  final String errorMessage;
  final List<Entry>? _previousEntries;
  @override
  List<Entry>? get previousEntries {
    final value = _previousEntries;
    if (value == null) return null;
    if (_previousEntries is EqualUnmodifiableListView) return _previousEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final FeedSettings? settings;

  @override
  String toString() {
    return 'EntryFeedState.error(errorMessage: $errorMessage, previousEntries: $previousEntries, settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryFeedErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._previousEntries, _previousEntries) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage,
      const DeepCollectionEquality().hash(_previousEntries), settings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryFeedErrorImplCopyWith<_$EntryFeedErrorImpl> get copyWith =>
      __$$EntryFeedErrorImplCopyWithImpl<_$EntryFeedErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Entry> entries, bool isFetchingMore,
            bool hasMore, FeedSettings settings, int? currentPage)
        loaded,
    required TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)
        error,
  }) {
    return error(errorMessage, previousEntries, settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult? Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
  }) {
    return error?.call(errorMessage, previousEntries, settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Entry> entries, bool isFetchingMore, bool hasMore,
            FeedSettings settings, int? currentPage)?
        loaded,
    TResult Function(String errorMessage, List<Entry>? previousEntries,
            FeedSettings? settings)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage, previousEntries, settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EntryFeedLoading value) loading,
    required TResult Function(EntryFeedLoaded value) loaded,
    required TResult Function(EntryFeedError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EntryFeedLoading value)? loading,
    TResult? Function(EntryFeedLoaded value)? loaded,
    TResult? Function(EntryFeedError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EntryFeedLoading value)? loading,
    TResult Function(EntryFeedLoaded value)? loaded,
    TResult Function(EntryFeedError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EntryFeedError implements EntryFeedState {
  const factory EntryFeedError(
      {required final String errorMessage,
      final List<Entry>? previousEntries,
      final FeedSettings? settings}) = _$EntryFeedErrorImpl;

  String get errorMessage;
  List<Entry>? get previousEntries;
  FeedSettings? get settings;
  @JsonKey(ignore: true)
  _$$EntryFeedErrorImplCopyWith<_$EntryFeedErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
