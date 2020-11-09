import 'dart:core';
import 'package:http/http.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:openapi/api.dart';

abstract class UserRepository {
  Future<bool> setDisplayName(String uuid, String displayName);
}

class RemoteUserRepository implements UserRepository {
  final UserApi userApi;
  final ApiClient apiClient;

  RemoteUserRepository({@required this.userApi, @required this.apiClient});

  Future<bool> setDisplayName(String uuid, String displayName) async {
    var input = HttpUserInfoInput();
    input.displayName = displayName;
    Response response = await userApi.patchUserInfoWithHttpInfo(uuid, input);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
