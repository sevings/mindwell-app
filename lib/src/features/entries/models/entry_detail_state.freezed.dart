// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EntryDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)
        loaded,
    required TResult Function(String message, MwEntry? entry) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult? Function(String message, MwEntry? entry)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult Function(String message, MwEntry? entry)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryDetailStateCopyWith<$Res> {
  factory $EntryDetailStateCopyWith(
          EntryDetailState value, $Res Function(EntryDetailState) then) =
      _$EntryDetailStateCopyWithImpl<$Res, EntryDetailState>;
}

/// @nodoc
class _$EntryDetailStateCopyWithImpl<$Res, $Val extends EntryDetailState>
    implements $EntryDetailStateCopyWith<$Res> {
  _$EntryDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$EntryDetailStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'EntryDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)
        loaded,
    required TResult Function(String message, MwEntry? entry) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult? Function(String message, MwEntry? entry)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult Function(String message, MwEntry? entry)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements EntryDetailState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$EntryDetailStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'EntryDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)
        loaded,
    required TResult Function(String message, MwEntry? entry) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult? Function(String message, MwEntry? entry)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult Function(String message, MwEntry? entry)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements EntryDetailState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {MwEntry entry,
      List<MwComment> comments,
      bool hasMoreComments,
      bool isLoadingComments,
      MwAdjacentEntries? adjacentEntries,
      int? availableCommentsCount});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$EntryDetailStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? comments = null,
    Object? hasMoreComments = null,
    Object? isLoadingComments = null,
    Object? adjacentEntries = freezed,
    Object? availableCommentsCount = freezed,
  }) {
    return _then(_$LoadedImpl(
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as MwEntry,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<MwComment>,
      hasMoreComments: null == hasMoreComments
          ? _value.hasMoreComments
          : hasMoreComments // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingComments: null == isLoadingComments
          ? _value.isLoadingComments
          : isLoadingComments // ignore: cast_nullable_to_non_nullable
              as bool,
      adjacentEntries: freezed == adjacentEntries
          ? _value.adjacentEntries
          : adjacentEntries // ignore: cast_nullable_to_non_nullable
              as MwAdjacentEntries?,
      availableCommentsCount: freezed == availableCommentsCount
          ? _value.availableCommentsCount
          : availableCommentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.entry,
      final List<MwComment> comments = const [],
      this.hasMoreComments = false,
      this.isLoadingComments = false,
      this.adjacentEntries,
      this.availableCommentsCount})
      : _comments = comments;

  @override
  final MwEntry entry;
  final List<MwComment> _comments;
  @override
  @JsonKey()
  List<MwComment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  @JsonKey()
  final bool hasMoreComments;
  @override
  @JsonKey()
  final bool isLoadingComments;
  @override
  final MwAdjacentEntries? adjacentEntries;
  @override
  final int? availableCommentsCount;

  @override
  String toString() {
    return 'EntryDetailState.loaded(entry: $entry, comments: $comments, hasMoreComments: $hasMoreComments, isLoadingComments: $isLoadingComments, adjacentEntries: $adjacentEntries, availableCommentsCount: $availableCommentsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.entry, entry) || other.entry == entry) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.hasMoreComments, hasMoreComments) ||
                other.hasMoreComments == hasMoreComments) &&
            (identical(other.isLoadingComments, isLoadingComments) ||
                other.isLoadingComments == isLoadingComments) &&
            (identical(other.adjacentEntries, adjacentEntries) ||
                other.adjacentEntries == adjacentEntries) &&
            (identical(other.availableCommentsCount, availableCommentsCount) ||
                other.availableCommentsCount == availableCommentsCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      entry,
      const DeepCollectionEquality().hash(_comments),
      hasMoreComments,
      isLoadingComments,
      adjacentEntries,
      availableCommentsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)
        loaded,
    required TResult Function(String message, MwEntry? entry) error,
  }) {
    return loaded(entry, comments, hasMoreComments, isLoadingComments,
        adjacentEntries, availableCommentsCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult? Function(String message, MwEntry? entry)? error,
  }) {
    return loaded?.call(entry, comments, hasMoreComments, isLoadingComments,
        adjacentEntries, availableCommentsCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult Function(String message, MwEntry? entry)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(entry, comments, hasMoreComments, isLoadingComments,
          adjacentEntries, availableCommentsCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements EntryDetailState {
  const factory _Loaded(
      {required final MwEntry entry,
      final List<MwComment> comments,
      final bool hasMoreComments,
      final bool isLoadingComments,
      final MwAdjacentEntries? adjacentEntries,
      final int? availableCommentsCount}) = _$LoadedImpl;

  MwEntry get entry;
  List<MwComment> get comments;
  bool get hasMoreComments;
  bool get isLoadingComments;
  MwAdjacentEntries? get adjacentEntries;
  int? get availableCommentsCount;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, MwEntry? entry});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$EntryDetailStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? entry = freezed,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      entry: freezed == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as MwEntry?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message, this.entry});

  @override
  final String message;
  @override
  final MwEntry? entry;

  @override
  String toString() {
    return 'EntryDetailState.error(message: $message, entry: $entry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.entry, entry) || other.entry == entry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, entry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)
        loaded,
    required TResult Function(String message, MwEntry? entry) error,
  }) {
    return error(message, entry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult? Function(String message, MwEntry? entry)? error,
  }) {
    return error?.call(message, entry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            MwEntry entry,
            List<MwComment> comments,
            bool hasMoreComments,
            bool isLoadingComments,
            MwAdjacentEntries? adjacentEntries,
            int? availableCommentsCount)?
        loaded,
    TResult Function(String message, MwEntry? entry)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, entry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements EntryDetailState {
  const factory _Error({required final String message, final MwEntry? entry}) =
      _$ErrorImpl;

  String get message;
  MwEntry? get entry;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
