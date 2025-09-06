import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for RelationsApi
void main() {
  final instance = MindwellApi().getRelationsApi();

  group(RelationsApi, () {
    // cancel following request or unsubscribe the user
    //
    //Future<MwRelationship> relationsFromNameDelete(String name) async
    test('test relationsFromNameDelete', () async {
      // TODO
    });

    //Future<MwRelationship> relationsFromNameGet(String name) async
    test('test relationsFromNameGet', () async {
      // TODO
    });

    // permit the user to follow you
    //
    //Future<MwRelationship> relationsFromNamePut(String name) async
    test('test relationsFromNamePut', () async {
      // TODO
    });

    //Future relationsInvitedNamePost(String name, String invite) async
    test('test relationsInvitedNamePost', () async {
      // TODO
    });

    //Future<MwRelationship> relationsToNameDelete(String name) async
    test('test relationsToNameDelete', () async {
      // TODO
    });

    //Future<MwRelationship> relationsToNameGet(String name) async
    test('test relationsToNameGet', () async {
      // TODO
    });

    //Future<MwRelationship> relationsToNamePut(String name, String r) async
    test('test relationsToNamePut', () async {
      // TODO
    });

  });
}
