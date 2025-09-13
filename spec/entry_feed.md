# Entry Feed Screen Specification

## 1. Introduction

This document outlines the technical specifications for the Entry Feed screen in the Mindwell mobile application. This screen is the primary interface for users to view a chronological list of diary entries.

## 2. Goals

*   Provide a flexible and engaging way to browse different types of entry feeds.
*   Offer a high degree of customization, allowing users to control the display format, sorting, and filtering of the feed.
*   Ensure a consistent and high-quality user experience across all feed types.

## 3. Functional Requirements

### 3.1. Tabbed Navigation

The screen will use a `SliverAppBar` with a persistent `TabBar`. A dynamic tab system will be implemented, where each feed type has its own specific tab configuration.

*   **Live Feed Tabs:** Invited, Waiting, Discussed (corresponding to API sections: `entries`, `waiting`, `comments`).
*   **Best Feed Tabs:** Week, Month, Year (corresponding to API categories: `week`, `month`, `year`).
*   **Subscriptions Feed Tabs:** Entries, Replies (from friends and watched users/themes).
*   **Profile Feed:** Displays entries for a specific user or "My Entries".

### 3.2. UI Elements

*   **App Bar:** A `SliverAppBar` that displays the screen title and a menu button for accessing settings and search. The `TabBar` will be part of the app bar.
*   **Entry List:** A list of entries, displayed in either a "short" (masonry) or "full" (single-column) format.
    *   **Short Format:** A compact, masonry layout using `EntryCardShort` widgets and the `flutter_staggered_grid_view` package.
    *   **Full Format:** A detailed, single-column layout using `EntryCardFull` widgets.
*   **Floating Action Button (FAB):** A FAB for creating a new entry.
*   **Loading State:** A shimmer effect will be used to indicate that the feed is loading.
*   **Animations:** New entries appearing in the feed will have a subtle animation (e.g., fade in).

### 3.3. User Actions

*   **Tap on Entry:** Navigates to the Entry Detail screen.
*   **Tap on Author:** Navigates to the author's Profile screen.
*   **Pull to Refresh:** Reloads the feed.
*   **Infinite Scrolling:** Loads older entries as the user scrolls down.

### 3.4. Settings

A bottom sheet will be used to display settings. The available options will vary depending on the active feed type.

**Universal Options:**

*   **Display Format**: Choose between "Short" and "Full" entry display modes. This option is available for all feed types.

**Feed-Specific Options:**

*   **Live Feed:**
    *   **Source Options**:
        *   Include Diaries (API parameter: "users")
        *   Include Themes (API parameter: "themes")
        *   *Validation: At least one source must be enabled.*

*   **Best Feed:**
    *   **Source Options**:
        *   Include Diaries (API parameter: "users")
        *   Include Themes (API parameter: "themes")
        *   *Validation: At least one source must be enabled.*
    *   **Entry Count**:
        *   Options: 10, 20, 30, 50, 100 entries.

*   **Profile Feed:**
    *   **Sort Order**:
        *   Newest First
        *   Oldest First
        *   Best First

*   **Friends Feed:**
    *   No feed-specific options. Only universal settings apply.

## 4. Non-Functional Requirements

*   **Performance:** The feed should load quickly and scroll smoothly.
*   **Security:** All data must be transmitted over HTTPS.
*   **Accessibility:** The screen should be accessible to users with disabilities.
*   **Responsiveness:** The layout should adapt to different screen sizes.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated API clients directly in the providers for each feed type.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod` for each feed type.
*   **Componentization:**
    *   A reusable `EntryFeed` widget will be created that can be configured for different feed types.
    *   `EntryCardShort` and `EntryCardFull` widgets will be created for the two display formats.
*   **Widgets:**
    *   `CustomScrollView`, `SliverAppBar`, `TabBar`, and `TabBarView`.
    *   `flutter_staggered_grid_view` for the masonry layout.
    *   `FloatingActionButton`.

### 5.1. API Integration Updates

*   **Best Feed**: API requests will include a `category` parameter (`week`, `month`, `year`) based on the selected tab.
*   **Live Feed**: API requests will include a `section` parameter (`entries`, `waiting`, `comments`) based on the selected tab.
*   **Profile Feed**: Fixed user ID parameter passing for "My Entries" functionality.

## 6. State Management

Each feed's `StateNotifier` will manage an `EntryFeedState` object, which will be a sealed class with the following states:

```dart
sealed class EntryFeedState {
  EntryFeedLoading();
  EntryFeedLoaded({
    required List<Entry> entries,
    required bool isFetchingMore,
    required bool hasMore,
    required FeedSettings settings,
    required FeedType feedType,
  });
  EntryFeedError(String errorMessage);
  EntryFeedEmpty();
}
```

### 6.1. Feed Settings

```dart
class FeedSettings {
  final int entriesPerPage;
  final bool loadFromDiaries;
  final bool loadFromThemes;
  final DisplayFormat displayFormat;
  final SortOrder sortOrder;
  
  const FeedSettings({
    this.entriesPerPage = 20,
    this.loadFromDiaries = true,
    this.loadFromThemes = true,
    this.displayFormat = DisplayFormat.short,
    this.sortOrder = SortOrder.newest,
  });
}

enum DisplayFormat { short, full }
enum SortOrder { newest, oldest, best }
enum FeedType { live, best, friends, profile, theme }
```

## 7. Offline Support

*   **Caching Strategy:**
    *   Cache feed data locally using Hive
    *   Implement cache invalidation based on data freshness
    *   Show cached data immediately when available
*   **Offline Actions:**
    *   Queue user actions (votes, favorites) when offline
    *   Sync queued actions when connection is restored
    *   Show offline indicators in UI
*   **Conflict Resolution:**
    *   Handle conflicts when syncing offline actions
    *   Provide user choice for conflict resolution


## 8. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the entry cards, tabs, and settings.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Layout Accessibility:** Ensure that both the masonry and single-column layouts are accessible to screen readers, with a clear and logical reading order.
*   **Screen Reader Support:** Provide descriptive text for entry content and metadata.
*   **High Contrast:** Support for high contrast mode and system theme preferences.

## 9. Future Considerations

*   **Advanced Filtering:** Add more advanced filtering options, such as filtering by date range or content type.
*   **Personalization:** Implement personalized feed algorithms based on user preferences.
*   **Content Recommendations:** Suggest relevant entries based on user activity.
*   **Feed Analytics:** Track user engagement with different feed types and content.
