import 'package:flutter_test/flutter_test.dart';

import 'package:mindwell/src/features/chat/models/message_action.dart';

void main() {
  group('MessageAction', () {
    group('EditMessageAction', () {
      test('should create edit action with correct properties', () {
        // Arrange
        const messageId = 123;
        const currentContent = 'Original message';

        // Act
        final action = MessageAction.edit(
          messageId: messageId,
          currentContent: currentContent,
        );

        // Assert
        expect(action, isA<EditMessageAction>());
        action.when(
          edit: (id, content) {
            expect(id, messageId);
            expect(content, currentContent);
          },
          delete: (id) => fail('Should not be delete action'),
          report: (id, reason) => fail('Should not be report action'),
          retry: (id, content) => fail('Should not be retry action'),
        );
      });
    });

    group('DeleteMessageAction', () {
      test('should create delete action with correct properties', () {
        // Arrange
        const messageId = 456;

        // Act
        final action = MessageAction.delete(messageId: messageId);

        // Assert
        expect(action, isA<DeleteMessageAction>());
        action.when(
          edit: (id, content) => fail('Should not be edit action'),
          delete: (id) {
            expect(id, messageId);
          },
          report: (id, reason) => fail('Should not be report action'),
          retry: (id, content) => fail('Should not be retry action'),
        );
      });
    });

    group('ReportMessageAction', () {
      test('should create report action with reason', () {
        // Arrange
        const messageId = 789;
        const reason = 'Inappropriate content';

        // Act
        final action = MessageAction.report(
          messageId: messageId,
          reason: reason,
        );

        // Assert
        expect(action, isA<ReportMessageAction>());
        action.when(
          edit: (id, content) => fail('Should not be edit action'),
          delete: (id) => fail('Should not be delete action'),
          report: (id, reportReason) {
            expect(id, messageId);
            expect(reportReason, reason);
          },
          retry: (id, content) => fail('Should not be retry action'),
        );
      });

      test('should create report action without reason', () {
        // Arrange
        const messageId = 789;

        // Act
        final action = MessageAction.report(messageId: messageId);

        // Assert
        expect(action, isA<ReportMessageAction>());
        action.when(
          edit: (id, content) => fail('Should not be edit action'),
          delete: (id) => fail('Should not be delete action'),
          report: (id, reason) {
            expect(id, messageId);
            expect(reason, isNull);
          },
          retry: (id, content) => fail('Should not be retry action'),
        );
      });
    });

    group('RetryMessageAction', () {
      test('should create retry action with correct properties', () {
        // Arrange
        const messageId = 101112;
        const content = 'Retry this message';

        // Act
        final action = MessageAction.retry(
          messageId: messageId,
          content: content,
        );

        // Assert
        expect(action, isA<RetryMessageAction>());
        action.when(
          edit: (id, content) => fail('Should not be edit action'),
          delete: (id) => fail('Should not be delete action'),
          report: (id, reason) => fail('Should not be report action'),
          retry: (id, retryContent) {
            expect(id, messageId);
            expect(retryContent, content);
          },
        );
      });
    });
  });

  group('MessageActionResult', () {
    group('MessageActionSuccess', () {
      test('should create success result with message', () {
        // Arrange
        const message = 'Action completed successfully';

        // Act
        final result = MessageActionResult.success(message: message);

        // Assert
        expect(result, isA<MessageActionSuccess>());
        result.when(
          success: (msg) {
            expect(msg, message);
          },
          error: (error) => fail('Should not be error result'),
        );
      });

      test('should create success result without message', () {
        // Act
        final result = const MessageActionResult.success();

        // Assert
        expect(result, isA<MessageActionSuccess>());
        result.when(
          success: (msg) {
            expect(msg, isNull);
          },
          error: (error) => fail('Should not be error result'),
        );
      });
    });

    group('MessageActionError', () {
      test('should create error result with error message', () {
        // Arrange
        const error = 'Something went wrong';

        // Act
        final result = MessageActionResult.error(error: error);

        // Assert
        expect(result, isA<MessageActionError>());
        result.when(
          success: (msg) => fail('Should not be success result'),
          error: (err) {
            expect(err, error);
          },
        );
      });
    });
  });
}
