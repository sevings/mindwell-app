import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for ChatsApi
void main() {
  final instance = MindwellApi().getChatsApi();

  group(ChatsApi, () {
    //Future<MwChatList> chatsGet({ int limit, String after, String before }) async
    test('test chatsGet', () async {
      // TODO
    });

    //Future<MwChat> chatsNameGet(String name) async
    test('test chatsNameGet', () async {
      // TODO
    });

    //Future<MwMessageList> chatsNameMessagesGet(String name, { int limit, String after, String before }) async
    test('test chatsNameMessagesGet', () async {
      // TODO
    });

    //Future<MwMessage> chatsNameMessagesPost(String name, String content, num uid) async
    test('test chatsNameMessagesPost', () async {
      // TODO
    });

    //Future<MwNotificationsReadPut200Response> chatsNameReadPut(String name, int message) async
    test('test chatsNameReadPut', () async {
      // TODO
    });

    //Future messagesIdComplainPost(int id, { String content }) async
    test('test messagesIdComplainPost', () async {
      // TODO
    });

    //Future messagesIdDelete(int id) async
    test('test messagesIdDelete', () async {
      // TODO
    });

    //Future<MwMessage> messagesIdGet(int id) async
    test('test messagesIdGet', () async {
      // TODO
    });

    //Future<MwMessage> messagesIdPut(int id, String content) async
    test('test messagesIdPut', () async {
      // TODO
    });

  });
}
