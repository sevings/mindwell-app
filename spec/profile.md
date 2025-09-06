# Profile Screen Specification

## 1. Overview

The Profile screen is a dynamic and responsive screen that showcases a user's personal information and activity. It uses a `CustomScrollView` with a `SliverAppBar` for a modern, collapsible header, and a responsive grid layout for the content cards.

## 2. UI Elements

### 2.1. Header (`SliverAppBar`)

*   **Flexible Space:** The user's cover image will be displayed in the `flexibleSpace` of the `SliverAppBar`, creating a parallax effect on scroll.
*   **Avatar:** The user's avatar will be displayed prominently, overlapping the cover image and the main content area.
*   **Name and Status:** The user's name and online status will be displayed in the app bar, collapsing to a smaller size as the user scrolls.
*   **Action Buttons:** The action buttons will be displayed in the app bar, always visible.
    *   **Own Profile:** An icon button to navigate to the profile editing screen.
    *   **Another User's Profile:**
        *   Icon buttons to "Follow" (if the current user is not blocked by the other user), "Write a Message" (if the current user is invited and not blocked by the other user), and "Give Invite" (if the current user has available invites and the other user can be invited).
        *   A popup menu with items: "Unfollow", "Hide from Live/Unhide", "Block/Unblock", and "Complain".
        *   If the viewed user has requested to follow the current user, display "Allow" and "Deny" icon buttons in addition to the standard action buttons.
*   **Counts:** A collection of user statistics.
    *   Each count (Entries, Comments, Favorited, Followings, Followers, Invited) is displayed only if its value is greater than 0.
    *   The layout of the counts adapts to the screen width, appearing in one or two rows.
    *   Tapping on a count navigates to the relevant screen (e.g., tapping "Followers" opens the list of followers).

### 2.2. Content Cards

The content cards will be displayed in a responsive grid layout below the header. Each card will be a reusable widget.

*   **Information Card:** Displays detailed information about the user.
    *   **Title:** The user's bio or title.
    *   **Gender:** Displayed if it is set by the user.
    *   **Day Count:** The number of days the user has been active.
    *   **Invited By:** Shows the user who invited them, if applicable.
    *   **Privacy Level:** The user's profile privacy setting.
    *   **Rank:** The user's rank.
    *   **Tag Count:** The total number of tags the user has used.
    *   **Blocked User Count:** The number of users the current user has blocked.

*   **Badge Card:** Showcases the user's most recently earned badges.
    *   It is only displayed if the user has earned at least one badge.
    *   Displays the last 12 badges in a grid of 2 to 4 rows.
    *   If the user has more than 12 badges, the last slot in the grid will be an icon button that opens a full list of their badges.

*   **Last Images Card:** A gallery of the user's most recent images.
    *   This card is only displayed if the user has uploaded at least one image.
    *   Displays the last 9 images in a 3x3 grid.
    *   Tapping an image opens it in a fullscreen viewer with navigation to view the next or previous image.
    *   If there are more than 9 images, a button is included to navigate to the user's full image list.

*   **Tag Card:** Displays the tags used by the user.
    *   This card is only displayed if the user has used at least one tag.
    *   Tapping on a tag opens the entry feed, filtered to show only entries with that tag.

*   **Last Entries Card:** A list of the user's most recent entries.
    *   This card is only displayed if the user has at least one entry.
    *   Displays the titles and dates of the last 10 entries, fetched from the calendar endpoint.
    *   Tapping on an entry title navigates to the detailed view of that entry.

*   **Calendar Card:** A calendar view of the user's activity.
    *   This card is only displayed if the user has at least one entry.
    *   Displays a month-by-month calendar.
    *   Buttons are provided to navigate one month and one year backward and forward.
    *   If a day has only one entry, the beginning of the entry's title is displayed on the calendar. Tapping it opens the entry detail screen.
    *   If a day has more than one entry, a count of entries is displayed. Tapping the day opens a popup list of the entry titles for that day.

### 2.3. Loading State

A shimmer effect will be used to indicate that the profile data is loading, with placeholders for each card.

## 3. Layout and Responsiveness

The layout will adapt to the screen width using breakpoints:

*   **Single Column (< 540dp):** All cards are displayed in a single column.
*   **Two-Column (540dp - 1200dp):**
    *   **Left Column:** Information, Badge, Last Images cards.
    *   **Right Column:** Tag, Last Entries, Calendar cards.
*   **Three-Column (> 1200dp):**
    *   **Left Column:** Information, Badge, Last Images cards.
    *   **Middle Column:** A feed of the user's entries.
    *   **Right Column:** Tag, Last Entries, Calendar cards.

## 4. Data Requirements

*   `/users/{name}`: For the main profile data.
*   `/users/{name}/badges`: For the badge card.
*   `/users/{name}/images`: For the last images card.
*   `/users/{name}/tags`: For the tag card.
*   `/users/{name}/calendar`: For the last entries and calendar cards.
*   `/users/{name}/tlog`: For the entry feed in the three-column layout.

## 5. State Management

A `StateNotifierProvider` from `Riverpod` will be used to manage the state of the profile screen. The state will be a sealed class:

*   **`ProfileLoading`:** The initial loading state.
*   **`ProfileLoaded`:** The state when all data is loaded.
    *   `Profile profile`: The main profile data.
    *   `List<Badge> badges`: The list of badges.
    *   `List<Image> images`: The list of images.
    *   `List<Tag> tags`: The list of tags.
    *   `Calendar calendar`: The calendar data.
*   **`ProfileError`:** The state when an error occurs.
    *   `String errorMessage`: The error message.

## 6. Accessibility

*   **Semantic Labels:** Provide meaningful semantic labels for all interactive elements, including the action buttons, counts, badges, and images.
*   **Focus Order:** Ensure that the focus order is logical and that all interactive elements are focusable.
*   **Content Grouping:** Group related content within each card for better screen reader navigation.
*   **Screen Reader Support:**
    *   Provide descriptive text for all user information and statistics
    *   Announce changes in online status and relationship status
    *   Describe image content and badge achievements
    *   Provide context for calendar entries and activity
*   **High Contrast Support:** Ensure all text and UI elements meet WCAG AA contrast requirements.
*   **Text Scaling:** Respect system text size preferences and ensure UI remains functional at all sizes.
*   **Keyboard Navigation:** Full keyboard accessibility for all profile interactions.
*   **Alternative Text:** Provide meaningful alternative text for all images, including avatars, covers, and badge icons.
*   **Focus Indicators:** Clear, visible focus indicators for all interactive elements.
*   **Motion Preferences:** Respect `prefers-reduced-motion` system setting for animations and transitions.

## 7. Future Considerations

*   **Customizable Profile Layout:** Allow users to reorder and hide cards on their own profile.
*   **Profile Analytics:** Provide more detailed analytics and insights into the user's activity.
