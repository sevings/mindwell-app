# Settings Screen Specification

## 1. Introduction

This document specifies the requirements for the Settings screen of the Mindwell mobile application. The screen will provide a native look and feel on both Android and iOS, with a clean, modern, and user-friendly interface.

## 2. Goals

*   Provide users with control over their account settings.
*   Offer customization options for the app's behavior and appearance.
*   Ensure user data privacy and security.
*   Adhere to platform-specific UI guidelines for a native feel.

## 3. Functional Requirements

The Settings screen will be organized into logical sections using reusable `SettingsSection` widgets.

### 3.1. Account Settings

*   **Change Password:**
    *   Navigates to a Change Password screen.
    *   Requires the user to enter their current password and new password (functionality using the `/account/password` POST endpoint).

*   **Change Email:**
    *   Navigates to a Change Email screen.
    *   Displays a note with the current email and whether it is verified.
    *   Requires the user to enter their new email and password (functionality using the `/account/email` POST endpoint).  Verification process will be initiated.

*   **Invites:**
    *   Navigates to an Invites screen.
    *   Displays the number of available invites.
    *   Includes an explanation that the user can give an invite to another user on their profile page, granting that user full rights.

### 3.2. Notification Settings

*   **Email Notifications:**
    *   Toggles for different email notification types (using `/account/settings/email` GET and PUT endpoints).
        *   Comments: Notify when someone comments on their entries.
        *   Followers: Notify when someone follows them.
        *   Invites: Notify when they receive an invite.
        *   Moved Entries: Notify when an entry is moved.
        *   Badges: Notify when they receive a badge.

*   **Telegram Notifications:**
    *   If Telegram is connected:
        *   Toggles for different Telegram notification types (using `/account/settings/telegram` GET and PUT endpoints).
            *   Comments
            *   Followers
            *   Invites
            *   Messages
            *   Moved Entries
            *   Badges
    *   If Telegram is not connected:
        *   A button to connect to Telegram.
        *   Tapping the button gets a token from `/account/subscribe/telegram` and opens the link `'https://t.me/' + bot_name + '?start=' + token`.
        *   Displays a short instruction that the user can receive notifications via the bot and that the token is valid for 10 minutes.
        *   A disconnect button will use the `/account/subscribe/telegram` DELETE endpoint.

*   **On-Site Notifications:**
    *   Toggles for different on-site notification types (using `/account/settings/onsite` GET and PUT endpoints).
        *   Wishes: Notify when they receive a wish.

### 3.3. Data and Privacy

*   **Blocked Profiles:**
    *   Navigates to a screen listing blocked profiles.
    *   Displays a compact list of profiles with avatar, `showName`, and `lastSeenAt` or `isOnline`.
    *   Clicking on an item opens the user's profile.
    *   To the right of each item, a button allows removing the profile from the list.
    *   Includes an explanation: "The user profile is closed for blocked users. They can't see your entries and comments, and you don't see theirs unless you visit their profile directly."

*   **Hidden Profiles:**
    *   Navigates to a screen listing hidden profiles.
    *   Displays a compact list of profiles with avatar, `showName`, and `lastSeenAt` or `isOnline`.
    *   Clicking on an item opens the user's profile.
    *   To the right of each item, a button allows removing the profile from the list.
    *   Includes an explanation: "You don't see their entries in 'live' and 'best' feeds, but they can see your entries and comments as always."

*   **Privacy Policy:**
    *   Links to the app's privacy policy (external URL).

*   **Terms of Service:**
    *   Links to the app's terms of service (external URL).

*   **Delete Account:**
    *   Initiates account deletion process (requires confirmation). *Note: There isn't a specific API endpoint for this in the provided Swagger file. This might require backend development.* A warning should be displayed about data loss.

### 3.4. About

*   **App Version:**
    *   Displays the current version of the app.

*   **Contact Us:**
    *   Provides contact information or a link to a contact form.

## 4. Non-Functional Requirements

*   **Security:**
    *   All communication with the server must be encrypted using HTTPS.
    *   Sensitive settings (e.g., password, email) should require re-authentication before modification.

*   **Performance:**
    *   The Settings screen should load quickly and respond to user interactions without noticeable delay.

*   **Accessibility:**
    *   The screen should be accessible to users with disabilities, following accessibility guidelines for both Android and iOS.  Ensure proper labels for screen readers.
    *   Ensure sufficient color contrast for text and backgrounds.

*   **Localization:**
    *   The Settings screen should be localized to support multiple languages.

## 5. Platform-Specific UI

*   **Android:** Use Material Design components, with a standard `AppBar` and `ListView`.
*   **iOS:** Use Cupertino components, with a `CupertinoNavigationBar` and `CupertinoListSection`.

## 6. State Management

A `StateNotifierProvider` from `Riverpod` will be used to manage the state of the settings screen. The state will be a sealed class:

*   **`SettingsLoading`:** The initial loading state.
*   **`SettingsLoaded`:** The state when all settings are loaded.
    *   `EmailSettings emailSettings`: The user's email notification settings.
    *   `TelegramSettings telegramSettings`: The user's Telegram notification settings.
    *   `OnsiteSettings onsiteSettings`: The user's on-site notification settings.
*   **`SettingsError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 7. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all settings items, including the current state of toggles.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Content Grouping:** Group related settings within sections for better screen reader navigation.

## 8. Future Considerations

*   Two-factor authentication settings.
*   Data export options.
*   More granular notification settings.
