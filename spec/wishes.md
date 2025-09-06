# Wishes Screen Specification

## 1. Introduction

This document outlines the technical specifications for the Wishes feature in the Mindwell mobile application. Wishes are special messages that users can send to each other, often used for expressing gratitude, support, or encouragement.

## 2. Goals

*   Provide a meaningful way for users to connect and support each other
*   Create a positive, encouraging community atmosphere
*   Enable users to send and receive wishes with appropriate privacy controls
*   Ensure a consistent and delightful user experience

## 3. Functional Requirements

### 3.1. Wishes List Screen

*   **Data Source:** `/wishes` API endpoint using the generated `WishesApi`
*   **UI Elements:**
    *   **App Bar:** Title "Wishes" with filter options (received, sent, all)
    *   **Wish List:** Chronological list of wishes using `ListView.builder`
    *   **Wish Card:** Reusable `WishCard` widget displaying:
        *   Sender's avatar and name
        *   Wish content with rich text formatting
        *   Timestamp
        *   Thank button (for received wishes)
        *   Status indicator (read/unread, thanked/not thanked)
    *   **Empty State:** Encouraging message when no wishes are present
    *   **Pull-to-Refresh:** Refresh the wishes list

### 3.2. Send Wish Screen

*   **Data Source:** `/wishes` POST endpoint
*   **UI Elements:**
    *   **Receiver Info:** Avatar, name, and profile link
    *   **Wish Content:**
        *   Plain text editor for wish message
        *   Character limit indicator
    *   **Send Button:** With loading state and confirmation

### 3.3. Wish Detail Screen

*   **Data Source:** `/wishes/{id}` API endpoint
*   **UI Elements:**
    *   **Wish Content:** Full wish message with formatting
    *   **Sender Info:** Avatar, name, and profile link
    *   **Actions:**
        *   Thank button (for received wishes)
        *   Report/Complain option
    *   **Metadata:** Timestamp, read status, thank status

### 3.4. Wish Management

*   **Features:**
    *   **Mark as Read:** Automatic and manual read status updates
    *   **Thank System:** Users can thank wish senders
    *   **Block/Report:** Handle inappropriate wishes

## 4. State Management

### 4.1. Wishes List State

```dart
sealed class WishesListState {
  WishesListLoading();
  WishesListLoaded({
    required List<Wish> wishes,
    required int unreadCount,
    required bool isFetchingMore,
    required bool hasMore,
    required WishFilter filter,
  });
  WishesListError(String errorMessage);
}
```

### 4.2. Send Wish State

```dart
sealed class SendWishState {
  SendWishInitial();
  SendWishComposing({
    required User? recipient,
    required String content,
    required bool isAnonymous,
    required bool isPublic,
  });
  SendWishSending();
  SendWishSent();
  SendWishError(String errorMessage);
}
```

## 5. API Integration

*   **WishesApi:** Use generated API client for all wish operations
*   **Real-time Updates:** Subscribe to wish-related notifications
*   **Caching:** Cache wishes for offline reading
*   **Optimistic Updates:** Show sent wishes immediately

## 6. UI/UX Considerations

*   **Warm Design:** Use warm colors and friendly typography
*   **Encouraging Content:** Positive messaging and imagery
*   **Smooth Animations:** Gentle transitions and micro-interactions
*   **Accessibility:** Full screen reader support and keyboard navigation
*   **Responsive Design:** Adapt to different screen sizes

## 7. Privacy and Safety

*   **Content Moderation:** Automatic and manual content filtering
*   **User Blocking:** Allow users to block wish senders
*   **Anonymous Options:** Support for anonymous wishes
*   **Report System:** Easy reporting of inappropriate content
*   **Privacy Controls:** Granular privacy settings

## 8. Accessibility

*   **Semantic Labels:** All wish cards and actions must have proper labels
*   **Focus Management:** Logical tab order for wish navigation
*   **Screen Reader Support:** Descriptive text for wish content and actions
*   **High Contrast:** Support for high contrast mode
*   **Text Scaling:** Respect system text size preferences

## 9. Future Considerations

*   **Wish Templates:** Pre-written wish templates for common occasions
*   **Wish Categories:** Organize wishes by type (birthday, encouragement, etc.)
*   **Wish Analytics:** Track wish sending and receiving patterns
*   **Wish Reactions:** Additional reaction types beyond thanking
*   **Wish Scheduling:** Schedule wishes to be sent at specific times
