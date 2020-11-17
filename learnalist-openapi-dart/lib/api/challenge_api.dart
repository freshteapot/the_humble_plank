part of openapi.api;



class ChallengeApi {
  final ApiClient apiClient;

  ChallengeApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Create a new challenge
  Future<Response> createChallengeWithHttpInfo(ChallengeInput challengeInput) async {
    Object postBody = challengeInput;

    // verify required params are set
    if(challengeInput == null) {
     throw ApiException(400, "Missing required param: challengeInput");
    }

    // create path and map variables
    String path = "/challenge/".replaceAll("{format}","json");

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
  /// Create a new challenge
  Future<ChallengeShortInfo> createChallenge(ChallengeInput challengeInput) async {
    Response response = await createChallengeWithHttpInfo(challengeInput);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'ChallengeShortInfo') as ChallengeShortInfo;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Delete a challenge, forever
  Future deleteChallengeWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/challenge/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Delete a challenge, forever
  Future deleteChallenge(String uuid) async {
    Response response = await deleteChallengeWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// Get all challenge info, users and records
  Future<Response> getChallengeWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/challenge/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Get all challenge info, users and records
  Future<ChallengeInfo> getChallenge(String uuid) async {
    Response response = await getChallengeWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'ChallengeInfo') as ChallengeInfo;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Get all challenges for a given user
  Future<Response> getChallengesByUserWithHttpInfo(String userUUID) async {
    Object postBody;

    // verify required params are set
    if(userUUID == null) {
     throw ApiException(400, "Missing required param: userUUID");
    }

    // create path and map variables
    String path = "/challenges/{userUUID}".replaceAll("{format}","json").replaceAll("{" + "userUUID" + "}", userUUID.toString());

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
  /// Get all challenges for a given user
  Future<List<ChallengeShortInfo>> getChallengesByUser(String userUUID) async {
    Response response = await getChallengesByUserWithHttpInfo(userUUID);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<ChallengeShortInfo>') as List).map((item) => item as ChallengeShortInfo).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Join a challenge
  Future joinChallengeWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/challenge/{uuid}/join".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
                                             'PUT',
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
  /// Join a challenge
  Future joinChallenge(String uuid) async {
    Response response = await joinChallengeWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// Leave a challenge
  Future leaveChallengeWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/challenge/{uuid}/leave".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
                                             'PUT',
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
  /// Leave a challenge
  Future leaveChallenge(String uuid) async {
    Response response = await leaveChallengeWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

}
