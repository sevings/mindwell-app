// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageAction {
  int get messageId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int messageId, String currentContent) edit,
    required TResult Function(int messageId) delete,
    required TResult Function(int messageId, String? reason) report,
    required TResult Function(int messageId, String content) retry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int messageId, String currentContent)? edit,
    TResult? Function(int messageId)? delete,
    TResult? Function(int messageId, String? reason)? report,
    TResult? Function(int messageId, String content)? retry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int messageId, String currentContent)? edit,
    TResult Function(int messageId)? delete,
    TResult Function(int messageId, String? reason)? report,
    TResult Function(int messageId, String content)? retry,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMessageAction value) edit,
    required TResult Function(DeleteMessageAction value) delete,
    required TResult Function(ReportMessageAction value) report,
    required TResult Function(RetryMessageAction value) retry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMessageAction value)? edit,
    TResult? Function(DeleteMessageAction value)? delete,
    TResult? Function(ReportMessageAction value)? report,
    TResult? Function(RetryMessageAction value)? retry,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMessageAction value)? edit,
    TResult Function(DeleteMessageAction value)? delete,
    TResult Function(ReportMessageAction value)? report,
    TResult Function(RetryMessageAction value)? retry,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageActionCopyWith<MessageAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageActionCopyWith<$Res> {
  factory $MessageActionCopyWith(
          MessageAction value, $Res Function(MessageAction) then) =
      _$MessageActionCopyWithImpl<$Res, MessageAction>;
  @useResult
  $Res call({int messageId});
}

/// @nodoc
class _$MessageActionCopyWithImpl<$Res, $Val extends MessageAction>
    implements $MessageActionCopyWith<$Res> {
  _$MessageActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditMessageActionImplCopyWith<$Res>
    implements $MessageActionCopyWith<$Res> {
  factory _$$EditMessageActionImplCopyWith(_$EditMessageActionImpl value,
          $Res Function(_$EditMessageActionImpl) then) =
      __$$EditMessageActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int messageId, String currentContent});
}

/// @nodoc
class __$$EditMessageActionImplCopyWithImpl<$Res>
    extends _$MessageActionCopyWithImpl<$Res, _$EditMessageActionImpl>
    implements _$$EditMessageActionImplCopyWith<$Res> {
  __$$EditMessageActionImplCopyWithImpl(_$EditMessageActionImpl _value,
      $Res Function(_$EditMessageActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? currentContent = null,
  }) {
    return _then(_$EditMessageActionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      currentContent: null == currentContent
          ? _value.currentContent
          : currentContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EditMessageActionImpl implements EditMessageAction {
  const _$EditMessageActionImpl(
      {required this.messageId, required this.currentContent});

  @override
  final int messageId;
  @override
  final String currentContent;

  @override
  String toString() {
    return 'MessageAction.edit(messageId: $messageId, currentContent: $currentContent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMessageActionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.currentContent, currentContent) ||
                other.currentContent == currentContent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, currentContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMessageActionImplCopyWith<_$EditMessageActionImpl> get copyWith =>
      __$$EditMessageActionImplCopyWithImpl<_$EditMessageActionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int messageId, String currentContent) edit,
    required TResult Function(int messageId) delete,
    required TResult Function(int messageId, String? reason) report,
    required TResult Function(int messageId, String content) retry,
  }) {
    return edit(messageId, currentContent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int messageId, String currentContent)? edit,
    TResult? Function(int messageId)? delete,
    TResult? Function(int messageId, String? reason)? report,
    TResult? Function(int messageId, String content)? retry,
  }) {
    return edit?.call(messageId, currentContent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int messageId, String currentContent)? edit,
    TResult Function(int messageId)? delete,
    TResult Function(int messageId, String? reason)? report,
    TResult Function(int messageId, String content)? retry,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(messageId, currentContent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMessageAction value) edit,
    required TResult Function(DeleteMessageAction value) delete,
    required TResult Function(ReportMessageAction value) report,
    required TResult Function(RetryMessageAction value) retry,
  }) {
    return edit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMessageAction value)? edit,
    TResult? Function(DeleteMessageAction value)? delete,
    TResult? Function(ReportMessageAction value)? report,
    TResult? Function(RetryMessageAction value)? retry,
  }) {
    return edit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMessageAction value)? edit,
    TResult Function(DeleteMessageAction value)? delete,
    TResult Function(ReportMessageAction value)? report,
    TResult Function(RetryMessageAction value)? retry,
    required TResult orElse(),
  }) {
    if (edit != null) {
      return edit(this);
    }
    return orElse();
  }
}

abstract class EditMessageAction implements MessageAction {
  const factory EditMessageAction(
      {required final int messageId,
      required final String currentContent}) = _$EditMessageActionImpl;

  @override
  int get messageId;
  String get currentContent;
  @override
  @JsonKey(ignore: true)
  _$$EditMessageActionImplCopyWith<_$EditMessageActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteMessageActionImplCopyWith<$Res>
    implements $MessageActionCopyWith<$Res> {
  factory _$$DeleteMessageActionImplCopyWith(_$DeleteMessageActionImpl value,
          $Res Function(_$DeleteMessageActionImpl) then) =
      __$$DeleteMessageActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int messageId});
}

/// @nodoc
class __$$DeleteMessageActionImplCopyWithImpl<$Res>
    extends _$MessageActionCopyWithImpl<$Res, _$DeleteMessageActionImpl>
    implements _$$DeleteMessageActionImplCopyWith<$Res> {
  __$$DeleteMessageActionImplCopyWithImpl(_$DeleteMessageActionImpl _value,
      $Res Function(_$DeleteMessageActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
  }) {
    return _then(_$DeleteMessageActionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteMessageActionImpl implements DeleteMessageAction {
  const _$DeleteMessageActionImpl({required this.messageId});

  @override
  final int messageId;

  @override
  String toString() {
    return 'MessageAction.delete(messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteMessageActionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteMessageActionImplCopyWith<_$DeleteMessageActionImpl> get copyWith =>
      __$$DeleteMessageActionImplCopyWithImpl<_$DeleteMessageActionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int messageId, String currentContent) edit,
    required TResult Function(int messageId) delete,
    required TResult Function(int messageId, String? reason) report,
    required TResult Function(int messageId, String content) retry,
  }) {
    return delete(messageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int messageId, String currentContent)? edit,
    TResult? Function(int messageId)? delete,
    TResult? Function(int messageId, String? reason)? report,
    TResult? Function(int messageId, String content)? retry,
  }) {
    return delete?.call(messageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int messageId, String currentContent)? edit,
    TResult Function(int messageId)? delete,
    TResult Function(int messageId, String? reason)? report,
    TResult Function(int messageId, String content)? retry,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(messageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMessageAction value) edit,
    required TResult Function(DeleteMessageAction value) delete,
    required TResult Function(ReportMessageAction value) report,
    required TResult Function(RetryMessageAction value) retry,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMessageAction value)? edit,
    TResult? Function(DeleteMessageAction value)? delete,
    TResult? Function(ReportMessageAction value)? report,
    TResult? Function(RetryMessageAction value)? retry,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMessageAction value)? edit,
    TResult Function(DeleteMessageAction value)? delete,
    TResult Function(ReportMessageAction value)? report,
    TResult Function(RetryMessageAction value)? retry,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class DeleteMessageAction implements MessageAction {
  const factory DeleteMessageAction({required final int messageId}) =
      _$DeleteMessageActionImpl;

  @override
  int get messageId;
  @override
  @JsonKey(ignore: true)
  _$$DeleteMessageActionImplCopyWith<_$DeleteMessageActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReportMessageActionImplCopyWith<$Res>
    implements $MessageActionCopyWith<$Res> {
  factory _$$ReportMessageActionImplCopyWith(_$ReportMessageActionImpl value,
          $Res Function(_$ReportMessageActionImpl) then) =
      __$$ReportMessageActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int messageId, String? reason});
}

/// @nodoc
class __$$ReportMessageActionImplCopyWithImpl<$Res>
    extends _$MessageActionCopyWithImpl<$Res, _$ReportMessageActionImpl>
    implements _$$ReportMessageActionImplCopyWith<$Res> {
  __$$ReportMessageActionImplCopyWithImpl(_$ReportMessageActionImpl _value,
      $Res Function(_$ReportMessageActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? reason = freezed,
  }) {
    return _then(_$ReportMessageActionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReportMessageActionImpl implements ReportMessageAction {
  const _$ReportMessageActionImpl({required this.messageId, this.reason});

  @override
  final int messageId;
  @override
  final String? reason;

  @override
  String toString() {
    return 'MessageAction.report(messageId: $messageId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportMessageActionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportMessageActionImplCopyWith<_$ReportMessageActionImpl> get copyWith =>
      __$$ReportMessageActionImplCopyWithImpl<_$ReportMessageActionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int messageId, String currentContent) edit,
    required TResult Function(int messageId) delete,
    required TResult Function(int messageId, String? reason) report,
    required TResult Function(int messageId, String content) retry,
  }) {
    return report(messageId, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int messageId, String currentContent)? edit,
    TResult? Function(int messageId)? delete,
    TResult? Function(int messageId, String? reason)? report,
    TResult? Function(int messageId, String content)? retry,
  }) {
    return report?.call(messageId, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int messageId, String currentContent)? edit,
    TResult Function(int messageId)? delete,
    TResult Function(int messageId, String? reason)? report,
    TResult Function(int messageId, String content)? retry,
    required TResult orElse(),
  }) {
    if (report != null) {
      return report(messageId, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMessageAction value) edit,
    required TResult Function(DeleteMessageAction value) delete,
    required TResult Function(ReportMessageAction value) report,
    required TResult Function(RetryMessageAction value) retry,
  }) {
    return report(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMessageAction value)? edit,
    TResult? Function(DeleteMessageAction value)? delete,
    TResult? Function(ReportMessageAction value)? report,
    TResult? Function(RetryMessageAction value)? retry,
  }) {
    return report?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMessageAction value)? edit,
    TResult Function(DeleteMessageAction value)? delete,
    TResult Function(ReportMessageAction value)? report,
    TResult Function(RetryMessageAction value)? retry,
    required TResult orElse(),
  }) {
    if (report != null) {
      return report(this);
    }
    return orElse();
  }
}

abstract class ReportMessageAction implements MessageAction {
  const factory ReportMessageAction(
      {required final int messageId,
      final String? reason}) = _$ReportMessageActionImpl;

  @override
  int get messageId;
  String? get reason;
  @override
  @JsonKey(ignore: true)
  _$$ReportMessageActionImplCopyWith<_$ReportMessageActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RetryMessageActionImplCopyWith<$Res>
    implements $MessageActionCopyWith<$Res> {
  factory _$$RetryMessageActionImplCopyWith(_$RetryMessageActionImpl value,
          $Res Function(_$RetryMessageActionImpl) then) =
      __$$RetryMessageActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int messageId, String content});
}

/// @nodoc
class __$$RetryMessageActionImplCopyWithImpl<$Res>
    extends _$MessageActionCopyWithImpl<$Res, _$RetryMessageActionImpl>
    implements _$$RetryMessageActionImplCopyWith<$Res> {
  __$$RetryMessageActionImplCopyWithImpl(_$RetryMessageActionImpl _value,
      $Res Function(_$RetryMessageActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? content = null,
  }) {
    return _then(_$RetryMessageActionImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RetryMessageActionImpl implements RetryMessageAction {
  const _$RetryMessageActionImpl(
      {required this.messageId, required this.content});

  @override
  final int messageId;
  @override
  final String content;

  @override
  String toString() {
    return 'MessageAction.retry(messageId: $messageId, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RetryMessageActionImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageId, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RetryMessageActionImplCopyWith<_$RetryMessageActionImpl> get copyWith =>
      __$$RetryMessageActionImplCopyWithImpl<_$RetryMessageActionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int messageId, String currentContent) edit,
    required TResult Function(int messageId) delete,
    required TResult Function(int messageId, String? reason) report,
    required TResult Function(int messageId, String content) retry,
  }) {
    return retry(messageId, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int messageId, String currentContent)? edit,
    TResult? Function(int messageId)? delete,
    TResult? Function(int messageId, String? reason)? report,
    TResult? Function(int messageId, String content)? retry,
  }) {
    return retry?.call(messageId, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int messageId, String currentContent)? edit,
    TResult Function(int messageId)? delete,
    TResult Function(int messageId, String? reason)? report,
    TResult Function(int messageId, String content)? retry,
    required TResult orElse(),
  }) {
    if (retry != null) {
      return retry(messageId, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EditMessageAction value) edit,
    required TResult Function(DeleteMessageAction value) delete,
    required TResult Function(ReportMessageAction value) report,
    required TResult Function(RetryMessageAction value) retry,
  }) {
    return retry(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EditMessageAction value)? edit,
    TResult? Function(DeleteMessageAction value)? delete,
    TResult? Function(ReportMessageAction value)? report,
    TResult? Function(RetryMessageAction value)? retry,
  }) {
    return retry?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EditMessageAction value)? edit,
    TResult Function(DeleteMessageAction value)? delete,
    TResult Function(ReportMessageAction value)? report,
    TResult Function(RetryMessageAction value)? retry,
    required TResult orElse(),
  }) {
    if (retry != null) {
      return retry(this);
    }
    return orElse();
  }
}

abstract class RetryMessageAction implements MessageAction {
  const factory RetryMessageAction(
      {required final int messageId,
      required final String content}) = _$RetryMessageActionImpl;

  @override
  int get messageId;
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$RetryMessageActionImplCopyWith<_$RetryMessageActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageActionResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) success,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? success,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageActionSuccess value) success,
    required TResult Function(MessageActionError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageActionSuccess value)? success,
    TResult? Function(MessageActionError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageActionSuccess value)? success,
    TResult Function(MessageActionError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageActionResultCopyWith<$Res> {
  factory $MessageActionResultCopyWith(
          MessageActionResult value, $Res Function(MessageActionResult) then) =
      _$MessageActionResultCopyWithImpl<$Res, MessageActionResult>;
}

/// @nodoc
class _$MessageActionResultCopyWithImpl<$Res, $Val extends MessageActionResult>
    implements $MessageActionResultCopyWith<$Res> {
  _$MessageActionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MessageActionSuccessImplCopyWith<$Res> {
  factory _$$MessageActionSuccessImplCopyWith(_$MessageActionSuccessImpl value,
          $Res Function(_$MessageActionSuccessImpl) then) =
      __$$MessageActionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$MessageActionSuccessImplCopyWithImpl<$Res>
    extends _$MessageActionResultCopyWithImpl<$Res, _$MessageActionSuccessImpl>
    implements _$$MessageActionSuccessImplCopyWith<$Res> {
  __$$MessageActionSuccessImplCopyWithImpl(_$MessageActionSuccessImpl _value,
      $Res Function(_$MessageActionSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$MessageActionSuccessImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MessageActionSuccessImpl implements MessageActionSuccess {
  const _$MessageActionSuccessImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'MessageActionResult.success(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageActionSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageActionSuccessImplCopyWith<_$MessageActionSuccessImpl>
      get copyWith =>
          __$$MessageActionSuccessImplCopyWithImpl<_$MessageActionSuccessImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) success,
    required TResult Function(String error) error,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? success,
    TResult? Function(String error)? error,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageActionSuccess value) success,
    required TResult Function(MessageActionError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageActionSuccess value)? success,
    TResult? Function(MessageActionError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageActionSuccess value)? success,
    TResult Function(MessageActionError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class MessageActionSuccess implements MessageActionResult {
  const factory MessageActionSuccess({final String? message}) =
      _$MessageActionSuccessImpl;

  String? get message;
  @JsonKey(ignore: true)
  _$$MessageActionSuccessImplCopyWith<_$MessageActionSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MessageActionErrorImplCopyWith<$Res> {
  factory _$$MessageActionErrorImplCopyWith(_$MessageActionErrorImpl value,
          $Res Function(_$MessageActionErrorImpl) then) =
      __$$MessageActionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$MessageActionErrorImplCopyWithImpl<$Res>
    extends _$MessageActionResultCopyWithImpl<$Res, _$MessageActionErrorImpl>
    implements _$$MessageActionErrorImplCopyWith<$Res> {
  __$$MessageActionErrorImplCopyWithImpl(_$MessageActionErrorImpl _value,
      $Res Function(_$MessageActionErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MessageActionErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MessageActionErrorImpl implements MessageActionError {
  const _$MessageActionErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'MessageActionResult.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageActionErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageActionErrorImplCopyWith<_$MessageActionErrorImpl> get copyWith =>
      __$$MessageActionErrorImplCopyWithImpl<_$MessageActionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) success,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? success,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? success,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MessageActionSuccess value) success,
    required TResult Function(MessageActionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MessageActionSuccess value)? success,
    TResult? Function(MessageActionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MessageActionSuccess value)? success,
    TResult Function(MessageActionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MessageActionError implements MessageActionResult {
  const factory MessageActionError({required final String error}) =
      _$MessageActionErrorImpl;

  String get error;
  @JsonKey(ignore: true)
  _$$MessageActionErrorImplCopyWith<_$MessageActionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
