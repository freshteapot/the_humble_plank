import 'package:openapi/api.dart';
import 'package:test/test.dart';


/// tests for UserApi
void main() {
  var instance = UserApi();

  group('tests for UserApi', () {
    // Deletes a user and there lists
    //
    //Future<HttpResponseMessage> deleteUser(String uuid) async 
    test('test deleteUser', () async {
      // TODO
    });

    // Login with idToken, mostly to support mobile devices.
    //
    //Future<HttpUserLoginResponse> loginWithIdpIdToken(HttpUserLoginIDPInput httpUserLoginIDPInput) async 
    test('test loginWithIdpIdToken', () async {
      // TODO
    });

    // Login with username and password. The token can be used in future api requests via bearerAuth
    //
    //Future<HttpUserLoginResponse> loginWithUsernameAndPassword(HttpUserLoginRequest httpUserLoginRequest) async 
    test('test loginWithUsernameAndPassword', () async {
      // TODO
    });

    // Single or many updates to the users information
    //
    //Future patchUserInfo(String uuid, HttpUserInfoInput httpUserInfoInput) async 
    test('test patchUserInfo', () async {
      // TODO
    });

    // Register a new user with username and password
    //
    //Future<HttpUserRegisterResponse> registerUserWithUsernameAndPassword(HttpUserRegisterInput httpUserRegisterInput) async 
    test('test registerUserWithUsernameAndPassword', () async {
      // TODO
    });

  });
}
