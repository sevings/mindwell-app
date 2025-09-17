// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_messages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatMessagesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessagesLoading value) loading,
    required TResult Function(ChatMessagesLoaded value) loaded,
    required TResult Function(ChatMessagesError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessagesLoading value)? loading,
    TResult? Function(ChatMessagesLoaded value)? loaded,
    TResult? Function(ChatMessagesError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessagesLoading value)? loading,
    TResult Function(ChatMessagesLoaded value)? loaded,
    TResult Function(ChatMessagesError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessagesStateCopyWith<$Res> {
  factory $ChatMessagesStateCopyWith(
          ChatMessagesState value, $Res Function(ChatMessagesState) then) =
      _$ChatMessagesStateCopyWithImpl<$Res, ChatMessagesState>;
}

/// @nodoc
class _$ChatMessagesStateCopyWithImpl<$Res, $Val extends ChatMessagesState>
    implements $ChatMessagesStateCopyWith<$Res> {
  _$ChatMessagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatMessagesLoadingImplCopyWith<$Res> {
  factory _$$ChatMessagesLoadingImplCopyWith(_$ChatMessagesLoadingImpl value,
          $Res Function(_$ChatMessagesLoadingImpl) then) =
      __$$ChatMessagesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatMessagesLoadingImplCopyWithImpl<$Res>
    extends _$ChatMessagesStateCopyWithImpl<$Res, _$ChatMessagesLoadingImpl>
    implements _$$ChatMessagesLoadingImplCopyWith<$Res> {
  __$$ChatMessagesLoadingImplCopyWithImpl(_$ChatMessagesLoadingImpl _value,
      $Res Function(_$ChatMessagesLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatMessagesLoadingImpl implements ChatMessagesLoading {
  const _$ChatMessagesLoadingImpl();

  @override
  String toString() {
    return 'ChatMessagesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessagesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
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
    required TResult Function(ChatMessagesLoading value) loading,
    required TResult Function(ChatMessagesLoaded value) loaded,
    required TResult Function(ChatMessagesError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessagesLoading value)? loading,
    TResult? Function(ChatMessagesLoaded value)? loaded,
    TResult? Function(ChatMessagesError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessagesLoading value)? loading,
    TResult Function(ChatMessagesLoaded value)? loaded,
    TResult Function(ChatMessagesError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatMessagesLoading implements ChatMessagesState {
  const factory ChatMessagesLoading() = _$ChatMessagesLoadingImpl;
}

/// @nodoc
abstract class _$$ChatMessagesLoadedImplCopyWith<$Res> {
  factory _$$ChatMessagesLoadedImplCopyWith(_$ChatMessagesLoadedImpl value,
          $Res Function(_$ChatMessagesLoadedImpl) then) =
      __$$ChatMessagesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<MwMessage> messages,
      Map<int, MessageStatus> messageStatus,
      bool isFetchingMore,
      bool hasMore,
      bool isSending,
      ConnectionStatus connectionStatus,
      Set<int> readMessageIds,
      List<MwMessage> queuedMessages});
}

/// @nodoc
class __$$ChatMessagesLoadedImplCopyWithImpl<$Res>
    extends _$ChatMessagesStateCopyWithImpl<$Res, _$ChatMessagesLoadedImpl>
    implements _$$ChatMessagesLoadedImplCopyWith<$Res> {
  __$$ChatMessagesLoadedImplCopyWithImpl(_$ChatMessagesLoadedImpl _value,
      $Res Function(_$ChatMessagesLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? messageStatus = null,
    Object? isFetchingMore = null,
    Object? hasMore = null,
    Object? isSending = null,
    Object? connectionStatus = null,
    Object? readMessageIds = null,
    Object? queuedMessages = null,
  }) {
    return _then(_$ChatMessagesLoadedImpl(
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MwMessage>,
      messageStatus: null == messageStatus
          ? _value._messageStatus
          : messageStatus // ignore: cast_nullable_to_non_nullable
              as Map<int, MessageStatus>,
      isFetchingMore: null == isFetchingMore
          ? _value.isFetchingMore
          : isFetchingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as ConnectionStatus,
      readMessageIds: null == readMessageIds
          ? _value._readMessageIds
          : readMessageIds // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      queuedMessages: null == queuedMessages
          ? _value._queuedMessages
          : queuedMessages // ignore: cast_nullable_to_non_nullable
              as List<MwMessage>,
    ));
  }
}

/// @nodoc

class _$ChatMessagesLoadedImpl implements ChatMessagesLoaded {
  const _$ChatMessagesLoadedImpl(
      {required final List<MwMessage> messages,
      final Map<int, MessageStatus> messageStatus = const {},
      this.isFetchingMore = false,
      this.hasMore = false,
      this.isSending = false,
      this.connectionStatus = ConnectionStatus.unknown,
      final Set<int> readMessageIds = const {},
      final List<MwMessage> queuedMessages = const []})
      : _messages = messages,
        _messageStatus = messageStatus,
        _readMessageIds = readMessageIds,
        _queuedMessages = queuedMessages;

  final List<MwMessage> _messages;
  @override
  List<MwMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final Map<int, MessageStatus> _messageStatus;
  @override
  @JsonKey()
  Map<int, MessageStatus> get messageStatus {
    if (_messageStatus is EqualUnmodifiableMapView) return _messageStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_messageStatus);
  }

  @override
  @JsonKey()
  final bool isFetchingMore;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final ConnectionStatus connectionStatus;
  final Set<int> _readMessageIds;
  @override
  @JsonKey()
  Set<int> get readMessageIds {
    if (_readMessageIds is EqualUnmodifiableSetView) return _readMessageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_readMessageIds);
  }

  final List<MwMessage> _queuedMessages;
  @override
  @JsonKey()
  List<MwMessage> get queuedMessages {
    if (_queuedMessages is EqualUnmodifiableListView) return _queuedMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queuedMessages);
  }

  @override
  String toString() {
    return 'ChatMessagesState.loaded(messages: $messages, messageStatus: $messageStatus, isFetchingMore: $isFetchingMore, hasMore: $hasMore, isSending: $isSending, connectionStatus: $connectionStatus, readMessageIds: $readMessageIds, queuedMessages: $queuedMessages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessagesLoadedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality()
                .equals(other._messageStatus, _messageStatus) &&
            (identical(other.isFetchingMore, isFetchingMore) ||
                other.isFetchingMore == isFetchingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.connectionStatus, connectionStatus) ||
                other.connectionStatus == connectionStatus) &&
            const DeepCollectionEquality()
                .equals(other._readMessageIds, _readMessageIds) &&
            const DeepCollectionEquality()
                .equals(other._queuedMessages, _queuedMessages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_messageStatus),
      isFetchingMore,
      hasMore,
      isSending,
      connectionStatus,
      const DeepCollectionEquality().hash(_readMessageIds),
      const DeepCollectionEquality().hash(_queuedMessages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessagesLoadedImplCopyWith<_$ChatMessagesLoadedImpl> get copyWith =>
      __$$ChatMessagesLoadedImplCopyWithImpl<_$ChatMessagesLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(messages, messageStatus, isFetchingMore, hasMore, isSending,
        connectionStatus, readMessageIds, queuedMessages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(messages, messageStatus, isFetchingMore, hasMore,
        isSending, connectionStatus, readMessageIds, queuedMessages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(messages, messageStatus, isFetchingMore, hasMore, isSending,
          connectionStatus, readMessageIds, queuedMessages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatMessagesLoading value) loading,
    required TResult Function(ChatMessagesLoaded value) loaded,
    required TResult Function(ChatMessagesError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessagesLoading value)? loading,
    TResult? Function(ChatMessagesLoaded value)? loaded,
    TResult? Function(ChatMessagesError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessagesLoading value)? loading,
    TResult Function(ChatMessagesLoaded value)? loaded,
    TResult Function(ChatMessagesError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ChatMessagesLoaded implements ChatMessagesState {
  const factory ChatMessagesLoaded(
      {required final List<MwMessage> messages,
      final Map<int, MessageStatus> messageStatus,
      final bool isFetchingMore,
      final bool hasMore,
      final bool isSending,
      final ConnectionStatus connectionStatus,
      final Set<int> readMessageIds,
      final List<MwMessage> queuedMessages}) = _$ChatMessagesLoadedImpl;

  List<MwMessage> get messages;
  Map<int, MessageStatus> get messageStatus;
  bool get isFetchingMore;
  bool get hasMore;
  bool get isSending;
  ConnectionStatus get connectionStatus;
  Set<int> get readMessageIds;
  List<MwMessage> get queuedMessages;
  @JsonKey(ignore: true)
  _$$ChatMessagesLoadedImplCopyWith<_$ChatMessagesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatMessagesErrorImplCopyWith<$Res> {
  factory _$$ChatMessagesErrorImplCopyWith(_$ChatMessagesErrorImpl value,
          $Res Function(_$ChatMessagesErrorImpl) then) =
      __$$ChatMessagesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatMessagesErrorImplCopyWithImpl<$Res>
    extends _$ChatMessagesStateCopyWithImpl<$Res, _$ChatMessagesErrorImpl>
    implements _$$ChatMessagesErrorImplCopyWith<$Res> {
  __$$ChatMessagesErrorImplCopyWithImpl(_$ChatMessagesErrorImpl _value,
      $Res Function(_$ChatMessagesErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ChatMessagesErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChatMessagesErrorImpl implements ChatMessagesError {
  const _$ChatMessagesErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatMessagesState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessagesErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessagesErrorImplCopyWith<_$ChatMessagesErrorImpl> get copyWith =>
      __$$ChatMessagesErrorImplCopyWithImpl<_$ChatMessagesErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            List<MwMessage> messages,
            Map<int, MessageStatus> messageStatus,
            bool isFetchingMore,
            bool hasMore,
            bool isSending,
            ConnectionStatus connectionStatus,
            Set<int> readMessageIds,
            List<MwMessage> queuedMessages)?
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
    required TResult Function(ChatMessagesLoading value) loading,
    required TResult Function(ChatMessagesLoaded value) loaded,
    required TResult Function(ChatMessagesError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatMessagesLoading value)? loading,
    TResult? Function(ChatMessagesLoaded value)? loaded,
    TResult? Function(ChatMessagesError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatMessagesLoading value)? loading,
    TResult Function(ChatMessagesLoaded value)? loaded,
    TResult Function(ChatMessagesError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatMessagesError implements ChatMessagesState {
  const factory ChatMessagesError(final String message) =
      _$ChatMessagesErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ChatMessagesErrorImplCopyWith<_$ChatMessagesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
