/// Configuration for tabs in different feed types.
/// 
/// This class defines the tab structure for each feed type,
/// including tab labels and their corresponding values.
class FeedTabConfig {
  /// The label to display for this tab
  final String label;
  
  /// The value/parameter associated with this tab
  final String value;
  
  /// Optional icon for the tab
  final String? icon;
  
  const FeedTabConfig({
    required this.label,
    required this.value,
    this.icon,
  });
}

/// Tab configurations for different feed types.
class FeedTabConfigs {
  /// Tabs for live feed: entries, waiting, comments
  static const List<FeedTabConfig> live = [
    FeedTabConfig(
      label: 'invited',
      value: 'entries',
      icon: 'article_outlined',
    ),
    FeedTabConfig(
      label: 'waiting',
      value: 'waiting',
      icon: 'schedule_outlined',
    ),
    FeedTabConfig(
      label: 'discussed',
      value: 'comments',
      icon: 'comment_outlined',
    ),
  ];
  
  /// Tabs for best feed: week, month, year
  static const List<FeedTabConfig> best = [
    FeedTabConfig(
      label: 'week',
      value: 'week',
      icon: 'date_range',
    ),
    FeedTabConfig(
      label: 'month',
      value: 'month',
      icon: 'calendar_month',
    ),
    FeedTabConfig(
      label: 'year',
      value: 'year',
      icon: 'calendar_today',
    ),
  ];
  
  /// Tabs for subscriptions feed: friends, watching (labels: entries, replies)
  static const List<FeedTabConfig> subscriptions = [
    FeedTabConfig(
      label: 'entries',
      value: 'friends',
      icon: 'people_outlined',
    ),
    FeedTabConfig(
      label: 'replies',
      value: 'watching',
      icon: 'visibility_outlined',
    ),
  ];
  
  /// Get tab configuration for a specific feed type
  static List<FeedTabConfig> getTabsForFeedType(String feedType) {
    switch (feedType) {
      case 'live':
        return live;
      case 'best':
        return best;
      case 'subscriptions':
        return subscriptions;
      default:
        return [];
    }
  }
}
