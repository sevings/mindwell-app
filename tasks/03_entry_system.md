# Epic: Entry System

This epic covers the core functionality of creating, viewing, and managing entries. It includes the entry feed, the detailed entry view, and the entry editor.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: Entry Feed Models

### Goal
Define the data models for the entry feed state and settings.

### Files to be Created or Modified:
*   `lib/src/features/entries/models/entry_feed_state.dart` (Create)
*   `lib/src/features/entries/models/feed_settings.dart` (Create)

### Implementation Details:
1.  **Create `feed_settings.dart`:**
    *   Create a `FeedSettings` class using `freezed`. It should contain properties for `entriesPerPage`, `displayFormat` (`short`, `full`), `sortOrder` (`newest`, `oldest`, `best`), etc.
2.  **Create `entry_feed_state.dart`:**
    *   Use `freezed` to create a sealed class `EntryFeedState` with states: `loading`, `loaded`, `error`, `empty`.
    *   The `loaded` state should contain `List<Entry> entries`, `bool hasMore`, and `FeedSettings settings`.

### Testing:
*   **Unit Tests:** Verify the models and their properties.

---

## Task 2: Entry Caching Service

### Goal
Implement a caching service for entries to support offline viewing.

### Files to be Created or Modified:
*   `lib/src/core/services/entry_cache_service.dart` (Create)

### Implementation Details:
1.  **Create `entry_cache_service.dart`:**
    *   Create a service that uses `Hive` to store and retrieve lists of entries for different feed types. This will provide offline support.

### Testing:
*   **Unit Tests:**
    *   Test the `EntryCacheService` to ensure data is correctly stored and retrieved from Hive.

---

## Task 3: Entry Feed Provider

### Goal
Create the state notifier provider to manage the logic for fetching and paginating the entry feed.

### Files to be Created or Modified:
*   `lib/src/features/entries/providers/entry_feed_provider.dart` (Create)

### Implementation Details:
1.  **Create `entry_feed_provider.dart`:**
    *   Create a `StateNotifierProvider` that takes a `FeedType` (e.g., `live`, `best`, `profile`) and other relevant parameters (like `userId` for profile).
    *   The notifier will manage the `EntryFeedState`.
    *   Dependencies: The relevant API (e.g., `TlogApi`, `UsersApi`) and `EntryCacheService`.
    *   API calls from the provider must include the correct parameters based on the selected feed and tab:
        *   **Best Feed:** Pass a `category` parameter (`week`, `month`, `year`).
        *   **Live Feed:** Pass a `section` parameter (`entries`, `waiting`, `comments`).
        *   **Profile Feed:** Correctly pass the `userId`, especially for the "My Entries" view.
    *   Implement methods:
        *   `fetchInitialEntries()`: Fetches the first page from the API or cache.
        *   `fetchMoreEntries()`: Implements infinite scrolling.
        *   `refresh()`: Implements pull-to-refresh.
        *   `updateSettings(FeedSettings newSettings)`: Refetches data with new settings.

### Testing:
*   **Unit Tests:**
    *   Test the `EntryFeedNotifier` logic for fetching, pagination, and refreshing. Mock the API and cache service.

---

## Task 4: Entry Card Widgets

### Goal
Build the reusable UI components for displaying a single entry in different formats (short and full).

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/entry_card_short.dart` (Create)
*   `lib/src/features/entries/widgets/entry_card_full.dart` (Create)

### Implementation Details:
1.  **Create `entry_card_short.dart` and `entry_card_full.dart`:**
    *   These widgets will display a single entry in the two different formats.
    *   They will show the author's avatar, name, entry title, a snippet of the content, and stats (comments, votes).
    *   Use the `CachedImage` core widget.
    *   Tapping the card should navigate to the entry detail screen.

### Testing:
*   **Widget Tests:**
    *   Test `EntryCardShort` and `EntryCardFull` with mock `Entry` data.

---

## Task 5: Entry List Widget

### Goal
Create a widget that displays a list of entries, supporting different layouts, infinite scrolling, and pull-to-refresh.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/entry_list.dart` (Create)

### Implementation Details:
1.  **Create `entry_list.dart`:**
    *   A widget that takes a `FeedType` and displays the correct list format.
    *   It will watch the `entryFeedProvider` and display the list of entries.
    *   Use `flutter_staggered_grid_view` for the "short" format (masonry layout).
    *   Use a `ListView.builder` for the "full" format.
    *   Implement infinite scrolling by calling `fetchMoreEntries` when the user nears the end of the list.
    *   Implement pull-to-refresh.
    *   Show `SkeletonLoader` widgets while loading.

### Testing:
*   **Widget Tests:**
    *   Test `EntryList` by mocking the `entryFeedProvider`. Verify that it displays the correct list, handles loading/error states, and triggers fetch/refresh calls.

---

## Task 6: Entry Feed Screen

### Goal
Build the main screen for the entry feed, including tabbed navigation for different feed types.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_feed_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `entry_feed_screen.dart`:**
    *   The main screen will have a dynamic tab system. The tabs displayed in the `SliverAppBar`'s `TabBar` will change based on the context (e.g., which main feed is selected from navigation).
    *   **Live Feed Tabs:** Invited, Waiting, Discussed.
    *   **Best Feed Tabs:** Week, Month, Year.
    *   **Subscriptions Feed Tabs:** Entries, Replies.
    *   The `TabBarView` will contain `EntryList` widgets configured for each specific tab.
    *   Include a `FloatingActionButton` to navigate to the entry editor.
    *   Add a menu button to open the `FeedSettingsBottomSheet`.
2.  **Modify `app_router.dart`:**
    *   Set the `EntryFeedScreen` as the home route (`/`).

### Testing:
*   **Widget Tests:**
    *   Test `EntryFeedScreen` to ensure tabs and navigation work.

---

## Task 7: Feed Settings UI

### Goal
Create the bottom sheet UI for changing feed display settings.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/feed_settings_bottom_sheet.dart` (Create)

### Implementation Details:
1.  **Create `feed_settings_bottom_sheet.dart`:**
    *   A bottom sheet to allow users to change the `FeedSettings`.
    *   The UI should dynamically display options based on the current `FeedType`:
        *   **Universal (All Feeds):** Display Format (Short/Full).
        *   **Live Feed:** Source Options (Diaries/Themes).
        *   **Best Feed:** Source Options (Diaries/Themes), Entry Count (10, 20, 30, 50, 100).
        *   **Profile Feed:** Sort Order (Newest, Oldest, Best).
        *   **Friends Feed:** No specific options other than the universal ones.
    *   When settings are changed, call `updateSettings` on the provider.

### Testing:
*   **Widget Tests:**
    *   Test the bottom sheet functionality with a mocked provider.

---

## Task 8: Entry Detail State and Provider

### Goal
Set up the state management for viewing a single entry's details.

### Files to be Created or Modified:
*   `lib/src/features/entries/providers/entry_detail_provider.dart` (Create)
*   `lib/src/features/entries/models/entry_detail_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `entry_detail_state.dart` using `freezed` (`loading`, `loaded`, `error`).
    *   Create `entry_detail_provider.dart`, a `StateNotifierProvider` that takes an `entryId`. It will fetch the entry and its comments from the `EntriesApi` and `CommentsApi`.

### Testing:
*   **Unit Tests:** Test the `EntryDetailNotifier` logic.

---

## Task 9: Entry Detail Screen UI

### Goal
Create the screen that displays the full content of a single entry.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `entry_detail_screen.dart`:**
    *   Use a `CustomScrollView` and `SliverAppBar` for a collapsing header effect with the entry title.
    *   Display author info, timestamp, and tags.
    *   Use the `flutter_html` package to render the entry's HTML content.
    *   Display a gallery for attached images.
    *   Include the `CommentList` and `AddCommentForm`.
    *   Add buttons for voting and favoriting, with optimistic UI updates.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/entries/:id` that builds the `EntryDetailScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `EntryDetailScreen` with a mocked provider to verify all content (HTML, comments, etc.) is rendered correctly.

---

## Task 10: Comment Display Widgets

### Goal
Build the widgets for displaying a list of comments and individual comment items.

### Files to be Created or Modified:
*   `lib/src/features/comments/widgets/comment_list.dart` (Create)
*   `lib/src/features/comments/widgets/comment_item.dart` (Create)

### Implementation Details:
1.  **Create Comment Widgets:**
    *   `CommentItem`: Displays a single comment.
    *   `CommentList`: Displays a list of `CommentItem`s and handles comment pagination.

### Testing:
*   **Widget Tests:**
    *   Test `CommentList` and `CommentItem` widgets independently.

---

## Task 11: Add Comment Form

### Goal
Create the form for users to add new comments to an entry.

### Files to be Created or Modified:
*   `lib/src/features/comments/widgets/add_comment_form.dart` (Create)

### Implementation Details:
1.  **Create `add_comment_form.dart`:**
    *   A text field and button to post a new comment.

### Testing:
*   **Widget Tests:**
    *   Test the `AddCommentForm` widget independently.

---

## Task 12: Entry Editor State and Provider

### Goal
Set up the state management for the entry editor.

### Files to be Created or Modified:
*   `lib/src/features/entries/providers/entry_editor_provider.dart` (Create)
*   `lib/src/features/entries/models/entry_editor_state.dart` (Create)

### Implementation Details:
1.  **Create Models and Provider:**
    *   Create `entry_editor_state.dart` using `freezed` (`loading`, `editing`, `publishing`, `error`).
    *   Create `entry_editor_provider.dart`, a `StateNotifierProvider` that takes an optional `entryId` (for editing).

### Testing:
*   **Unit Tests:**
    *   Test the `EntryEditorNotifier` logic for creating, updating, and publishing.

---

## Task 13: Draft Storage Service

### Goal
Implement a service to automatically save and load entry drafts.

### Files to be Created or Modified:
*   `lib/src/core/services/draft_storage_service.dart` (Create)

### Implementation Details:
1.  **Create `draft_storage_service.dart`:**
    *   A service using `Hive` to save and load a single entry draft. The provider will use this for autosaving new entries.

### Testing:
*   **Unit Tests:**
    *   Test the `DraftStorageService`.

---

## Task 14: Entry Editor Screen

### Goal
Implement the rich text editor UI for creating and editing entries.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `entry_editor_screen.dart`:**
    *   Set up the screen layout with a title `TextField` and the editor.
    *   Integrate the `flutter_quill` package for the rich text editor and its toolbar.
    *   Implement image picking (using `image_picker`) and embedding into the editor.
    *   Create UI for managing tags.
    *   Add "Preview" and "Publish" buttons. "Publish" should trigger the provider to upload images (if any) and then post the entry data.
    *   Show loading indicators during publishing.
2.  **Modify `app_router.dart`:**
    *   Add `GoRoute`s for `/entries/new` and `/entries/:id/edit`.

### Testing:
*   **Widget Tests:**
    *   Test the `EntryEditorScreen`. Mock the provider and verify that the Quill editor is present and that publishing actions call the correct provider methods.
