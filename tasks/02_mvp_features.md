# MVP Features Implementation

## Epic Overview
This epic covers the core MVP features of the Mindwell application, including authentication, basic entry feeds, user profiles, and essential user interactions.

## Common Guidelines for This Epic
- Implement proper state management with Riverpod
- Use the established design system and component library
- Follow the layered architecture pattern
- Implement comprehensive error handling and loading states
- Add full accessibility support with semantic labels
- Use the generated API client from the `/api` folder
- Implement proper offline support with caching

---

## Task 2.1: Authentication System

### Description
Implement the complete authentication system with login, registration, and session management.

### Acceptance Criteria
- [ ] Login screen with email/password fields
- [ ] Registration screen with validation
- [ ] Password recovery functionality
- [ ] OAuth 2.0 token management
- [ ] Secure token storage
- [ ] Automatic token refresh
- [ ] Biometric authentication support
- [ ] Session persistence across app restarts

### Implementation Details
1. **Create authentication entities** in `lib/src/features/auth/domain/entities/`:
   ```dart
   @freezed
   class User with _$User {
     const factory User({
       required String id,
       required String username,
       required String email,
       String? avatar,
       String? cover,
       // ... other user fields
     }) = _User;
   }
   
   @freezed
   class AuthTokens with _$AuthTokens {
     const factory AuthTokens({
       required String accessToken,
       required String refreshToken,
       required DateTime expiresAt,
     }) = _AuthTokens;
   }
   ```

2. **Implement authentication repository** in `lib/src/features/auth/data/repositories/`:
   - Login with email/password
   - Registration with validation
   - Password recovery
   - Token refresh
   - Logout functionality

3. **Create authentication use cases** in `lib/src/features/auth/domain/usecases/`:
   - Login use case
   - Register use case
   - Refresh token use case
   - Logout use case
   - Check authentication status use case

4. **Implement authentication state management**:
   ```dart
   sealed class AuthState {
     Unauthenticated();
     Authenticating();
     Authenticated(User user);
     AuthError(String message);
   }
   ```

5. **Create authentication screens** in `lib/src/features/auth/presentation/screens/`:
   - Unified login/registration screen with TabBar
   - Password recovery screen
   - Biometric setup screen

### Files to Create
- `lib/src/features/auth/domain/entities/user.dart`
- `lib/src/features/auth/domain/entities/auth_tokens.dart`
- `lib/src/features/auth/data/repositories/auth_repository_impl.dart`
- `lib/src/features/auth/domain/usecases/login_usecase.dart`
- `lib/src/features/auth/domain/usecases/register_usecase.dart`
- `lib/src/features/auth/presentation/screens/auth_screen.dart`
- `lib/src/features/auth/presentation/widgets/login_form.dart`
- `lib/src/features/auth/presentation/widgets/registration_form.dart`

---

## Task 2.2: Common UI Components

### Description
Implement the core UI component library with buttons, inputs, cards, and other reusable components.

### Acceptance Criteria
- [ ] Button components (primary, secondary, text, icon)
- [ ] Input components (text field, password, search)
- [ ] Card components with consistent styling
- [ ] Loading components (shimmer, progress indicators)
- [ ] Navigation components (app bar, bottom nav, drawer)
- [ ] Feedback components (snackbar, dialog, bottom sheet)
- [ ] All components follow the design system
- [ ] Full accessibility support

### Implementation Details
1. **Create button components** in `lib/src/core/design/components/buttons/`:
   - Primary button with loading state
   - Secondary button with outlined style
   - Text button for less important actions
   - Icon button with tooltip
   - Floating action button

2. **Implement input components** in `lib/src/core/design/components/inputs/`:
   - Text field with label and validation
   - Password field with visibility toggle
   - Search field with clear button
   - Text area for multi-line input

3. **Create display components** in `lib/src/core/design/components/display/`:
   - Card with consistent elevation and padding
   - Avatar with fallback initials
   - Badge for status indicators
   - Chip for tags and filters
   - Divider for content separation

4. **Implement navigation components** in `lib/src/core/design/components/navigation/`:
   - App bar with title and actions
   - Bottom navigation bar
   - Navigation drawer
   - Tab bar for content sections

5. **Create feedback components** in `lib/src/core/design/components/feedback/`:
   - Snackbar for brief messages
   - Dialog for important interactions
   - Bottom sheet for secondary actions
   - Tooltip for contextual help

### Files to Create
- `lib/src/core/design/components/buttons/primary_button.dart`
- `lib/src/core/design/components/inputs/text_field.dart`
- `lib/src/core/design/components/display/card.dart`
- `lib/src/core/design/components/navigation/app_bar.dart`
- `lib/src/core/design/components/feedback/snackbar.dart`

---

## Task 2.3: Entry Feed System

### Description
Implement the core entry feed system with Live and Best feeds, including entry cards and feed management.

### Acceptance Criteria
- [ ] Live feed with real-time entries
- [ ] Best feed with highly-rated entries
- [ ] Entry cards in short and full formats
- [ ] Pull-to-refresh functionality
- [ ] Infinite scrolling pagination
- [ ] Feed settings (entries per page, display format, sort order)
- [ ] Shimmer loading states
- [ ] Empty state handling

### Implementation Details
1. **Create entry entities** in `lib/src/features/entries/domain/entities/`:
   ```dart
   @freezed
   class Entry with _$Entry {
     const factory Entry({
       required String id,
       required String title,
       required String content,
       required User author,
       required DateTime createdAt,
       required int rating,
       required int commentsCount,
       required bool isFavorited,
       List<String>? tags,
       List<Image>? images,
     }) = _Entry;
   }
   ```

2. **Implement feed repository** in `lib/src/features/entries/data/repositories/`:
   - Live feed API integration
   - Best feed API integration
   - Feed settings management
   - Caching and offline support

3. **Create feed use cases** in `lib/src/features/entries/domain/usecases/`:
   - Load live feed use case
   - Load best feed use case
   - Load more entries use case
   - Refresh feed use case

4. **Implement feed state management**:
   ```dart
   sealed class EntryFeedState {
     EntryFeedLoading();
     EntryFeedLoaded({
       required List<Entry> entries,
       required bool isFetchingMore,
       required bool hasMore,
       required FeedSettings settings,
     });
     EntryFeedError(String errorMessage);
     EntryFeedEmpty();
   }
   ```

5. **Create entry feed screens** in `lib/src/features/entries/presentation/screens/`:
   - Main feed screen with TabBar
   - Feed settings bottom sheet
   - Entry detail navigation

6. **Implement entry card widgets** in `lib/src/features/entries/presentation/widgets/`:
   - EntryCardShort for masonry layout
   - EntryCardFull for detailed view
   - Entry card interactions (vote, favorite, comment)

### Files to Create
- `lib/src/features/entries/domain/entities/entry.dart`
- `lib/src/features/entries/data/repositories/entry_repository_impl.dart`
- `lib/src/features/entries/domain/usecases/load_feed_usecase.dart`
- `lib/src/features/entries/presentation/screens/entry_feed_screen.dart`
- `lib/src/features/entries/presentation/widgets/entry_card_short.dart`
- `lib/src/features/entries/presentation/widgets/entry_card_full.dart`

---

## Task 2.4: Entry Detail Screen

### Description
Implement the entry detail screen with full entry content, comments, and user interactions.

### Acceptance Criteria
- [ ] Full entry display with HTML content rendering
- [ ] Author information and timestamp
- [ ] Image gallery with fullscreen viewer
- [ ] Tag navigation
- [ ] Vote and favorite functionality
- [ ] Comments list with pagination
- [ ] Add comment functionality
- [ ] Adjacent entries navigation
- [ ] Long press context menu

### Implementation Details
1. **Create comment entities** in `lib/src/features/comments/domain/entities/`:
   ```dart
   @freezed
   class Comment with _$Comment {
     const factory Comment({
       required String id,
       required String content,
       required User author,
       required DateTime createdAt,
       required int rating,
       required String entryId,
     }) = _Comment;
   }
   ```

2. **Implement entry detail repository** in `lib/src/features/entries/data/repositories/`:
   - Load entry details
   - Load entry comments
   - Vote on entry
   - Favorite entry
   - Add comment

3. **Create entry detail use cases** in `lib/src/features/entries/domain/usecases/`:
   - Load entry detail use case
   - Load entry comments use case
   - Vote on entry use case
   - Add comment use case

4. **Implement entry detail state management**:
   ```dart
   sealed class EntryDetailState {
     EntryDetailLoading();
     EntryDetailLoaded({
       required Entry entry,
       required List<Comment> comments,
       required bool isFetchingMoreComments,
       required bool hasMoreComments,
     });
     EntryDetailError(String errorMessage);
   }
   ```

5. **Create entry detail screen** in `lib/src/features/entries/presentation/screens/`:
   - CustomScrollView with SliverAppBar
   - Entry content with HTML rendering
   - Image gallery with photo_view
   - Comments list with infinite scroll
   - Comment input field

6. **Implement entry detail widgets** in `lib/src/features/entries/presentation/widgets/`:
   - EntryContent widget
   - CommentList widget
   - CommentItem widget
   - ImageGallery widget

### Files to Create
- `lib/src/features/comments/domain/entities/comment.dart`
- `lib/src/features/entries/presentation/screens/entry_detail_screen.dart`
- `lib/src/features/entries/presentation/widgets/entry_content.dart`
- `lib/src/features/entries/presentation/widgets/comment_list.dart`
- `lib/src/features/entries/presentation/widgets/image_gallery.dart`

---

## Task 2.5: Entry Editor

### Description
Implement the entry editor with rich text editing, image management, and publishing functionality.

### Acceptance Criteria
- [ ] Rich text editor with formatting toolbar
- [ ] Title input field
- [ ] Image insertion and management
- [ ] Tag management with chips
- [ ] Entry settings (privacy, comments, votes)
- [ ] Local draft autosaving
- [ ] Image upload with progress
- [ ] Preview functionality
- [ ] Publish to server

### Implementation Details
1. **Create entry editor entities** in `lib/src/features/entries/domain/entities/`:
   ```dart
   @freezed
   class EntryDraft with _$EntryDraft {
     const factory EntryDraft({
       required String id,
       required String title,
       required String content,
       required List<String> tags,
       required EntrySettings settings,
       required List<ImageUpload> images,
       required DateTime lastSaved,
     }) = _EntryDraft;
   }
   ```

2. **Implement entry editor repository** in `lib/src/features/entries/data/repositories/`:
   - Save local draft
   - Load local draft
   - Upload images
   - Publish entry
   - Update existing entry

3. **Create entry editor use cases** in `lib/src/features/entries/domain/usecases/`:
   - Save draft use case
   - Load draft use case
   - Upload image use case
   - Publish entry use case

4. **Implement entry editor state management**:
   ```dart
   sealed class EntryEditorState {
     EntryEditorLoading();
     EntryEditorEditing({
       required String title,
       required String content,
       required List<String> tags,
       required EntrySettings settings,
       required List<ImageUpload> images,
     });
     EntryEditorSaving();
     EntryEditorPublishing();
     EntryEditorError(String errorMessage);
   }
   ```

5. **Create entry editor screen** in `lib/src/features/entries/presentation/screens/`:
   - Rich text editor with flutter_quill
   - Image management interface
   - Tag management with chips
   - Settings bottom sheet
   - Action buttons (preview, publish)

6. **Implement entry editor widgets** in `lib/src/features/entries/presentation/widgets/`:
   - RichTextEditor widget
   - ImageManager widget
   - TagManager widget
   - EntrySettingsSheet widget

### Files to Create
- `lib/src/features/entries/domain/entities/entry_draft.dart`
- `lib/src/features/entries/presentation/screens/entry_editor_screen.dart`
- `lib/src/features/entries/presentation/widgets/rich_text_editor.dart`
- `lib/src/features/entries/presentation/widgets/image_manager.dart`
- `lib/src/features/entries/presentation/widgets/tag_manager.dart`

---

## Task 2.6: User Profile System

### Description
Implement the user profile system with profile display, user interactions, and profile management.

### Acceptance Criteria
- [ ] Profile display with cover image and avatar
- [ ] User information and statistics
- [ ] Follow/unfollow functionality
- [ ] User's entries, comments, and images
- [ ] Badge display
- [ ] Calendar view of user activity
- [ ] Responsive layout for different screen sizes
- [ ] Profile editing for own profile

### Implementation Details
1. **Create profile entities** in `lib/src/features/profiles/domain/entities/`:
   ```dart
   @freezed
   class Profile with _$Profile {
     const factory Profile({
       required String id,
       required String username,
       required String displayName,
       String? bio,
       String? avatar,
       String? cover,
       required int entriesCount,
       required int commentsCount,
       required int followersCount,
       required int followingCount,
       required bool isFollowing,
       required bool isOnline,
       required DateTime lastSeenAt,
     }) = _Profile;
   }
   ```

2. **Implement profile repository** in `lib/src/features/profiles/data/repositories/`:
   - Load user profile
   - Follow/unfollow user
   - Load user's entries
   - Load user's images
   - Load user's badges
   - Load user's calendar

3. **Create profile use cases** in `lib/src/features/profiles/domain/usecases/`:
   - Load profile use case
   - Follow user use case
   - Load user entries use case
   - Load user images use case

4. **Implement profile state management**:
   ```dart
   sealed class ProfileState {
     ProfileLoading();
     ProfileLoaded({
       required Profile profile,
       required List<Entry> entries,
       required List<Image> images,
       required List<Badge> badges,
       required Calendar calendar,
     });
     ProfileError(String errorMessage);
   }
   ```

5. **Create profile screen** in `lib/src/features/profiles/presentation/screens/`:
   - CustomScrollView with SliverAppBar
   - Profile header with cover and avatar
   - User statistics and counts
   - Content cards (entries, images, badges, calendar)
   - Responsive grid layout

6. **Implement profile widgets** in `lib/src/features/profiles/presentation/widgets/`:
   - ProfileHeader widget
   - UserStats widget
   - ProfileCard widget
   - BadgeGrid widget
   - ImageGrid widget
   - CalendarWidget widget

### Files to Create
- `lib/src/features/profiles/domain/entities/profile.dart`
- `lib/src/features/profiles/presentation/screens/profile_screen.dart`
- `lib/src/features/profiles/presentation/widgets/profile_header.dart`
- `lib/src/features/profiles/presentation/widgets/user_stats.dart`
- `lib/src/features/profiles/presentation/widgets/badge_grid.dart`

---

## Task 2.7: Navigation and Routing

### Description
Implement the main navigation system with bottom navigation, drawer, and proper routing.

### Acceptance Criteria
- [ ] Bottom navigation bar for logged-in users
- [ ] Navigation drawer with user profile
- [ ] Proper route definitions for all screens
- [ ] Authentication-based navigation
- [ ] Deep linking support
- [ ] Navigation state persistence
- [ ] Proper back button handling

### Implementation Details
1. **Create navigation entities** in `lib/src/core/navigation/entities/`:
   ```dart
   enum AppRoute {
     auth,
     home,
     profile,
     settings,
     entryDetail,
     entryEditor,
     // ... other routes
   }
   ```

2. **Implement navigation service** in `lib/src/core/navigation/services/`:
   - Route generation
   - Navigation state management
   - Deep link handling
   - Authentication guards

3. **Create navigation widgets** in `lib/src/core/navigation/widgets/`:
   - MainNavigation widget
   - BottomNavigationBar widget
   - NavigationDrawer widget
   - RouteGuard widget

4. **Implement navigation state management**:
   ```dart
   sealed class NavigationState {
     NavigationInitial();
     NavigationChanged(AppRoute currentRoute);
     NavigationError(String errorMessage);
   }
   ```

5. **Create main navigation screen** in `lib/src/core/navigation/screens/`:
   - Main app shell with navigation
   - Route-based content display
   - Navigation state management

### Files to Create
- `lib/src/core/navigation/entities/app_route.dart`
- `lib/src/core/navigation/services/navigation_service.dart`
- `lib/src/core/navigation/widgets/main_navigation.dart`
- `lib/src/core/navigation/widgets/bottom_navigation_bar.dart`
- `lib/src/core/navigation/screens/main_screen.dart`

---

## Task 2.8: Settings Screen

### Description
Implement the settings screen with account settings, notification preferences, and app configuration.

### Acceptance Criteria
- [ ] Account settings (password, email, invites)
- [ ] Notification settings (email, on-site)
- [ ] Privacy settings (blocked profiles, hidden profiles)
- [ ] App settings (theme, language)
- [ ] About section (version, contact)
- [ ] Platform-specific UI (Material/Cupertino)
- [ ] Settings persistence

### Implementation Details
1. **Create settings entities** in `lib/src/features/settings/domain/entities/`:
   ```dart
   @freezed
   class AppSettings with _$AppSettings {
     const factory AppSettings({
       required ThemeMode themeMode,
       required String language,
       required bool notificationsEnabled,
       required EmailSettings emailSettings,
       required OnsiteSettings onsiteSettings,
     }) = _AppSettings;
   }
   ```

2. **Implement settings repository** in `lib/src/features/settings/data/repositories/`:
   - Load settings
   - Save settings
   - Update account settings
   - Update notification settings

3. **Create settings use cases** in `lib/src/features/settings/domain/usecases/`:
   - Load settings use case
   - Update settings use case
   - Change password use case
   - Update email use case

4. **Implement settings state management**:
   ```dart
   sealed class SettingsState {
     SettingsLoading();
     SettingsLoaded({
       required AppSettings settings,
       required EmailSettings emailSettings,
       required OnsiteSettings onsiteSettings,
     });
     SettingsError(String errorMessage);
   }
   ```

5. **Create settings screen** in `lib/src/features/settings/presentation/screens/`:
   - Settings list with sections
   - Platform-specific UI components
   - Settings forms and inputs
   - Confirmation dialogs

6. **Implement settings widgets** in `lib/src/features/settings/presentation/widgets/`:
   - SettingsSection widget
   - SettingsItem widget
   - ToggleSetting widget
   - SettingsForm widget

### Files to Create
- `lib/src/features/settings/domain/entities/app_settings.dart`
- `lib/src/features/settings/presentation/screens/settings_screen.dart`
- `lib/src/features/settings/presentation/widgets/settings_section.dart`
- `lib/src/features/settings/presentation/widgets/settings_item.dart`

---

## Epic Completion Criteria
- [ ] Authentication system is fully functional with all features
- [ ] Common UI components are implemented and tested
- [ ] Entry feed system works with Live and Best feeds
- [ ] Entry detail screen displays content and comments properly
- [ ] Entry editor allows creating and editing entries
- [ ] User profile system displays user information and interactions
- [ ] Navigation system works with proper routing and guards
- [ ] Settings screen allows configuring all app preferences
- [ ] All features have proper error handling and loading states
- [ ] All features are accessible and follow design guidelines
- [ ] All features work offline with proper caching
- [ ] All features are tested with unit and widget tests

## Notes
- Implement features in the order listed for proper dependency management
- Test each feature thoroughly before moving to the next
- Ensure all features follow the established architecture patterns
- Use the generated API client for all server communication
- Implement proper offline support with caching and queuing
- Add comprehensive accessibility support to all components
