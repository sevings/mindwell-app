import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for MeApi
void main() {
  final instance = MindwellApi().getMeApi();

  group(MeApi, () {
    //Future meAvatarPut(MultipartFile file) async
    test('test meAvatarPut', () async {
      // TODO
    });

    //Future<MwBadgeList> meBadgesGet({ int limit }) async
    test('test meBadgesGet', () async {
      // TODO
    });

    //Future<MwCalendar> meCalendarGet({ int start, int end, int limit }) async
    test('test meCalendarGet', () async {
      // TODO
    });

    //Future<MwCommentList> meCommentsGet({ int limit, String after, String before }) async
    test('test meCommentsGet', () async {
      // TODO
    });

    //Future meCoverPut(MultipartFile file) async
    test('test meCoverPut', () async {
      // TODO
    });

    //Future<MwFeed> meFavoritesGet({ int limit, String after, String before, String query }) async
    test('test meFavoritesGet', () async {
      // TODO
    });

    //Future<MwFriendList> meFollowersGet({ int limit, String after, String before }) async
    test('test meFollowersGet', () async {
      // TODO
    });

    //Future<MwFriendList> meFollowingsGet({ int limit, String after, String before }) async
    test('test meFollowingsGet', () async {
      // TODO
    });

    //Future<MwAuthProfile> meGet() async
    test('test meGet', () async {
      // TODO
    });

    //Future<MwFriendList> meHiddenGet({ int limit, String after, String before }) async
    test('test meHiddenGet', () async {
      // TODO
    });

    //Future<MwFriendList> meIgnoredGet({ int limit, String after, String before }) async
    test('test meIgnoredGet', () async {
      // TODO
    });

    //Future<MwImageList> meImagesGet({ int limit, String after, String before }) async
    test('test meImagesGet', () async {
      // TODO
    });

    //Future<MwFriendList> meInvitedGet({ int limit, String after, String before }) async
    test('test meInvitedGet', () async {
      // TODO
    });

    //Future<MwMeOnlinePut200Response> meOnlinePut() async
    test('test meOnlinePut', () async {
      // TODO
    });

    //Future<MwProfile> mePut(String showName, String privacy, String chatPrivacy, { String gender, bool isDaylog, String title, String birthday, String country, String city, bool showInTops }) async
    test('test mePut', () async {
      // TODO
    });

    //Future<MwFriendList> meRequestedGet({ int limit, String after, String before }) async
    test('test meRequestedGet', () async {
      // TODO
    });

    //Future<MwTagList> meTagsGet({ int limit, String query }) async
    test('test meTagsGet', () async {
      // TODO
    });

    //Future<MwFeed> meTlogGet({ int limit, String after, String before, String tag, String sort, String query }) async
    test('test meTlogGet', () async {
      // TODO
    });

    //Future<MwEntry> meTlogPost(String content, String privacy, { String title, BuiltSet<int> images, BuiltSet<String> tags, BuiltList<int> visibleFor, bool isCommentable, bool isVotable, bool inLive, bool isShared, bool isDraft }) async
    test('test meTlogPost', () async {
      // TODO
    });

  });
}
