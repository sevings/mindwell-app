# Chat Messages Screen Specification

## 1. Introduction

This document specifies the requirements for the Chat Messages screen of the Mindwell mobile application. This screen displays the messages within a specific chat conversation.

## 2. Goals

*   Display a real-time, chronologically ordered list of messages.
*   Provide a clear and intuitive interface for sending and receiving messages.
*   Support various message interactions like editing, deleting, and reporting.

## 3. Functional Requirements

### 3.1. Data Source

The Chat Messages screen will display messages fetched from the `/chats/{name}/messages` API endpoint using the generated `ChatsApi`.

### 3.2. UI Elements

*   **App Bar:**
    *   Displays the chat partner's username and avatar.
    *   Tapping the app bar navigates to the partner's profile.
    *   Includes a back button.
*   **Message List:**
    *   Displays messages in chronological order (newest at the bottom).
    *   Uses modern, rounded message bubbles with tails, with animations for new messages.
    *   Differentiates between the current user's messages (right-aligned, primary color) and the partner's messages (left-aligned, secondary color).
*   **Input Field:**
    *   A text input field at the bottom for composing messages.
    *   A send button to send the message.

### 3.3. User Interactions

*   **Send Message:**
    *   Tapping the send button sends the message.
    *   The UI updates optimistically, showing the message with a "sending" indicator.
    *   If the message fails to send, a "retry" option is displayed on the message bubble.
*   **Load Older Messages:** Scrolling to the top of the list loads older messages.
*   **Message Actions:** A long-press on a message reveals a menu with options to `Edit`, `Delete`, or `Complain`, depending on the user's rights.
*   **Mark as Read:** Messages are automatically marked as read after a short delay when they become visible on the screen.

## 4. Non-Functional Requirements

*   **Performance:** The list should scroll smoothly, and sending messages should be instant.
*   **Responsiveness:** The UI should adapt to different screen sizes.
*   **Accessibility:** The screen should be accessible.
*   **Security:** All communication must be over HTTPS.

## 5. Flutter Implementation Details

*   **API Client:** Use the generated `ChatsApi`.
*   **State Management:** Use a `StateNotifierProvider` from `Riverpod`.
*   **Widgets:**
    *   `ListView.builder` (with `reverse: true`) for the message list.
    *   `TextField` for the message input.
    *   A reusable `MessageBubble` widget for displaying messages.
*   **Scrolling:** Use the `scrollable_positioned_list` package to scroll to the first unread message.

## 6. State Management

The `StateNotifier` will manage a `ChatMessagesState` object, which will be a sealed class with the following states:

*   **`ChatMessagesLoading`:** The initial loading state.
*   **`ChatMessagesLoaded`:** The state when the messages are loaded.
    *   `List<Message> messages`: The list of messages.
    *   `Map<int, MessageStatus> messageStatus`: The sending status of each message.
    *   `bool isFetchingMore`: The pagination loading state.
    *   `bool hasMore`: Whether there are more messages to fetch.
*   **`ChatMessagesError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

The `MessageStatus` will be an enum: `sending`, `sent`, `failed`.

## 7. Real-time Updates via WebSocket

The `StateNotifier` will handle real-time updates from the `"messages#" + username` channel:

*   **`new`:** Add the new message to the list and mark it as `sent`.
*   **`updated`:** Find the message in the list and update its content.
*   **`removed`:** Remove the message from the list.
*   **`read`:** Update the read status of the messages.

## 8. Offline Support

*   **Message Caching:**
    *   Cache chat messages locally using Hive
    *   Implement cache invalidation based on message freshness
    *   Show cached messages immediately when available
*   **Offline Messaging:**
    *   Queue outgoing messages when offline
    *   Show "sending" status for queued messages
    *   Sync queued messages when connection is restored
    *   Handle message delivery failures gracefully
*   **Connection Status:**
    *   Show clear connection status indicators
    *   Disable message sending when offline
    *   Provide retry options for failed messages

## 9. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the message bubbles, input field, and send button.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Content Grouping:** Group related content within message bubbles for better screen reader navigation.
*   **Screen Reader Support:**
    *   Announce new messages as they arrive
    *   Provide context for message status (sending, sent, failed)
    *   Describe message content and metadata
*   **High Contrast Support:** Ensure all text and UI elements meet WCAG AA contrast requirements.
*   **Text Scaling:** Respect system text size preferences.
*   **Keyboard Navigation:** Full keyboard accessibility for message composition and navigation.

## 10. Future Considerations

*   **"Is Typing" Indicator:** Show an indicator when the chat partner is typing.
*   **Media Attachments:** Allow users to send images and other media.
*   **Read Receipts:** Display read receipts for messages.
*   **Message Search:** Implement search functionality within chat history.
*   **Message Reactions:** Allow users to react to messages with emojis.
