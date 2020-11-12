import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

const CredentialsLoginTypeGoogle = "google";
const CredentialsLoginTypeUsername = "username";
const CredentialsLoginTypeNone = "na";

class Credentials {
  HttpUserLoginResponse login;
  String serverBasePath;

  GoogleSignInAccount idpGoogle;
  String loginType;

  bool idpGoogleEnabled() => loginType == CredentialsLoginTypeGoogle;

  Credentials()
      : login = HttpUserLoginResponse(),
        serverBasePath = "",
        idpGoogle = null,
        loginType = CredentialsLoginTypeNone;

  factory Credentials.defaultValues() {
    var _credentials = Credentials();
    _credentials.login.token = "";
    _credentials.login.userUuid = "";
    _credentials.serverBasePath = "";
    _credentials.loginType = CredentialsLoginTypeNone;
    _credentials.idpGoogle = null;
    return _credentials;
  }
}

abstract class CredentialsRepository {
  Future<HttpUserLoginResponse> loginWithIdp(
      HttpUserLoginIDPInput input, String serverBasePath);

  Future<HttpUserLoginResponse> loginWithUsername(
      HttpUserLoginRequest input, String serverBasePath);
  Future<bool> saveCredentials(
      Credentials newCredentials, String serverBasePath);
  Future<Credentials> loadCredentials();
  Future<void> unloadCredentials();
  Credentials getCredentials();
  bool isLoggedIn();
  void setIdpGoogle(GoogleSignInAccount account);
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

  Future<HttpUserLoginResponse> loginWithIdp(
      HttpUserLoginIDPInput input, String serverBasePath) async {
    this.apiClient.basePath = serverBasePath;
    return await userApi.loginWithIdpIdToken(input);
  }

  Future<bool> saveCredentials(
      Credentials newCredentials, String serverBasePath) async {
    bool ok;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ok = await prefs.setString("token", newCredentials.login.token);
    print("Saving token $ok");
    ok = await prefs.setString("user_uuid", newCredentials.login.userUuid);
    print("Saving user_uuid $ok");
    ok = await prefs.setString("server_basepath", serverBasePath);
    print("Saving server_basepath $ok");
    ok = await prefs.setString("login_type", newCredentials.loginType);
    print("Saving login_type $ok");

    this
        .apiClient
        .getAuthentication<HttpBearerAuth>('bearerAuth')
        .setAccessToken(newCredentials.login.token);
    return true;
  }

  Future<void> unloadCredentials() async {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
      _credentials = Credentials.defaultValues();
      this
          .apiClient
          .getAuthentication<HttpBearerAuth>('bearerAuth')
          .setAccessToken("");
      return;
    });
  }

  Future<Credentials> loadCredentials() async {
    var prefs = await SharedPreferences.getInstance();
    Credentials credentials = Credentials.defaultValues();

    if (prefs.containsKey("token")) {
      credentials.login.token = prefs.getString("token");
    }

    if (prefs.containsKey("user_uuid")) {
      credentials.login.userUuid = prefs.getString("user_uuid");
    }

    if (prefs.containsKey("server_basepath")) {
      credentials.serverBasePath = prefs.getString("server_basepath");
    }

    if (prefs.containsKey("login_type")) {
      credentials.loginType = prefs.getString("login_type");
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

  bool isLoggedIn() {
    if (_credentials.idpGoogle != null) {
      return true;
    }

    return _credentials.login.token != "" ? true : false;
  }

  void setIdpGoogle(GoogleSignInAccount account) {
    _credentials.idpGoogle = account;
    if (_credentials.idpGoogle != null) {
      _credentials.login.userUuid = _credentials.idpGoogle.id;
    }
    _debugGoogle();
  }

  Future<void> _debugGoogle() async {
    if (_credentials.idpGoogle == null) {
      return;
    }
    print(_credentials.idpGoogle);
    var a = await _credentials.idpGoogle.authentication;
    print("idToken: ${a.idToken}");
    print("accessToken: ${a.accessToken}");
    print("serverAuthCode: ${a.serverAuthCode}");
  }
}
