/// Types of entry feeds available in the application.
/// 
/// Each feed type corresponds to a different API endpoint and
/// provides a different view of entries.
enum FeedType {
  /// Real-time feed of entries
  live,
  
  /// Highly-rated entries
  best,
  
  /// Entries from followed users
  friends,
  
  /// Entries from a specific user profile
  profile,
  
  /// Entries from a specific theme
  theme,
}

/// Extension methods for FeedType to provide additional functionality.
extension FeedTypeExtension on FeedType {
  /// Get the display name for the feed type.
  String get displayName {
    switch (this) {
      case FeedType.live:
        return 'Live';
      case FeedType.best:
        return 'Best';
      case FeedType.friends:
        return 'Friends';
      case FeedType.profile:
        return 'Profile';
      case FeedType.theme:
        return 'Theme';
    }
  }
  
  /// Get the cache key for this feed type.
  /// 
  /// For profile and theme feeds, additional parameters may be needed.
  String getCacheKey([String? parameter]) {
    switch (this) {
      case FeedType.live:
        return 'live';
      case FeedType.best:
        return 'best';
      case FeedType.friends:
        return 'friends';
      case FeedType.profile:
        return 'profile_${parameter ?? 'default'}';
      case FeedType.theme:
        return 'theme_${parameter ?? 'default'}';
    }
  }
}
