part of openapi.api;



class UserApi {
  final ApiClient apiClient;

  UserApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Deletes a user and there lists
  Future<Response> deleteUserWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/user/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    List<String> authNames = ["basicAuth", "bearerAuth"];

    if(nullableContentType != null && nullableContentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'DELETE',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             nullableContentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// Deletes a user and there lists
  Future<HttpResponseMessage> deleteUser(String uuid) async {
    Response response = await deleteUserWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpResponseMessage') as HttpResponseMessage;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Login with idToken, mostly to support mobile devices.
  Future<Response> loginWithIdpIdTokenWithHttpInfo(HttpUserLoginIDPInput httpUserLoginIDPInput) async {
    Object postBody = httpUserLoginIDPInput;

    // verify required params are set
    if(httpUserLoginIDPInput == null) {
     throw ApiException(400, "Missing required param: httpUserLoginIDPInput");
    }

    // create path and map variables
    String path = "/user/login/idp".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    List<String> authNames = [];

    if(nullableContentType != null && nullableContentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             nullableContentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// Login with idToken, mostly to support mobile devices.
  Future<HttpUserLoginResponse> loginWithIdpIdToken(HttpUserLoginIDPInput httpUserLoginIDPInput) async {
    Response response = await loginWithIdpIdTokenWithHttpInfo(httpUserLoginIDPInput);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpUserLoginResponse') as HttpUserLoginResponse;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Login with username and password. The token can be used in future api requests via bearerAuth
  Future<Response> loginWithUsernameAndPasswordWithHttpInfo(HttpUserLoginRequest httpUserLoginRequest) async {
    Object postBody = httpUserLoginRequest;

    // verify required params are set
    if(httpUserLoginRequest == null) {
     throw ApiException(400, "Missing required param: httpUserLoginRequest");
    }

    // create path and map variables
    String path = "/user/login".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    List<String> authNames = [];

    if(nullableContentType != null && nullableContentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             nullableContentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// Login with username and password. The token can be used in future api requests via bearerAuth
  Future<HttpUserLoginResponse> loginWithUsernameAndPassword(HttpUserLoginRequest httpUserLoginRequest) async {
    Response response = await loginWithUsernameAndPasswordWithHttpInfo(httpUserLoginRequest);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpUserLoginResponse') as HttpUserLoginResponse;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Single or many updates to the users information
  Future patchUserInfoWithHttpInfo(String uuid, HttpUserInfoInput httpUserInfoInput) async {
    Object postBody = httpUserInfoInput;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }
    if(httpUserInfoInput == null) {
     throw ApiException(400, "Missing required param: httpUserInfoInput");
    }

    // create path and map variables
    String path = "/user/info/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    List<String> authNames = ["basicAuth", "bearerAuth"];

    if(nullableContentType != null && nullableContentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'PATCH',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             nullableContentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// Single or many updates to the users information
  Future patchUserInfo(String uuid, HttpUserInfoInput httpUserInfoInput) async {
    Response response = await patchUserInfoWithHttpInfo(uuid, httpUserInfoInput);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// Register a new user with username and password
  Future<Response> registerUserWithUsernameAndPasswordWithHttpInfo(HttpUserRegisterInput httpUserRegisterInput, { String xUserRegister }) async {
    Object postBody = httpUserRegisterInput;

    // verify required params are set
    if(httpUserRegisterInput == null) {
     throw ApiException(400, "Missing required param: httpUserRegisterInput");
    }

    // create path and map variables
    String path = "/user/register".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    headerParams["x-user-register"] = xUserRegister;

    List<String> contentTypes = ["application/json"];

    String nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    List<String> authNames = ["basicAuth", "bearerAuth"];

    if(nullableContentType != null && nullableContentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             nullableContentType,
                                             authNames);
    return response;
  }

  /// 
  ///
  /// Register a new user with username and password
  Future<HttpUserRegisterResponse> registerUserWithUsernameAndPassword(HttpUserRegisterInput httpUserRegisterInput, { String xUserRegister }) async {
    Response response = await registerUserWithUsernameAndPasswordWithHttpInfo(httpUserRegisterInput,  xUserRegister: xUserRegister );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpUserRegisterResponse') as HttpUserRegisterResponse;
    } else {
      return null;
    }
  }

}
