# Epic: Theme System

This epic covers the functionality for browsing, viewing, creating, and managing themes. Themes are community-driven spaces for content.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: Theme List State Management

### Goal
Set up the state management for fetching and filtering a list of themes.

### Files to be Created or Modified:
*   `lib/src/features/themes/providers/theme_list_provider.dart` (Create)
*   `lib/src/features/themes/models/theme_list_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `theme_list_state.dart` using `freezed` (`loading`, `loaded`, `error`). The `loaded` state should include `List<Theme> themes`, `bool hasMore`, search/filter parameters, etc.
    *   Create `theme_list_provider.dart`, a `StateNotifierProvider` that fetches a paginated list of themes from the `ThemesApi`.
    *   The notifier should support search and filtering logic, refetching the list when parameters change.

### Testing:
*   **Unit Tests:** Test the `ThemeListNotifier`, including its search and filter logic.

---

## Task 2: Theme List UI

### Goal
To create the screen that displays a searchable and filterable list of themes.

### Files to be Created or Modified:
*   `lib/src/features/themes/screens/theme_list_screen.dart` (Create)
*   `lib/src/features/themes/widgets/theme_card.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `theme_card.dart`:**
    *   A reusable widget to display a theme's avatar, cover, name, description, and stats (followers, entries).
    *   Tapping the card navigates to the `ThemeDetailScreen`.
2.  **Create `theme_list_screen.dart`:**
    *   A screen with an app bar containing search and filter controls.
    *   It will watch the `themeListProvider` and display a responsive `StaggeredGrid` of `ThemeCard` widgets.
    *   Implement pull-to-refresh and infinite scrolling.
    *   Include a `FloatingActionButton` to navigate to the theme creation screen.
3.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/themes` that builds the `ThemeListScreen`.

### Testing:
*   **Widget Tests:** Test the `ThemeListScreen` and `ThemeCard` with mocked provider data.

---

## Task 3: Theme Detail State Management

### Goal
Set up the state management for viewing the details of a single theme.

### Files to be Created or Modified:
*   `lib/src/features/themes/providers/theme_detail_provider.dart` (Create)
*   `lib/src/features/themes/models/theme_detail_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `theme_detail_state.dart` using `freezed` (`loading`, `loaded`, `error`). The `loaded` state will contain the `Theme` object and lists of its associated entries, followers, etc.
    *   Create `theme_detail_provider.dart`, a `StateNotifierProvider` that takes a theme `name`. It will fetch all the necessary data for the detail view from the `ThemesApi`.

### Testing:
*   **Unit Tests:** Test the `ThemeDetailNotifier` to ensure it aggregates data correctly.

---

## Task 4: Theme Detail UI

### Goal
To create the screen that provides a comprehensive view of a single theme.

### Files to be Created or Modified:
*   `lib/src/features/themes/screens/theme_detail_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `theme_detail_screen.dart`:**
    *   Use a `CustomScrollView` with a `SliverAppBar` for the theme's cover image and collapsing header.
    *   The header should display the theme's avatar, name, stats, and a Follow/Unfollow button.
    *   Below the header, use a `TabBar` to switch between different content views:
        *   **Entries:** A feed of entries posted to this theme (reuse the `EntryList` widget from the Entry System epic).
        *   **Followers:** A list of users following the theme (reuse the `UserListScreen` or a similar widget).
        *   Other tabs like Images, Comments as specified.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/themes/:name` that builds the `ThemeDetailScreen`.

### Testing:
*   **Widget Tests:** Test the `ThemeDetailScreen` with a mocked provider. Verify the collapsing header, tab navigation, and content views.

---

## Task 5: Theme Creation/Editing State Management

### Goal
Set up the state management for creating and editing a theme.

### Files to be Created or Modified:
*   `lib/src/features/themes/providers/theme_edit_provider.dart` (Create)
*   `lib/src/features/themes/models/theme_edit_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `theme_edit_state.dart` using `freezed` to manage the form state (`initial`, `submitting`, `success`, `error`).
    *   Create `theme_edit_provider.dart`, a `StateNotifierProvider`. It will handle the logic for creating or updating a theme via the `ThemesApi`. It will also manage uploading avatar and cover images.

### Testing:
*   **Unit Tests:** Test the `ThemeEditNotifier`, mocking the `ThemesApi` to verify creation and update logic.

---

## Task 6: Theme Creation/Editing UI

### Goal
To build a form that allows users to create new themes and edit existing ones.

### Files to be Created or Modified:
*   `lib/src/features/themes/screens/theme_edit_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `theme_edit_screen.dart`:**
    *   A `Form`-based screen with `StyledTextField` widgets for the theme's name, display name, and description.
    *   Include controls for uploading/changing the avatar and cover image (using `image_picker`).
    *   Provide inputs for configuring theme settings (privacy, moderation, etc.).
    *   The "Save" or "Create" button will call the appropriate method on the `themeEditProvider`. The button should show a loading state during submission.
2.  **Modify `app_router.dart`:**
    *   Add `GoRoute`s for `/themes/new` and `/themes/:name/edit`.

### Testing:
*   **Widget Tests:** Test the `ThemeEditScreen`, checking for form validation and interaction with the mocked provider.
