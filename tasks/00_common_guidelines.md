# Common Guidelines

This document outlines the common guidelines and architectural principles to be followed throughout the development of the Mindwell application. Every task should adhere to these guidelines to ensure consistency, maintainability, and quality.

## 1. General Principles

*   **Simplicity:** Keep solutions simple and easy to understand. Avoid over-engineering.
*   **Consistency:** Follow consistent patterns and conventions throughout the application.
*   **Clarity:** Write clean, readable, and well-documented code.
*   **Testing:** All features must be accompanied by relevant tests (unit, widget, and integration).

## 2. Architecture

We follow a simple two-layer architecture as defined in `spec/architecture.md`.

*   **UI Layer:** Contains Flutter widgets and Riverpod providers.
*   **Data Layer:** Consists of API clients and local storage services.

### Project Structure

Adhere to the feature-based project structure:

```
lib/
└── src/
    ├── features/
    │   ├── <feature_name>/
    │   │   ├── widgets/
    │   │   ├── providers/
    │   │   ├── models/
    │   │   └── screens/
    │   └── ...
    ├── core/
    │   ├── api/
    │   ├── models/
    │   ├── utils/
    │   └── widgets/
    └── app.dart
```

## 3. Technology Stack

You must use the following technologies and packages as specified in the architecture.

*   **State Management:** Use `riverpod`.
    *   `Provider` for simple, immutable values.
    *   `StateNotifierProvider` for complex state objects that can change.
    *   `FutureProvider` for asynchronous operations that return a single value.
    *   `StreamProvider` for streams of data.
*   **Routing:** Use `go_router` for declarative, URI-based navigation.
*   **API Communication:**
    *   **Always** use the pre-generated API client located in the `/api` directory. Do not make raw HTTP requests.
    *   The API client is configured to use `dio`, which includes interceptors for authentication and error handling.
*   **Local Storage:**
    *   Use `hive` for caching data and user settings.
    *   Use `flutter_secure_storage` for storing sensitive data like authentication tokens.
*   **JSON Serialization:** Use `freezed` for creating immutable models and `json_serializable` for serialization.
*   **Internationalization (i18n):**
    *   Use `flutter_localizations` and the `intl` package.
    *   All user-facing strings must be placed in `.arb` files (`lib/l10n/`).
    *   The default language is Russian (`ru`), with English (`en`) as the secondary language.

## 4. Code Style and Quality

*   **Linting:** Adhere to the Flutter Lints specified in `analysis_options.yaml`.
*   **Error Handling:**
    *   Implement robust error handling for API calls, local storage operations, and other potential failure points.
    *   Display user-friendly error messages.
    *   Use custom error classes like `NetworkError`, `ApiError`, `ValidationError` where appropriate.
*   **Immutability:** Prefer immutable data structures. Use `freezed` to enforce this for your models.

## 5. Testing

*   **Unit Tests:** For providers, utility functions, and business logic. Use `mocktail` for mocking dependencies.
*   **Widget Tests:** For individual widgets and screens to verify UI rendering and interaction.
*   **Integration Tests:** For critical end-to-end user flows.
*   **File Location:** Place test files in the `test/` directory, mirroring the `lib/` structure.

## 6. Task Implementation Workflow

For each task, please follow these steps:

1.  **Understand the Goal:** Read the task description carefully to understand the requirements.
2.  **Identify Files:** Determine which files need to be created or modified. The task description will often provide a list.
3.  **Implement the Feature:** Write the necessary Dart code, following all the guidelines above.
4.  **Write Tests:** Create corresponding tests for the new or modified code.
5.  **Apply Automatic Fixes:** Run `dart fix --apply` to automatically fix common linting issues.
6.  **Run Analysis:** Execute `flutter analyze` and fix all remaining reported issues before proceeding.
7.  **Verify:** Ensure the implementation is correct and all tests pass.
