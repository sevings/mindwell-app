# Epic: Comment System

This epic focuses on the functionality related to viewing and interacting with comments outside of the entry detail screen, such as a dedicated feed of comments.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

**Note:** The basic display of comments under an entry is covered in `03_entry_system.md`. This epic is for standalone comment feeds.

## Task 1: Comment Feed State Model

### Goal
To define the data model for the state of a paginated comment feed.

### Files to be Created or Modified:
*   `lib/src/features/comments/models/comment_feed_state.dart` (Create)

### Implementation Details:
1.  **Create `comment_feed_state.dart`:**
    *   Use `freezed` to create a sealed class `CommentFeedState` with the following states: `loading`, `loaded`, `error`.
    *   The `loaded` state should contain `List<Comment> comments`, `bool hasMore`, and `bool isFetchingMore`. The `Comment` model will come from the generated API client.

### Testing:
*   **Unit Tests:**
    *   Verify the properties and states of the `CommentFeedState` model.

---

## Task 2: Comment Feed Provider

### Goal
To set up the provider for fetching and managing a paginated list of comments.

### Files to be Created or Modified:
*   `lib/src/features/comments/providers/comment_feed_provider.dart` (Create)

### Implementation Details:
1.  **Create `comment_feed_provider.dart`:**
    *   Create a `StateNotifierProvider` that likely takes a user's name as a parameter to fetch their comments.
    *   The notifier will manage the `CommentFeedState`.
    *   It will depend on the `UsersApi` from the generated API client.
    *   Implement methods for initial fetch, fetching more comments (pagination), and refreshing the list.

### Testing:
*   **Unit Tests:**
    *   Write tests for the `CommentFeedNotifier`, mocking the `UsersApi`.
    *   Verify the notifier correctly handles initial load, pagination, and error states.

---

## Task 3: Comment Card Widget

### Goal
To build the reusable UI component for displaying a single comment within a feed.

### Files to be Created or Modified:
*   `lib/src/features/comments/widgets/comment_card.dart` (Create)

### Implementation Details:
1.  **Create `comment_card.dart`:**
    *   Create a widget to display a single comment's information.
    *   Include the author's avatar/name, the title of the entry the comment belongs to, a snippet of the comment content (rendered with `flutter_html`), and the timestamp.
    *   Include upvote/downvote buttons.
    *   Tapping the card should navigate the user to the `EntryDetailScreen` and scroll to that specific comment.
    *   Tapping the author's name/avatar should navigate to their `ProfileScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `CommentCard` widget with mock `Comment` data.
    *   Verify that tapping on the card or author triggers the correct navigation event in a mocked router.

---

## Task 4: Comment Feed List Widget

### Goal
To build the widget that displays a list of `CommentCard`s and handles user interactions like scrolling and refreshing.

### Files to be Created or Modified:
*   `lib/src/features/comments/widgets/comment_feed_list.dart` (Create)

### Implementation Details:
1.  **Create `comment_feed_list.dart`:**
    *   This widget will watch the `commentFeedProvider`.
    *   It will display a `ListView.builder` of `CommentCard` widgets.
    *   It should show a loading state (e.g., `SkeletonLoader`) and an error/empty state.
    *   Implement pull-to-refresh and infinite scrolling.

### Testing:
*   **Widget Tests:**
    *   Test the `CommentFeedList`, mocking the `commentFeedProvider` to check its different states (loading, loaded, error).

---

## Task 5: Comment Feed Screen

### Goal
To create the main screen that houses the comment feed and configure its route.

### Files to be Created or Modified:
*   `lib/src/features/comments/screens/comment_feed_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `comment_feed_screen.dart`:**
    *   A screen that displays the `CommentFeedList`. It will likely be navigated to from a user's profile.
    *   It should have a `PlatformAppBar` with an appropriate title (e.g., "Comments by @username").
2.  **Modify `app_router.dart`:**
    *   Add a new `GoRoute`, for example `/users/:name/comments`, that builds the `CommentFeedScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `CommentFeedScreen` renders the list and app bar correctly.
