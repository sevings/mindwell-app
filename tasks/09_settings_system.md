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

## Task 2: Platform-Adaptive Settings UI Components

### Goal
To create the reusable, platform-adaptive UI components for building the settings screens.

### Files to be Created or Modified:
*   `lib/src/features/settings/widgets/settings_section.dart` (Create)
*   `lib/src/features/settings/widgets/settings_tile.dart` (Create)

### Implementation Details:
1.  **Create UI Components:**
    *   `settings_tile.dart`: A reusable widget that adapts its appearance. It will render a `ListTile` on Android and a `CupertinoListTile` on iOS. It can contain a title, subtitle, leading icon, and a trailing widget (like a `Switch` or a chevron icon).
    *   `settings_section.dart`: A widget that groups `SettingsTile`s under a common header, adapting to `Material` or `Cupertino` styling.

### Testing:
*   **Widget Tests:** Test the components to verify that they adapt between Material and Cupertino styles.

---

## Task 3: Main Settings Screen

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

## Task 4: Account Management Screens

### Goal
To build the sub-screens for managing account-specific details like changing password and email.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/change_password_screen.dart` (Create)
*   `lib/src/features/settings/screens/change_email_screen.dart` (Create)
*   `lib/src/features/settings/screens/invites_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `change_password_screen.dart`:**
    *   A form with fields for the current password and the new password (with confirmation).
    *   Use a dedicated provider or the existing `SettingsProvider` to call the `/account/password` endpoint.
    *   Provide feedback on success or failure.
2.  **Create `change_email_screen.dart`:**
    *   A form to enter a new email and the current password for confirmation.
    *   Call the `/account/email` endpoint.
    *   Display the user's current email and its verification status.
3.  **Create `invites_screen.dart`:**
    *   A simple screen that displays the number of available invites and instructional text.
4.  **Modify `app_router.dart`:**
    *   Add the corresponding `GoRoute`s for these new screens, likely as sub-routes of `/settings`.

### Testing:
*   **Widget Tests:** Test each new screen, focusing on form validation and interaction with a mocked provider/API service.

---

## Task 5: Privacy Management Providers

### Goal
To create the state management providers for the blocked and hidden users lists.

### Files to be Created or Modified:
*   `lib/src/features/settings/providers/blocked_users_provider.dart` (Create)
*   `lib/src/features/settings/providers/hidden_users_provider.dart` (Create)

### Implementation Details:
1.  **Create Providers:**
    *   Create `blocked_users_provider.dart` and `hidden_users_provider.dart`.
    *   Each will be a `StateNotifierProvider` responsible for fetching its respective list of users and handling the "unblock" or "unhide" action.

### Testing:
*   **Unit Tests:** Test the providers for fetching and removing users from the lists.

---

## Task 6: Privacy Management Screens

### Goal
To build the screens that allow users to view and manage their blocked and hidden profiles lists.

### Files to be Created or Modified:
*   `lib/src/features/settings/screens/blocked_users_screen.dart` (Create)
*   `lib/src/features/settings/screens/hidden_users_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create Screens:**
    *   Create `blocked_users_screen.dart` and `hidden_users_screen.dart`.
    *   These screens will use their respective providers to display a list of users.
    *   Each list item will show the user's avatar and name.
    *   Include a button on each item to unblock/unhide the user, which calls the method on the provider.
2.  **Modify `app_router.dart`:**
    *   Add `GoRoute`s for these screens.

### Testing:
*   **Widget Tests:** Test the screens with a mocked provider to ensure the list displays correctly and the unblock/unhide buttons work.
