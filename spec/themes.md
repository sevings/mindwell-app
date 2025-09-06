# Themes Screen Specification

## 1. Introduction

This document outlines the technical specifications for the Themes feature in the Mindwell mobile application. Themes are community-driven content areas where users can create and participate in topic-specific discussions.

## 2. Goals

*   Provide a comprehensive theme management system for users and administrators
*   Enable theme creation, customization, and moderation
*   Support theme-specific content creation and interaction
*   Ensure consistent UI/UX across all theme-related screens

## 3. Functional Requirements

### 3.1. Theme List Screen

*   **Data Source:** `/themes` API endpoint using the generated `ThemesApi`
*   **UI Elements:**
    *   **App Bar:** Title "Themes" with search and filter options
    *   **Theme Grid:** Responsive masonry grid using `flutter_staggered_grid_view`
    *   **Theme Card:** Reusable `ThemeCard` widget displaying:
        *   Theme avatar and cover image
        *   Theme name and description
        *   Follower count and entry count
        *   Last activity timestamp
    *   **Search and Filter:** 
        *   Search by theme name or description
        *   Filter by popularity, activity, or creation date
    *   **Create Theme Button:** FAB for creating new themes (if user has permission)

### 3.2. Theme Detail Screen

*   **Data Source:** `/themes/{name}` API endpoint
*   **UI Elements:**
    *   **SliverAppBar:** Theme cover image with parallax effect
    *   **Theme Info Section:**
        *   Theme avatar, name, and description
        *   Follower count and entry count
        *   Follow/Unfollow button
        *   Theme settings (if user is admin)
    *   **Tab Navigation:** Entries, Comments, Images, Followers
    *   **Content Sections:** Similar to user profile but theme-specific

### 3.3. Theme Creation/Edit Screen

*   **Data Source:** `/themes` POST and `/themes/{name}` PUT endpoints
*   **UI Elements:**
    *   **Form Fields:**
        *   Theme name (unique identifier)
        *   Display name
        *   Description
        *   Avatar upload
        *   Cover image upload
    *   **Settings:**
        *   Privacy level (public, private, invite-only)
        *   Entry approval requirements
        *   Comment moderation settings
    *   **Validation:** Real-time validation for name availability

## 4. State Management

### 4.1. Theme List State

```dart
sealed class ThemeListState {
  ThemeListLoading();
  ThemeListLoaded({
    required List<Theme> themes,
    required bool isFetchingMore,
    required bool hasMore,
    required String? searchQuery,
    required ThemeFilter filter,
  });
  ThemeListError(String errorMessage);
}
```

### 4.2. Theme Detail State

```dart
sealed class ThemeDetailState {
  ThemeDetailLoading();
  ThemeDetailLoaded({
    required Theme theme,
    required List<Entry> entries,
    required List<Comment> comments,
    required List<Image> images,
    required List<User> followers,
    required bool isFollowing,
    required bool isAdmin,
  });
  ThemeDetailError(String errorMessage);
}
```

## 5. API Integration

*   **ThemesApi:** Use generated API client for all theme operations
*   **Image Upload:** Handle theme avatar and cover image uploads
*   **Caching:** Cache theme data for offline access

## 6. UI/UX Considerations

*   **Consistent Design:** Follow the established design system
*   **Responsive Layout:** Adapt to different screen sizes
*   **Loading States:** Use shimmer effects for theme cards
*   **Empty States:** Provide helpful messages when no themes exist
*   **Error Handling:** Show user-friendly error messages with retry options

## 7. Accessibility

*   **Semantic Labels:** All theme cards and interactive elements must have proper labels
*   **Focus Management:** Logical tab order for theme navigation
*   **Screen Reader Support:** Descriptive text for theme content and actions
*   **Keyboard Navigation:** Full keyboard accessibility for theme management

## 8. Future Considerations

*   **Theme Categories:** Organize themes by categories or tags
*   **Theme Discovery:** Algorithm-based theme recommendations
*   **Theme Analytics:** Detailed analytics for theme administrators
*   **Theme Templates:** Pre-built theme templates for quick setup
