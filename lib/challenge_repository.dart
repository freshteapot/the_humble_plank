import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

import 'package:openapi/api.dart';

class ChallengeRepository extends ChangeNotifier {
  final ChallengeApi challengeApi;
  final ApiClient apiClient;

  ChallengeRepository({@required this.challengeApi, @required this.apiClient});

  Future<ChallengeInfo> getChallenge(String uuid) async {
    return await challengeApi.getChallenge(uuid);
  }

  Future<ChallengeShortInfo> createChallenge(ChallengeInput input) async {
    return await challengeApi.createChallenge(input);
  }

  Future<List<ChallengeShortInfo>> getChallengesByUser(String userUUID) async {
    return await challengeApi.getChallengesByUser(userUUID);
  }

  Future<bool> joinChallenge(String uuid) async {
    Response response = await challengeApi.joinChallengeWithHttpInfo(uuid);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> leaveChallenge(String uuid) async {
    Response response = await challengeApi.leaveChallengeWithHttpInfo(uuid);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
