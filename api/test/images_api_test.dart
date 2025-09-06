import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for ImagesApi
void main() {
  final instance = MindwellApi().getImagesApi();

  group(ImagesApi, () {
    //Future<MwImage> imagesFindGet(String link) async
    test('test imagesFindGet', () async {
      // TODO
    });

    //Future imagesIdDelete(int id) async
    test('test imagesIdDelete', () async {
      // TODO
    });

    //Future<MwImage> imagesIdGet(int id) async
    test('test imagesIdGet', () async {
      // TODO
    });

    //Future<MwImage> imagesPost(MultipartFile file) async
    test('test imagesPost', () async {
      // TODO
    });

  });
}
