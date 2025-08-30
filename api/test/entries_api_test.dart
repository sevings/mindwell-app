import 'package:test/test.dart';
import 'package:mindwell/mindwell.dart';


/// tests for EntriesApi
void main() {
  final instance = Mindwell().getEntriesApi();

  group(EntriesApi, () {
    //Future<MwFeed> entriesBestGet({ int limit, String tag, String query, String source_, String category }) async
    test('test entriesBestGet', () async {
      // TODO
    });

    //Future<MwFeed> entriesFriendsGet({ int limit, String after, String before, String tag, String query }) async
    test('test entriesFriendsGet', () async {
      // TODO
    });

    //Future<MwAdjacentEntries> entriesIdAdjacentGet(int id) async
    test('test entriesIdAdjacentGet', () async {
      // TODO
    });

    //Future entriesIdComplainPost(int id, { String content }) async
    test('test entriesIdComplainPost', () async {
      // TODO
    });

    //Future entriesIdDelete(int id) async
    test('test entriesIdDelete', () async {
      // TODO
    });

    //Future<MwEntry> entriesIdGet(int id) async
    test('test entriesIdGet', () async {
      // TODO
    });

    //Future<MwEntry> entriesIdPut(int id, String content, String privacy, { String title, BuiltSet<int> images, BuiltSet<String> tags, BuiltList<int> visibleFor, bool isCommentable, bool isVotable, bool inLive, bool isShared, bool anonymousComments }) async
    test('test entriesIdPut', () async {
      // TODO
    });

    //Future<MwFeed> entriesLiveGet({ int limit, String after, String before, String tag, String query, String source_, String section }) async
    test('test entriesLiveGet', () async {
      // TODO
    });

    //Future<MwEntry> entriesRandomGet() async
    test('test entriesRandomGet', () async {
      // TODO
    });

    //Future<MwTagList> entriesTagsGet({ int limit, String query }) async
    test('test entriesTagsGet', () async {
      // TODO
    });

    //Future<MwFeed> entriesWatchingGet({ int limit, String after, String before }) async
    test('test entriesWatchingGet', () async {
      // TODO
    });

  });
}
