import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_settings.freezed.dart';

/// Display format options for the entry feed.
enum DisplayFormat {
  /// Short format - compact cards with minimal content
  short,
  /// Full format - detailed cards with more content
  full,
}

/// Sort order options for the entry feed.
enum SortOrder {
  /// Sort by newest entries first
  newest,
  /// Sort by oldest entries first
  oldest,
  /// Sort by best rated entries first
  best,
}

/// Settings for configuring the entry feed display and behavior.
/// 
/// This class uses freezed to ensure immutability and provides
/// configuration options for how entries are displayed and sorted.
@freezed
class FeedSettings with _$FeedSettings {
  const factory FeedSettings({
    /// Number of entries to load per page
    @Default(20) int entriesPerPage,
    
    /// Display format for entries (short or full)
    @Default(DisplayFormat.short) DisplayFormat displayFormat,
    
    /// Sort order for entries
    @Default(SortOrder.newest) SortOrder sortOrder,
    
    /// Whether to show only entries with images
    @Default(false) bool imagesOnly,
    
    /// Whether to show only favorited entries
    @Default(false) bool favoritesOnly,
    
    /// Whether to show only entries from followed users
    @Default(false) bool followedOnly,
    
    /// Whether to enable auto-refresh
    @Default(true) bool autoRefresh,
    
    /// Auto-refresh interval in seconds
    @Default(30) int autoRefreshInterval,
  }) = _FeedSettings;

  const FeedSettings._();

  /// Default feed settings
  static const FeedSettings defaultSettings = FeedSettings();
}
