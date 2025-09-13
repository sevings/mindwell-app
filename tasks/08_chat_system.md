# Epic: Chat System

This epic covers the implementation of the real-time chat feature, including the list of conversations and the message view for a single conversation.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

**Note:** The `WebSocketService` set up in the Notifications epic (`07_notifications.md`) is a prerequisite for this epic as it manages the connection and message streams.

## Task 1: Chat List State Management

### Goal
To build the state management for the user's list of active chat conversations.

### Files to be Created or Modified:
*   `lib/src/features/chat/providers/chat_list_provider.dart` (Create)
*   `lib/src/features/chat/models/chat_list_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `chat_list_state.dart` with `freezed` (`loading`, `loaded`, `error`). The `loaded` state will contain `List<Chat> chats`, `bool hasMore`, etc.
    *   Create `chat_list_provider.dart`, a `StateNotifierProvider`.
    *   Dependencies: `ChatsApi` and `WebSocketService`.
    *   The notifier will fetch the initial list of chats via the API.
    *   It will listen to the `messagesStream` from the `WebSocketService`. When a new message event arrives for a chat, it should update that chat's `lastMessage` and `unreadCount`, and move it to the top of the list. If it's a new chat, it may need to fetch the chat's details.

### Testing:
*   **Unit Tests:** Test the `ChatListNotifier`, mocking the API and WebSocket service. Verify that it correctly handles API data and real-time message events.

---

## Task 2: Chat List UI

### Goal
To build the screen that displays a user's active chat conversations.

### Files to be Created or Modified:
*   `lib/src/features/chat/screens/chat_list_screen.dart` (Create)
*   `lib/src/features/chat/widgets/chat_list_item.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `chat_list_item.dart`:**
    *   A reusable `ListTile`-like widget to display a single chat conversation.
    *   Show the partner's avatar, name, a snippet of the last message, the timestamp, and a badge with the unread message count.
    *   Tapping the item navigates to the `ChatMessagesScreen`.
2.  **Create `chat_list_screen.dart`:**
    *   A screen that watches the `chatListProvider`.
    *   Displays a `ListView` of `ChatListItem` widgets.
    *   Implement pull-to-refresh and infinite scrolling.
3.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/chats`.

### Testing:
*   **Widget Tests:** Test the `ChatListScreen` and `ChatListItem` widgets with a mocked provider.

---

## Task 3: Chat Messages State Management

### Goal
To build the state management for an individual chat conversation.

### Files to be Created or Modified:
*   `lib/src/features/chat/providers/chat_messages_provider.dart` (Create)
*   `lib/src/features/chat/models/chat_messages_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `chat_messages_state.dart` with `freezed` (`loading`, `loaded`, `error`). The `loaded` state will have `List<Message> messages`, `Map<int, MessageStatus> messageStatus`, etc.
    *   Create `chat_messages_provider.dart`, a `StateNotifierProvider` that takes the chat partner's `username`.
    *   Dependencies: `ChatsApi` and `WebSocketService`.
    *   The notifier fetches message history via the API and listens to the WebSocket for real-time message updates (`new`, `updated`, `removed`, `read`).
    *   Implement a `sendMessage(String text)` method that performs an optimistic update (adds the message to the state with a `sending` status) and then makes the API call. It should handle success and failure of the API call by updating the message's status.

### Testing:
*   **Unit Tests:**
    *   Test the `ChatMessagesNotifier`. Mock the API and WebSocket.
    *   Verify optimistic updates for sending messages work correctly for both success and failure cases.
    *   Verify it handles incoming real-time events correctly.

---

## Task 4: Chat Messages UI

### Goal
To build the screen for an individual chat conversation.

### Files to be Created or Modified:
*   `lib/src/features/chat/screens/chat_messages_screen.dart` (Create)
*   `lib/src/features/chat/widgets/message_bubble.dart` (Create)
*   `lib/src/features/chat/widgets/message_input.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create Message Widgets:**
    *   `MessageBubble`: A widget to display a single message, styled differently for sent vs. received messages. It should also show the message status (sending, failed).
    *   `MessageInput`: A `TextField` and a `Send` button for composing and sending messages.
2.  **Create `chat_messages_screen.dart`:**
    *   The screen will watch the `chatMessagesProvider`.
    *   The `AppBar` should show the partner's name and avatar and link to their profile.
    *   Use a `ListView.builder` with `reverse: true` to display the `MessageBubble`s.
    *   Implement pagination (scrolling to the top to load older messages).
    *   Place the `MessageInput` widget at the bottom of the screen.
3.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/chats/:name` that builds the `ChatMessagesScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `ChatMessagesScreen` with a mocked provider.
    *   Test sending a message and ensure the UI updates as expected.
