import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for NotificationsApi
void main() {
  final instance = MindwellApi().getNotificationsApi();

  group(NotificationsApi, () {
    //Future<MwNotificationList> notificationsGet({ int limit, String after, String before, bool unread }) async
    test('test notificationsGet', () async {
      // TODO
    });

    //Future<MwNotification> notificationsIdGet(int id) async
    test('test notificationsIdGet', () async {
      // TODO
    });

    //Future<MwNotificationsReadPut200Response> notificationsReadPut({ num time }) async
    test('test notificationsReadPut', () async {
      // TODO
    });

  });
}
