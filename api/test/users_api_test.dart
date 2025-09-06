import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for UsersApi
void main() {
  final instance = MindwellApi().getUsersApi();

  group(UsersApi, () {
    //Future<MwUsersGet200Response> usersGet({ String top, String query }) async
    test('test usersGet', () async {
      // TODO
    });

    //Future<MwBadgeList> usersNameBadgesGet(String name, { int limit }) async
    test('test usersNameBadgesGet', () async {
      // TODO
    });

    //Future<MwCalendar> usersNameCalendarGet(String name, { int start, int end, int limit }) async
    test('test usersNameCalendarGet', () async {
      // TODO
    });

    //Future<MwCommentList> usersNameCommentsGet(String name, { int limit, String after, String before }) async
    test('test usersNameCommentsGet', () async {
      // TODO
    });

    //Future usersNameComplainPost(String name, { String content }) async
    test('test usersNameComplainPost', () async {
      // TODO
    });

    //Future<MwFeed> usersNameFavoritesGet(String name, { int limit, String after, String before, String query }) async
    test('test usersNameFavoritesGet', () async {
      // TODO
    });

    //Future<MwFriendList> usersNameFollowersGet(String name, { int limit, String after, String before }) async
    test('test usersNameFollowersGet', () async {
      // TODO
    });

    //Future<MwFriendList> usersNameFollowingsGet(String name, { int limit, String after, String before }) async
    test('test usersNameFollowingsGet', () async {
      // TODO
    });

    //Future<MwProfile> usersNameGet(String name) async
    test('test usersNameGet', () async {
      // TODO
    });

    //Future<MwImageList> usersNameImagesGet(String name, { int limit, String after, String before }) async
    test('test usersNameImagesGet', () async {
      // TODO
    });

    //Future<MwFriendList> usersNameInvitedGet(String name, { int limit, String after, String before }) async
    test('test usersNameInvitedGet', () async {
      // TODO
    });

    //Future<MwTagList> usersNameTagsGet(String name, { int limit, String query }) async
    test('test usersNameTagsGet', () async {
      // TODO
    });

    //Future<MwFeed> usersNameTlogGet(String name, { int limit, String after, String before, String tag, String sort, String query }) async
    test('test usersNameTlogGet', () async {
      // TODO
    });

  });
}
