import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple authentication state for navigation components.
/// 
/// This is a temporary implementation that will be replaced with
/// a proper authentication system in future tasks.
class AuthState {
  /// Creates an authentication state.
  const AuthState({
    required this.isAuthenticated,
    this.userId,
    this.username,
  });

  /// Whether the user is currently authenticated.
  final bool isAuthenticated;

  /// The user's ID if authenticated.
  final String? userId;

  /// The user's username if authenticated.
  final String? username;

  /// Creates a copy of this state with the given fields replaced.
  AuthState copyWith({
    bool? isAuthenticated,
    String? userId,
    String? username,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isAuthenticated == isAuthenticated &&
        other.userId == userId &&
        other.username == username;
  }

  @override
  int get hashCode {
    return isAuthenticated.hashCode ^ userId.hashCode ^ username.hashCode;
  }
}

/// Authentication state notifier.
/// 
/// Manages the authentication state for the application.
/// This is a temporary implementation for navigation components.
class AuthNotifier extends StateNotifier<AuthState> {
  /// Creates an authentication notifier.
  AuthNotifier() : super(const AuthState(isAuthenticated: false));

  /// Simulates user login.
  void login({
    required String userId,
    required String username,
  }) {
    state = state.copyWith(
      isAuthenticated: true,
      userId: userId,
      username: username,
    );
  }

  /// Simulates user logout.
  void logout() {
    state = const AuthState(isAuthenticated: false);
  }

  /// Simulates checking authentication status.
  /// In a real app, this would check stored tokens or make API calls.
  void checkAuthStatus() {
    // For now, we'll simulate that the user is not authenticated
    // This will be replaced with actual token checking in future tasks
    state = const AuthState(isAuthenticated: false);
  }
}

/// Provider for the authentication state.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
