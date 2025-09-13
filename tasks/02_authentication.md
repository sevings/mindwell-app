# Epic: Authentication

This epic covers the implementation of the user authentication flow, including login, registration, and session management. The primary goal is to create a secure and user-friendly authentication experience.

Refer to the [Common Guidelines](./00_common_guidelines.md) for architectural and coding standards.

## Task 1: Secure Token Storage & State Model

### Goal
Create the service for securely storing authentication tokens (both user and app tokens) and define the `AuthState` data model.

### Files to be Created or Modified:
*   `lib/src/core/services/token_storage_service.dart` (Create)
*   `lib/src/features/auth/models/auth_state.dart` (Create)

### Implementation Details:
1.  **Create `token_storage_service.dart`:**
    *   Create a class `TokenStorageService` that uses `flutter_secure_storage`.
    *   Implement methods for user tokens: `saveUserTokens(accessToken, refreshToken)`, `getAccessToken()`, `getRefreshToken()`, `clearUserTokens()`.
    *   Implement methods for the app token: `saveAppToken(appToken)`, `getAppToken()`, `clearAppToken()`.
2.  **Create `auth_state.dart`:**
    *   Use `freezed` to create a sealed class `AuthState` with the following states:
        *   `initial()`
        *   `loading()`
        *   `authenticated({required User user})`
        *   `unauthenticated()`
        *   `error({required String message})`
    *   The `User` model should come from the generated API client.

### Testing:
*   **Unit Tests:**
    *   Test the `TokenStorageService` using an in-memory mock of `FlutterSecureStorage` for both user and app tokens.

---

## Task 2: Authentication Logic Provider

### Goal
Implement the `AuthNotifier` to manage authentication state, business logic, and app token retrieval.

### Files to be Created or Modified:
*   `lib/src/features/auth/providers/auth_provider.dart` (Create)

### Implementation Details:
1.  **Create `auth_provider.dart`:**
    *   Create a `StateNotifierProvider` that exposes an `AuthNotifier`.
    *   `AuthNotifier` will manage the `AuthState`.
    *   Dependencies: `Oauth2Api`, `AccountApi`, and `TokenStorageService`.
    *   Implement methods:
        *   `getAppToken()`: A method to be called on app startup. It should check for a stored app token, and if it's missing or invalid, fetch a new one using the `client_credentials` grant type. This token will be used for API calls when the user is not logged in.
        *   `login(String email, String password)`
        *   `register(String username, String email, String password)`
        *   `logout()`: This should clear only the user tokens, leaving the app token intact.
        *   `checkAuthStatus()`: A method to check for stored user tokens on app startup and update the state accordingly.

### Testing:
*   **Unit Tests:**
    *   Test the `AuthNotifier` logic. Mock its dependencies (`Oauth2Api`, `AccountApi`, `TokenStorageService`).
    *   Verify app token fetching logic.
    *   Verify that the state changes correctly for login success/failure, registration, and logout.

---

## Task 3: API Client Interceptor for Auth

### Goal
Configure the API client's `Dio` instance to automatically inject the correct auth token (user or app) and handle token refresh.

### Files to be Created or Modified:
*   `lib/src/core/api/api_provider.dart` (Modify or Create)

### Implementation Details:
1.  **Modify `api_provider.dart`:**
    *   Ensure the `Dio` instance used by the API client has an `Interceptor` that:
        *   Checks the authentication state (e.g., via `ref.read(authProvider)`).
        *   If the user is authenticated, it adds the `Authorization: Bearer <accessToken>` header.
        *   If the user is not authenticated, it adds the `Authorization: Bearer <appToken>` header.
        *   Handles 401 Unauthorized errors by attempting to refresh the user token (using the refresh token) or re-fetching the app token.
        *   If refresh fails for a user token, log the user out.

### Testing:
*   **Unit Tests:**
    *   Test the `Dio` interceptor logic for both user and app token injection and refresh scenarios.

---

## Task 4: Route Guards for Authentication

### Goal
Protect routes based on user authentication status using `go_router`'s redirect functionality.

### Files to be Created or Modified:
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Modify `app_router.dart`:**
    *   Use the `auth_provider` to implement route guards.
    *   `redirect` logic:
        *   If the user is not authenticated, redirect them from protected routes to the `/login` route.
        *   If the user is authenticated, redirect them from the `/login` route to the `/` (home) route.

### Testing:
*   **Widget/Integration Tests:**
    *   Test the routing and redirect logic by mocking the auth state.

---

## Task 5: Login Form UI

### Goal
Build the user interface for the login form.

### Files to be Created or Modified:
*   `lib/src/features/auth/widgets/login_form.dart` (Create)

### Implementation Details:
1.  **Create `login_form.dart`:**
    *   A `StatefulWidget` containing a `Form`.
    *   Use the `StyledTextField` core widget for email and password.
    *   Include a password visibility toggle icon.
    *   Use the `PrimaryButton` core widget for the "Login" button.
    *   When the button is pressed, call the `login` method on the `AuthNotifier`.
    *   Listen to the `auth_provider` state to show a loading indicator on the button or display an error message (e.g., in a `SnackBar`).

### Testing:
*   **Widget Tests:**
    *   Test the `LoginForm` widget:
        *   Verify that form validation works (e.g., for empty fields, invalid email format).
        *   Mock the `AuthNotifier` and verify that the correct methods are called when the button is tapped.
        *   Simulate state changes in the mocked provider (e.g., loading, error) and verify the UI updates accordingly.

---

## Task 6: Registration Form UI

### Goal
Build the user interface for the registration form.

### Files to be Created or Modified:
*   `lib/src/features/auth/widgets/registration_form.dart` (Create)

### Implementation Details:
1.  **Create `registration_form.dart`:**
    *   Similar structure to the `LoginForm`.
    *   Add a `username` field.
    *   Include a password strength indicator (can be a simple widget for now).
    *   Link to "Terms of Service" and "Privacy Policy" (can be simple text for now).
    *   Call the `register` method on the `AuthNotifier`.

### Testing:
*   **Widget Tests:**
    *   Test the `RegistrationForm` widget, similar to the `LoginForm` tests.

---

## Task 7: Authentication Screen

### Goal
Build the screen that hosts and allows switching between the login and registration forms.

### Files to be Created or Modified:
*   `lib/src/features/auth/screens/auth_screen.dart` (Create)
*   `lib/src/core/router/app_router.dart` (Modify)

### Implementation Details:
1.  **Create `auth_screen.dart`:**
    *   This screen will host the `TabBar` to switch between the login and registration forms.
    *   Use a `DefaultTabController` with a `Scaffold` and `AppBar` containing the `TabBar`.
    *   The `TabBarView` will contain `LoginForm` and `RegistrationForm`.
2.  **Modify `app_router.dart`:**
    *   Add a `GoRoute` for the `/login` path, which builds the `AuthScreen`.

### Testing:
*   **Widget Tests:**
    *   Test the `AuthScreen` to ensure the tabs and forms are displayed.
