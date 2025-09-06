import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for DesignApi
void main() {
  final instance = MindwellApi().getDesignApi();

  group(DesignApi, () {
    //Future<MwDesignFontsGet200Response> designFontsGet() async
    test('test designFontsGet', () async {
      // TODO
    });

    //Future<MwDesign> designGet() async
    test('test designGet', () async {
      // TODO
    });

    //Future<MwDesign> designPut(String textAlignment, { String css, String backgroundColor, String textColor, String fontFamily, int fontSize }) async
    test('test designPut', () async {
      // TODO
    });

  });
}
