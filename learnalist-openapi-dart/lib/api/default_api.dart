part of openapi.api;



class DefaultApi {
  final ApiClient apiClient;

  DefaultApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Get information about the server, linked to the git repo
  Future<Response> getServerVersionWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/version".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

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
                                             'GET',
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
  /// Get information about the server, linked to the git repo
  Future<Version> getServerVersion() async {
    Response response = await getServerVersionWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Version') as Version;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Register the user and the token, to be able to send push notifications
  Future<Response> registerDeviceWithHttpInfo(HttpMobileRegisterInput httpMobileRegisterInput) async {
    Object postBody = httpMobileRegisterInput;

    // verify required params are set
    if(httpMobileRegisterInput == null) {
     throw ApiException(400, "Missing required param: httpMobileRegisterInput");
    }

    // create path and map variables
    String path = "/register-device".replaceAll("{format}","json");

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
  /// Register the user and the token, to be able to send push notifications
  Future<HttpResponseMessage> registerDevice(HttpMobileRegisterInput httpMobileRegisterInput) async {
    Response response = await registerDeviceWithHttpInfo(httpMobileRegisterInput);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpResponseMessage') as HttpResponseMessage;
    } else {
      return null;
    }
  }

}
