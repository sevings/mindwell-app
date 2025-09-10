# User Badge List Screen Specification

## 1. Introduction

This document outlines the technical specifications for the User Badge List screen in the Mindwell mobile application. This screen displays a list of badges earned by a user.

## 2. Goals

*   Display a list of badges in a visually appealing and easy-to-understand layout.
*   Provide details for each badge, including its icon, title, and description.
*   Ensure a consistent and high-quality user experience.

## 3. Functional Requirements

### 3.1. Content Display

*   **Badge Grid:** Display a grid of badges earned by the user.
*   **Badge Card:** Each badge should be displayed in a `Card` widget with the following information:
    *   **Icon:** Display the badge's icon using `cached_network_image`.
    *   **Title:** Display the title of the badge.
    *   **Description:** Display the description of what the badge is for.
    *   **Received Date:** Display the date the badge was awarded, formatted as `dd.MM.yyyy`.
*   **Empty State:** If the user has not earned any badges, display a message indicating that they can earn badges by participating in the community.

### 3.2. User Actions

*   **Pull to refresh:** Should reload the list of badges.
*   **Tap on a badge:** Should show a dialog with a larger view of the badge icon and the full description.

### 3.3. Data Requirements

The User Badge List screen requires data from the following API endpoint:

*   `GET /users/{name}/badges`: To retrieve the list of badges (`BadgeList` object).

## 4. Non-Functional Requirements

*   **Performance:** The screen should load quickly and scroll smoothly.
*   **Security:** All data must be transmitted securely over HTTPS.
*   **Accessibility:** The screen should be accessible to users with disabilities.
*   **Responsiveness:** The layout should adapt to different screen sizes and orientations.

## 5. UI Design

*   **Layout:** Use a `CustomScrollView` with a `SliverGrid` to display the badges in a 2-column grid. This will provide a more modern and performant scrolling experience.
*   **Loading State:** Use a shimmer effect to indicate that the badges are loading. This will provide a better user experience than a `CircularProgressIndicator`.
*   **Badge Card:**
    *   Create a reusable `BadgeCard` widget to ensure consistency and maintainability.
    *   Use a `Card` widget with a slight elevation.
    *   Inside the card, use a `Column` to arrange the badge elements vertically:
        1.  `Icon` (or `Image` from the network)
        2.  `Title` (using a `Text` widget with a bold style)
        3.  `Description` (using a `Text` widget with a smaller font size)
        4.  `Received Date` (using a `Text` widget with an italic style)
*   **Styling:**
    *   **Typography:** Use the typography defined in the application's theme.
    *   **Color Palette:** Adhere to the application's color palette.
    *   **Spacing:** Use consistent spacing and padding.

## 6. Flutter Implementation Details

*   **API Client:** Use the generated `UsersApi` directly in the provider.
*   **State Management:** Use `Riverpod` to manage the state of the screen.
    *   Use a `StateNotifierProvider` to handle the badge list state and API calls.
    *   The provider will directly call the API client methods.
*   **Widget:**
    *   The main widget will be a `ConsumerWidget` that listens to the `StateNotifierProvider`.
    *   The widget will handle the different states of the badge list (loading, data, error, empty).

## 7. State Management

The state of the screen will be managed by a `StateNotifierProvider` that returns a `BadgeListState` object. The `BadgeListState` will be a sealed class with the following states:

*   **`BadgeListLoading`:** Show a shimmer effect.
*   **`BadgeListLoaded`:** Show the `SliverGrid` of badges.
*   **`BadgeListEmpty`:** Show the empty state message.
*   **`BadgeListError`:** Show an error message with a "Retry" button.

## 8. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the badge cards and the "Retry" button.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Alternative Text:** Provide alternative text for all badge icons.

## 9. Future Considerations

*   **Gamification:** Badges can be used to encourage user engagement and reward them for their activity.
*   **Animations:** Add animations when new badges are awarded or when the user interacts with them.
*   **Sharing:** Allow users to share their earned badges on social media.