import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:openapi/api.dart';
import 'package:the_humble_plank/credentials_repository.dart';

class PlankRepository extends ChangeNotifier {
  final PlankApi plankApi;
  final ApiClient apiClient;

  PlankRepository({@required this.plankApi, @required this.apiClient});

  Future<Credentials> loadCredentials() async {
    var prefs = await SharedPreferences.getInstance();
    Credentials credentials = new Credentials();

    credentials.login.token = prefs.getString("token");
    credentials.login.userUuid = prefs.getString("user_uuid");
    credentials.serverBasePath = prefs.getString("server_basepath");

    if (credentials.serverBasePath != null) {
      apiClient.basePath = credentials.serverBasePath;
    }

    if (credentials.login.token != null) {
      apiClient
          .getAuthentication<HttpBearerAuth>('bearerAuth')
          .setAccessToken(credentials.login.token);
    }

    return credentials;
  }

  Future<List<Plank>> history() async {
    return await plankApi.getPlankHistoryByUser();
  }

  Future<bool> addEntry(Plank record, String challengeUuid) async {
    try {
      var response = await plankApi.addPlankEntryWithHttpInfo(record,
          xChallenge: challengeUuid);
      if (response.statusCode > 201) {
        return false;
      }
      return true;
    } catch (error) {
      print(error);
      print((error as ApiException).code);
      return false;
    }
  }
}
