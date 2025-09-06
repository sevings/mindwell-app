import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for CommentsApi
void main() {
  final instance = MindwellApi().getCommentsApi();

  group(CommentsApi, () {
    //Future<MwCommentList> commentsGet({ int limit, String after, String before }) async
    test('test commentsGet', () async {
      // TODO
    });

    //Future commentsIdComplainPost(int id, { String content }) async
    test('test commentsIdComplainPost', () async {
      // TODO
    });

    //Future commentsIdDelete(int id) async
    test('test commentsIdDelete', () async {
      // TODO
    });

    //Future<MwComment> commentsIdGet(int id) async
    test('test commentsIdGet', () async {
      // TODO
    });

    //Future<MwComment> commentsIdPut(int id, String content) async
    test('test commentsIdPut', () async {
      // TODO
    });

    //Future<MwUser> entriesIdCommentatorGet(int id) async
    test('test entriesIdCommentatorGet', () async {
      // TODO
    });

    //Future<MwCommentList> entriesIdCommentsGet(int id, { int limit, String after, String before }) async
    test('test entriesIdCommentsGet', () async {
      // TODO
    });

    //Future<MwComment> entriesIdCommentsPost(int id, String content) async
    test('test entriesIdCommentsPost', () async {
      // TODO
    });

  });
}
