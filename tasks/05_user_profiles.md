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
    *   Implement a `refresh` method to re-fetch all profile data.

### Testing:
*   **Unit Tests:**
    *   Test the `ProfileNotifier`, mocking the `UsersApi`.
    *   Verify that it correctly fetches and aggregates data.
    *   Test that it handles API errors gracefully.

---

## Task 3: Profile Header UI

### Goal
Build the card-based header widget for the user profile screen.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/profile_header_card.dart` (Create)

### Implementation Details:
1.  **Create `profile_header_card.dart`:**
    *   Create a `ProfileHeaderCard` that serves as the profile screen's header. It should be a `Card` widget that fills the screen width.
    *   It should display a full-width cover image with a 3:1 aspect ratio.
    *   The user's avatar (124px) should be positioned to overlap the cover image and the content area below. It should have a border and shadow.
    *   Display the user's name and status below the avatar.
    *   Display user statistics (Entries, Comments, etc.) distributed across the full width. The layout should be responsive (e.g., max 3 stats per row on smaller screens, single row on larger screens).

### Testing:
*   **Widget Tests:**
    *   Test the `ProfileHeaderCard` widget with mock data.

---

## Task 4: Profile Action Handler

### Goal
Implement the logic for handling all user-to-user actions on the profile screen.

### Files to be Created or Modified:
*   `lib/src/features/profile/providers/profile_provider.dart` (Modify)

### Implementation Details:
1.  **Modify `ProfileNotifier`:**
    *   Implement methods for all user actions: `follow`, `unfollow`, `block`/`unblock`, `hideFromLive`/`unhideFromLive`, `complain`, `giveInvite`, and `acceptFollowRequest`/`denyFollowRequest`.
    *   Each method should call the appropriate API endpoint.

### Testing:
*   **Unit Tests:**
    *   Unit test each action method in the notifier, mocking the API to verify correct calls and state updates.

---

## Task 5: Profile Action Buttons UI

### Goal
Build the UI for the primary action button in the profile header card.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/profile_header_card.dart` (Modify)

### Implementation Details:
1.  **Modify `profile_header_card.dart`:**
    *   Add an orange, circular action button to the top-right corner of the header image.
    *   The button's icon should change based on the user relationship (e.g., a `tune` icon for editing one's own profile, follow/unfollow icons for other users).
    *   This button can also host a popup menu for secondary actions ("Write a Message", "Block", "Complain", etc.).
    *   Connect the button to the corresponding methods in the `ProfileNotifier`.

### Testing:
*   **Widget Tests:**
    *   Widget test the header with different `User` mock data to ensure the correct buttons and menu items are displayed for various user relationships.

---

## Task 6: Update Profile Info UI

### Goal
Create a dialog or screen for editing profile text information.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/profile_edit_dialog.dart` (Create)

### Implementation Details:
1.  **Create `profile_edit_dialog.dart`:**
    *   Design a dialog or a full-screen widget containing input fields for editable profile data (e.g., bio).
    *   Include "Save" and "Cancel" buttons.

### Testing:
*   **Widget Tests:**
    *   Test the `ProfileEditDialog` with mock data.

---

## Task 7: Update Profile Info Logic

### Goal
Implement the logic to save updated text information.

### Files to be Created or Modified:
*   `lib/src/features/profile/providers/profile_provider.dart` (Modify)

### Implementation Details:
1.  **Modify `ProfileNotifier`:**
    *   Create an `updateProfileInfo` method that takes new text data, calls the `UsersApi`, and refreshes the profile on success.

### Testing:
*   **Unit Tests:**
    *   Test the `updateProfileInfo` method, mocking the `UsersApi`.

---

## Task 8: Update Cover and Avatar UI

### Goal
Create UI elements for changing avatar and cover images.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/profile_header.dart` (Modify)

### Implementation Details:
1.  **Modify `profile_header.dart`:**
    *   When viewing one's own profile, add tappable overlays or buttons on the avatar and cover image.
    *   Tapping these elements should trigger the image selection process.

### Testing:
*   **Widget Tests:**
    *   Verify the upload buttons are visible on the user's own profile and hidden on others'.

---

## Task 9: Update Cover and Avatar Logic

### Goal
Implement the logic for uploading and updating avatar/cover images.

### Files to be Created or Modified:
*   `lib/src/features/profile/providers/profile_provider.dart` (Modify)
*   `lib/src/core/services/image_upload_service.dart` (Create or Modify)

### Implementation Details:
1.  **Modify `ProfileNotifier`:**
    *   Create `updateAvatar` and `updateCover` methods.
    *   These methods will use a reusable `ImageUploadService` to let the user pick an image from the gallery and upload it.
    *   After a successful upload, they will call the API to update the user's profile with the new image URL and then refresh the profile data.
2.  **Create/Modify `ImageUploadService`:**
    *   Ensure there's a reusable service for image picking and uploading.

### Testing:
*   **Unit Tests:**
    *   Test the `updateAvatar` and `updateCover` methods, mocking the `ImageUploadService` and `UsersApi`.

---

## Task 10: Profile Info Card Widget

### Goal
Build a reusable widget to display the user's detailed information.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/info_card.dart` (Create)

### Implementation Details:
1.  **Create `info_card.dart`:**
    *   Create a widget that displays the user's bio, gender, activity duration, inviter, privacy level, rank, tag count, and blocked user count, as specified in `spec/profile.md`.
    *   The card will take the relevant user data from the `ProfileState` as a parameter.

### Testing:
*   **Widget Tests:**
    *   Test the `InfoCard` widget with mock data.

---

## Task 11: Profile Badge Card Widget

### Goal
Build a reusable widget to showcase the user's earned badges.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/badge_card.dart` (Create)

### Implementation Details:
1.  **Create `badge_card.dart`:**
    *   Create a widget to display a grid of the user's most recently earned badges.
    *   Include a button to view all badges if the user has more than the displayed amount.
    *   The card will take the list of badges from the `ProfileState` as a parameter.

### Testing:
*   **Widget Tests:**
    *   Test the `BadgeCard` widget with mock data.

---

## Task 12: Profile Last Images Card Widget

### Goal
Build a reusable widget to display a gallery of the user's recent images.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/image_card.dart` (Create)

### Implementation Details:
1.  **Create `image_card.dart`:**
    *   Create a widget to display a grid of the user's most recent images.
    *   Tapping an image should open it in a fullscreen viewer.
    *   Include a button to view the full image list if applicable.
    *   The card will take the list of images from the `ProfileState` as a parameter.

### Testing:
*   **Widget Tests:**
    *   Test the `ImageCard` widget with mock data.

---

## Task 13: Profile Tag Card Widget

### Goal
Build a reusable widget to display the tags used by the user.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/tag_card.dart` (Create)

### Implementation Details:
1.  **Create `tag_card.dart`:**
    *   Create a widget that displays a list or cloud of tags used by the user.
    *   Tapping a tag should navigate to a feed of entries with that tag.
    *   The card will take the list of tags from the `ProfileState` as a parameter.

### Testing:
*   **Widget Tests:**
    *   Test the `TagCard` widget with mock data.

---

## Task 14: Profile Last Entries Card Widget

### Goal
Build a reusable widget to display the user's most recent entries.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/last_entries_card.dart` (Create)

### Implementation Details:
1.  **Create `last_entries_card.dart`:**
    *   Create a widget that displays a list of the user's last 10 entry titles and dates.
    *   It should only be displayed if the user has at least one entry.
    *   Tapping an entry should navigate to the entry detail screen.
    *   The card will take the calendar data from the `ProfileState` as a parameter.

### Testing:
*   **Widget Tests:**
    *   Test the `LastEntriesCard` widget with mock data.

---

## Task 15: Profile Calendar Card Widget

### Goal
Build a reusable widget to display the user's activity in a calendar view.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/calendar_card.dart` (Create)

### Implementation Details:
1.  **Create `calendar_card.dart`:**
    *   The widget will take calendar data from the `ProfileState` and the user's registration date as parameters.
2.  **Header UI:**
    *   Implement a header with navigation buttons: "previous year" (⏮️), "previous month" (◀️), "next month" (▶️), and "next year" (⏭️).
    *   Display the current month and year, using localized month names. The year should only be shown if it is not the current year.
3.  **Calendar Grid:**
    *   Display a standard month grid.
    *   For days with one entry, display the day number and a truncated title (8 chars + "...").
    *   For days with multiple entries, display the day number and a count (e.g., "+3").
    *   Style active days with a primary-colored background and white text.
4.  **Navigation Logic:**
    *   Implement logic for month and year navigation.
    *   Disable navigation to dates before the user's registration date. Implement a fallback to the registration month if year navigation is blocked.
5.  **Interaction Logic:**
    *   On tapping a single-entry day, navigate to the `EntryDetailScreen`.
    *   On tapping a multiple-entry day, show a popup dialog.
6.  **Popup Dialog:**
    *   Create a dialog with a constrained size (300px width, max 300px height).
    *   The dialog should display a scrollable list of entries for the selected day.
    *   Each item in the list should be tappable, navigating to the corresponding `EntryDetailScreen`.
    *   Include a close button.

### Testing:
*   **Widget Tests:**
    *   Test the `CalendarCard` widget with mock data.

---

## Task 16: Profile Screen Structure

### Goal
Build the basic structure of the profile screen, including the app bar and handling of different data states.

### Files to be Created or Modified:
*   `lib/src/features/profile/screens/profile_screen.dart` (Create)

### Implementation Details:
1.  **Create `profile_screen.dart`:**
    *   The main screen widget that watches the `profileProvider`.
    *   The screen layout will be structured with the new `ProfileHeaderCard` at the top.
    *   The rest of the profile content (info card, badge card, etc.) will be placed in a scrollable view below the header card.
    *   Display a `SkeletonLoader` while the state is `loading`.
    *   Display an error message if the state is `error`.
    *   When loaded, display the header card and the main content area.

### Testing:
*   **Widget Tests:**
    *   Test the `ProfileScreen`, mocking the `profileProvider` in its `loading`, `loaded`, and `error` states to ensure the correct widgets are displayed.

---

## Task 17: Responsive Profile Layout

### Goal
Integrate the content cards into the profile screen with a responsive layout.

### Files to be Created or Modified:
*   `lib/src/features/profile/screens/profile_screen.dart` (Modify)

### Implementation Details:
1.  **Modify `profile_screen.dart`:**
    *   Inside the `CustomScrollView`, add a `SliverToBoxAdapter` or similar sliver widget to contain the content grid.
    *   Use a `LayoutBuilder` and `StaggeredGrid` (from `flutter_staggered_grid_view`) to implement the responsive layout.
    *   Arrange the `InfoCard`, `BadgeCard`, `ImageCard`, etc., into 1, 2, or 3 columns based on the screen width breakpoints defined in `spec/profile.md`.
    *   For the three-column layout (> 1200dp), the middle column should display the user's entry feed using the `ProfileTlogFeed` widget.

### Testing:
*   **Widget Tests:**
    *   Verify the responsive layout changes correctly at different screen widths by mocking the screen size.

---

## Task 18: Profile Entry Feed

### Goal
Build a widget to display the user's entry feed for the desktop layout.

### Files to be Created or Modified:
*   `lib/src/features/profile/widgets/profile_tlog_feed.dart` (Create)

### Implementation Details:
1.  **Create `profile_tlog_feed.dart`:**
    *   Create a widget that displays a list of entries.
    *   It should support infinite scrolling to load more entries by calling the provider's `fetchNextTlogPage` method.
    *   It will take the entry list and pagination state from the `ProfileState` as parameters.
    *   Reuse existing entry card/tile widgets if available to display each entry.

### Testing:
*   **Widget Tests:**
    *   Test the `ProfileTlogFeed` widget with mock data.
    *   Verify that it correctly displays entries and handles pagination.

---

## Task 19: Add Profile Route

### Goal
Integrate the profile screen into the app's navigation system.

### Files to be Created or Modified:
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for the path `/users/:name`.
    *   This route should build the `ProfileScreen`, passing the `name` parameter to it.

### Testing:
*   N/A (This is a configuration change, can be verified via integration testing).

---

## Task 20: User List State and Provider

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

## Task 21: User Card Widget

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

## Task 22: User List Screen UI

### Goal
Create the UI for the user list screen, displaying a grid of users and handling basic states.

### Files to be Created or Modified:
*   `lib/src/features/profile/screens/user_list_screen.dart` (Create)

### Implementation Details:
1.  **Create `user_list_screen.dart`:**
    *   Create a screen that takes a `UserListType` and `username` as parameters.
    *   It will watch the `userListProvider`.
    *   Display a responsive `StaggeredGrid` of `UserCard` widgets when data is loaded.
    *   Handle and display the initial loading, empty, and error states appropriately.

### Testing:
*   **Widget Tests:**
    *   Test the `UserListScreen`, mocking the provider to verify the grid and state handling (loading, loaded, empty, error).

---

## Task 23: User List Screen Functionality

### Goal
Implement pull-to-refresh and infinite scrolling for the user list.

### Files to be Created or Modified:
*   `lib/src/features/profile/screens/user_list_screen.dart` (Modify)

### Implementation Details:
1.  **Modify `user_list_screen.dart`:**
    *   Wrap the user grid in a `RefreshIndicator` to allow pull-to-refresh, which should call a `refresh` method on the provider.
    *   Implement infinite scrolling by detecting when the user has scrolled to the end of the list and calling a `fetchNextPage` method on the provider.

### Testing:
*   **Widget Tests:**
    *   Test that pulling to refresh calls the correct method on the provider.
    *   Test that scrolling to the end of the list triggers pagination.

---

## Task 24: Add User List Routes

### Goal
Integrate the user list screen into the app's navigation system.

### Files to be Created or Modified:
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Modify `app_router.dart`:**
    *   Add routes like `/users/:name/followers` and `/users/:name/following` that build the `UserListScreen` with the correct parameters (`UserListType` and `username`).

### Testing:
*   N/A (This is a configuration change, can be verified via integration testing).
