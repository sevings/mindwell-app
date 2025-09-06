import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for AccountApi
void main() {
  final instance = MindwellApi().getAccountApi();

  group(AccountApi, () {
    // check if email is used
    //
    //Future<MwAccountEmailEmailGet200Response> accountEmailEmailGet(String email) async
    test('test accountEmailEmailGet', () async {
      // TODO
    });

    // set new email
    //
    //Future accountEmailPost(String email, String password) async
    test('test accountEmailPost', () async {
      // TODO
    });

    //Future<MwAccountInvitesGet200Response> accountInvitesGet() async
    test('test accountInvitesGet', () async {
      // TODO
    });

    // check if name is used
    //
    //Future<MwAccountNameNameGet200Response> accountNameNameGet(String name) async
    test('test accountNameNameGet', () async {
      // TODO
    });

    // change new password
    //
    //Future accountPasswordPost(String oldPassword, String newPassword) async
    test('test accountPasswordPost', () async {
      // TODO
    });

    // reset password
    //
    //Future accountRecoverPasswordPost(String email, String password, int date, String code) async
    test('test accountRecoverPasswordPost', () async {
      // TODO
    });

    // request reset password email
    //
    //Future accountRecoverPost(String email) async
    test('test accountRecoverPost', () async {
      // TODO
    });

    // register new account
    //
    //Future<MwAuthProfile> accountRegisterPost(String email, String password, String name, { String birthday, String gender, String country, String city }) async
    test('test accountRegisterPost', () async {
      // TODO
    });

    //Future<MwAccountSettingsEmailGet200Response> accountSettingsEmailGet() async
    test('test accountSettingsEmailGet', () async {
      // TODO
    });

    //Future accountSettingsEmailPut({ bool comments, bool followers, bool invites, bool movedEntries, bool badges }) async
    test('test accountSettingsEmailPut', () async {
      // TODO
    });

    //Future<MwAccountSettingsOnsiteGet200Response> accountSettingsOnsiteGet() async
    test('test accountSettingsOnsiteGet', () async {
      // TODO
    });

    //Future accountSettingsOnsitePut({ bool wishes }) async
    test('test accountSettingsOnsitePut', () async {
      // TODO
    });

    //Future<MwAccountSettingsTelegramGet200Response> accountSettingsTelegramGet() async
    test('test accountSettingsTelegramGet', () async {
      // TODO
    });

    //Future accountSettingsTelegramPut({ bool comments, bool followers, bool invites, bool messages, bool movedEntries, bool badges }) async
    test('test accountSettingsTelegramPut', () async {
      // TODO
    });

    //Future accountSubscribeTelegramDelete() async
    test('test accountSubscribeTelegramDelete', () async {
      // TODO
    });

    //Future<MwAccountSubscribeTokenGet200Response> accountSubscribeTelegramGet() async
    test('test accountSubscribeTelegramGet', () async {
      // TODO
    });

    //Future<MwAccountSubscribeTokenGet200Response> accountSubscribeTokenGet() async
    test('test accountSubscribeTokenGet', () async {
      // TODO
    });

    // verify account email
    //
    //Future accountVerificationEmailGet(String email, String code) async
    test('test accountVerificationEmailGet', () async {
      // TODO
    });

    // request verification email
    //
    //Future accountVerificationPost() async
    test('test accountVerificationPost', () async {
      // TODO
    });

  });
}
