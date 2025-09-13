# Epic: Advanced Features

This epic includes additional, standalone features that enrich the user experience, such as viewing user-specific galleries of images and earned badges.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: User Badge List State Management

### Goal
To create the state management for displaying a list of a user's earned badges.

### Files to be Created or Modified:
*   `lib/src/features/badges/providers/badge_list_provider.dart` (Create)
*   `lib/src/features/badges/models/badge_list_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `badge_list_state.dart` with `freezed` (`loading`, `loaded`, `empty`, `error`).
    *   Create `badge_list_provider.dart`, a `StateNotifierProvider` that takes a `username`. It will use the `UsersApi` to fetch the list of badges for that user.

### Testing:
*   **Unit Tests:** Test the `BadgeListNotifier`.

---

## Task 2: User Badge List UI

### Goal
To create the screen that displays all the badges a specific user has earned.

### Files to be Created or Modified:
*   `lib/src/features/badges/screens/badge_list_screen.dart` (Create)
*   `lib/src/features/badges/widgets/badge_card.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `badge_card.dart`:**
    *   A widget to display a single badge. It should show the badge's icon, title, description, and the date it was received.
    *   Tapping it could show a dialog with more details.
2.  **Create `badge_list_screen.dart`:**
    *   This screen takes a `username` as a parameter.
    *   It watches the `badgeListProvider` and displays a responsive grid of `BadgeCard` widgets (e.g., using `SliverGrid`).
    *   It should handle loading, empty, and error states gracefully.
3.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/users/:name/badges`.

### Testing:
*   **Widget Tests:** Test the `BadgeListScreen` and `BadgeCard` with a mocked provider.

---

## Task 3: User Image List State Management

### Goal
To build the state management for a user's image gallery.

### Files to be Created or Modified:
*   `lib/src/features/images/providers/image_list_provider.dart` (Create)
*   `lib/src/features/images/models/image_list_state.dart` (Create)

### Implementation Details:
1.  **Add Dependencies:** Add `flutter_staggered_grid_view` and `photo_view` to `pubspec.yaml`.
2.  **Create Models and Provider:**
    *   Create `image_list_state.dart` with `freezed` (`loading`, `loaded`, `error`). The `loaded` state will contain `List<Image> images`, `bool hasMore`, etc.
    *   Create `image_list_provider.dart`, a `StateNotifierProvider` that takes a `username`. It will use the `UsersApi` to fetch a paginated list of images.

### Testing:
*   **Unit Tests:** Test the `ImageListNotifier`, including pagination.

---

## Task 4: User Image Gallery UI

### Goal
To build the gallery screen for a user's images with a masonry grid layout.

### Files to be Created or Modified:
*   `lib/src/features/images/screens/image_list_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `image_list_screen.dart`:**
    *   The screen will watch the `imageListProvider`.
    *   Display a responsive `StaggeredGrid` of images using `cached_network_image`.
    *   Implement pull-to-refresh and infinite scrolling.
    *   Tapping an image should navigate to the `ImageViewerScreen`, passing the list of images and the initial index. Use a `Hero` animation for a smooth transition.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/users/:name/images`.

### Testing:
*   **Widget Tests:**
    *   Test `ImageListScreen` with a mocked provider.

---

## Task 5: Fullscreen Image Viewer

### Goal
To build a fullscreen interactive viewer for the image gallery.

### Files to be Created or Modified:
*   `lib/src/features/images/screens/image_viewer_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `image_viewer_screen.dart`:**
    *   This screen will use a `PageView.builder` to allow swiping between images.
    *   Each page in the `PageView` will be a `PhotoView` widget, enabling pinch-to-zoom functionality.
    *   The provider should be used here as well to load more images as the user swipes towards the end of the currently loaded list.
2.  **Modify `app_router.dart`:**
    *   Add a sub-route or separate route for the viewer.

### Testing:
*   **Widget Tests:**
    *   Test `ImageViewerScreen`, verifying that swiping works and that `PhotoView` is used.
