import 'package:test/test.dart';
import 'package:mindwell/mindwell.dart';


/// tests for ThemesApi
void main() {
  final instance = Mindwell().getThemesApi();

  group(ThemesApi, () {
    //Future<MwThemesGet200Response> themesGet({ String top, String query }) async
    test('test themesGet', () async {
      // TODO
    });

    //Future themesNameAvatarPut(String name, MultipartFile file) async
    test('test themesNameAvatarPut', () async {
      // TODO
    });

    //Future<MwCalendar> themesNameCalendarGet(String name, { int start, int end, int limit }) async
    test('test themesNameCalendarGet', () async {
      // TODO
    });

    //Future<MwCommentList> themesNameCommentsGet(String name, { int limit, String after, String before }) async
    test('test themesNameCommentsGet', () async {
      // TODO
    });

    //Future themesNameComplainPost(String name, { String content }) async
    test('test themesNameComplainPost', () async {
      // TODO
    });

    //Future themesNameCoverPut(String name, MultipartFile file) async
    test('test themesNameCoverPut', () async {
      // TODO
    });

    //Future<MwFriendList> themesNameFollowersGet(String name, { int limit, String after, String before }) async
    test('test themesNameFollowersGet', () async {
      // TODO
    });

    //Future<MwProfile> themesNameGet(String name) async
    test('test themesNameGet', () async {
      // TODO
    });

    //Future<MwImageList> themesNameImagesGet(String name, { int limit, String after, String before }) async
    test('test themesNameImagesGet', () async {
      // TODO
    });

    //Future<MwProfile> themesNamePut(String name, String showName, String privacy, { bool isDaylog, String title, bool showInTops }) async
    test('test themesNamePut', () async {
      // TODO
    });

    //Future<MwTagList> themesNameTagsGet(String name, { int limit, String query }) async
    test('test themesNameTagsGet', () async {
      // TODO
    });

    //Future<MwFeed> themesNameTlogGet(String name, { int limit, String after, String before, String tag, String sort, String query }) async
    test('test themesNameTlogGet', () async {
      // TODO
    });

    //Future<MwEntry> themesNameTlogPost(String name, String content, String privacy, { String title, BuiltSet<int> images, BuiltSet<String> tags, bool isCommentable, bool isVotable, bool inLive, bool isShared, bool isDraft, bool isAnonymous }) async
    test('test themesNameTlogPost', () async {
      // TODO
    });

    //Future<MwProfile> themesPost(String name, String showName) async
    test('test themesPost', () async {
      // TODO
    });

  });
}
