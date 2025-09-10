# Common Project Guidelines

This document contains common guidelines and instructions that apply to all tasks in the Mindwell project. These guidelines should be followed consistently across all epics and tasks.

## Project Overview

Mindwell is a cross-platform mobile application for iOS and Android built with Flutter. It's a social diary platform where users can create entries, interact with content, and connect with others.

## Technology Stack

- **Framework:** Flutter (Material Design)
- **Language:** Dart
- **State Management:** Riverpod (Provider, StateNotifierProvider, FutureProvider)
- **Routing:** go_router
- **API:** Generated API clients from `/api` folder
- **HTTP Client:** Dio with interceptors
- **Local Storage:** Hive for caching and settings
- **Secure Storage:** flutter_secure_storage for tokens
- **Image Handling:** cached_network_image, image_picker
- **JSON Serialization:** json_serializable, freezed
- **Internationalization:** flutter_localizations
- **Testing:** flutter_test, mocktail

## Architecture Principles

### Two-Layer Architecture
- **UI Layer:** Flutter widgets and Riverpod providers
- **Data Layer:** API clients and local storage

### Data Flow
1. User interacts with widget
2. Widget calls Riverpod provider method
3. Provider calls API service or checks local cache
4. Provider updates state with new data
5. UI rebuilds automatically with new state

## Code Standards

### File Structure
```
lib/
├── config/
├── src/
│   ├── features/
│   │   ├── {feature_name}/
│   │   │   ├── widgets/
│   │   │   └── providers/
│   ├── core/
│   │   ├── api/
│   │   ├── models/
│   │   ├── utils/
│   │   └── widgets/
│   └── app.dart
└── main.dart
```

### Naming Conventions
- **Files:** snake_case (e.g., `entry_detail_screen.dart`)
- **Classes:** PascalCase (e.g., `EntryDetailScreen`)
- **Variables/Functions:** camelCase (e.g., `entryList`)
- **Constants:** UPPER_SNAKE_CASE (e.g., `API_BASE_URL`)

### State Management Patterns
- Use `Provider` for simple values
- Use `StateNotifierProvider` for complex state
- Use `FutureProvider` for async data
- Always use sealed classes for state objects

### API Integration
- **ALWAYS** use generated API clients from `/api` folder
- **NEVER** create custom API clients
- Use providers to wrap API calls
- Handle errors gracefully with user-friendly messages

## Testing Requirements

### Every Task Must Include Tests
- **Unit Tests:** Test providers and utility functions
- **Widget Tests:** Test UI components and screens
- **Integration Tests:** Test critical user flows (when applicable)

### Code Quality Requirements
- **Flutter Analyze:** After completing every task, run `flutter analyze` and fix all issues
- **Lint Compliance:** All code must pass Flutter lints without warnings or errors
- **Code Formatting:** Use `dart format` to ensure consistent code formatting
- **Static Analysis:** Address all static analysis warnings and suggestions

### Test Structure
```dart
// Example test structure
group('FeatureName', () {
  group('ProviderName', () {
    test('should handle success case', () {
      // Test implementation
    });
    
    test('should handle error case', () {
      // Test implementation
    });
  });
  
  group('WidgetName', () {
    testWidgets('should render correctly', (tester) async {
      // Widget test implementation
    });
  });
});
```

## UI/UX Guidelines

### Design System
- Use centralized design system in `lib/src/core/`
- Follow Material Design guidelines
- Support both light and dark themes
- Ensure WCAG 2.1 AA accessibility compliance

### Color Palette
- **Primary:** #ff5e3a (Mindwell Orange)
- **Secondary:** #7c5ac2 (Purple), #38a9ff (Blue), #08ddc1 (Teal)
- **Neutral:** #3f4257 (Dark Gray), #f8f9fa (Background)
- **Semantic:** #10b981 (Success), #f59e0b (Warning), #ef4444 (Error)

### Typography
- Use system fonts with fallbacks
- Follow Material Design type scale
- Support text scaling preferences

### Spacing
- Base unit: 8dp
- Scale: xs(4), sm(8), md(16), lg(24), xl(32), xxl(48), xxxl(64)

## Accessibility Requirements

### WCAG 2.1 AA Compliance
- Minimum 4.5:1 contrast ratio for normal text
- Minimum 3:1 contrast ratio for large text
- All interactive elements must be focusable
- Provide semantic labels for all UI elements
- Support screen readers (TalkBack, VoiceOver)

### Implementation
- Use `Semantics` widget for custom components
- Provide `tooltip` for icon buttons
- Use `ExcludeSemantics` for decorative elements
- Test with screen readers

## Internationalization

### Supported Languages
- **Primary:** Russian (default)
- **Secondary:** English

### Implementation
- All user-visible strings must be in localization files
- Use `flutter_localizations` and `intl` packages
- Date and number formatting must respect locale conventions
- Text direction must support Cyrillic script

### File Structure
```
lib/l10n/
├── app_ru.arb
├── app_en.arb
└── app_localizations.dart
```

## Error Handling

### Error Types
- `NetworkError`: Connection issues
- `ApiError`: Server errors
- `ValidationError`: Input validation failures

### Implementation
- Show user-friendly error messages
- Provide retry options where appropriate
- Log errors for debugging
- Handle offline scenarios gracefully

## Security Requirements

### Authentication
- Use OAuth 2.0 with password and refresh token flows
- Store tokens securely with `flutter_secure_storage`
- Implement automatic token refresh with Dio interceptors
- Support biometric authentication when available

### Data Protection
- All communication over HTTPS
- Sanitize user-generated content to prevent XSS
- Implement proper session management
- Follow privacy-by-design principles

## Performance Guidelines

### Optimization
- Use `ListView.builder` for large lists
- Implement proper image caching
- Use `const` constructors where possible
- Minimize widget rebuilds
- Implement proper pagination

### Loading States
- Use shimmer effects instead of `CircularProgressIndicator`
- Show skeleton loaders for content
- Implement optimistic UI updates
- Cache data locally for offline access

## WebSocket Integration

### Library
- Use `centrifuge` library for WebSocket communication
- Obtain connection token from `/account/subscribe/token`
- Subscribe to channels: `"notifications#" + username`, `"messages#" + username`

### Message Handling
- Handle states: `new`, `updated`, `removed`, `read`
- Implement exponential backoff for reconnection
- Queue messages when offline
- Show connection status indicators

## File Creation Guidelines

### For Each Task
1. **Create necessary files** as specified in the task
2. **Modify existing files** only when explicitly required
3. **Follow the file structure** outlined above
4. **Include proper imports** and dependencies
5. **Write comprehensive tests** for all functionality
6. **Run `flutter analyze`** and fix all issues before considering the task complete
7. **Run `flutter test`** and ensure all tests pass
8. **Format code** with `dart format .`

### File Templates
- Use consistent file headers with proper documentation
- Include proper imports at the top
- Follow Dart formatting guidelines
- Use meaningful variable and function names

## Common Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  riverpod: ^2.4.9
  go_router: ^12.1.3
  dio: ^5.3.2
  hive: ^2.2.3
  flutter_secure_storage: ^9.0.0
  cached_network_image: ^3.3.0
  image_picker: ^1.0.4
  json_serializable: ^6.7.1
  freezed: ^2.4.6
  centrifuge: ^1.0.0
  flutter_html: ^3.0.0-beta.2
  flutter_quill: ^9.2.0
  photo_view: ^0.14.0
  flutter_staggered_grid_view: ^0.7.0
  shimmer: ^3.0.0
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.1
  build_runner: ^2.4.7
  json_annotation: ^4.8.1
  freezed_annotation: ^2.4.1
```

## Task Completion Criteria

### Every Task Must Meet These Requirements
- [ ] All specified files created/modified as required
- [ ] All tests written and passing
- [ ] `flutter analyze` passes with no issues
- [ ] `flutter test` passes with no failures
- [ ] Code properly formatted with `dart format .`
- [ ] All lint warnings and errors resolved
- [ ] App builds successfully
- [ ] Documentation updated if needed

## Task Implementation Order

1. **Basic App Structure** (Epic 01)
2. **Design System** (Epic 02)
3. **Authentication** (Epic 03)
4. **Core Features** (Epic 04-08)
5. **Advanced Features** (Epic 09-12)
6. **Testing & Polish** (Epic 13-14)

## Post-Task Validation Process

### Required Steps After Every Task
1. **Run Flutter Analyze:** Execute `flutter analyze` and fix all issues
2. **Run Tests:** Execute `flutter test` and ensure all tests pass
3. **Code Formatting:** Run `dart format .` to format all code
4. **Lint Check:** Verify no lint warnings or errors remain
5. **Build Check:** Run `flutter build` to ensure the app builds successfully
6. **Documentation:** Update any necessary documentation

### Flutter Analyze Command
```bash
# Run static analysis
flutter analyze

# Fix auto-fixable issues
dart fix --apply

# Format code
dart format .

# Run tests
flutter test
```

## Quality Assurance

### Code Review Checklist
- [ ] Follows naming conventions
- [ ] Includes proper error handling
- [ ] Has comprehensive tests
- [ ] Meets accessibility requirements
- [ ] Uses generated API clients
- [ ] Follows state management patterns
- [ ] Includes proper documentation
- [ ] Handles offline scenarios
- [ ] Passes `flutter analyze` without issues
- [ ] All tests pass
- [ ] Code is properly formatted

### Performance Checklist
- [ ] Uses efficient widgets
- [ ] Implements proper caching
- [ ] Handles large datasets
- [ ] Optimizes image loading
- [ ] Minimizes API calls

## Support and Resources

### Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Material Design Guidelines](https://material.io/design)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

### Tools
- Flutter Inspector for debugging
- Dart DevTools for performance analysis
- Accessibility Scanner for a11y testing
- Screen readers for accessibility testing

---

**Remember:** These guidelines ensure consistency, quality, and maintainability across the entire Mindwell project. Always refer to this document when implementing any task.
