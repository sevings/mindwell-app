# Epic: Design System & Core UI

This epic focuses on establishing the foundational design system and core UI components for the Mindwell application. The goal is to create a consistent, reusable, and platform-adaptive set of widgets that will be used throughout the app.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: Visual Theme Definition

### Goal
Define the core visual theme of the application, including colors, typography, and spacing constants.

### Files to be Created or Modified:
*   `lib/src/core/theme/mindwell_theme.dart` (Create)
*   `lib/src/core/theme/color_schemes.dart` (Create)
*   `lib/src/core/theme/typography.dart` (Create)
*   `lib/src/core/theme/spacing.dart` (Create)

### Implementation Details:
1.  **Create `color_schemes.dart`:**
    *   Define `ColorScheme` objects for both light and dark themes using the colors from `spec/common_ui.md`.
    *   Ensure WCAG AA compliance for contrast ratios.
2.  **Create `typography.dart`:**
    *   Define a `TextTheme` with the font families and type scale specified in the spec.
    *   Use `Inter` as the primary font (you may need to add it to `pubspec.yaml` and the `assets` folder).
3.  **Create `spacing.dart`:**
    *   Define a class with static `const` double values for the spacing scale (xs, sm, md, etc.).
4.  **Create `mindwell_theme.dart`:**
    *   Create a `MindwellTheme` class that combines the color scheme, text theme, and component themes.
    *   Define `ThemeData` for both light and dark modes.
    *   Configure themes for `AppBar`, `Button`, `Card`, and `InputDecoration`.

### Testing:
*   **Unit Test:** Write unit tests for the theme data to verify that colors and typography settings are correct.

---

## Task 2: Basic App Structure

### Goal
Set up the root of the application and configure the main app widget to use the defined themes.

### Files to be Created or Modified:
*   `lib/src/app.dart` (Create)
*   `lib/main.dart` (Modify)

### Implementation Details:
1.  **Modify `main.dart`:**
    *   Initialize any necessary services (like `Hive` or `flutter_secure_storage`) in the `main` function.
    *   Run the main application widget.
2.  **Create `app.dart`:**
    *   Create a `StatelessWidget` `MindWellApp`.
    *   This widget will be a `MaterialApp` (or a platform-aware equivalent).
    *   Use the themes defined in `mindwell_theme.dart`.
    *   Set up `go_router` for navigation (initially with just a home route placeholder).

### Testing:
*   **Widget Test:** Write a widget test for `MindWellApp` to ensure it builds correctly and applies the light and dark themes.

---

## Task 3: App Router and Home Shell

### Goal
Set up the basic navigation structure using `go_router` and create the main home screen shell that will host the navigation elements.

### Files to be Created or Modified:
*   `lib/src/core/router/app_router.dart` (Create)
*   `lib/src/features/home/screens/home_screen.dart` (Create)

### Implementation Details:
1.  **Create `app_router.dart`:**
    *   Configure `GoRouter` with an initial set of routes (e.g., home, login).
    *   Implement a `ShellRoute` that will wrap the main authenticated screens. `HomeScreen` will be the builder for this `ShellRoute`.
2.  **Create `home_screen.dart`:**
    *   This will be the main screen inside the `ShellRoute`.
    *   It should contain a `Scaffold` that will hold the `PlatformAppBar`, `BottomNavBar`, and `NavDrawer` in subsequent tasks.

### Testing:
*   **Widget Tests:**
    *   Test the `HomeScreen` to ensure the `Scaffold` renders.
    *   Write basic router tests to confirm navigation to the home route.

---

## Task 4: Core Navigation Widgets

### Goal
Implement the reusable navigation components: App Bar, Bottom Navigation Bar, and Navigation Drawer.

### Files to be Created or Modified:
*   `lib/src/core/widgets/platform_app_bar.dart` (Create)
*   `lib/src/core/widgets/bottom_nav_bar.dart` (Create)
*   `lib/src/core/widgets/nav_drawer.dart` (Create)
*   `lib/src/features/home/screens/home_screen.dart` (Modify)

### Implementation Details:
1.  **Create `platform_app_bar.dart`:**
    *   Create a widget that returns a `Material` `AppBar` on Android and a `CupertinoSliverNavigationBar` on iOS.
    *   It should accept a title and a list of actions.
2.  **Create `bottom_nav_bar.dart`:**
    *   Implement the bottom navigation bar with icons for Home, Notifications, and Chat.
    *   It should only be visible when the user is authenticated (manage visibility with a provider).
    *   Use `NavigationBar` for Material and `CupertinoTabBar` for iOS.
3.  **Create `nav_drawer.dart`:**
    *   Implement the side navigation drawer.
    *   Display different items based on the user's authentication state (use a provider to get the state).
    *   Include the profile header.
4.  **Modify `home_screen.dart`:**
    *   Integrate the `PlatformAppBar`, `BottomNavBar`, and `NavDrawer` into the `Scaffold`.

### Testing:
*   **Widget Tests:**
    *   Test `PlatformAppBar`, `BottomNavBar`, and `NavDrawer` individually.
    *   Mock an authentication provider to test both logged-in and logged-out states for the navigation elements.

---

## Task 5: Reusable Button Components

### Goal
Create a set of standardized, reusable button widgets that conform to the design system.

### Files to be Created or Modified:
*   `lib/src/core/widgets/buttons/primary_button.dart` (Create)
*   `lib/src/core/widgets/buttons/secondary_button.dart` (Create)
*   `lib/src/core/widgets/buttons/text_button.dart` (Create)

### Implementation Details:
1.  **Create `primary_button.dart`:**
    *   An `ElevatedButton` with the primary color scheme.
    *   Should support a loading state (e.g., showing a `CircularProgressIndicator` instead of text).
    *   Should handle enabled/disabled states.
2.  **Create `secondary_button.dart`:**
    *   An `OutlinedButton` styled according to the spec.
3.  **Create `text_button.dart`:**
    *   A `TextButton` styled according to the spec.
4.  **Storybook (Optional but Recommended):**
    *   If possible, use a tool like `storybook_flutter` to create a gallery of these buttons in all their states.

### Testing:
*   **Widget Tests:** Write tests for each button type to verify:
    *   They render correctly.
    *   The `onPressed` callback is triggered when tapped.
    *   Disabled and loading states appear as expected.

---

## Task 6: Reusable Form and Input Components

### Goal
Create standardized components for text input and forms.

### Files to be Created or Modified:
*   `lib/src/core/widgets/inputs/styled_text_field.dart` (Create)

### Implementation Details:
1.  **Create `styled_text_field.dart`:**
    *   A wrapper around `TextFormField`.
    *   Use the `InputDecorationTheme` defined in the main theme.
    *   Should accept a label, validator, controller, and other standard `TextFormField` properties.
    *   Should clearly display validation errors.

### Testing:
*   **Widget Tests:**
    *   Test that the `StyledTextField` renders correctly with a label.
    *   Test that it displays an error message when a validator fails.
    *   Test that user input correctly updates the `TextEditingController`.

---

## Task 7: Loaders and Feedback Components

### Goal
Implement standardized components for indicating loading states and showing feedback to the user (dialogs, snackbars).

### Files to be Created or Modified:
*   `lib/src/core/widgets/loaders/skeleton_loader.dart` (Create)
*   `lib/src/core/widgets/loaders/app_loader.dart` (Create)
*   `lib/src/core/widgets/dialogs/app_dialog.dart` (Create)
*   `lib/src/core/utils/snackbar_utils.dart` (Create)

### Implementation Details:
1.  **Create `app_loader.dart`:**
    *   A simple, centered `CircularProgressIndicator`.
2.  **Create `skeleton_loader.dart`:**
    *   Use the `shimmer` package to create a skeleton loading effect.
    *   Make it composable so it can wrap any widget structure.
3.  **Create `app_dialog.dart`:**
    *   Create a standardized dialog function that shows a platform-adaptive dialog (`AlertDialog` or `CupertinoAlertDialog`).
    *   It should accept a title, content, and a list of actions.
4.  **Create `snackbar_utils.dart`:**
    *   A utility class with static methods to show styled `SnackBar` messages for success, error, and info.

### Testing:
*   **Widget Tests:**
    *   Test that `AppLoader` and `SkeletonLoader` render.
    *   Write tests to verify that `AppDialog` can be shown and that its action buttons work.
*   **Unit Tests:**
    *   Test the logic within `SnackbarUtils` if any.

---

## Task 8: Image Handling Widget

### Goal
Create a reliable widget for displaying network images with proper loading and error states.

### Files to be Created or Modified:
*   `lib/src/core/widgets/images/cached_image.dart` (Create)

### Implementation Details:
1.  **Create `cached_image.dart`:**
    *   Use the `cached_network_image` package.
    *   Provide a `placeholder` builder that shows a `SkeletonLoader`.
    *   Provide an `errorWidget` builder that shows a placeholder icon or message.
    *   The widget should accept an image URL and optional dimensions (width, height).

### Testing:
*   **Widget Tests:**
    *   Test the `CachedImage` widget. You will need to mock the network image provider to test the loading, success, and error states.
