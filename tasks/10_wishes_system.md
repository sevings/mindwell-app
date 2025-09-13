# Epic: Wishes System

This epic details the implementation of the "Wishes" feature, a system for users to send and receive supportive messages.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: Wishes List State Management

### Goal
To create the state management for viewing lists of sent and received wishes.

### Files to be Created or Modified:
*   `lib/src/features/wishes/providers/wishes_list_provider.dart` (Create)
*   `lib/src/features/wishes/models/wishes_list_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `wishes_list_state.dart` with `freezed` (`loading`, `loaded`, `error`). The `loaded` state will contain `List<Wish> wishes`, a `WishFilter` enum (`sent`, `received`, `all`), `bool hasMore`, etc.
    *   Create `wishes_list_provider.dart`, a `StateNotifierProvider`.
    *   The notifier will use the `WishesApi` to fetch wishes based on the selected filter.
    *   Implement methods for pagination, refresh, and changing the filter.

### Testing:
*   **Unit Tests:** Test the `WishesListNotifier`, including the filtering and pagination logic.

---

## Task 2: Wishes List UI

### Goal
To create the screen where users can view a list of their wishes.

### Files to be Created or Modified:
*   `lib/src/features/wishes/screens/wishes_list_screen.dart` (Create)
*   `lib/src/features/wishes/widgets/wish_card.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `wish_card.dart`:**
    *   A widget to display a single wish. It should show the sender's info, the wish content, and the timestamp.
    *   For received wishes, it should include a "Thank" button. The UI should update optimistically when the button is pressed.
    *   It should also have a visual indicator for read/unread status.
2.  **Create `wishes_list_screen.dart`:**
    *   A screen with an `AppBar` that contains tabs or a dropdown to select the filter (Sent/Received/All).
    *   It will watch the `wishesListProvider` and display a `ListView` of `WishCard` widgets.
    *   Implement pull-to-refresh and infinite scrolling.
3.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/wishes`.

### Testing:
*   **Widget Tests:** Test the `WishesListScreen` and `WishCard` with a mocked provider. Verify the UI updates correctly when the filter changes or the thank button is pressed.

---

## Task 3: Send Wish State Management

### Goal
To build the state management for composing and sending a wish.

### Files to be Created or Modified:
*   `lib/src/features/wishes/providers/send_wish_provider.dart` (Create)
*   `lib/src/features/wishes/models/send_wish_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `send_wish_state.dart` with `freezed` (`initial`, `sending`, `sent`, `error`).
    *   Create `send_wish_provider.dart`, a `StateNotifierProvider` that handles the business logic of sending a wish using the `WishesApi`.

### Testing:
*   **Unit Tests:** Test the `SendWishNotifier`.

---

## Task 4: Send Wish UI

### Goal
To build the UI for composing and sending a wish to another user.

### Files to be Created or Modified:
*   `lib/src/features/wishes/screens/send_wish_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `send_wish_screen.dart`:**
    *   This screen will typically be navigated to from a user's profile. It will receive the recipient's user information as a parameter.
    *   Display the recipient's avatar and name at the top.
    *   Provide a `TextField` for the wish message, including a character counter.
    *   A "Send" button will call the `sendWish` method on the provider. The button should be disabled while the state is `sending` and should show a loading indicator.
    *   On success (`sent` state), the screen should probably pop or show a success confirmation.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/users/:name/send-wish`.

### Testing:
*   **Widget Tests:** Test the `SendWishScreen`. Mock the provider to verify that the send button calls the correct method and that the UI responds to state changes (e.g., loading, success).
