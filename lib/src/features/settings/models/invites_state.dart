import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'invites_state.freezed.dart';

/// Represents the current invites state of the application.
///
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various invites scenarios.
@freezed
sealed class InvitesState with _$InvitesState {
  /// Initial state when invites haven't been loaded yet.
  const factory InvitesState.initial() = _Initial;

  /// Loading state when invites are being fetched.
  const factory InvitesState.loading() = _Loading;

  /// Loaded state when invites have been successfully fetched.
  ///
  /// [invites] The user's invites data from the API
  const factory InvitesState.loaded({
    required MwAccountInvitesGet200Response invites,
  }) = _Loaded;

  /// Error state when invites operations fail.
  ///
  /// [message] The error message describing what went wrong.
  const factory InvitesState.error({required String message}) = _Error;
}
