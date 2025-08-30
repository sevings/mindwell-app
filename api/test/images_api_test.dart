import 'package:test/test.dart';
import 'package:mindwell/mindwell.dart';


/// tests for ImagesApi
void main() {
  final instance = Mindwell().getImagesApi();

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
