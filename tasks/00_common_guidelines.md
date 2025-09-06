# Common Guidelines and Architecture Overview

## Project Overview

MindWell is a cross-platform mobile application built with Flutter for iOS and Android. It's a social diary platform where users can create entries, interact with others, and participate in themed communities.

## Architecture Principles

### Technology Stack
- **Framework:** Flutter with Material Design
- **State Management:** Riverpod
- **Routing:** go_router
- **API Communication:** Generated API Client + Dio
- **Local Storage:** Hive (key-value) + flutter_secure_storage (sensitive data)
- **Image Handling:** cached_network_image + image_picker
- **Dependency Injection:** injectable
- **JSON Serialization:** json_serializable + freezed
- **Date Formatting:** intl
- **Logging:** logging
- **Testing:** flutter_test + integration_test + mocktail

### Architectural Pattern
**Layered Architecture (Clean Architecture):**
- **Presentation Layer:** Flutter Widgets + Riverpod
- **Domain Layer:** Entities + Usecases
- **Data Layer:** Repositories + API Client + Local Storage

### Project Structure
```
lib/
├── config/
├── src/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── presentation/
│   │   │   │   ├── screens/
│   │   │   │   └── widgets/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   └── usecases/
│   │   │   └── data/
│   │   │       ├── repositories/
│   │   │       └── models/
│   │   └── ...
│   ├── core/
│   │   ├── api/
│   │   ├── di/
│   │   ├── error/
│   │   ├── routing/
│   │   └── design/
│   └── app.dart
└── main.dart
```

## Common Implementation Guidelines

### State Management
- Use `StateNotifierProvider` for complex state management
- Use `FutureProvider` for one-time data fetching
- Use `StreamProvider` for real-time data
- Use `Provider` for simple dependencies
- All states should be sealed classes with clear state definitions

### Error Handling
- Use sealed class hierarchy for errors:
  - `NetworkError`: Connection issues, timeouts
  - `ApiError`: Server errors, HTTP status codes
  - `ValidationError`: Client-side validation failures
  - `AuthenticationError`: Token expired, unauthorized
  - `PermissionError`: Insufficient permissions
- Implement centralized error handling with Dio interceptors
- Provide user-friendly error messages with actionable recovery options

### UI/UX Guidelines

#### Design System
- **Primary Color:** `#ff5e3a` (MindWell Orange)
- **Secondary Colors:** Purple `#7c5ac2`, Blue `#38a9ff`, Teal `#08ddc1`
- **Typography:** Inter (web), SF Pro Display (iOS), Roboto (Android)
- **Spacing:** 8dp base unit (xs: 4dp, sm: 8dp, md: 16dp, lg: 24dp, xl: 32dp)
- **Animations:** Fast (150ms), Normal (300ms), Slow (500ms)

#### Component Standards
- Use Material Design components with consistent theming
- Implement responsive design with breakpoints:
  - Mobile: < 600dp (single column)
  - Tablet: 600dp - 1024dp (two columns)
  - Desktop: > 1024dp (three columns)
- Use shimmer effects for loading states instead of CircularProgressIndicator
- Implement proper accessibility with semantic labels and focus management

### API Integration
- Use generated API client from `/api` folder
- Implement Dio interceptors for:
  - Authentication token injection
  - Automatic token refresh
  - Error handling and logging
  - Request/response logging
- Store configuration in `lib/config/config.dart`

### Security
- All communication over HTTPS
- Store sensitive data (tokens) in flutter_secure_storage
- Implement OAuth 2.0 with password flow and refresh tokens
- Sanitize user-generated content to prevent XSS
- Implement proper session management

### Offline Support
- Cache data locally using Hive
- Queue user actions when offline
- Sync queued actions when connection restored
- Show cached data immediately when available
- Implement cache invalidation strategies

### WebSocket Integration
- Use `centrifuge` library for WebSocket communication
- Subscribe to channels: `"notifications#" + username` and `"messages#" + username`
- Handle connection states: connecting, connected, disconnected, error
- Implement exponential backoff for reconnection
- Queue messages when offline

### Testing Strategy
- **Unit Tests:** 80%+ coverage for domain and data layers
- **Widget Tests:** All screens and complex widgets
- **Integration Tests:** Critical user flows (login, registration, entry creation)
- Use mocktail for mocking dependencies

### Accessibility (a11y)
- Follow WCAG 2.1 AA guidelines
- Provide semantic labels for all interactive elements
- Ensure proper focus order and keyboard navigation
- Support screen readers with descriptive text
- Respect system preferences (text size, reduced motion)
- Maintain 4.5:1 contrast ratio for normal text

### Performance
- Use `ListView.builder` for large lists
- Implement image caching with cached_network_image
- Use `const` constructors where possible
- Implement lazy loading and pagination
- Optimize widget rebuilds with proper state management

### Code Quality
- Follow Flutter lints and Dart analyzer recommendations
- Use consistent naming conventions
- Write self-documenting code with clear variable names
- Implement proper error handling and logging
- Use dependency injection for testability

## Task Implementation Guidelines

### For Each Task:
1. **Read the specification** thoroughly before starting
2. **Follow the architecture** patterns established above
3. **Implement proper error handling** with user-friendly messages
4. **Add accessibility support** with semantic labels and focus management
5. **Write tests** for the implemented functionality
6. **Use the design system** colors, typography, and spacing
7. **Implement loading states** with shimmer effects
8. **Add proper navigation** using go_router
9. **Handle offline scenarios** with caching and queuing
10. **Document any deviations** from the guidelines

### State Management Pattern
```dart
// Example state class
sealed class FeatureState {
  FeatureLoading();
  FeatureLoaded({
    required List<Item> items,
    required bool isFetchingMore,
    required bool hasMore,
  });
  FeatureError(String errorMessage);
  FeatureEmpty();
}

// Example notifier
class FeatureNotifier extends StateNotifier<FeatureState> {
  FeatureNotifier(this._repository) : super(FeatureLoading());
  
  final FeatureRepository _repository;
  
  Future<void> loadItems() async {
    try {
      final items = await _repository.getItems();
      state = FeatureLoaded(items: items, isFetchingMore: false, hasMore: true);
    } catch (e) {
      state = FeatureError(e.toString());
    }
  }
}
```

### Widget Structure Pattern
```dart
class FeatureScreen extends ConsumerWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featureNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Feature')),
      body: switch (state) {
        FeatureLoading() => const ShimmerLoader(),
        FeatureLoaded() => _buildLoadedContent(state),
        FeatureError() => _buildErrorContent(state),
        FeatureEmpty() => _buildEmptyContent(),
      },
    );
  }
}
```

## Development Phases

### Phase 1: Basic App (Foundation)
- Project setup and configuration
- Core infrastructure (DI, routing, error handling)
- Design system implementation
- Basic authentication flow

### Phase 2: MVP Features
- User authentication and registration
- Basic entry feed (Live, Best)
- User profiles and basic interactions
- Entry creation and editing
- Basic navigation and common UI components

### Phase 3: Advanced Features
- Real-time features (WebSocket integration)
- Chat system
- Notifications
- Themes and communities
- Advanced profile features
- Settings and preferences

### Phase 4: Polish and Optimization
- Performance optimization
- Advanced accessibility features
- Comprehensive testing
- Offline support enhancement
- Advanced UI/UX features

## Notes for AI Implementation

When implementing tasks:
1. **Always check existing code** before creating new files
2. **Follow the established patterns** in the codebase
3. **Use the generated API client** from the `/api` folder
4. **Implement proper error handling** with user-friendly messages
5. **Add accessibility support** from the beginning
6. **Write tests** for new functionality
7. **Use the design system** consistently
8. **Handle edge cases** and error scenarios
9. **Document complex logic** with clear comments
10. **Ensure responsive design** works on all screen sizes

Remember: Each task should be small, focused, and well-tested. If a task seems too large, break it down into smaller, more manageable pieces.
