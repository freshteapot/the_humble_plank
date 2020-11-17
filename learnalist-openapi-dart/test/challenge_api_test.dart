import 'package:openapi/api.dart';
import 'package:test/test.dart';


/// tests for ChallengeApi
void main() {
  var instance = ChallengeApi();

  group('tests for ChallengeApi', () {
    // Create a new challenge
    //
    //Future<ChallengeShortInfo> createChallenge(ChallengeInput challengeInput) async 
    test('test createChallenge', () async {
      // TODO
    });

    // Delete a challenge, forever
    //
    //Future deleteChallenge(String uuid) async 
    test('test deleteChallenge', () async {
      // TODO
    });

    // Get all challenge info, users and records
    //
    //Future<ChallengeInfo> getChallenge(String uuid) async 
    test('test getChallenge', () async {
      // TODO
    });

    // Get all challenges for a given user
    //
    //Future<List<ChallengeShortInfo>> getChallengesByUser(String userUUID) async 
    test('test getChallengesByUser', () async {
      // TODO
    });

    // Join a challenge
    //
    //Future joinChallenge(String uuid) async 
    test('test joinChallenge', () async {
      // TODO
    });

    // Leave a challenge
    //
    //Future leaveChallenge(String uuid) async 
    test('test leaveChallenge', () async {
      // TODO
    });

  });
}
