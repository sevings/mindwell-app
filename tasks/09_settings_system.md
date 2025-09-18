# Epic: Settings System

This epic covers the implementation of the app's settings screens, allowing users to manage their account, notifications, privacy, and other preferences. The UI should adapt to feel native on both Android and iOS.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: Settings State Management

### Goal
To fetch and manage the state of all user settings.

### Files to be Created or Modified:
*   `lib/src/features/settings/providers/settings_provider.dart` (Create)
*   `lib/src/features/settings/models/settings_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `settings_state.dart` using `freezed` (`loading`, `loaded`, `error`). The `loaded` state will hold separate objects for `EmailSettings`, `TelegramSettings`, and `OnsiteSettings`, which will be fetched from the API.
    *   Create `settings_provider.dart`, a `StateNotifierProvider`.
    *   The notifier will depend on the `AccountApi`. In its `init` method, it will make parallel calls to fetch the different settings groups (`/account/settings/email`, `/account/settings/telegram`, etc.).
    *   It will also have methods to update settings, like `updateEmailSettings(EmailSettings newSettings)`, which will make a PUT request and then refetch the settings to confirm the new state.

### Testing:
*   **Unit Tests:** Test the `SettingsNotifier` to verify it fetches and updates settings correctly.

---

## Task 2: Create Settings Tile UI Component

### Goal
To create a reusable, platform-adaptive `SettingsTile` widget for building settings screens.

### Files to be Created or Modified:
*   `lib/src/features/settings/widgets/settings_tile.dart` (Create)

### Implementation Details:
1.  **Create `settings_tile.dart`:**
    *   A reusable widget that adapts its appearance.
    *   It will render a `ListTile` on Android and a `CupertinoListTile` on iOS.
    *   It can contain a title, subtitle, leading icon, and a trailing widget (like a `Switch` or a chevron icon).

### Testing:
*   **Widget Tests:** Test the component to verify that it adapts between Material and Cupertino styles.

---

## Task 3: Create Settings Section UI Component

### Goal
To create a reusable, platform-adaptive `SettingsSection` widget to group settings tiles.

### Files to be Created or Modified:
*   `lib/src/features/settings/widgets/settings_section.dart` (Create)

### Implementation Details:
1.  **Create `settings_section.dart`:**
    *   A widget that groups `SettingsTile`s under a common header.
    *   It should adapt to `Material` or `Cupertino` styling.

### Testing:
*   **Widget Tests:** Test the component to verify that it adapts between Material and Cupertino styles.

---

## Task 4: Main Settings Screen

### Goal
To build the main settings screen layout that groups all setting categories.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/settings_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `settings_screen.dart`:**
    *   The main screen that watches the `settingsProvider`.
    *   It should display a platform-adaptive `Scaffold` (`Scaffold` for Android, `CupertinoPageScaffold` for iOS).
    *   The body will be a `ListView` of `SettingsSection` widgets for each category (Account, Notifications, etc.).
    *   Each section will contain `SettingsTile` widgets for the individual settings.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/settings`.

### Testing:
*   **Widget Tests:** Test the `SettingsScreen` with a mocked provider.

---

## Task 5: Change Password Screen

### Goal
To build the screen for changing the user's password.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/change_password_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `change_password_screen.dart`:**
    *   A form with fields for the current password and the new password (with confirmation).
    *   Use a dedicated provider or the existing `SettingsProvider` to call the `/account/password` endpoint.
    *   Provide feedback on success or failure.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for this screen, likely as a sub-route of `/settings`.

### Testing:
*   **Widget Tests:** Test the screen, focusing on form validation and interaction with a mocked provider/API service.

---

## Task 6: Change Email Screen

### Goal
To build the screen for changing the user's email.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/change_email_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `change_email_screen.dart`:**
    *   A form to enter a new email and the current password for confirmation.
    *   Call the `/account/email` endpoint.
    *   Display the user's current email and its verification status.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for this screen, likely as a sub-route of `/settings`.

### Testing:
*   **Widget Tests:** Test the screen, focusing on form validation and interaction with a mocked provider/API service.

---

## Task 7: Invites Screen

### Goal
To build a screen displaying the user's available invites.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/invites_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `invites_screen.dart`:**
    *   A simple screen that displays the number of available invites and instructional text.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for this screen, likely as a sub-route of `/settings`.

### Testing:
*   **Widget Tests:** Test the `InvitesScreen`.

---

## Task 8: Blocked Users Provider

### Goal
To create the state management provider for the blocked users list.

### Files to be Created or Modified:
*   `lib/src/features/settings/providers/blocked_users_provider.dart` (Create)

### Implementation Details:
1.  **Create Provider:**
    *   Create `blocked_users_provider.dart`.
    *   It will be a `StateNotifierProvider` responsible for fetching the list of blocked users and handling the "unblock" action.

### Testing:
*   **Unit Tests:** Test the provider for fetching and removing users from the list.

---

## Task 9: Hidden Users Provider

### Goal
To create the state management provider for the hidden users list.

### Files to be Created or Modified:
*   `lib/src/features/settings/providers/hidden_users_provider.dart` (Create)

### Implementation Details:
1.  **Create Provider:**
    *   Create `hidden_users_provider.dart`.
    *   It will be a `StateNotifierProvider` responsible for fetching its respective list of users and handling the "unhide" action.

### Testing:
*   **Unit Tests:** Test the provider for fetching and removing users from the list.

---

## Task 10: Blocked Users Screen

### Goal
To build the screen that allows users to view and manage their blocked users list.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/blocked_users_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create Screen:**
    *   Create `blocked_users_screen.dart`.
    *   This screen will use its respective provider to display a list of users.
    *   Each list item will show the user's avatar and name.
    *   Include a button on each item to unblock the user, which calls the method on the provider.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for this screen.

### Testing:
*   **Widget Tests:** Test the screen with a mocked provider to ensure the list displays correctly and the unblock button works.

---

## Task 11: Hidden Users Screen

### Goal
To build the screen that allows users to view and manage their hidden profiles list.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/hidden_users_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create Screen:**
    *   Create `hidden_users_screen.dart`.
    *   This screen will use its respective provider to display a list of users.
    *   Each list item will show the user's avatar and name.
    *   Include a button on each item to unhide the user, which calls the method on the provider.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for this screen.

### Testing:
*   **Widget Tests:** Test the screen with a mocked provider to ensure the list displays correctly and the unhide button works.
