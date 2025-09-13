# Epic: User Profiles and Lists

This epic covers the creation of user-facing profiles and lists of users (e.g., followers, following).

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: User Profile State Model

### Goal
Define the data model for the user profile screen state.

### Files to be Created or Modified:
*   `lib/src/features/profile/models/profile_state.dart` (Create)

### Implementation Details:
1.  **Create `profile_state.dart`:**
    *   Use `freezed` to create a sealed class `ProfileState` with states: `loading`, `loaded`, `error`.
    *   The `loaded` state should contain all the data needed for the profile screen: `User user`, `List<Badge> badges`, `List<Image> images`, `List<Tag> tags`, `Calendar calendarData`, etc. The models will come from the generated API client.

### Testing:
*   **Unit Tests:**
    *   Verify the `ProfileState` model's properties and states.

---

## Task 2: User Profile Provider

### Goal
Set up the state notifier provider to fetch and manage all data for a user profile.

### Files to be Created or Modified:
*   `lib/src/features/profile/providers/profile_provider.dart` (Create)

### Implementation Details:
1.  **Create `profile_provider.dart`:**
    *   Create a `StateNotifierProvider` that takes a `username` as a parameter.
    *   The `ProfileNotifier` will manage the `ProfileState`.
    *   It will depend on the `UsersApi`.
    *   In its constructor or an `init` method, it should make parallel API calls to fetch all the required data for the profile (`/users/{name}`, `/users/{name}/badges`, etc.).
    *   Once all data is fetched, it should update the state to `loaded`. If any call fails, it should go into an `error` state.
    *   Implement methods to handle user actions like `follow`, `unfollow`, `block`, etc., which will call the API and then refetch the main user data to update the UI.

### Testing:
*   **Unit Tests:**
    *   Test the `ProfileNotifier`, mocking the `UsersApi`.
    *   Verify that it correctly fetches and aggregates data.
    *   Test that it handles API errors gracefully.
    *   Test the follow/unfollow/block action logic.

---

## Task 3: Profile Header UI

### Goal
Build the collapsible header widget for the user profile screen.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/profile_header.dart` (Create)

### Implementation Details:
1.  **Create `profile_header.dart`:**
    *   A widget that will be placed inside the `SliverAppBar`'s `flexibleSpace`.
    *   It should display the cover image, avatar, user's name, and action buttons.
    *   The content should animate and collapse smoothly as the user scrolls.

### Testing:
*   **Widget Tests:**
    *   Test the `ProfileHeader` widget with mock data.

---

## Task 4: Profile Content Card Widgets

### Goal
Build the set of reusable widgets for displaying different types of content on the profile.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/info_card.dart` (Create)
*   `lib/src/features/profile/widgets/badge_card.dart` (Create)
*   `lib/src/features/profile/widgets/image_card.dart` (Create)
*   `lib/src/features/profile/widgets/tag_card.dart` (Create)
*   `lib/src/features/profile/widgets/calendar_card.dart` (Create)

### Implementation Details:
1.  **Create Card Widgets:**
    *   Create separate, reusable widgets for each content card specified in the spec (`InfoCard`, `BadgeCard`, etc.). Each card will take the relevant data from the `ProfileState` as a parameter.

### Testing:
*   **Widget Tests:**
    *   Test each card widget individually with mock data.

---

## Task 5: Profile Screen Layout

### Goal
Build the main profile screen, integrating the header and content cards into a responsive, scrollable layout.

### Files to be Created or Modified:
*   `lib/src/features/profile/screens/profile_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `profile_screen.dart`:**
    *   The main screen widget that watches the `profileProvider`.
    *   Use a `CustomScrollView` with a `SliverAppBar`.
    *   Display a `SkeletonLoader` while the state is `loading`.
    *   Once loaded, display the `ProfileHeader` and the content cards.
    *   Use a `LayoutBuilder` and `StaggeredGrid` (from `flutter_staggered_grid_view`) to implement the responsive layout (1, 2, or 3 columns based on screen width).
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/users/:name` that builds the `ProfileScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `ProfileScreen`, mocking the `profileProvider` in its `loading`, `loaded`, and `error` states.
    *   Verify the responsive layout changes correctly at different screen widths.

---

## Task 6: User List State and Provider

### Goal
Create the state management system for displaying paginated lists of users.

### Files to be Created or Modified:
*   `lib/src/features/profile/providers/user_list_provider.dart` (Create)
*   `lib/src/features/profile/models/user_list_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `user_list_state.dart` using `freezed` (`loading`, `loaded`, `error`). The `loaded` state will contain `List<User> users` and `bool hasMore`.
    *   Create `user_list_provider.dart`. This `StateNotifierProvider` should be flexible enough to handle different types of user lists (e.g., it could take a `UserListType` enum and a `username` as parameters). The notifier will call the appropriate `UsersApi` method based on the type.

### Testing:
*   **Unit Tests:** Test the `UserListNotifier` for different list types.

---

## Task 7: User Card Widget

### Goal
Create a reusable widget to display a single user's information in a list or grid.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/user_card.dart` (Create)

### Implementation Details:
1.  **Create `user_card.dart`:**
    *   A reusable widget to display a user's information in a compact card format (avatar, cover, name, stats).
    *   Tapping the card should navigate to that user's `ProfileScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `UserCard` with mock data.

---

## Task 8: User List Screen

### Goal
Create the screen that displays a responsive grid of users.

### Files to be Created or Modified:
*   `lib/src/features/profile/screens/user_list_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `user_list_screen.dart`:**
    *   A screen that takes a `UserListType` and `username`.
    *   It will watch the `userListProvider` and display a responsive `StaggeredGrid` of `UserCard` widgets.
    *   Implement pull-to-refresh and infinite scrolling.
    *   Display loading, empty, and error states.
2.  **Modify `app_router.dart`:**
    *   Add routes like `/users/:name/followers` and `/users/:name/following` that build the `UserListScreen` with the correct parameters.

### Testing:
*   **Widget Tests:**
    *   Test the `UserListScreen`, mocking the provider to verify the grid, pagination, and state handling.
