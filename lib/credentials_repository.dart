import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:openapi/api.dart';

class Credentials {
  HttpUserLoginResponse login;
  String serverBasePath;

  Credentials()
      : login = HttpUserLoginResponse(),
        serverBasePath = "";
}

abstract class CredentialsRepository {
  Future<HttpUserLoginResponse> loginWithUsername(
      HttpUserLoginRequest input, String serverBasePath);
  Future<bool> saveCredentials(
      HttpUserLoginResponse input, String serverBasePath);
  Future<Credentials> loadCredentials();
  Future<void> unloadCredentials();
  Credentials getCredentials();
}

class RemoteCredentialsRepository implements CredentialsRepository {
  final UserApi userApi;
  final ApiClient apiClient;

  RemoteCredentialsRepository(
      {@required this.userApi, @required this.apiClient});

  Future<HttpUserLoginResponse> loginWithUsername(
      HttpUserLoginRequest input, String serverBasePath) async {
    this.apiClient.basePath = serverBasePath;
    return await userApi.loginWithUsernameAndPassword(input);
  }

  Future<bool> saveCredentials(
      HttpUserLoginResponse input, String serverBasePath) async {
    bool ok;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ok = await prefs.setString("token", input.token);

    print(ok);
    ok = await prefs.setString("user_uuid", input.userUuid);
    print(ok);
    ok = await prefs.setString("server_basepath", serverBasePath);
    print(ok);

    this
        .apiClient
        .getAuthentication<HttpBearerAuth>('bearerAuth')
        .setAccessToken(input.token);
    return true;
  }

  Future<void> unloadCredentials() async {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
      _credentials = new Credentials();
      return;
    });
  }

  Future<Credentials> loadCredentials() async {
    var prefs = await SharedPreferences.getInstance();
    Credentials credentials = Credentials();

    if (prefs.containsKey("token")) {
      credentials.login.token = prefs.getString("token");
    }

    if (prefs.containsKey("user_uuid")) {
      credentials.login.userUuid = prefs.getString("user_uuid");
    }

    if (prefs.containsKey("server_basepath")) {
      credentials.serverBasePath = prefs.getString("server_basepath");
    }

    apiClient.basePath = credentials.serverBasePath;

    apiClient
        .getAuthentication<HttpBearerAuth>('bearerAuth')
        .setAccessToken(credentials.login.token);
    _credentials = credentials;
    return _credentials;
  }

  Credentials _credentials;

  Credentials getCredentials() {
    return _credentials;
  }
}
