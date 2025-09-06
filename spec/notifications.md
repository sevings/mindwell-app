# Notifications Screen Specification

## 1. Introduction

This document specifies the requirements for the Notifications screen of the Mindwell mobile application. This screen displays a list of notifications to the user, informing them of various events within the application.

## 2. Goals

*   Display a list of notifications in a clear, organized, and visually appealing manner.
*   Provide a seamless experience for viewing and interacting with notifications.
*   Support real-time updates, pagination, and read/unread status.

## 3. Functional Requirements

### 3.1. Data Source

The Notifications screen will display notifications fetched from the `/notifications` API endpoint using the generated `NotificationsApi`.

### 3.2. UI Elements

*   **App Bar:**
    *   Displays the screen title: "Notifications".
    *   Includes a back button for navigation.
*   **Notification List:**
    *   Displays a list of notifications using `ListView.builder`.
    *   Each notification will be a reusable `NotificationItem` widget with a modern and visually engaging layout.
    *   **Type Icon:** An icon representing the type of notification.
    *   **Text Content:** A brief description of the notification.
    *   **Timestamp:** The date and time the notification was created.
    *   **User Avatar (If Applicable):** The user's avatar.
    *   **Read/Unread Indicator:** A visual cue to indicate whether the notification has been read.
    *   **Comment Notification Specifics:**
        *   Display the first 4 lines of the comment.
        *   Display the title of the entry the comment belongs to.
*   **Pull-to-Refresh:** Allows the user to refresh the list.
*   **Pagination:** Implement infinite scrolling to load older notifications.
*   **Loading State:** A shimmer effect will be used to indicate that the notifications are loading.
*   **Animations:** New notifications will have a subtle animation (e.g., fade in).

### 3.3. Data Requirements

The screen requires data from the `/notifications` API endpoint, which returns a `NotificationList` object.

### 3.4. User Interactions

*   **Notification Tap:** Navigates to the relevant screen based on the notification type.
*   **Mark as Read:** Tapping on a notification automatically marks it as read.
*   **Mark All as Read:** Tapping the "Mark All as Read" button marks all notifications as read.

## 4. Non-Functional Requirements

*   **Performance:** The list should load quickly and scroll smoothly.
*   **Responsiveness:** The UI should adapt to different screen sizes.
*   **Accessibility:** The list should be accessible to users with disabilities.
*   **Security:** All communication with the server must be encrypted using HTTPS.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated `NotificationsApi`.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod`.
*   **Componentization:** A reusable `NotificationItem` widget will be created.
*   **Widgets:**
    *   `ListView.builder` for the notification list.
    *   `RefreshIndicator` for pull-to-refresh.
    *   `cached_network_image` for caching images.

## 6. State Management

The `StateNotifier` will manage a `NotificationListState` object, which will be a sealed class with the following states:

*   **`NotificationListLoading`:** The initial loading state.
*   **`NotificationListLoaded`:** The state when the notifications are loaded.
    *   `List<Notification> notifications`: The list of notifications.
    *   `int unreadCount`: The number of unread notifications.
    *   `bool isFetchingMore`: The pagination loading state.
    *   `bool hasMore`: Whether there are more notifications to fetch.
*   **`NotificationListError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 7. Real-time Updates via WebSocket

The `StateNotifier` will handle real-time updates from the `"notifications#" + username` channel:

*   **`new`:** Add the new notification to the top of the list and update the unread count.
*   **`updated`:** Update the corresponding notification in the list.
*   **`removed`:** Remove the corresponding notification from the list.
*   **`read`:** Update the read status of all notifications.

## 8. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all UI elements, including the notification items and the "Mark All as Read" button.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Content Grouping:** Group related content within notification items for better screen reader navigation.

## 9. Future Considerations

*   **Grouping of similar notifications.**
*   **A more sophisticated notification filtering system.**
