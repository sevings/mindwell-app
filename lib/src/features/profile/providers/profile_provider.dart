import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:mindwell_api/mindwell_api.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_provider.dart';
import '../models/profile_state.dart';

/// Provider for the ProfileNotifier that manages the state of a specific user profile.
/// 
/// Takes a [username] as a parameter to create separate providers for each user profile.
final profileProvider = StateNotifierProvider.family<ProfileNotifier, ProfileState, String>(
  (ref, username) {
    final usersApi = ref.read(usersApiProvider);
    final relationsApi = ref.read(relationsApiProvider);
    final meApi = ref.read(meApiProvider);
    
    return ProfileNotifier(
      username: username,
      usersApi: usersApi,
      relationsApi: relationsApi,
      meApi: meApi,
    );
  },
);

/// Provider for the RelationsApi instance.
final relationsApiProvider = Provider<RelationsApi>((ref) {
  final api = ref.read(mindwellApiProvider);
  return api.getRelationsApi();
});

/// Notifier that manages the state and logic for fetching user profile data.
/// 
/// This class handles:
/// - Fetching user profile data from multiple API endpoints in parallel
/// - Managing follow/unfollow/block actions
/// - Updating profile information
/// - Error handling and state management
/// - Optimistic UI updates for user actions
class ProfileNotifier extends StateNotifier<ProfileState> {
  final String _username;
  final UsersApi _usersApi;
  final RelationsApi _relationsApi;
  final MeApi _meApi;
  final Logger _logger = Logger('ProfileNotifier');
  
  bool _isLoading = false;

  ProfileNotifier({
    required String username,
    required UsersApi usersApi,
    required RelationsApi relationsApi,
    required MeApi meApi,
  })  : _username = username,
        _usersApi = usersApi,
        _relationsApi = relationsApi,
        _meApi = meApi,
        super(const ProfileState.initial()) {
    _initialize();
  }

  /// Initialize the notifier by fetching the profile data.
  Future<void> _initialize() async {
    await fetchProfileData();
  }

  /// Fetch all profile data from the API in parallel.
  /// 
  /// This method fetches:
  /// - User profile information
  /// - User badges
  /// - User images
  /// - User tags
  /// - User calendar data
  Future<void> fetchProfileData() async {
    if (_isLoading) {
      return; // Prevent multiple simultaneous loads
    }
    
    _logger.info('Fetching profile data for user $_username');
    state = const ProfileState.loading();
    _isLoading = true;
    
    try {
      // Fetch all profile data in parallel
      final futures = await Future.wait([
        _usersApi.usersNameGet(name: _username),
        _usersApi.usersNameBadgesGet(name: _username),
        _usersApi.usersNameImagesGet(name: _username),
        _usersApi.usersNameTagsGet(name: _username),
        _usersApi.usersNameCalendarGet(name: _username),
      ]);
      
      final profileResponse = futures[0] as Response<MwProfile>;
      final badgesResponse = futures[1] as Response<MwBadgeList>;
      final imagesResponse = futures[2] as Response<MwImageList>;
      final tagsResponse = futures[3] as Response<MwTagList>;
      final calendarResponse = futures[4] as Response<MwCalendar>;
      
      final profile = profileResponse.data;
      if (profile == null) {
        throw Exception('User profile not found');
      }
      
      // Use MwProfile directly for the ProfileState
      final user = profile;
      
      final badges = badgesResponse.data?.data?.toList() ?? [];
      final images = imagesResponse.data?.data?.toList() ?? [];
      final tags = tagsResponse.data?.data?.toList() ?? [];
      final calendarData = calendarResponse.data;
      
      _logger.info('Fetched profile data for user $_username');
      _logger.info('Loaded ${badges.length} badges, ${images.length} images, ${tags.length} tags');
      
      state = ProfileState.loaded(
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      );
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to fetch profile data for user $_username', e, stackTrace);
      state = ProfileState.error(
        message: _getErrorMessage(e),
      );
    } finally {
      _isLoading = false;
    }
  }

  /// Follow the user.
  /// 
  /// This method:
  /// 1. Makes an API call to follow the user
  /// 2. Refetches the profile data to update the UI
  Future<void> followUser() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (user, badges, images, tags, calendarData) => (
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      ),
      error: (message) => null,
    );
    
    if (currentState == null) return;
    
    try {
      _logger.info('Following user $_username');
      
      // Make API call to follow user using RelationsApi
      await _relationsApi.relationsToNamePut(name: _username, r: 'followed');
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully followed user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to follow user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Unfollow the user.
  /// 
  /// This method:
  /// 1. Makes an API call to unfollow the user
  /// 2. Refetches the profile data to update the UI
  Future<void> unfollowUser() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (user, badges, images, tags, calendarData) => (
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      ),
      error: (message) => null,
    );
    
    if (currentState == null) return;
    
    try {
      _logger.info('Unfollowing user $_username');
      
      // Make API call to unfollow user using RelationsApi
      await _relationsApi.relationsToNameDelete(name: _username);
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully unfollowed user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to unfollow user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Block the user.
  /// 
  /// This method:
  /// 1. Makes an API call to block the user
  /// 2. Refetches the profile data to update the UI
  Future<void> blockUser() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (user, badges, images, tags, calendarData) => (
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      ),
      error: (message) => null,
    );
    
    if (currentState == null) return;
    
    try {
      _logger.info('Blocking user $_username');
      
      // Make API call to block user using RelationsApi
      await _relationsApi.relationsToNamePut(name: _username, r: 'ignored');
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully blocked user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to block user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Unblock the user.
  /// 
  /// This method:
  /// 1. Makes an API call to unblock the user
  /// 2. Refetches the profile data to update the UI
  Future<void> unblockUser() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (user, badges, images, tags, calendarData) => (
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      ),
      error: (message) => null,
    );
    
    if (currentState == null) return;
    
    try {
      _logger.info('Unblocking user $_username');
      
      // Make API call to unblock user using RelationsApi
      await _relationsApi.relationsToNamePut(name: _username, r: 'none');
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully unblocked user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to unblock user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Hide the user from live feed.
  /// 
  /// This method:
  /// 1. Makes an API call to hide the user from live
  /// 2. Refetches the profile data to update the UI
  Future<void> hideFromLive() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (user, badges, images, tags, calendarData) => (
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      ),
      error: (message) => null,
    );
    
    if (currentState == null) return;
    
    try {
      _logger.info('Hiding user $_username from live');
      
      // Make API call to hide user from live using RelationsApi
      await _relationsApi.relationsToNamePut(name: _username, r: 'hidden');
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully hid user $_username from live');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to hide user $_username from live', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Unhide the user from live feed.
  /// 
  /// This method:
  /// 1. Makes an API call to unhide the user from live
  /// 2. Refetches the profile data to update the UI
  Future<void> unhideFromLive() async {
    final currentState = state.when(
      initial: () => null,
      loading: () => null,
      loaded: (user, badges, images, tags, calendarData) => (
        user: user,
        badges: badges,
        images: images,
        tags: tags,
        calendarData: calendarData,
      ),
      error: (message) => null,
    );
    
    if (currentState == null) return;
    
    try {
      _logger.info('Unhiding user $_username from live');
      
      // Make API call to unhide user from live using RelationsApi
      await _relationsApi.relationsToNamePut(name: _username, r: 'followed');
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully unhid user $_username from live');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to unhide user $_username from live', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Complain about the user.
  /// 
  /// This method makes an API call to report the user for inappropriate behavior.
  Future<void> complain() async {
    try {
      _logger.info('Complaining about user $_username');
      
      // Make API call to complain about user using UsersApi
      await _usersApi.usersNameComplainPost(name: _username);
      
      _logger.info('Successfully complained about user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to complain about user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Give an invite to the user.
  /// 
  /// This method makes an API call to send an invite to the user.
  Future<void> giveInvite(String invite) async {
    try {
      _logger.info('Giving invite to user $_username');
      
      // Make API call to give invite using RelationsApi
      await _relationsApi.relationsInvitedNamePost(name: _username, invite: invite);
      
      _logger.info('Successfully gave invite to user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to give invite to user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Accept a follow request from the user.
  /// 
  /// This method makes an API call to accept the user's follow request.
  Future<void> acceptFollowRequest() async {
    try {
      _logger.info('Accepting follow request from user $_username');
      
      // Make API call to accept follow request using RelationsApi
      await _relationsApi.relationsFromNamePut(name: _username);
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully accepted follow request from user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to accept follow request from user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Deny a follow request from the user.
  /// 
  /// This method makes an API call to deny the user's follow request.
  Future<void> denyFollowRequest() async {
    try {
      _logger.info('Denying follow request from user $_username');
      
      // Make API call to deny follow request using RelationsApi
      await _relationsApi.relationsFromNameDelete(name: _username);
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully denied follow request from user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to deny follow request from user $_username', e, stackTrace);
      // Don't change state on error - user can retry
    }
  }

  /// Update profile information.
  /// 
  /// This method:
  /// 1. Calls the MeApi to update the user's profile information
  /// 2. Refreshes the profile data to update the UI
  /// 
  /// [showName] The display name for the user
  /// [privacy] The privacy level for the profile
  /// [chatPrivacy] The privacy level for chat
  /// [gender] Optional gender information
  /// [isDaylog] Whether the user is using daylog mode
  /// [title] Optional title/bio for the profile
  /// [birthday] Optional birthday information
  /// [country] Optional country information
  /// [city] Optional city information
  /// [showInTops] Whether to show in top users lists
  Future<void> updateProfileInfo({
    required String showName,
    required String privacy,
    required String chatPrivacy,
    String? gender,
    bool? isDaylog,
    String? title,
    String? birthday,
    String? country,
    String? city,
    bool? showInTops,
  }) async {
    try {
      _logger.info('Updating profile information for user $_username');
      
      // Make API call to update profile using MeApi
      await _meApi.mePut(
        showName: showName,
        privacy: privacy,
        chatPrivacy: chatPrivacy,
        gender: gender,
        isDaylog: isDaylog,
        title: title,
        birthday: birthday,
        country: country,
        city: city,
        showInTops: showInTops,
      );
      
      // Refresh profile data to update the UI with new information
      await fetchProfileData();
      
      _logger.info('Successfully updated profile information for user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to update profile information for user $_username', e, stackTrace);
      // Don't change state on error - user can retry
      rethrow; // Re-throw to allow UI to handle the error
    }
  }

  /// Refresh the profile data.
  /// 
  /// This method clears the current state and fetches fresh data.
  Future<void> refresh() async {
    _logger.info('Refreshing profile data for user $_username');
    await fetchProfileData();
  }

  /// Extracts a user-friendly error message from an exception.
  /// 
  /// This method handles different types of exceptions and returns
  /// appropriate error messages for display to the user.
  /// 
  /// [error] The exception that occurred
  /// Returns a user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.response?.statusCode) {
        case 404:
          return 'Пользователь не найден';
        case 403:
          return 'Нет доступа к профилю пользователя';
        case 429:
          return 'Слишком много запросов. Попробуйте позже';
        default:
          return 'Произошла ошибка сети. Проверьте подключение к интернету';
      }
    }
    
    if (error is Exception) {
      return error.toString();
    }
    
    return 'Произошла неизвестная ошибка';
  }
}
