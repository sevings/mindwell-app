# Architecture

This document outlines the architecture of the Mindwell application, a cross-platform mobile application for iOS and Android built with Flutter.

## 1. Guiding Principles

*   **Simplicity:** Keep the architecture simple and easy to understand.
*   **Maintainability:** The codebase should be easy to modify and debug.
*   **Consistency:** Follow consistent patterns throughout the application.
*   **Pragmatic:** Use the right tool for the job without over-engineering.

## 2. Technology Stack

*   **Programming Language:** Dart
*   **UI Framework:** Flutter (Material Design)
*   **State Management:** [Riverpod](https://riverpod.dev/) - Simple providers and StateNotifier
*   **Routing:** [go_router](https://pub.dev/packages/go_router) for declarative routing
*   **API Communication:**
    *   Generated API Client (from `/api`)
    *   [Dio](https://pub.dev/packages/dio) for HTTP requests and interceptors
*   **Local Data Storage:** [Hive](https://pub.dev/packages/hive) for caching and settings
*   **Secure Storage:** [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) for tokens
*   **Image Handling:**
    *   [cached_network_image](https://pub.dev/packages/cached_network_image) for network images
    *   [image_picker](https://pub.dev/packages/image_picker) for image selection
*   **JSON Serialization:** [json_serializable](https://pub.dev/packages/json_serializable) and [freezed](https://pub.dev/packages/freezed)
*   **Internationalization:** [flutter_localizations](https://pub.dev/packages/flutter_localizations)
*   **Testing:** [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) and [mocktail](https://pub.dev/packages/mocktail)

## 3. Architecture

We use a simple two-layer architecture that's easy to understand and maintain:

*   **UI Layer:** Flutter widgets and Riverpod providers
*   **Data Layer:** API clients and local storage

```
+---------------------+
|      UI Layer       |
| (Widgets + Riverpod)|
+---------------------+
        |
        v
+---------------------+
|     Data Layer      |
| (API + Local Storage)|
+---------------------+
```

### 3.1. UI Layer

*   **Widgets:** Flutter widgets with Material Design
*   **State Management:** Simple Riverpod providers:
    *   `Provider` for simple values
    *   `StateNotifierProvider` for complex state
    *   `FutureProvider` for async data
*   **Routing:** `go_router` for navigation

### 3.2. Data Layer

*   **API Services:** Direct use of generated API clients
*   **Local Storage:** Hive for caching and user preferences
*   **Models:** Simple data classes with json_serializable and freezed

## 4. Data Flow

1.  **User Interaction:** User interacts with a widget
2.  **Provider Call:** Widget calls a Riverpod provider method
3.  **API Call:** Provider directly calls API service or checks local cache
4.  **State Update:** Provider updates its state with new data
5.  **UI Update:** UI rebuilds automatically with new state

## 5. Authentication and Authorization

*   **OAuth 2.0:** We will use the `OAuth2Password` flow for the initial login and the `OAuth2RefreshToken` flow to maintain the session.
*   **Token Storage:** Access and refresh tokens will be stored securely using `flutter_secure_storage`.
*   **Token Refresh:** We will implement an interceptor with `dio` to automatically refresh the access token when it expires.

## 6. Error Handling

*   **Simple Error Types:** Use basic error classes for common scenarios:
    *   `NetworkError`: Connection issues
    *   `ApiError`: Server errors
    *   `ValidationError`: Input validation failures
*   **Error Display:** Show user-friendly error messages with retry options
*   **Logging:** Log errors for debugging purposes

## 7. Code Style and Linting

*   **Flutter Lints:** We will use the recommended Flutter lints to enforce a consistent code style.
*   **Static Analysis:** We will use the Dart analyzer to identify potential problems in the code.

## 8. Offline Support

*   **Caching:** Use Hive to cache data locally
*   **Offline Actions:** Queue user actions when offline, sync when online
*   **Cache Management:** Simple TTL-based cache invalidation

## 9. UI/UX Design

*   **Design System:** Use consistent colors, typography, and spacing
*   **Material Design:** Follow Material Design guidelines
*   **Component Library:** Build reusable UI components
*   **Animations:** Use subtle animations for better UX

## 10. Project Structure

Simple feature-based structure:

```
lib/
├── config/
├── src/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── widgets/
│   │   │   └── providers/
│   │   ├── entries/
│   │   │   ├── widgets/
│   │   │   └── providers/
│   │   └── ...
│   ├── core/
│   │   ├── api/
│   │   ├── models/
│   │   ├── utils/
│   │   └── widgets/
│   └── app.dart
└── main.dart
```

## 11. Testing

*   **Unit Tests:** Test providers and utility functions
*   **Widget Tests:** Test UI components and screens
*   **Integration Tests:** Test critical user flows

## 12. Internationalization

*   **Languages:** Russian (default), English
*   **Implementation:** Use `flutter_localizations` and `intl` packages
*   **String Management:** All user-visible strings must be stored in localization files
*   **Translation Requirements:**
    *   All UI text, error messages, and user-facing content must have Russian translations
    *   Date and number formatting must respect Russian locale conventions
    *   Text direction and layout must support Cyrillic script
*   **File Structure:**
    ```
    lib/l10n/
    ├── app_ru.arb
    ├── app_en.arb
    └── app_localizations.dart
    ```

## 13. Accessibility

*   **WCAG 2.1 AA:** Follow accessibility guidelines
*   **Screen Readers:** Support TalkBack and VoiceOver
*   **Semantic Labels:** Provide meaningful labels for all UI elements
*   **Color Contrast:** Ensure sufficient contrast ratios

## 14. Websocket integration
*   **Library:** Use the `centrifuge` library for WebSocket communication.
*   **Connection Token:** Obtain the connection token from the `/account/
subscribe/token` API endpoint.
*   **Channels:** Subscribe to the following channels:
    *   `"notifications#" + username`
    *   `"messages#" + username`
*   **Message Format:** The server will send JSON messages with the following 
data format:
    *   **Notifications Channel:** `{id: int64, subj: int64, type: string, 
    state: string}`
        *   `id`: Notification ID.
        *   `subj`: Subject ID (user, comment, etc.).
        *   `type`: Notification type.
        *   `state`: Notification state.
    *   **Messages Channel:** `{id: int64, subj: int64, type: string, state: 
    string}`
        *   `id`: Chat ID.
        *   `subj`: Message ID.
        *   `type`: Always 'message'.
        *   `state`: Message state.
*   **Message States:** The `state` field can have the following values: 
`new`, `updated`, `removed`, `read`.
*   **Message Handling:** The application should handle incoming messages and 
update the UI and data accordingly.
*   **Connection Management:**
    *   Implement exponential backoff for reconnection attempts
    *   Handle connection state changes (connecting, connected, disconnected, 
    error)
    *   Queue messages when offline and sync when reconnected
    *   Show connection status indicator in UI
*   **Error Handling:** We will implement comprehensive error handling for 
WebSocket connections:
    *   Network connectivity issues
    *   Authentication token expiration
    *   Server-side connection limits
    *   Graceful degradation when WebSocket is unavailable
