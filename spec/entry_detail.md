# Entry Detail Screen Specification

## 1. Introduction

This document outlines the technical specifications for the Entry Detail screen in the Mindwell mobile application. This screen displays a single diary entry in its entirety, along with associated information and actions.

## 2. Goals

*   Display a complete diary entry in a clear, engaging, and easy-to-read format.
*   Provide a seamless experience for user interaction, such as commenting, favoriting, and voting.
*   Ensure a consistent and high-quality user experience.

## 3. Functional Requirements

### 3.1. Content Display

*   **Layout:** The screen will be built using a `CustomScrollView` with a `SliverAppBar` for a modern, collapsible app bar, and `Slivers` for the rest of the content.
*   **Entry Content:**
    *   **Author Information:** The author's avatar and display name.
    *   **Timestamp:** The entry's creation date and time.
    *   **Title:** The entry's title, which will collapse into the `SliverAppBar`.
    *   **Content:** The full content of the entry, with HTML formatting rendered using the `flutter_html` package.
    *   **Images:** Attached images will be displayed in a gallery view.
    *   **Tags:** A list of tappable tags.
    *   **Adjacent Entries:** Display clickable titles of previous and next adjacent entries with right and left arrows if they exist.
*   **Comments:**
    *   A list of comments will be displayed below the entry content.
    *   Each comment will be a reusable `CommentItem` widget, displaying the author's avatar, name, timestamp, content, and rating.
    *   **Load More Comments Button:** If there are more comments, display a button on top of the comment list. The text should be "load more" if there are more than 20 comments to load, or "display X comments" if there are X comments left (X <= 20). Clicking this button should load the previous 20 comments.
*   **Loading State:** Use a shimmer effect to indicate that the entry and comments are loading.

### 3.2. User Actions

*   **Voting and Favoriting:** Tapping the vote or favorite buttons will provide immediate visual feedback (optimistic UI) and make an API call in the background.
*   **Tap on Tag:** Tapping a tag will navigate to a filtered view of entries with that tag.
*   **View Image:** Tapping an image will open it in a fullscreen gallery view.
*   **Load More Comments:** Older comments will be loaded automatically as the user scrolls up (infinite scrolling).
*   **Add Comment:** A text input field will be provided for adding new comments.
*   **Long Press Menu:** A long press on the entry or a comment will open a context menu with options like `Pin`, `Follow`, `Edit`, `Delete`, and `Complain`, depending on the user's rights.

### 3.3. Data Requirements

The screen requires data from the following API endpoints:

*   `/entries/{id}`: To retrieve the entry data.
*   `/entries/{id}/comments`: To retrieve the list of comments.
*   `/comments`: To post a new comment.

## 4. Non-Functional Requirements

*   **Performance:** The screen should load quickly and scroll smoothly.
*   **Security:** All data must be transmitted over HTTPS. All user-generated content must be sanitized to prevent XSS attacks.
*   **Accessibility:** The screen should be accessible to users with disabilities.
*   **Responsiveness:** The layout should adapt to different screen sizes.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated `EntriesApi` and `CommentsApi` directly in the provider.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod`.
*   **Widgets:**
    *   `CustomScrollView`, `SliverAppBar`, and other `Slivers`.
    *   `EntryContent`, `CommentList`, and `CommentItem` reusable widgets.
    *   `flutter_html` for rendering HTML content.
    *   `TextField` for the comment input.
    *   `PopupMenuButton` for the long press menu.

## 6. State Management

The `StateNotifier` will manage an `EntryDetailState` object, which will be a sealed class with the following states:

*   **`EntryDetailLoading`:** The initial loading state.
*   **`EntryDetailLoaded`:** The state when the entry and comments are loaded.
    *   `Entry entry`: The entry data.
    *   `List<Comment> comments`: The list of comments.
    *   `bool isFetchingMoreComments`: The pagination loading state for comments.
    *   `bool hasMoreComments`: Whether there are more comments to fetch.
*   **`EntryDetailError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 7. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the vote buttons, favorite button, tags, and images.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Content Grouping:** Group related content within the entry and comment sections for better screen reader navigation.

## 8. Future Considerations

*   **Real-time Updates:** Use WebSockets to receive and display new comments and entry updates in real-time.
*   **Sharing:** Implement functionality for sharing the entry.
*   **Related Entries:** Display a list of related entries at the bottom of the screen.
