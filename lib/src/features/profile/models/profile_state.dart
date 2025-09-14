import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindwell_api/mindwell_api.dart';

part 'profile_state.freezed.dart';

/// Represents the state of a user profile screen.
/// 
/// This sealed class uses freezed to ensure immutability and provides
/// different states for various profile loading scenarios.
@freezed
sealed class ProfileState with _$ProfileState {
  /// Initial state when the profile screen is first loaded.
  const factory ProfileState.initial() = _Initial;

  /// Loading state when profile data is being fetched.
  const factory ProfileState.loading() = _Loading;

  /// Loaded state when all profile data has been successfully fetched.
  /// 
  /// [user] The user information from the API.
  /// [badges] List of badges earned by the user.
  /// [images] List of images uploaded by the user.
  /// [tags] List of tags used by the user with their counts.
  /// [calendarData] Calendar data showing user activity over time.
  const factory ProfileState.loaded({
    required MwProfile user,
    @Default([]) List<MwBadge> badges,
    @Default([]) List<MwImage> images,
    @Default([]) List<MwTagListDataInner> tags,
    MwCalendar? calendarData,
  }) = _Loaded;

  /// Error state when profile data fetching fails.
  /// 
  /// [message] The error message describing what went wrong.
  const factory ProfileState.error({
    required String message,
  }) = _Error;
}
