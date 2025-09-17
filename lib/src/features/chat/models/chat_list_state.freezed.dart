// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwChat> chats, bool isFetchingMore, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListStateCopyWith<$Res> {
  factory $ChatListStateCopyWith(
          ChatListState value, $Res Function(ChatListState) then) =
      _$ChatListStateCopyWithImpl<$Res, ChatListState>;
}

/// @nodoc
class _$ChatListStateCopyWithImpl<$Res, $Val extends ChatListState>
    implements $ChatListStateCopyWith<$Res> {
  _$ChatListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatListLoadingImplCopyWith<$Res> {
  factory _$$ChatListLoadingImplCopyWith(_$ChatListLoadingImpl value,
          $Res Function(_$ChatListLoadingImpl) then) =
      __$$ChatListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatListLoadingImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListLoadingImpl>
    implements _$$ChatListLoadingImplCopyWith<$Res> {
  __$$ChatListLoadingImplCopyWithImpl(
      _$ChatListLoadingImpl _value, $Res Function(_$ChatListLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatListLoadingImpl implements ChatListLoading {
  const _$ChatListLoadingImpl();

  @override
  String toString() {
    return 'ChatListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwChat> chats, bool isFetchingMore, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult Function(String message)? error,
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
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatListLoading implements ChatListState {
  const factory ChatListLoading() = _$ChatListLoadingImpl;
}

/// @nodoc
abstract class _$$ChatListLoadedImplCopyWith<$Res> {
  factory _$$ChatListLoadedImplCopyWith(_$ChatListLoadedImpl value,
          $Res Function(_$ChatListLoadedImpl) then) =
      __$$ChatListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<MwChat> chats, bool isFetchingMore, bool hasMore});
}

/// @nodoc
class __$$ChatListLoadedImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListLoadedImpl>
    implements _$$ChatListLoadedImplCopyWith<$Res> {
  __$$ChatListLoadedImplCopyWithImpl(
      _$ChatListLoadedImpl _value, $Res Function(_$ChatListLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? isFetchingMore = null,
    Object? hasMore = null,
  }) {
    return _then(_$ChatListLoadedImpl(
      chats: null == chats
          ? _value._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<MwChat>,
      isFetchingMore: null == isFetchingMore
          ? _value.isFetchingMore
          : isFetchingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChatListLoadedImpl implements ChatListLoaded {
  const _$ChatListLoadedImpl(
      {required final List<MwChat> chats,
      this.isFetchingMore = false,
      this.hasMore = false})
      : _chats = chats;

  final List<MwChat> _chats;
  @override
  List<MwChat> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  @JsonKey()
  final bool isFetchingMore;
  @override
  @JsonKey()
  final bool hasMore;

  @override
  String toString() {
    return 'ChatListState.loaded(chats: $chats, isFetchingMore: $isFetchingMore, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListLoadedImpl &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.isFetchingMore, isFetchingMore) ||
                other.isFetchingMore == isFetchingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_chats), isFetchingMore, hasMore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListLoadedImplCopyWith<_$ChatListLoadedImpl> get copyWith =>
      __$$ChatListLoadedImplCopyWithImpl<_$ChatListLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwChat> chats, bool isFetchingMore, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(chats, isFetchingMore, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(chats, isFetchingMore, hasMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(chats, isFetchingMore, hasMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ChatListLoaded implements ChatListState {
  const factory ChatListLoaded(
      {required final List<MwChat> chats,
      final bool isFetchingMore,
      final bool hasMore}) = _$ChatListLoadedImpl;

  List<MwChat> get chats;
  bool get isFetchingMore;
  bool get hasMore;
  @JsonKey(ignore: true)
  _$$ChatListLoadedImplCopyWith<_$ChatListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatListErrorImplCopyWith<$Res> {
  factory _$$ChatListErrorImplCopyWith(
          _$ChatListErrorImpl value, $Res Function(_$ChatListErrorImpl) then) =
      __$$ChatListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatListErrorImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListErrorImpl>
    implements _$$ChatListErrorImplCopyWith<$Res> {
  __$$ChatListErrorImplCopyWithImpl(
      _$ChatListErrorImpl _value, $Res Function(_$ChatListErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatListErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChatListErrorImpl implements ChatListError {
  const _$ChatListErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListErrorImplCopyWith<_$ChatListErrorImpl> get copyWith =>
      __$$ChatListErrorImplCopyWithImpl<_$ChatListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwChat> chats, bool isFetchingMore, bool hasMore)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<MwChat> chats, bool isFetchingMore, bool hasMore)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatListError implements ChatListState {
  const factory ChatListError(final String message) = _$ChatListErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ChatListErrorImplCopyWith<_$ChatListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
