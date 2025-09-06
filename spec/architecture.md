# Architecture

This document outlines the architecture of the MindWell application, a cross-platform mobile application for iOS and Android built with Flutter.

## 1. Guiding Principles

*   **Scalability:** The architecture should be able to accommodate future growth in features and user base.
*   **Maintainability:** The codebase should be easy to understand, modify, and debug.
*   **Testability:** The architecture should facilitate unit, widget, and integration testing.
*   **Consistency:** The codebase should follow a consistent style and a set of best practices.

## 2. Technology Stack

*   **Programming Language:** Dart
*   **UI Framework:** Flutter (Material Design)
*   **State Management:** [Riverpod](https://riverpod.dev/)
*   **Routing:** [go_router](https://pub.dev/packages/go_router) for declarative routing.
*   **API Communication:**
    *   Generated API Client (from `/api`)
    *   [Dio](https://pub.dev/packages/dio) for advanced networking features like interceptors.
*   **Local Data Storage:** [Hive](https://pub.dev/packages/hive) for key-value storage.
*   **Secure Storage:** [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) for storing sensitive data like tokens.
*   **Image Handling:**
    *   [cached_network_image](https://pub.dev/packages/cached_network_image) for displaying and caching network images.
    *   [image_picker](https://pub.dev/packages/image_picker) for selecting images from the gallery or camera.
*   **Dependency Injection:** [injectable](https://pub.dev/packages/injectable)
*   **JSON Serialization/Deserialization:**
    *   [json_serializable](https://pub.dev/packages/json_serializable)
    *   [freezed](https://pub.dev/packages/freezed) for immutable data classes.
*   **Date Formatting:** [intl](https://pub.dev/packages/intl)
*   **Logging:** [logging](https://pub.dev/packages/logging)
*   **Testing:**
    *   [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) for unit and widget tests.
    *   [integration_test](https://pub.dev/packages/integration_test) for integration tests.
    *   [mocktail](https://pub.dev/packages/mocktail) for mocking dependencies.

## 3. Architectural Pattern

We will use a **Layered Architecture** based on the principles of Clean Architecture. This will separate the application into three main layers:

*   **Presentation Layer:** Responsible for the UI and user interaction.
*   **Domain Layer:** Contains the business logic and entities of the application.
*   **Data Layer:** Responsible for data access and communication with external data sources.

```
+---------------------+
| Presentation Layer  |
| (Flutter Widgets,   |
|  Riverpod)          |
+---------------------+
        |
        v
+---------------------+
|    Domain Layer     |
| (Entities, Usecases)|
+---------------------+
        |
        v
+---------------------+
|     Data Layer      |
| (Repositories,      |
|  API Client,        |
|  Local Storage)     |
+---------------------+
```

### 3.1. Presentation Layer

*   **Widgets:** Flutter widgets will be used to build the UI. We will use the Material Design library to ensure a consistent look and feel.
*   **State Management:** Riverpod will be used for state management. We will use a combination of `Provider`, `FutureProvider`, `StreamProvider`, and `StateNotifierProvider` to manage the state of the application.
*   **Routing:** `go_router` will be used for declarative routing. This will make it easier to manage navigation and deep linking.

### 3.2. Domain Layer

*   **Entities:** These are the core business objects of the application (e.g., `User`, `Entry`, `Comment`). They will be implemented as immutable data classes using `freezed`.
*   **Usecases:** These are the application-specific business rules. They will orchestrate the flow of data between the Presentation and Data layers.

### 3.3. Data Layer

*   **Repositories:** The repositories will be responsible for abstracting the data sources. They will provide a clean API for the Domain layer to access the data.
*   **API Client:** The generated API client will be used to communicate with the backend API. We will use `dio` to add interceptors for logging, error handling, and adding the authentication token to the headers. Configuration is stored in the `lib/config/config.dart` file.
*   **Local Storage:** Hive will be used to cache data and store user settings.

## 4. Data Flow

1.  **User Interaction:** The user interacts with a widget in the Presentation Layer.
2.  **Widget Call:** The widget calls a method on a Riverpod provider.
3.  **Provider Call:** The provider calls a usecase in the Domain Layer.
4.  **Usecase Execution:** The usecase executes the business logic and interacts with one or more repositories in the Data Layer.
5.  **Repository Request:** The repository fetches data from the API or local storage.
6.  **Data Return:** The data is returned to the usecase.
7.  **State Update:** The usecase returns the data to the provider, which updates its state.
8.  **UI Update:** The UI rebuilds to reflect the new state.

## 5. Authentication and Authorization

*   **OAuth 2.0:** We will use the `OAuth2Password` flow for the initial login and the `OAuth2RefreshToken` flow to maintain the session.
*   **Token Storage:** Access and refresh tokens will be stored securely using `flutter_secure_storage`.
*   **Token Refresh:** We will implement an interceptor with `dio` to automatically refresh the access token when it expires.

## 6. Error Handling

*   **Sealed Classes:** We will use a sealed class hierarchy to represent different types of errors:
    *   `NetworkError`: Connection issues, timeouts, no internet
    *   `ApiError`: Server errors, HTTP status codes, API-specific errors
    *   `ValidationError`: Client-side validation failures
    *   `AuthenticationError`: Token expired, unauthorized access
    *   `PermissionError`: Insufficient permissions for action
*   **Centralized Error Handling:** We will have a centralized error handling mechanism with:
    *   Global error interceptor using Dio
    *   Error logging with context (user ID, screen, action)
    *   Automatic retry logic for transient errors
    *   Offline detection and appropriate messaging
*   **User-Friendly Error Messages:** We will display user-friendly error messages with:
    *   Localized error messages
    *   Actionable error recovery options
    *   Consistent error UI components
    *   Progressive error disclosure (simple → detailed)

## 7. Code Style and Linting

*   **Flutter Lints:** We will use the recommended Flutter lints to enforce a consistent code style.
*   **Static Analysis:** We will use the Dart analyzer to identify potential problems in the code.

## 8. Build and Deployment

*   **Code Obfuscation:** We will use ProGuard/R8 for Android and the corresponding settings for iOS to obfuscate the code.

## 9. WebSocket Integration

*   **Library:** Use the `centrifuge` library for WebSocket communication.
*   **Connection Token:** Obtain the connection token from the `/account/subscribe/token` API endpoint.
*   **Channels:** Subscribe to the following channels:
    *   `"notifications#" + username`
    *   `"messages#" + username`
*   **Message Format:** The server will send JSON messages with the following data format:

    *   **Notifications Channel:** `{id: int64, subj: int64, type: string, state: string}`
        *   `id`: Notification ID.
        *   `subj`: Subject ID (user, comment, etc.).
        *   `type`: Notification type.
        *   `state`: Notification state.
    *   **Messages Channel:** `{id: int64, subj: int64, type: string, state: string}`
        *   `id`: Chat ID.
        *   `subj`: Message ID.
        *   `type`: Always 'message'.
        *   `state`: Message state.

*   **Message States:** The `state` field can have the following values: `new`, `updated`, `removed`, `read`.
*   **Message Handling:** The application should handle incoming messages and update the UI and data accordingly.
*   **Connection Management:**
    *   Implement exponential backoff for reconnection attempts
    *   Handle connection state changes (connecting, connected, disconnected, error)
    *   Queue messages when offline and sync when reconnected
    *   Show connection status indicator in UI
*   **Error Handling:** We will implement comprehensive error handling for WebSocket connections:
    *   Network connectivity issues
    *   Authentication token expiration
    *   Server-side connection limits
    *   Graceful degradation when WebSocket is unavailable

## 10. Offline Support and Caching

*   **Local Storage Strategy:**
    *   Use Hive for structured data caching (entries, comments, user profiles)
    *   Implement cache invalidation strategies based on data freshness
    *   Store user preferences and settings locally
*   **Offline-First Approach:**
    *   Show cached data immediately when available
    *   Queue user actions when offline (comments, votes, follows)
    *   Sync queued actions when connection is restored
    *   Provide clear offline indicators in UI
*   **Cache Management:**
    *   Implement LRU cache eviction for images and large data
    *   Set appropriate TTL for different data types
    *   Provide manual cache clearing options in settings
*   **Conflict Resolution:**
    *   Handle conflicts when syncing offline actions
    *   Provide user choice for conflict resolution
    *   Log conflicts for debugging and improvement

## 11. UI/UX Design Principles

To ensure a consistent and high-quality user experience, we will adhere to the following UI/UX design principles:

*   **Color Palette:** We will define a primary, secondary, and accent color palette that reflects the MindWell brand. The color palette will be used consistently throughout the application.
*   **Typography:** We will use a consistent set of fonts, font sizes, and font weights to ensure readability and a clear visual hierarchy.
*   **Iconography:** We will use a consistent set of icons, preferably from the Material Icons library, to represent actions and information.
*   **Component Library:** We will build a custom component library on top of the Material Design library to ensure that common UI elements (e.g., buttons, text fields, cards) have a consistent look and feel.
*   **Animations and Transitions:** We will use subtle animations and transitions to provide visual feedback to the user and to make the application feel more polished and responsive.

## 12. Project Structure

We will use a feature-based project structure to organize the codebase. This will make it easier to navigate the code, to add new features, and to work on different features in parallel.

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
│   │   └── ...
│   └── app.dart
└── main.dart
```

## 13. Testing Strategy

We will adopt a comprehensive testing strategy to ensure the quality and reliability of the application.

*   **Unit Tests:** We will write unit tests for all usecases, repository implementations, and models. We will aim for a code coverage of at least 80% for the domain and data layers.
*   **Widget Tests:** We will write widget tests for all screens and complex widgets to verify that they render correctly and that they respond to user interaction as expected.
*   **Integration Tests:** We will write integration tests for all critical user flows, such as login, registration, and creating a new entry.

## 14. Accessibility (a11y)

We will strive to make the MindWell application accessible to as many users as possible, including those with disabilities. We will follow the Web Content Accessibility Guidelines (WCAG) 2.1 and will:

*   Use semantic widgets to provide context to screen readers.
*   Provide alternative text for all images.
*   Ensure that all text has a sufficient color contrast ratio.
*   Test the application with screen readers (e.g., TalkBack on Android, VoiceOver on iOS).
