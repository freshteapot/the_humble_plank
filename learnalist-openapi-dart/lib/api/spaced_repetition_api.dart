part of openapi.api;



class SpacedRepetitionApi {
  final ApiClient apiClient;

  SpacedRepetitionApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Add entry for spaced based learning
  Future<Response> addSpacedRepetitionEntryWithHttpInfo(Object body) async {
    Object postBody = body;

    // verify required params are set
    if(body == null) {
     throw ApiException(400, "Missing required param: body");
    }

    // create path and map variables
    String path = "/spaced-repetition/".replaceAll("{format}","json");

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
  /// Add entry for spaced based learning
  Future<Object> addSpacedRepetitionEntry(Object body) async {
    Response response = await addSpacedRepetitionEntryWithHttpInfo(body);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Object') as Object;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Deletes a single entry based on the UUID
  Future deleteSpacedRepetitionEntryWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/spaced-repetition/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Deletes a single entry based on the UUID
  Future deleteSpacedRepetitionEntry(String uuid) async {
    Response response = await deleteSpacedRepetitionEntryWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// Get next entry for spaced based learning
  Future<Response> getNextSpacedRepetitionEntryWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/spaced-repetition/next".replaceAll("{format}","json");

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
  /// Get next entry for spaced based learning
  Future<Object> getNextSpacedRepetitionEntry() async {
    Response response = await getNextSpacedRepetitionEntryWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Object') as Object;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Get all entries for spaced repetition learning
  Future<Response> getSpacedRepetitionEntriesWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/spaced-repetition/all".replaceAll("{format}","json");

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
  /// Get all entries for spaced repetition learning
  Future<List<Object>> getSpacedRepetitionEntries() async {
    Response response = await getSpacedRepetitionEntriesWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<Object>') as List).map((item) => item as Object).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Update spaced entry with feedback from the user
  Future<Response> updateSpacedRepetitionEntryWithHttpInfo(SpacedRepetitionEntryViewed spacedRepetitionEntryViewed) async {
    Object postBody = spacedRepetitionEntryViewed;

    // verify required params are set
    if(spacedRepetitionEntryViewed == null) {
     throw ApiException(400, "Missing required param: spacedRepetitionEntryViewed");
    }

    // create path and map variables
    String path = "/spaced-repetition/viewed".replaceAll("{format}","json");

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
  /// Update spaced entry with feedback from the user
  Future<Object> updateSpacedRepetitionEntry(SpacedRepetitionEntryViewed spacedRepetitionEntryViewed) async {
    Response response = await updateSpacedRepetitionEntryWithHttpInfo(spacedRepetitionEntryViewed);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Object') as Object;
    } else {
      return null;
    }
  }

}
