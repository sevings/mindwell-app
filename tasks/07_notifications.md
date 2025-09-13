# Epic: Notifications System

This epic outlines the implementation of the user notifications system, including a dedicated screen to view notifications and real-time updates via WebSockets.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: WebSocket Service

### Goal
To create a core service that manages the WebSocket connection for real-time updates.

### Files to be Created or Modified:
*   `lib/src/core/services/websocket_service.dart` (Create)
*   `lib/src/core/api/api_provider.dart` (Modify)

### Implementation Details:
1.  **Modify `api_provider.dart`:**
    *   Add the `centrifuge` package to `pubspec.yaml`.
    *   Add a provider for the `AccountApi`.
2.  **Create `websocket_service.dart`:**
    *   Create a `WebSocketService` class.
    *   Dependencies: `AccountApi` (to get the connection token) and `AuthNotifier` (to know the current user's username).
    *   Implement methods:
        *   `connect()`: Fetches the token from `/account/subscribe/token`, creates a `centrifuge.Client`, and connects. It should only connect if the user is authenticated.
        *   `disconnect()`: Disconnects the client.
        *   `subscribeToChannels()`: Subscribes to `"notifications#{username}"` and `"messages#{username}"`.
    *   The service should expose `Stream`s of incoming messages for different channels (e.g., `notificationMessagesStream`).
    *   Implement connection management logic as per `architecture.md`, including exponential backoff for reconnection.

### Testing:
*   **Unit Tests:**
    *   Test the `WebSocketService`. Mock its dependencies.
    *   Verify that it attempts to connect only when authenticated.
    *   Verify that it correctly subscribes to channels based on the username.
    *   You may need to mock the `centrifuge` client to simulate connection states and incoming messages.

---

## Task 2: WebSocket Provider

### Goal
To create a global provider that manages the lifecycle of the `WebSocketService`.

### Files to be Created or Modified:
*   `lib/src/core/providers/websocket_provider.dart` (Create)

### Implementation Details:
1.  **Create `websocket_provider.dart`:**
    *   Create a global `Provider` or `StateNotifierProvider` that initializes and holds the instance of `WebSocketService`.
    *   The provider should listen to the authentication state and call `connect()` or `disconnect()` on the service accordingly.

### Testing:
*   **Unit Tests:**
    *   Test that the provider correctly initializes and disposes of the service.
    *   Test that it connects/disconnects based on auth state changes.

---

## Task 3: Notifications State Management

### Goal
To build the state management provider for the notifications screen.

### Files to be Created or Modified:
*   `lib/src/features/notifications/providers/notification_list_provider.dart` (Create)
*   `lib/src/features/notifications/models/notification_list_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `notification_list_state.dart` with `freezed` (`loading`, `loaded`, `error`). The `loaded` state will contain `List<Notification> notifications`, `int unreadCount`, `bool hasMore`, etc.
    *   Create `notification_list_provider.dart`, a `StateNotifierProvider`.
    *   Dependencies: `NotificationsApi` and `WebSocketService`.
    *   The notifier will fetch initial notifications via the API.
    *   It must listen to the `notificationMessagesStream` from the `WebSocketService`. When a message arrives, it should update the state immutably (e.g., add a new notification to the top of the list, update an existing one).
    *   Implement methods for pagination (`fetchMore`), `markAsRead(notificationId)`, and `markAllAsRead()`.

### Testing:
*   **Unit Tests:**
    *   Test the `NotificationListNotifier`. Mock the API and the WebSocket service.
    *   Verify it handles both API-fetched data and real-time messages correctly.

---

## Task 4: Notifications UI

### Goal
To build the user interface for the notifications screen.

### Files to be Created or Modified:
*   `lib/src/features/notifications/screens/notifications_screen.dart` (Create)
*   `lib/src/features/notifications/widgets/notification_item.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `notification_item.dart`:**
    *   A reusable widget to display a single notification.
    *   It should show an icon based on the notification type, the text, timestamp, and a read/unread indicator.
    *   Tapping it should mark the notification as read and navigate to the relevant content (e.g., an entry detail screen).
2.  **Create `notifications_screen.dart`:**
    *   The screen will watch the `notificationListProvider`.
    *   Display a `ListView` of `NotificationItem` widgets.
    *   Implement pull-to-refresh and infinite scrolling.
    *   Include a "Mark All as Read" button in the `AppBar`.
    *   The unread count should be displayed, perhaps as a badge on the notifications icon in the main bottom navigation bar.
3.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/notifications`.

### Testing:
*   **Widget Tests:**
    *   Test the `NotificationsScreen` and `NotificationItem` widgets with a mocked provider.
    *   Simulate state changes (loading, new notification via WebSocket) and verify the UI updates.
