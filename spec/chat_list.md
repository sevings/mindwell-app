# Chat List Screen Specification

## 1. Introduction

This document specifies the requirements for the Chat List screen of the Mindwell mobile application. This screen displays a list of active chat conversations for the user.

## 2. Goals

*   Display a list of recent chat conversations in a clear and intuitive way.
*   Provide a seamless way to navigate to individual chat screens.
*   Clearly indicate unread message counts.
*   Support pagination and real-time updates.

## 3. Functional Requirements

### 3.1. Data Source

The Chat List screen will display chat conversations fetched from the `/chats` API endpoint using the generated `ChatsApi`.

### 3.2. UI Elements

*   **App Bar:**
    *   Use a `SliverAppBar` for a modern, collapsible app bar.
    *   Displays the screen title: "Chats".
*   **Chat List:**
    *   Displays a list of chat conversations using `ListView.builder`.
    *   Each chat item will be a reusable `ChatListItem` widget with the following:
        *   **Leading:** The chat partner's avatar, displayed using `CircleAvatar` and `cached_network_image`.
        *   **Title:** The chat partner's username or display name.
        *   **Subtitle:** A snippet of the most recent message.
        *   **Trailing:** A `Column` containing the timestamp of the last message and a `Badge` widget for the unread message count.
*   **Pull-to-Refresh:**
    *   Allows the user to refresh the list by swiping down.
*   **Pagination:**
    *   Implement infinite scrolling to load older chats as the user scrolls down.
*   **Empty State:**
    *   If the user has no active chats, display a message like "No conversations yet."
*   **Loading State:**
    *   Use a shimmer effect to indicate that the chat list is loading.

### 3.3. Data Requirements

The Chat List screen requires data from the `/chats` API endpoint, which returns a `ChatList` object.

### 3.4. User Interactions

*   **Chat Tap:** Tapping on a chat item navigates the user to the corresponding chat screen.

## 4. Non-Functional Requirements

*   **Performance:** The list should load quickly and scroll smoothly.
*   **Responsiveness:** The UI should adapt to different screen sizes and orientations.
*   **Accessibility:** The screen should be accessible to users with disabilities.
*   **Security:** All communication with the server must be encrypted using HTTPS.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated `ChatsApi`.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod` to manage the state of the chat list.
*   **Widgets:**
    *   `CustomScrollView` with a `SliverAppBar` and `SliverList`.
    *   `RefreshIndicator` for pull-to-refresh.
    *   `ChatListItem` for each chat item.
    *   `cached_network_image` for avatars.

## 6. State Management

The `StateNotifier` will manage a `ChatListState` object, which will be a sealed class with the following states:

*   **`ChatListLoading`:** The initial loading state.
*   **`ChatListLoaded`:** The state when the chat list is loaded.
    *   `List<Chat> chats`: The list of chats.
    *   `bool isFetchingMore`: The pagination loading state.
    *   `bool hasMore`: Whether there are more chats to fetch.
*   **`ChatListError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 7. Real-time Updates via WebSocket

The screen will listen to the `"messages#" + username` channel for real-time updates. The `StateNotifier` will handle these updates:

*   **`new`:**
    *   If the chat is already in the list, update the last message and unread count, and move it to the top.
    *   If the chat is not in the list, fetch the chat details from the API and add it to the top of the list.
    *   To prevent race conditions, ensure that the WebSocket event is not processed if a refresh is already in progress.
*   **`updated`:** Update the last message of the corresponding chat.
*   **`removed`:** Remove the message from the chat. If it was the last message, fetch the new last message.
*   **`read`:** Update the unread count of the corresponding chat.

## 8. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the chat list items and the search bar.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Alternative Text:** Provide alternative text for all user avatars.

## 9. Future Considerations

*   **Swipe Actions:** Implement swipe-to-archive or swipe-to-delete gestures.
*   **Online Status:** Display the online status of chat partners.
*   **Search:** Implement client-side or server-side search functionality.
