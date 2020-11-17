part of openapi.api;



class PlankApi {
  final ApiClient apiClient;

  PlankApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Add plank stats
  Future<Response> addPlankEntryWithHttpInfo(Plank plank, { String xChallenge }) async {
    Object postBody = plank;

    // verify required params are set
    if(plank == null) {
     throw ApiException(400, "Missing required param: plank");
    }

    // create path and map variables
    String path = "/plank/".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    headerParams["x-challenge"] = xChallenge;

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
  /// Add plank stats
  Future<Plank> addPlankEntry(Plank plank, { String xChallenge }) async {
    Response response = await addPlankEntryWithHttpInfo(plank,  xChallenge: xChallenge );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Plank') as Plank;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Delete a single entry based on the UUID
  Future deletePlankEntryWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/plank/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Delete a single entry based on the UUID
  Future deletePlankEntry(String uuid) async {
    Response response = await deletePlankEntryWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// Get all planks for a given user
  Future<Response> getPlankHistoryByUserWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/plank/history".replaceAll("{format}","json");

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
  /// Get all planks for a given user
  Future<List<Plank>> getPlankHistoryByUser() async {
    Response response = await getPlankHistoryByUserWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<Plank>') as List).map((item) => item as Plank).toList();
    } else {
      return null;
    }
  }

}
