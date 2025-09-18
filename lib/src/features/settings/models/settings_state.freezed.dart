// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmailSettings {
  bool get comments => throw _privateConstructorUsedError;
  bool get followers => throw _privateConstructorUsedError;
  bool get invites => throw _privateConstructorUsedError;
  bool get movedEntries => throw _privateConstructorUsedError;
  bool get badges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailSettingsCopyWith<EmailSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailSettingsCopyWith<$Res> {
  factory $EmailSettingsCopyWith(
          EmailSettings value, $Res Function(EmailSettings) then) =
      _$EmailSettingsCopyWithImpl<$Res, EmailSettings>;
  @useResult
  $Res call(
      {bool comments,
      bool followers,
      bool invites,
      bool movedEntries,
      bool badges});
}

/// @nodoc
class _$EmailSettingsCopyWithImpl<$Res, $Val extends EmailSettings>
    implements $EmailSettingsCopyWith<$Res> {
  _$EmailSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? followers = null,
    Object? invites = null,
    Object? movedEntries = null,
    Object? badges = null,
  }) {
    return _then(_value.copyWith(
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as bool,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as bool,
      invites: null == invites
          ? _value.invites
          : invites // ignore: cast_nullable_to_non_nullable
              as bool,
      movedEntries: null == movedEntries
          ? _value.movedEntries
          : movedEntries // ignore: cast_nullable_to_non_nullable
              as bool,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailSettingsImplCopyWith<$Res>
    implements $EmailSettingsCopyWith<$Res> {
  factory _$$EmailSettingsImplCopyWith(
          _$EmailSettingsImpl value, $Res Function(_$EmailSettingsImpl) then) =
      __$$EmailSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool comments,
      bool followers,
      bool invites,
      bool movedEntries,
      bool badges});
}

/// @nodoc
class __$$EmailSettingsImplCopyWithImpl<$Res>
    extends _$EmailSettingsCopyWithImpl<$Res, _$EmailSettingsImpl>
    implements _$$EmailSettingsImplCopyWith<$Res> {
  __$$EmailSettingsImplCopyWithImpl(
      _$EmailSettingsImpl _value, $Res Function(_$EmailSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? followers = null,
    Object? invites = null,
    Object? movedEntries = null,
    Object? badges = null,
  }) {
    return _then(_$EmailSettingsImpl(
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as bool,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as bool,
      invites: null == invites
          ? _value.invites
          : invites // ignore: cast_nullable_to_non_nullable
              as bool,
      movedEntries: null == movedEntries
          ? _value.movedEntries
          : movedEntries // ignore: cast_nullable_to_non_nullable
              as bool,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EmailSettingsImpl implements _EmailSettings {
  const _$EmailSettingsImpl(
      {this.comments = false,
      this.followers = false,
      this.invites = false,
      this.movedEntries = false,
      this.badges = false});

  @override
  @JsonKey()
  final bool comments;
  @override
  @JsonKey()
  final bool followers;
  @override
  @JsonKey()
  final bool invites;
  @override
  @JsonKey()
  final bool movedEntries;
  @override
  @JsonKey()
  final bool badges;

  @override
  String toString() {
    return 'EmailSettings(comments: $comments, followers: $followers, invites: $invites, movedEntries: $movedEntries, badges: $badges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailSettingsImpl &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.invites, invites) || other.invites == invites) &&
            (identical(other.movedEntries, movedEntries) ||
                other.movedEntries == movedEntries) &&
            (identical(other.badges, badges) || other.badges == badges));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, comments, followers, invites, movedEntries, badges);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailSettingsImplCopyWith<_$EmailSettingsImpl> get copyWith =>
      __$$EmailSettingsImplCopyWithImpl<_$EmailSettingsImpl>(this, _$identity);
}

abstract class _EmailSettings implements EmailSettings {
  const factory _EmailSettings(
      {final bool comments,
      final bool followers,
      final bool invites,
      final bool movedEntries,
      final bool badges}) = _$EmailSettingsImpl;

  @override
  bool get comments;
  @override
  bool get followers;
  @override
  bool get invites;
  @override
  bool get movedEntries;
  @override
  bool get badges;
  @override
  @JsonKey(ignore: true)
  _$$EmailSettingsImplCopyWith<_$EmailSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TelegramSettings {
  bool get comments => throw _privateConstructorUsedError;
  bool get followers => throw _privateConstructorUsedError;
  bool get invites => throw _privateConstructorUsedError;
  bool get messages => throw _privateConstructorUsedError;
  bool get movedEntries => throw _privateConstructorUsedError;
  bool get badges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TelegramSettingsCopyWith<TelegramSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramSettingsCopyWith<$Res> {
  factory $TelegramSettingsCopyWith(
          TelegramSettings value, $Res Function(TelegramSettings) then) =
      _$TelegramSettingsCopyWithImpl<$Res, TelegramSettings>;
  @useResult
  $Res call(
      {bool comments,
      bool followers,
      bool invites,
      bool messages,
      bool movedEntries,
      bool badges});
}

/// @nodoc
class _$TelegramSettingsCopyWithImpl<$Res, $Val extends TelegramSettings>
    implements $TelegramSettingsCopyWith<$Res> {
  _$TelegramSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? followers = null,
    Object? invites = null,
    Object? messages = null,
    Object? movedEntries = null,
    Object? badges = null,
  }) {
    return _then(_value.copyWith(
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as bool,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as bool,
      invites: null == invites
          ? _value.invites
          : invites // ignore: cast_nullable_to_non_nullable
              as bool,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as bool,
      movedEntries: null == movedEntries
          ? _value.movedEntries
          : movedEntries // ignore: cast_nullable_to_non_nullable
              as bool,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelegramSettingsImplCopyWith<$Res>
    implements $TelegramSettingsCopyWith<$Res> {
  factory _$$TelegramSettingsImplCopyWith(_$TelegramSettingsImpl value,
          $Res Function(_$TelegramSettingsImpl) then) =
      __$$TelegramSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool comments,
      bool followers,
      bool invites,
      bool messages,
      bool movedEntries,
      bool badges});
}

/// @nodoc
class __$$TelegramSettingsImplCopyWithImpl<$Res>
    extends _$TelegramSettingsCopyWithImpl<$Res, _$TelegramSettingsImpl>
    implements _$$TelegramSettingsImplCopyWith<$Res> {
  __$$TelegramSettingsImplCopyWithImpl(_$TelegramSettingsImpl _value,
      $Res Function(_$TelegramSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
    Object? followers = null,
    Object? invites = null,
    Object? messages = null,
    Object? movedEntries = null,
    Object? badges = null,
  }) {
    return _then(_$TelegramSettingsImpl(
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as bool,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as bool,
      invites: null == invites
          ? _value.invites
          : invites // ignore: cast_nullable_to_non_nullable
              as bool,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as bool,
      movedEntries: null == movedEntries
          ? _value.movedEntries
          : movedEntries // ignore: cast_nullable_to_non_nullable
              as bool,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TelegramSettingsImpl implements _TelegramSettings {
  const _$TelegramSettingsImpl(
      {this.comments = false,
      this.followers = false,
      this.invites = false,
      this.messages = false,
      this.movedEntries = false,
      this.badges = false});

  @override
  @JsonKey()
  final bool comments;
  @override
  @JsonKey()
  final bool followers;
  @override
  @JsonKey()
  final bool invites;
  @override
  @JsonKey()
  final bool messages;
  @override
  @JsonKey()
  final bool movedEntries;
  @override
  @JsonKey()
  final bool badges;

  @override
  String toString() {
    return 'TelegramSettings(comments: $comments, followers: $followers, invites: $invites, messages: $messages, movedEntries: $movedEntries, badges: $badges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelegramSettingsImpl &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.followers, followers) ||
                other.followers == followers) &&
            (identical(other.invites, invites) || other.invites == invites) &&
            (identical(other.messages, messages) ||
                other.messages == messages) &&
            (identical(other.movedEntries, movedEntries) ||
                other.movedEntries == movedEntries) &&
            (identical(other.badges, badges) || other.badges == badges));
  }

  @override
  int get hashCode => Object.hash(runtimeType, comments, followers, invites,
      messages, movedEntries, badges);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelegramSettingsImplCopyWith<_$TelegramSettingsImpl> get copyWith =>
      __$$TelegramSettingsImplCopyWithImpl<_$TelegramSettingsImpl>(
          this, _$identity);
}

abstract class _TelegramSettings implements TelegramSettings {
  const factory _TelegramSettings(
      {final bool comments,
      final bool followers,
      final bool invites,
      final bool messages,
      final bool movedEntries,
      final bool badges}) = _$TelegramSettingsImpl;

  @override
  bool get comments;
  @override
  bool get followers;
  @override
  bool get invites;
  @override
  bool get messages;
  @override
  bool get movedEntries;
  @override
  bool get badges;
  @override
  @JsonKey(ignore: true)
  _$$TelegramSettingsImplCopyWith<_$TelegramSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OnsiteSettings {
  bool get wishes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnsiteSettingsCopyWith<OnsiteSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnsiteSettingsCopyWith<$Res> {
  factory $OnsiteSettingsCopyWith(
          OnsiteSettings value, $Res Function(OnsiteSettings) then) =
      _$OnsiteSettingsCopyWithImpl<$Res, OnsiteSettings>;
  @useResult
  $Res call({bool wishes});
}

/// @nodoc
class _$OnsiteSettingsCopyWithImpl<$Res, $Val extends OnsiteSettings>
    implements $OnsiteSettingsCopyWith<$Res> {
  _$OnsiteSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wishes = null,
  }) {
    return _then(_value.copyWith(
      wishes: null == wishes
          ? _value.wishes
          : wishes // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnsiteSettingsImplCopyWith<$Res>
    implements $OnsiteSettingsCopyWith<$Res> {
  factory _$$OnsiteSettingsImplCopyWith(_$OnsiteSettingsImpl value,
          $Res Function(_$OnsiteSettingsImpl) then) =
      __$$OnsiteSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool wishes});
}

/// @nodoc
class __$$OnsiteSettingsImplCopyWithImpl<$Res>
    extends _$OnsiteSettingsCopyWithImpl<$Res, _$OnsiteSettingsImpl>
    implements _$$OnsiteSettingsImplCopyWith<$Res> {
  __$$OnsiteSettingsImplCopyWithImpl(
      _$OnsiteSettingsImpl _value, $Res Function(_$OnsiteSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wishes = null,
  }) {
    return _then(_$OnsiteSettingsImpl(
      wishes: null == wishes
          ? _value.wishes
          : wishes // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OnsiteSettingsImpl implements _OnsiteSettings {
  const _$OnsiteSettingsImpl({this.wishes = false});

  @override
  @JsonKey()
  final bool wishes;

  @override
  String toString() {
    return 'OnsiteSettings(wishes: $wishes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnsiteSettingsImpl &&
            (identical(other.wishes, wishes) || other.wishes == wishes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wishes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnsiteSettingsImplCopyWith<_$OnsiteSettingsImpl> get copyWith =>
      __$$OnsiteSettingsImplCopyWithImpl<_$OnsiteSettingsImpl>(
          this, _$identity);
}

abstract class _OnsiteSettings implements OnsiteSettings {
  const factory _OnsiteSettings({final bool wishes}) = _$OnsiteSettingsImpl;

  @override
  bool get wishes;
  @override
  @JsonKey(ignore: true)
  _$$OnsiteSettingsImplCopyWith<_$OnsiteSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SettingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult Function(String message)? error,
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
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

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
    extends _$SettingsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'SettingsState.initial()';
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
    required TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult Function(String message)? error,
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

abstract class _Initial implements SettingsState {
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
    extends _$SettingsStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'SettingsState.loading()';
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
    required TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
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

abstract class _Loading implements SettingsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {EmailSettings emailSettings,
      TelegramSettings telegramSettings,
      OnsiteSettings onsiteSettings});

  $EmailSettingsCopyWith<$Res> get emailSettings;
  $TelegramSettingsCopyWith<$Res> get telegramSettings;
  $OnsiteSettingsCopyWith<$Res> get onsiteSettings;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailSettings = null,
    Object? telegramSettings = null,
    Object? onsiteSettings = null,
  }) {
    return _then(_$LoadedImpl(
      emailSettings: null == emailSettings
          ? _value.emailSettings
          : emailSettings // ignore: cast_nullable_to_non_nullable
              as EmailSettings,
      telegramSettings: null == telegramSettings
          ? _value.telegramSettings
          : telegramSettings // ignore: cast_nullable_to_non_nullable
              as TelegramSettings,
      onsiteSettings: null == onsiteSettings
          ? _value.onsiteSettings
          : onsiteSettings // ignore: cast_nullable_to_non_nullable
              as OnsiteSettings,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $EmailSettingsCopyWith<$Res> get emailSettings {
    return $EmailSettingsCopyWith<$Res>(_value.emailSettings, (value) {
      return _then(_value.copyWith(emailSettings: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TelegramSettingsCopyWith<$Res> get telegramSettings {
    return $TelegramSettingsCopyWith<$Res>(_value.telegramSettings, (value) {
      return _then(_value.copyWith(telegramSettings: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OnsiteSettingsCopyWith<$Res> get onsiteSettings {
    return $OnsiteSettingsCopyWith<$Res>(_value.onsiteSettings, (value) {
      return _then(_value.copyWith(onsiteSettings: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.emailSettings,
      required this.telegramSettings,
      required this.onsiteSettings});

  @override
  final EmailSettings emailSettings;
  @override
  final TelegramSettings telegramSettings;
  @override
  final OnsiteSettings onsiteSettings;

  @override
  String toString() {
    return 'SettingsState.loaded(emailSettings: $emailSettings, telegramSettings: $telegramSettings, onsiteSettings: $onsiteSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.emailSettings, emailSettings) ||
                other.emailSettings == emailSettings) &&
            (identical(other.telegramSettings, telegramSettings) ||
                other.telegramSettings == telegramSettings) &&
            (identical(other.onsiteSettings, onsiteSettings) ||
                other.onsiteSettings == onsiteSettings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, emailSettings, telegramSettings, onsiteSettings);

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
    required TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(emailSettings, telegramSettings, onsiteSettings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(emailSettings, telegramSettings, onsiteSettings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(emailSettings, telegramSettings, onsiteSettings);
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

abstract class _Loaded implements SettingsState {
  const factory _Loaded(
      {required final EmailSettings emailSettings,
      required final TelegramSettings telegramSettings,
      required final OnsiteSettings onsiteSettings}) = _$LoadedImpl;

  EmailSettings get emailSettings;
  TelegramSettings get telegramSettings;
  OnsiteSettings get onsiteSettings;
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
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SettingsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

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
    required TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(EmailSettings emailSettings,
            TelegramSettings telegramSettings, OnsiteSettings onsiteSettings)?
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

abstract class _Error implements SettingsState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
