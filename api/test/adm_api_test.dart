import 'package:test/test.dart';
import 'package:mindwell/mindwell.dart';


/// tests for AdmApi
void main() {
  final instance = Mindwell().getAdmApi();

  group(AdmApi, () {
    //Future<MwAdmGrandfatherGet200Response> admGrandfatherGet() async
    test('test admGrandfatherGet', () async {
      // TODO
    });

    //Future<MwAdmGrandsonStatusGet200Response> admGrandfatherStatusGet() async
    test('test admGrandfatherStatusGet', () async {
      // TODO
    });

    //Future admGrandfatherStatusPost({ bool sent, String tracking, String comment }) async
    test('test admGrandfatherStatusPost', () async {
      // TODO
    });

    //Future<MwAdmGrandsonGet200Response> admGrandsonGet() async
    test('test admGrandsonGet', () async {
      // TODO
    });

    //Future admGrandsonPost(String postcode, String country, String address, String name, { String phone, String comment, bool anonymous }) async
    test('test admGrandsonPost', () async {
      // TODO
    });

    //Future<MwAdmGrandsonStatusGet200Response> admGrandsonStatusGet() async
    test('test admGrandsonStatusGet', () async {
      // TODO
    });

    //Future admGrandsonStatusPost(bool received) async
    test('test admGrandsonStatusPost', () async {
      // TODO
    });

    //Future<MwAdmStatGet200Response> admStatGet() async
    test('test admStatGet', () async {
      // TODO
    });

  });
}
