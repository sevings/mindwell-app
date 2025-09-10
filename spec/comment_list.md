# Comment List Screen Specification

## 1. Introduction

This document outlines the technical specifications for the Comment List screen in the Mindwell mobile application. This screen displays a list of comments from various entries.

## 2. Goals

*   Display a list of comments in a clear, engaging, and easy-to-read format.
*   Provide intuitive navigation to related content, such as entries and user profiles.
*   Enable user interaction with comments, such as voting.

## 3. Functional Requirements

### 3.1. Content Display

*   **Comment List:** Display a list of comments in chronological order (newest first).
*   **Comment Card:** Each comment will be displayed as a reusable `CommentCard` widget with:
    *   **Author Information:** The author's avatar and display name.
    *   **Entry Title:** The title of the entry the comment belongs to.
    *   **Timestamp:** The comment's creation date and time.
    *   **Content:** The comment content, with HTML formatting rendered using the `flutter_html` package.
    *   **Rating:** Upvote and downvote buttons with the current vote count.
*   **Loading State:** Use a shimmer effect to indicate that the comment list is loading.

### 3.2. User Actions

*   **Tap on Comment:** Navigates to the Entry Detail screen and scrolls to the corresponding comment.
*   **Tap on Author:** Tapping the author's avatar or name navigates to their profile screen.
*   **Upvote/Downvote:** Tapping the vote buttons updates the rating with immediate visual feedback (optimistic UI) and makes an API call in the background.
*   **Pull to refresh:** Loads newer comments.
*   **Infinite scroll:** Loads older comments.

### 3.3. Data Requirements

The screen requires data from the `/users/{name}/comments` API endpoint.

## 4. Non-Functional Requirements

*   **Performance:** The screen should load quickly and scroll smoothly.
*   **Security:** All data must be transmitted over HTTPS. Comment content should be sanitized using a well-vetted library to prevent XSS attacks.
*   **Accessibility:** The screen should be accessible to users with disabilities.
*   **Responsiveness:** The layout should adapt to different screen sizes.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated `UsersApi` directly in the provider.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod`.
*   **Widgets:**
    *   `ListView.builder` for the comment list.
    *   `CommentCard` for each comment.
    *   `flutter_html` to render the comment content.
    *   `IconButton` for the vote buttons.

## 6. State Management

The `StateNotifier` will manage a `CommentListState` object, which will be a sealed class with the following states:

*   **`CommentListLoading`:** The initial loading state.
*   **`CommentListLoaded`:** The state when the comments are loaded.
    *   `List<Comment> comments`: The list of comments.
    *   `bool isFetchingMore`: The pagination loading state.
    *   `bool hasMore`: Whether there are more comments to fetch.
*   **`CommentListError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 7. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the comment cards, vote buttons, and author avatars.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Content Grouping:** Group related content within comment cards for better screen reader navigation.

## 8. Future Considerations

*   **Real-time Updates:** Use WebSockets to receive and display new comments in real-time.
*   **Comment Replies:** Implement functionality for replying to comments.
*   **Filtering and Sorting:** Allow users to filter and sort the comment list.