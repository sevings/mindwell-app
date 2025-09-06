import 'package:test/test.dart';
import 'package:mindwell_api/mindwell_api.dart';


/// tests for VotesApi
void main() {
  final instance = MindwellApi().getVotesApi();

  group(VotesApi, () {
    //Future<MwRating> commentsIdVoteDelete(int id) async
    test('test commentsIdVoteDelete', () async {
      // TODO
    });

    //Future<MwRating> commentsIdVoteGet(int id) async
    test('test commentsIdVoteGet', () async {
      // TODO
    });

    //Future<MwRating> commentsIdVotePut(int id, { bool positive }) async
    test('test commentsIdVotePut', () async {
      // TODO
    });

    //Future<MwRating> entriesIdVoteDelete(int id) async
    test('test entriesIdVoteDelete', () async {
      // TODO
    });

    //Future<MwRating> entriesIdVoteGet(int id) async
    test('test entriesIdVoteGet', () async {
      // TODO
    });

    //Future<MwRating> entriesIdVotePut(int id, { bool positive }) async
    test('test entriesIdVotePut', () async {
      // TODO
    });

  });
}
