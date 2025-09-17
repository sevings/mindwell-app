import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell_api/mindwell_api.dart';

import 'package:mindwell/src/features/chat/screens/chat_messages_screen.dart';
import 'package:mindwell/src/features/chat/providers/chat_messages_provider.dart';
import 'package:mindwell/src/features/chat/models/chat_messages_state.dart';
import 'package:mindwell/src/features/auth/providers/auth_provider.dart';
import 'package:mindwell/src/features/auth/models/auth_state.dart';

// Mock classes
class MockChatMessagesNotifier extends StateNotifier<ChatMessagesState>
    with Mock
    implements ChatMessagesNotifier {
  MockChatMessagesNotifier() : super(const ChatMessagesState.loading());

  @override
  Future<void> fetchInitialMessages() async {
    // Mock implementation - do nothing
  }

  @override
  Future<void> fetchMoreMessages() async {
    // Mock implementation - do nothing
  }

  @override
  Future<void> sendMessage(String text) async {
    // Mock implementation - do nothing
  }

  @override
  Future<void> markAsRead() async {
    // Mock implementation - do nothing
  }

  @override
  Future<void> refresh() async {
    // Mock implementation - do nothing
  }
}

class MockAuthNotifier extends StateNotifier<AuthState>
    with Mock
    implements AuthNotifier {
  MockAuthNotifier() : super(const AuthState.initial());
}

void main() {
  group('ChatMessagesScreen', () {
    late MockChatMessagesNotifier mockChatNotifier;
    late MockAuthNotifier mockAuthNotifier;
    late $MwUser testUser;

    setUp(() {
      mockChatNotifier = MockChatMessagesNotifier();
      mockAuthNotifier = MockAuthNotifier();

      testUser = $MwUser(
        (b) => b
          ..id = 1
          ..name = 'testuser'
          ..showName = 'Test User'
          ..isTheme = false
          ..isOnline = true
          ..avatar = null,
      );
    });

    testWidgets('displays loading state initially', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.loading();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.text('Loading messages...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays empty state when no messages', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.loaded(
        messages: [],
        messageStatus: {},
      );
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.text('No messages yet'), findsOneWidget);
      expect(
        find.text('Start the conversation by sending a message'),
        findsOneWidget,
      );
    });

    testWidgets('displays messages list when messages are loaded', (
      WidgetTester tester,
    ) async {
      final testMessage = MwMessage(
        (b) => b
          ..id = 1
          ..chatId = 1
          ..author = null
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..read = false
          ..content = 'Test message'
          ..editContent = null
          ..rights = null,
      );

      mockChatNotifier.state = ChatMessagesState.loaded(
        messages: [testMessage],
        messageStatus: {},
      );
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.text('Test message'), findsOneWidget);
    });

    testWidgets('displays error state when error occurs', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.error(
        'Test error message',
      );
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.text('Test error message'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('shows message input when messages are loaded', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.loaded(
        messages: [],
        messageStatus: {},
      );
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsOneWidget);
    });

    testWidgets('hides message input in loading state', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.loading();
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('hides message input in error state', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.error('Test error');
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('displays username in app bar', (WidgetTester tester) async {
      mockChatNotifier.state = const ChatMessagesState.loading();
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.text('testuser'), findsOneWidget);
    });

    testWidgets('shows profile button in app bar', (WidgetTester tester) async {
      mockChatNotifier.state = const ChatMessagesState.loading();
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('disables message input when sending', (
      WidgetTester tester,
    ) async {
      mockChatNotifier.state = const ChatMessagesState.loaded(
        messages: [],
        messageStatus: {},
        isSending: true,
      );
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('shows loading indicator for pagination', (
      WidgetTester tester,
    ) async {
      final testMessage = MwMessage(
        (b) => b
          ..id = 1
          ..chatId = 1
          ..author = null
          ..createdAt = DateTime.now().millisecondsSinceEpoch / 1000
          ..read = false
          ..content = 'Test message'
          ..editContent = null
          ..rights = null,
      );

      mockChatNotifier.state = ChatMessagesState.loaded(
        messages: [testMessage],
        messageStatus: {},
        isFetchingMore: true,
      );
      mockAuthNotifier.state = AuthState.authenticated(
        user: testUser,
        authSource: AuthSource.login,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            chatMessagesProvider(
              'testuser',
            ).overrideWith((ref) => mockChatNotifier),
            authProvider.overrideWith((ref) => mockAuthNotifier),
          ],
          child: const MaterialApp(
            home: ChatMessagesScreen(username: 'testuser'),
          ),
        ),
      );

      // Should show loading indicator for pagination
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
