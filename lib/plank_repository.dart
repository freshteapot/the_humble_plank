import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:openapi/api.dart';

abstract class PlankRepository {
  Future<List<Plank>> history();
  Future<bool> addEntry(Plank record, String challengeUuid);
}

class RemotePlankRepository implements PlankRepository {
  final PlankApi plankApi;
  final ApiClient apiClient;

  RemotePlankRepository({@required this.plankApi, @required this.apiClient});

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
