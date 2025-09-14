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

## Task 5: Basic Entry List Layout & State

### Goal
Create a widget that displays a list of entries, supporting different layouts and handling loading/data states.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/entry_list.dart` (Create)

### Implementation Details:
1.  **Create `entry_list.dart`:**
    *   A widget that takes a `FeedType` and watches the `entryFeedProvider`.
    *   Use `flutter_staggered_grid_view` for the "short" format (masonry layout).
    *   Use a `ListView.builder` for the "full" format.
    *   Show `SkeletonLoader` widgets while the provider is in a loading state.
    *   Display the list of entries when loaded, and handle empty/error states appropriately.

### Testing:
*   **Widget Tests:**
    *   Test `EntryList` by mocking the `entryFeedProvider`. Verify that it displays the correct layout and handles loading, loaded, empty, and error states.

---

## Task 6: Entry List Interactions (Scroll/Refresh)

### Goal
Implement infinite scrolling and pull-to-refresh functionality in the entry list widget.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/entry_list.dart` (Modify)

### Implementation Details:
1.  **Implement Infinite Scrolling:**
    *   Detect when the user scrolls near the end of the list.
    *   Call the `fetchMoreEntries` method on the provider to load the next page of data.
2.  **Implement Pull-to-Refresh:**
    *   Wrap the list view in a `RefreshIndicator`.
    *   Trigger the `refresh` method on the provider when the user pulls down to refresh.

### Testing:
*   **Widget Tests:**
    *   Verify that scrolling to the end and pulling to refresh trigger the correct methods on the mocked provider.

---

## Task 7: Entry Feed Screen with Dynamic Tabs

### Goal
Build the main screen for the entry feed, including tabbed navigation for different feed types.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_feed_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `entry_feed_screen.dart`:**
    *   The main screen will have a dynamic tab system. The tabs displayed in the `SliverAppBar`'s `TabBar` will change based on the context.
    *   **Live Feed Tabs:** Invited, Waiting, Discussed.
    *   **Best Feed Tabs:** Week, Month, Year.
    *   **Subscriptions Feed Tabs:** Entries, Replies.
    *   The `TabBarView` will contain `EntryList` widgets configured for each specific tab.
2.  **Modify `app_router.dart`:**
    *   Set the `EntryFeedScreen` as the home route (`/`).

### Testing:
*   **Widget Tests:**
    *   Test `EntryFeedScreen` to ensure tabs are created correctly for different feed types and that navigation between them works.

---

## Task 8: Entry Feed Actions (FAB & Settings)

### Goal
Add the Floating Action Button and the settings menu to the entry feed screen.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_feed_screen.dart` (Modify)

### Implementation Details:
1.  **Add Floating Action Button:**
    *   Include a `FloatingActionButton` to navigate to the entry editor screen.
2.  **Add Settings Menu:**
    *   Add a menu button to the `SliverAppBar` that opens the `FeedSettingsBottomSheet`.

### Testing:
*   **Widget Tests:**
    *   Verify that tapping the FAB navigates to the editor route.
    *   Verify that tapping the menu button opens the settings bottom sheet.

---

## Task 9: Feed Settings UI

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

## Task 10: Entry Detail State and Provider

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

## Task 11: Entry Detail Screen Layout

### Goal
Create the core layout and content display for the entry detail screen.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `entry_detail_screen.dart`:**
    *   Use a `CustomScrollView` and `SliverAppBar` for a collapsing header effect with the entry title.
    *   Display author info, timestamp, and tags.
    *   Use the `flutter_html` package to render the entry's HTML content.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for `/entries/:id` that builds the `EntryDetailScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `EntryDetailScreen` with a mocked provider to verify that the title, author info, and HTML content are rendered correctly.

---

## Task 12: Entry Detail Image Gallery and Interactions

### Goal
Add the image gallery display and user interaction buttons (vote, favorite) to the entry detail screen.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Modify)

### Implementation Details:
1.  **Display Image Gallery:**
    *   In `entry_detail_screen.dart`, display a gallery for any images attached to the entry.
2.  **Add Interaction Buttons:**
    *   Include buttons for voting and favoriting the entry.
    *   Implement optimistic UI updates when these buttons are pressed, reflecting the change immediately while the API call is in progress.

### Testing:
*   **Widget Tests:**
    *   Verify the image gallery is displayed.
    *   Test that tapping the vote/favorite buttons triggers the correct provider methods and updates the UI optimistically.

---

## Task 13: Entry Detail Comments Integration

### Goal
Integrate the comment list and the "add comment" form into the entry detail screen.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Modify)

### Implementation Details:
1.  **Integrate Comment Widgets:**
    *   Add the `CommentList` widget to the `entry_detail_screen.dart` to display the comment thread.
    *   Add the `AddCommentForm` widget to allow users to post new comments.

### Testing:
*   **Widget Tests:**
    *   Verify that the `CommentList` and `AddCommentForm` are present on the screen when testing with a mocked provider that returns comment data.

---

## Task 14: Comment Display Widgets

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

## Task 15: Add Comment Form

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

## Task 16: Entry Editor State and Provider

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

## Task 17: Draft Storage Service

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

## Task 18: Entry Editor Core UI

### Goal
Implement the basic layout and rich text editor for the entry editor screen.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `entry_editor_screen.dart`:**
    *   Set up the screen layout with a title `TextField`.
    *   Integrate the `flutter_quill` package for the rich text editor and its toolbar.
2.  **Modify `app_router.dart`:**
    *   Add `GoRoute`s for `/entries/new` and `/entries/:id/edit`.

### Testing:
*   **Widget Tests:**
    *   Test the `EntryEditorScreen`. Mock the provider and verify that the Quill editor is present.

---

## Task 19: Entry Editor Image and Tag Management

### Goal
Implement the UI for managing images and tags within the entry editor.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Modify)

### Implementation Details:
1.  **Implement Image Management:**
    *   Integrate `image_picker` to allow users to select images from their gallery or camera.
    *   Implement functionality to embed the selected images into the `flutter_quill` editor.
2.  **Implement Tag Management:**
    *   Create UI for adding, displaying (as chips), and removing tags for the entry.

### Testing:
*   **Widget Tests:**
    *   Verify that the image picker can be launched and that the tag management UI works as expected.

---

## Task 20: Entry Editor Publishing Logic

### Goal
Implement the publishing functionality, including state management and API calls.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Modify)

### Implementation Details:
1.  **Add Action Buttons:**
    *   Add "Preview" and "Publish" buttons to the UI.
2.  **Implement Publishing Flow:**
    *   Connect the "Publish" button to the `entry_editor_provider`.
    *   The provider method should handle uploading new images and then posting the entry data to the API.
    *   The screen should listen to the provider's state and show loading indicators during the publishing process.

### Testing:
*   **Widget Tests:**
    *   Verify that tapping the "Publish" button calls the correct provider method. Test the UI's response to loading and error states from the provider.

---

## Task 21: Long Press Context Menu

### Goal
Implement a context menu that appears on long-press, offering actions like Pin, Follow, Edit, Delete, and Complain, based on user permissions.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/entry_context_menu.dart` (Create)
*   `lib/src/features/comments/widgets/comment_context_menu.dart` (Create)
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Modify)
*   `lib/src/features/entries/providers/entry_detail_provider.dart` (Modify)

### Implementation Details:
1.  **Create Context Menu Widgets:**
    *   Create `entry_context_menu.dart` and `comment_context_menu.dart` that use `PopupMenuButton` or a similar widget.
    *   The menu options will be dynamically built based on the user's rights for the specific entry or comment.
2.  **Integrate Menus:**
    *   Integrate these menus into `entry_detail_screen.dart` to be triggered by a long press on the entry content or a comment item.
3.  **Handle Actions:**
    *   The `entry_detail_provider.dart` will need methods to handle the actions (e.g., `pinEntry`, `deleteComment`, `followEntry`).

### Testing:
*   **Widget Tests:** Test the context menus with different user permissions to ensure the correct options are displayed and that actions trigger the appropriate provider methods.

---

## Task 22: Adjacent Entry Navigation

### Goal
Allow users to navigate to the previous and next entries directly from the entry detail screen.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/adjacent_entry_navigation.dart` (Create)
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Modify)
*   `lib/src/features/entries/providers/entry_detail_provider.dart` (Modify)

### Implementation Details:
1.  **Provider Logic:**
    *   The `entry_detail_provider.dart` should fetch and expose information about adjacent entries (`previousEntry` and `nextEntry`) in its state. This data is expected to be part of the `/entries/{id}` API response.
2.  **Create Navigation Widget:**
    *   Create `adjacent_entry_navigation.dart`, a widget that displays clickable titles and arrows for the previous and next entries.
3.  **Integrate Widget:**
    *   Add this widget to the `entry_detail_screen.dart`. Tapping on an adjacent entry title should navigate to that entry's detail screen.

### Testing:
*   **Widget Tests:** Test the `adjacent_entry_navigation.dart` widget to ensure it displays the correct data and that tapping navigates correctly.
*   **Unit Tests:** Verify the provider correctly handles adjacent entry data.

---

## Task 23: Fullscreen Image Gallery

### Goal
Implement a fullscreen, swipeable image gallery for viewing entry images with zoom capabilities.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/image_gallery_screen.dart` (Create)
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Modify)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create Gallery Screen:**
    *   Create `image_gallery_screen.dart` that uses a `PageView.builder` for a swipeable gallery.
    *   Integrate a package like `photo_view` to support pinch-to-zoom functionality for each image.
2.  **Trigger Navigation:**
    *   The gallery should be opened when a user taps on an image in the `entry_detail_screen.dart`.
3.  **Update Router:**
    *   Modify `app_router.dart` to add a route for the `ImageGalleryScreen`, configured to open as a fullscreen dialog or a separate page.

### Testing:
*   **Widget Tests:** Test the `ImageGalleryScreen` to ensure images are displayed correctly and that navigation and zoom gestures work as expected.

---

## Task 24: Tag Navigation

### Goal
Allow users to tap on a tag to navigate to a feed of entries filtered by that tag.

### Files to be Created or Modified:
*   `lib/src/features/entries/screens/entry_detail_screen.dart` (Modify)
*   `lib/src/features/entries/screens/entry_feed_screen.dart` (Modify)
*   `lib/src/features/entries/providers/entry_feed_provider.dart` (Modify)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Make Tags Tappable:**
    *   The tags displayed on the `entry_detail_screen.dart` should be interactive widgets.
2.  **Handle Navigation:**
    *   Tapping a tag should navigate to the `EntryFeedScreen`.
    *   Modify `app_router.dart` to handle navigation to a tagged feed, e.g., `/tags/:tagName`.
3.  **Filter Feed:**
    *   The `EntryFeedScreen` needs to accept a `tag` parameter to filter the entries.
    *   The `entryFeedProvider` will need to be updated to handle fetching entries filtered by a tag.

### Testing:
*   **Widget Tests:** Test that tapping a tag navigates to the `EntryFeedScreen` with the correct filter parameter.
*   **Unit Tests:** Test that the `entryFeedProvider` correctly fetches tagged entries when the filter is applied.

---

## Task 25: Implement Entry Settings Bottom Sheet

### Goal
Implement the UI for changing entry settings like privacy, comments, votes, live feed, and sharing settings.

### Files to be Created or Modified:
*   `lib/src/features/entries/widgets/entry_settings_bottom_sheet.dart` (Create)
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Modify)

### Implementation Details:
1.  **Create `entry_settings_bottom_sheet.dart`:**
    *   Create a bottom sheet widget that displays controls for all entry settings mentioned in the `entry_editor.md` spec.
    *   This includes privacy level, comment/vote settings, "Post in Live", "Allow Sharing", and the anonymous toggle.
2.  **Integrate with Editor Screen:**
    *   Add a button to the `entry_editor_screen.dart` that opens this bottom sheet.
    *   Changes made in the bottom sheet should update the state in the `EntryEditorProvider`.

### Testing:
*   **Widget Tests:** Test the `EntrySettingsBottomSheet` to ensure controls are displayed correctly and that interactions update the provider state.

---

## Task 26: Complete Preview Functionality

### Goal
Implement the preview functionality, allowing users to see how their entry will look before publishing.

### Files to be Created or Modified:
*   `lib/src/features/entries/providers/entry_editor_provider.dart` (Modify)
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Modify)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Provider Logic:**
    *   In `entry_editor_provider.dart`, implement a `previewEntry` method.
    *   This method will call the same API endpoint used for publishing, but with an `isDraft=true` flag.
2.  **UI Integration:**
    *   Connect the "Preview" button in `entry_editor_screen.dart` to call the `previewEntry` method.
    *   On a successful response, navigate the user to the `EntryDetailScreen` to show the preview of the draft. This might require a special route or parameter to indicate it's a preview.

### Testing:
*   **Unit Tests:** Test the `previewEntry` logic in the `EntryEditorNotifier`.
*   **Widget Tests:** Verify that tapping the preview button triggers the provider method and navigates correctly on success.

---

## Task 27: Add Theme Entry Support

### Goal
Allow users to create entries within a specific theme, with an option to post anonymously.

### Files to be Created or Modified:
*   `lib/src/features/entries/providers/entry_editor_provider.dart` (Modify)
*   `lib/src/features/entries/screens/entry_editor_screen.dart` (Modify)

### Implementation Details:
1.  **Update Editor Screen:**
    *   Modify `entry_editor_screen.dart` to accept an optional `themeName` parameter.
    *   If `themeName` is provided, the "Post Anonymously" toggle should be visible in the Entry Settings.
2.  **Update Provider Logic:**
    *   In `entry_editor_provider.dart`, when publishing, check if a `themeName` is present.
    *   If it is, use the `/themes/{name}/tlog` API endpoint instead of the user's personal Tlog endpoint (`/me/tlog`).
    *   Pass the value of the "Post Anonymously" setting to the API.

### Testing:
*   **Unit Tests:** Test the provider's logic to ensure it calls the correct API endpoint based on whether a theme is provided.
*   **Widget Tests:** Verify the "Post Anonymously" toggle is shown only when creating an entry in a theme.
