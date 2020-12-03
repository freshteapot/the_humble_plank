import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

import 'package:openapi/api.dart';

abstract class MobileRepository {
  Future<bool> registerDevice(String token);
}

class RemoteMobileRepository implements MobileRepository {
  final MobileApi mobileApi;
  final ApiClient apiClient;

  RemoteMobileRepository({@required this.mobileApi, @required this.apiClient});

  Future<bool> registerDevice(String token) async {
    var input = HttpMobileRegisterInput();
    input.token = token;
    Response response = await mobileApi.registerDeviceWithHttpInfo(input);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
