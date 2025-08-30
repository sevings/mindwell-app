import 'package:test/test.dart';
import 'package:mindwell/mindwell.dart';


/// tests for Oauth2Api
void main() {
  final instance = Mindwell().getOauth2Api();

  group(Oauth2Api, () {
    // only for internal usage
    //
    //Future<MwOauth2AllowPost200Response> oauth2AllowPost(String responseType, int clientId, String redirectUri, BuiltList<String> scope, { String state, String codeChallenge, String codeChallengeMethod }) async
    test('test oauth2AllowPost', () async {
      // TODO
    });

    //Future<MwApp> oauth2AppsIdGet(int id) async
    test('test oauth2AppsIdGet', () async {
      // TODO
    });

    // only for internal usage
    //
    //Future oauth2DenyGet(int clientId, String redirectUri) async
    test('test oauth2DenyGet', () async {
      // TODO
    });

    //Future<MwOAuth2Token> oauth2TokenPost(String grantType, int clientId, { String clientSecret, String code, String redirectUri, String codeVerifier, String refreshToken, String username, String password }) async
    test('test oauth2TokenPost', () async {
      // TODO
    });

  });
}
