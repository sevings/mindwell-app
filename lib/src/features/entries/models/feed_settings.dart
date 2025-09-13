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

/// Source options for live and best feeds.
enum FeedSource {
  /// Show entries from tlogs (diaries)
  tlogs,
  /// Show entries from themes
  themes,
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
    
    /// Whether to include entries from tlogs (diaries)
    @Default(true) bool includeTlogs,
    
    /// Whether to include entries from themes
    @Default(true) bool includeThemes,
  }) = _FeedSettings;

  const FeedSettings._();

  /// Default feed settings
  static const FeedSettings defaultSettings = FeedSettings();

  /// Validate that at least one source is enabled
  bool get isValidSourceConfiguration {
    return includeTlogs || includeThemes;
  }

  /// Create a copy with validation to ensure at least one source is enabled
  FeedSettings copyWithValidated({
    int? entriesPerPage,
    DisplayFormat? displayFormat,
    SortOrder? sortOrder,
    bool? includeTlogs,
    bool? includeThemes,
  }) {
    final newTlogs = includeTlogs ?? this.includeTlogs;
    final newThemes = includeThemes ?? this.includeThemes;
    
    // If both would be disabled, keep at least one enabled
    if (!newTlogs && !newThemes) {
      // If both are currently enabled, keep tlogs enabled
      // If only one is currently enabled, keep that one enabled
      final keepTlogs = this.includeTlogs;
      final keepThemes = this.includeThemes;
      
      return copyWith(
        entriesPerPage: entriesPerPage ?? this.entriesPerPage,
        displayFormat: displayFormat ?? this.displayFormat,
        sortOrder: sortOrder ?? this.sortOrder,
        includeTlogs: keepTlogs,
        includeThemes: keepThemes,
      );
    }
    
    return copyWith(
      entriesPerPage: entriesPerPage ?? this.entriesPerPage,
      displayFormat: displayFormat ?? this.displayFormat,
      sortOrder: sortOrder ?? this.sortOrder,
      includeTlogs: newTlogs,
      includeThemes: newThemes,
    );
  }
}
