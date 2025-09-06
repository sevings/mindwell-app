# Advanced Features Implementation

## Epic Overview
This epic covers the advanced features of the Mindwell application, including real-time chat, notifications, themes, and other sophisticated functionality.

## Common Guidelines for This Epic
- Implement WebSocket integration for real-time features
- Use proper state management with Riverpod for complex interactions
- Follow the established design system and component library
- Implement comprehensive offline support with conflict resolution
- Add full accessibility support with semantic labels and screen reader support
- Use the generated API client from the `/api` folder
- Implement proper error handling and loading states for all features

---

## Task 3.1: WebSocket Integration

### Description
Implement WebSocket integration using the centrifuge library for real-time communication.

### Acceptance Criteria
- [ ] WebSocket connection management with centrifuge
- [ ] Connection token retrieval from API
- [ ] Channel subscription (notifications and messages)
- [ ] Connection state management (connecting, connected, disconnected, error)
- [ ] Exponential backoff for reconnection
- [ ] Message queuing when offline
- [ ] Connection status indicator in UI
- [ ] Graceful degradation when WebSocket unavailable

### Implementation Details
1. **Create WebSocket entities** in `lib/src/core/websocket/entities/`:
   ```dart
   @freezed
   class WebSocketMessage with _$WebSocketMessage {
     const factory WebSocketMessage({
       required int id,
       required int subj,
       required String type,
       required String state,
     }) = _WebSocketMessage;
   }
   
   @freezed
   class ConnectionState with _$ConnectionState {
     const factory ConnectionState({
       required bool isConnected,
       required bool isConnecting,
       required String? error,
       required DateTime? lastConnected,
     }) = _ConnectionState;
   }
   ```

2. **Implement WebSocket service** in `lib/src/core/websocket/services/`:
   - Centrifuge client initialization
   - Connection token management
   - Channel subscription management
   - Message handling and routing
   - Reconnection logic with exponential backoff

3. **Create WebSocket repository** in `lib/src/core/websocket/repositories/`:
   - Connection state management
   - Message queuing for offline scenarios
   - Channel management
   - Error handling and recovery

4. **Implement WebSocket state management**:
   ```dart
   sealed class WebSocketState {
     WebSocketInitial();
     WebSocketConnecting();
     WebSocketConnected();
     WebSocketDisconnected();
     WebSocketError(String error);
   }
   ```

5. **Create WebSocket widgets** in `lib/src/core/websocket/widgets/`:
   - ConnectionStatusIndicator widget
   - WebSocketProvider widget
   - MessageQueueIndicator widget

### Files to Create
- `lib/src/core/websocket/entities/websocket_message.dart`
- `lib/src/core/websocket/services/websocket_service.dart`
- `lib/src/core/websocket/repositories/websocket_repository_impl.dart`
- `lib/src/core/websocket/widgets/connection_status_indicator.dart`

---

## Task 3.2: Chat System

### Description
Implement the complete chat system with real-time messaging, chat list, and message management.

### Acceptance Criteria
- [ ] Chat list screen with recent conversations
- [ ] Chat messages screen with real-time updates
- [ ] Message sending with optimistic UI
- [ ] Message status indicators (sending, sent, failed)
- [ ] Message actions (edit, delete, complain)
- [ ] Unread message counts
- [ ] Message pagination and infinite scroll
- [ ] Offline message queuing
- [ ] Message delivery status

### Implementation Details
1. **Create chat entities** in `lib/src/features/chat/domain/entities/`:
   ```dart
   @freezed
   class Chat with _$Chat {
     const factory Chat({
       required String id,
       required User partner,
       required Message? lastMessage,
       required int unreadCount,
       required DateTime lastActivity,
     }) = _Chat;
   }
   
   @freezed
   class Message with _$Message {
     const factory Message({
       required String id,
       required String content,
       required User sender,
       required DateTime createdAt,
       required MessageStatus status,
       required String chatId,
     }) = _Message;
   }
   
   enum MessageStatus { sending, sent, delivered, read, failed }
   ```

2. **Implement chat repository** in `lib/src/features/chat/data/repositories/`:
   - Load chat list
   - Load chat messages
   - Send message
   - Update message status
   - Mark messages as read
   - Handle offline message queuing

3. **Create chat use cases** in `lib/src/features/chat/domain/usecases/`:
   - Load chat list use case
   - Load chat messages use case
   - Send message use case
   - Mark as read use case
   - Update message status use case

4. **Implement chat state management**:
   ```dart
   sealed class ChatListState {
     ChatListLoading();
     ChatListLoaded({
       required List<Chat> chats,
       required bool isFetchingMore,
       required bool hasMore,
     });
     ChatListError(String errorMessage);
   }
   
   sealed class ChatMessagesState {
     ChatMessagesLoading();
     ChatMessagesLoaded({
       required List<Message> messages,
       required Map<String, MessageStatus> messageStatus,
       required bool isFetchingMore,
       required bool hasMore,
     });
     ChatMessagesError(String errorMessage);
   }
   ```

5. **Create chat screens** in `lib/src/features/chat/presentation/screens/`:
   - Chat list screen with CustomScrollView and SliverAppBar
   - Chat messages screen with ListView.builder
   - Message input with send button
   - Message status indicators

6. **Implement chat widgets** in `lib/src/features/chat/presentation/widgets/`:
   - ChatListItem widget
   - MessageBubble widget
   - MessageInput widget
   - MessageStatusIndicator widget
   - UnreadCountBadge widget

### Files to Create
- `lib/src/features/chat/domain/entities/chat.dart`
- `lib/src/features/chat/domain/entities/message.dart`
- `lib/src/features/chat/presentation/screens/chat_list_screen.dart`
- `lib/src/features/chat/presentation/screens/chat_messages_screen.dart`
- `lib/src/features/chat/presentation/widgets/chat_list_item.dart`
- `lib/src/features/chat/presentation/widgets/message_bubble.dart`

---

## Task 3.3: Notifications System

### Description
Implement the notifications system with real-time updates, notification management, and user interactions.

### Acceptance Criteria
- [ ] Notifications list screen with real-time updates
- [ ] Notification types (comments, followers, invites, badges)
- [ ] Read/unread status management
- [ ] Mark all as read functionality
- [ ] Notification navigation to relevant screens
- [ ] Pull-to-refresh and pagination
- [ ] Notification filtering and grouping
- [ ] Offline notification queuing

### Implementation Details
1. **Create notification entities** in `lib/src/features/notifications/domain/entities/`:
   ```dart
   @freezed
   class Notification with _$Notification {
     const factory Notification({
       required String id,
       required String type,
       required String content,
       required User? sender,
       required DateTime createdAt,
       required bool isRead,
       required String? subjectId,
       required String? subjectType,
     }) = _Notification;
   }
   
   enum NotificationType {
     comment,
     follower,
     invite,
     badge,
     message,
     movedEntry,
   }
   ```

2. **Implement notification repository** in `lib/src/features/notifications/data/repositories/`:
   - Load notifications
   - Mark notification as read
   - Mark all notifications as read
   - Handle real-time notification updates
   - Offline notification queuing

3. **Create notification use cases** in `lib/src/features/notifications/domain/usecases/`:
   - Load notifications use case
   - Mark as read use case
   - Mark all as read use case
   - Handle notification update use case

4. **Implement notification state management**:
   ```dart
   sealed class NotificationListState {
     NotificationListLoading();
     NotificationListLoaded({
       required List<Notification> notifications,
       required int unreadCount,
       required bool isFetchingMore,
       required bool hasMore,
     });
     NotificationListError(String errorMessage);
   }
   ```

5. **Create notification screens** in `lib/src/features/notifications/presentation/screens/`:
   - Notifications list screen with ListView.builder
   - Notification detail screen
   - Notification settings screen

6. **Implement notification widgets** in `lib/src/features/notifications/presentation/widgets/`:
   - NotificationItem widget
   - NotificationTypeIcon widget
   - UnreadIndicator widget
   - NotificationActions widget

### Files to Create
- `lib/src/features/notifications/domain/entities/notification.dart`
- `lib/src/features/notifications/presentation/screens/notifications_screen.dart`
- `lib/src/features/notifications/presentation/widgets/notification_item.dart`
- `lib/src/features/notifications/presentation/widgets/notification_type_icon.dart`

---

## Task 3.4: Themes System

### Description
Implement the themes system for community-driven content areas with theme management and participation.

### Acceptance Criteria
- [ ] Theme list screen with search and filtering
- [ ] Theme detail screen with entries and followers
- [ ] Theme creation and editing
- [ ] Theme following and participation
- [ ] Theme-specific entry creation
- [ ] Theme moderation tools
- [ ] Theme discovery and recommendations
- [ ] Theme analytics for administrators

### Implementation Details
1. **Create theme entities** in `lib/src/features/themes/domain/entities/`:
   ```dart
   @freezed
   class Theme with _$Theme {
     const factory Theme({
       required String id,
       required String name,
       required String displayName,
       required String description,
       required String? avatar,
       required String? cover,
       required int followersCount,
       required int entriesCount,
       required DateTime createdAt,
       required bool isFollowing,
       required bool isAdmin,
       required ThemePrivacy privacy,
     }) = _Theme;
   }
   
   enum ThemePrivacy { public, private, inviteOnly }
   ```

2. **Implement theme repository** in `lib/src/features/themes/data/repositories/`:
   - Load theme list
   - Load theme details
   - Create theme
   - Update theme
   - Follow/unfollow theme
   - Load theme entries
   - Load theme followers

3. **Create theme use cases** in `lib/src/features/themes/domain/usecases/`:
   - Load theme list use case
   - Load theme detail use case
   - Create theme use case
   - Follow theme use case
   - Load theme entries use case

4. **Implement theme state management**:
   ```dart
   sealed class ThemeListState {
     ThemeListLoading();
     ThemeListLoaded({
       required List<Theme> themes,
       required bool isFetchingMore,
       required bool hasMore,
       required String? searchQuery,
       required ThemeFilter filter,
     });
     ThemeListError(String errorMessage);
   }
   
   sealed class ThemeDetailState {
     ThemeDetailLoading();
     ThemeDetailLoaded({
       required Theme theme,
       required List<Entry> entries,
       required List<User> followers,
       required bool isFollowing,
       required bool isAdmin,
     });
     ThemeDetailError(String errorMessage);
   }
   ```

5. **Create theme screens** in `lib/src/features/themes/presentation/screens/`:
   - Theme list screen with search and filtering
   - Theme detail screen with tabs
   - Theme creation/editing screen
   - Theme settings screen

6. **Implement theme widgets** in `lib/src/features/themes/presentation/widgets/`:
   - ThemeCard widget
   - ThemeHeader widget
   - ThemeStats widget
   - ThemeCreationForm widget
   - ThemeFilterWidget widget

### Files to Create
- `lib/src/features/themes/domain/entities/theme.dart`
- `lib/src/features/themes/presentation/screens/theme_list_screen.dart`
- `lib/src/features/themes/presentation/screens/theme_detail_screen.dart`
- `lib/src/features/themes/presentation/widgets/theme_card.dart`
- `lib/src/features/themes/presentation/widgets/theme_header.dart`

---

## Task 3.5: User Lists and Relationships

### Description
Implement user lists for followers, following, and other user relationship management.

### Acceptance Criteria
- [ ] User list screen with responsive grid layout
- [ ] User cards with avatar, name, and statistics
- [ ] Follow/unfollow functionality
- [ ] User search and filtering
- [ ] Pagination and infinite scroll
- [ ] User relationship management
- [ ] Block/unblock functionality
- [ ] User invitation system

### Implementation Details
1. **Create user list entities** in `lib/src/features/users/domain/entities/`:
   ```dart
   @freezed
   class UserList with _$UserList {
     const factory UserList({
       required List<User> users,
       required bool hasMore,
       required int totalCount,
     }) = _UserList;
   }
   
   @freezed
   class UserRelationship with _$UserRelationship {
     const factory UserRelationship({
       required String userId,
       required bool isFollowing,
       required bool isBlocked,
       required bool isHidden,
       required bool canInvite,
     }) = _UserRelationship;
   }
   ```

2. **Implement user list repository** in `lib/src/features/users/data/repositories/`:
   - Load user lists (followers, following, blocked, hidden)
   - Search users
   - Manage user relationships
   - Handle user invitations

3. **Create user list use cases** in `lib/src/features/users/domain/usecases/`:
   - Load user list use case
   - Search users use case
   - Follow user use case
   - Block user use case
   - Invite user use case

4. **Implement user list state management**:
   ```dart
   sealed class UserListState {
     UserListLoading();
     UserListLoaded({
       required List<User> users,
       required bool isFetchingMore,
       required bool hasMore,
       required String? searchQuery,
     });
     UserListError(String errorMessage);
   }
   ```

5. **Create user list screens** in `lib/src/features/users/presentation/screens/`:
   - User list screen with responsive grid
   - User search screen
   - User relationship management screen

6. **Implement user list widgets** in `lib/src/features/users/presentation/widgets/`:
   - UserCard widget
   - UserGrid widget
   - UserSearchBar widget
   - UserRelationshipActions widget

### Files to Create
- `lib/src/features/users/domain/entities/user_list.dart`
- `lib/src/features/users/presentation/screens/user_list_screen.dart`
- `lib/src/features/users/presentation/widgets/user_card.dart`
- `lib/src/features/users/presentation/widgets/user_grid.dart`

---

## Task 3.6: Wishes System

### Description
Implement the wishes system for users to send encouraging messages to each other.

### Acceptance Criteria
- [ ] Wishes list screen with received and sent wishes
- [ ] Send wish screen with recipient selection
- [ ] Wish detail screen with full content
- [ ] Thank system for received wishes
- [ ] Wish filtering and search
- [ ] Anonymous wish options
- [ ] Wish privacy controls
- [ ] Wish reporting and moderation

### Implementation Details
1. **Create wish entities** in `lib/src/features/wishes/domain/entities/`:
   ```dart
   @freezed
   class Wish with _$Wish {
     const factory Wish({
       required String id,
       required String content,
       required User sender,
       required User recipient,
       required DateTime createdAt,
       required bool isAnonymous,
       required bool isPublic,
       required bool isThanked,
       required bool isRead,
     }) = _Wish;
   }
   ```

2. **Implement wish repository** in `lib/src/features/wishes/data/repositories/`:
   - Load wishes (received, sent, all)
   - Send wish
   - Thank wish
   - Mark wish as read
   - Report wish

3. **Create wish use cases** in `lib/src/features/wishes/domain/usecases/`:
   - Load wishes use case
   - Send wish use case
   - Thank wish use case
   - Mark as read use case

4. **Implement wish state management**:
   ```dart
   sealed class WishesListState {
     WishesListLoading();
     WishesListLoaded({
       required List<Wish> wishes,
       required int unreadCount,
       required bool isFetchingMore,
       required bool hasMore,
       required WishFilter filter,
     });
     WishesListError(String errorMessage);
   }
   ```

5. **Create wish screens** in `lib/src/features/wishes/presentation/screens/`:
   - Wishes list screen with filtering
   - Send wish screen
   - Wish detail screen

6. **Implement wish widgets** in `lib/src/features/wishes/presentation/widgets/`:
   - WishCard widget
   - WishComposer widget
   - WishFilterWidget widget
   - ThankButton widget

### Files to Create
- `lib/src/features/wishes/domain/entities/wish.dart`
- `lib/src/features/wishes/presentation/screens/wishes_screen.dart`
- `lib/src/features/wishes/presentation/screens/send_wish_screen.dart`
- `lib/src/features/wishes/presentation/widgets/wish_card.dart`
- `lib/src/features/wishes/presentation/widgets/wish_composer.dart`

---

## Task 3.7: Image Management System

### Description
Implement comprehensive image management with upload, display, and gallery functionality.

### Acceptance Criteria
- [ ] Image upload with progress indicators
- [ ] Image gallery with fullscreen viewer
- [ ] Image compression and optimization
- [ ] Image caching and offline support
- [ ] Image metadata display
- [ ] Image sharing functionality
- [ ] Image deletion and management
- [ ] Image privacy controls

### Implementation Details
1. **Create image entities** in `lib/src/features/images/domain/entities/`:
   ```dart
   @freezed
   class Image with _$Image {
     const factory Image({
       required String id,
       required String url,
       required String thumbnailUrl,
       required int width,
       required int height,
       required int fileSize,
       required DateTime uploadedAt,
       required User uploader,
       required String? description,
     }) = _Image;
   }
   
   @freezed
   class ImageUpload with _$ImageUpload {
     const factory ImageUpload({
       required String id,
       required String filePath,
       required ImageUploadStatus status,
       required double progress,
       String? error,
     }) = _ImageUpload;
   }
   
   enum ImageUploadStatus { pending, uploading, completed, failed }
   ```

2. **Implement image repository** in `lib/src/features/images/data/repositories/`:
   - Upload image
   - Load user images
   - Delete image
   - Get image metadata
   - Handle image compression

3. **Create image use cases** in `lib/src/features/images/domain/usecases/`:
   - Upload image use case
   - Load user images use case
   - Delete image use case
   - Compress image use case

4. **Implement image state management**:
   ```dart
   sealed class ImageListState {
     ImageListLoading();
     ImageListLoaded({
       required List<Image> images,
       required bool isFetchingMore,
       required bool hasMore,
     });
     ImageListError(String errorMessage);
   }
   ```

5. **Create image screens** in `lib/src/features/images/presentation/screens/`:
   - Image gallery screen with masonry grid
   - Fullscreen image viewer
   - Image upload screen

6. **Implement image widgets** in `lib/src/features/images/presentation/widgets/`:
   - ImageCard widget
   - ImageGrid widget
   - FullscreenImageViewer widget
   - ImageUploadProgress widget

### Files to Create
- `lib/src/features/images/domain/entities/image.dart`
- `lib/src/features/images/presentation/screens/image_gallery_screen.dart`
- `lib/src/features/images/presentation/widgets/image_card.dart`
- `lib/src/features/images/presentation/widgets/fullscreen_image_viewer.dart`

---

## Task 3.8: Advanced Profile Features

### Description
Implement advanced profile features including badges, calendar, and comprehensive user statistics.

### Acceptance Criteria
- [ ] Badge system with earned badges display
- [ ] User calendar with activity visualization
- [ ] Comprehensive user statistics
- [ ] Profile customization options
- [ ] User activity timeline
- [ ] Profile analytics and insights
- [ ] User achievement system
- [ ] Profile sharing functionality

### Implementation Details
1. **Create advanced profile entities** in `lib/src/features/profiles/domain/entities/`:
   ```dart
   @freezed
   class Badge with _$Badge {
     const factory Badge({
       required String id,
       required String name,
       required String description,
       required String iconUrl,
       required DateTime earnedAt,
       required BadgeCategory category,
     }) = _Badge;
   }
   
   @freezed
   class UserCalendar with _$UserCalendar {
     const factory UserCalendar({
       required Map<DateTime, List<Entry>> entries,
       required Map<DateTime, int> entryCounts,
       required DateTime startDate,
       required DateTime endDate,
     }) = _UserCalendar;
   }
   
   @freezed
   class UserStats with _$UserStats {
     const factory UserStats({
       required int totalEntries,
       required int totalComments,
       required int totalFavorites,
       required int totalFollowers,
       required int totalFollowing,
       required int totalBadges,
       required int activeDays,
       required DateTime joinDate,
     }) = _UserStats;
   }
   ```

2. **Implement advanced profile repository** in `lib/src/features/profiles/data/repositories/`:
   - Load user badges
   - Load user calendar
   - Load user statistics
   - Update profile settings
   - Handle profile customization

3. **Create advanced profile use cases** in `lib/src/features/profiles/domain/usecases/`:
   - Load user badges use case
   - Load user calendar use case
   - Load user statistics use case
   - Update profile use case

4. **Implement advanced profile state management**:
   ```dart
   sealed class ProfileDetailState {
     ProfileDetailLoading();
     ProfileDetailLoaded({
       required Profile profile,
       required List<Badge> badges,
       required UserCalendar calendar,
       required UserStats stats,
       required List<Entry> recentEntries,
     });
     ProfileDetailError(String errorMessage);
   }
   ```

5. **Create advanced profile screens** in `lib/src/features/profiles/presentation/screens/`:
   - Badge list screen
   - User calendar screen
   - Profile statistics screen
   - Profile customization screen

6. **Implement advanced profile widgets** in `lib/src/features/profiles/presentation/widgets/`:
   - BadgeCard widget
   - CalendarWidget widget
   - StatsWidget widget
   - ProfileCustomizationForm widget

### Files to Create
- `lib/src/features/profiles/domain/entities/badge.dart`
- `lib/src/features/profiles/domain/entities/user_calendar.dart`
- `lib/src/features/profiles/presentation/screens/badge_list_screen.dart`
- `lib/src/features/profiles/presentation/widgets/badge_card.dart`
- `lib/src/features/profiles/presentation/widgets/calendar_widget.dart`

---

## Epic Completion Criteria
- [ ] WebSocket integration is fully functional with real-time updates
- [ ] Chat system works with real-time messaging and offline support
- [ ] Notifications system provides real-time updates and management
- [ ] Themes system allows community creation and participation
- [ ] User lists and relationships are properly managed
- [ ] Wishes system enables user encouragement and support
- [ ] Image management provides comprehensive upload and display functionality
- [ ] Advanced profile features include badges, calendar, and statistics
- [ ] All features have proper offline support with conflict resolution
- [ ] All features are accessible and follow design guidelines
- [ ] All features work with real-time updates via WebSocket
- [ ] All features are tested with unit and widget tests

## Notes
- Implement WebSocket integration first as it's required for real-time features
- Test real-time functionality thoroughly with network interruptions
- Ensure proper offline support with message queuing and conflict resolution
- Implement comprehensive error handling for network-related issues
- Use the generated API client for all server communication
- Add proper accessibility support to all advanced features
- Test all features with different network conditions and offline scenarios
