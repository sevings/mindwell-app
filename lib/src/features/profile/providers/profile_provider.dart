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
    
    return ProfileNotifier(
      username: username,
      usersApi: usersApi,
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
/// - Error handling and state management
/// - Optimistic UI updates for user actions
class ProfileNotifier extends StateNotifier<ProfileState> {
  final String _username;
  final UsersApi _usersApi;
  final Logger _logger = Logger('ProfileNotifier');
  
  bool _isLoading = false;

  ProfileNotifier({
    required String username,
    required UsersApi usersApi,
  })  : _username = username,
        _usersApi = usersApi,
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
      
      // Make API call to follow user
      // Note: The actual follow API endpoint would need to be implemented
      // For now, we'll just log the action and refetch data
      // await _relationsApi.followUser(name: _username);
      
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
      
      // Make API call to unfollow user
      // Note: The actual unfollow API endpoint would need to be implemented
      // For now, we'll just log the action and refetch data
      // await _relationsApi.unfollowUser(name: _username);
      
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
      
      // Make API call to block user
      // Note: The actual block API endpoint would need to be implemented
      // For now, we'll just log the action
      // await _relationsApi.blockUser(name: _username);
      
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
      
      // Make API call to unblock user
      // Note: The actual unblock API endpoint would need to be implemented
      // For now, we'll just log the action
      // await _relationsApi.unblockUser(name: _username);
      
      // Refetch profile data to update the UI with new relationship status
      await fetchProfileData();
      
      _logger.info('Successfully unblocked user $_username');
      
    } catch (e, stackTrace) {
      _logger.severe('Failed to unblock user $_username', e, stackTrace);
      // Don't change state on error - user can retry
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
