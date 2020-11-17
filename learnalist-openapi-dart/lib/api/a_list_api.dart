part of openapi.api;



class AListApi {
  final ApiClient apiClient;

  AListApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// add a new list
  Future<Response> addListWithHttpInfo(AlistInput alistInput) async {
    Object postBody = alistInput;

    // verify required params are set
    if(alistInput == null) {
     throw ApiException(400, "Missing required param: alistInput");
    }

    // create path and map variables
    String path = "/alist".replaceAll("{format}","json");

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
  /// add a new list
  Future<Alist> addList(AlistInput alistInput) async {
    Response response = await addListWithHttpInfo(alistInput);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Alist') as Alist;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Delete a list
  Future<Response> deleteListByUuidWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/alist/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Delete a list
  Future<HttpResponseMessage> deleteListByUuid(String uuid) async {
    Response response = await deleteListByUuidWithHttpInfo(uuid);
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
  /// Get a list
  Future<Response> getListByUuidWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/alist/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Get a list
  Future<Alist> getListByUuid(String uuid) async {
    Response response = await getListByUuidWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Alist') as Alist;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Get lists by me
  Future<Response> getListsByMeWithHttpInfo({ String labels, String listType }) async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/alist/by/me".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if(labels != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "labels", labels));
    }
    if(listType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "list_type", listType));
    }

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
  /// Get lists by me
  Future<List<Alist>> getListsByMe({ String labels, String listType }) async {
    Response response = await getListsByMeWithHttpInfo( labels: labels, listType: listType );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<Alist>') as List).map((item) => item as Alist).toList();
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Update a list
  Future<Response> updateListByUuidWithHttpInfo(String uuid, Alist alist) async {
    Object postBody = alist;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }
    if(alist == null) {
     throw ApiException(400, "Missing required param: alist");
    }

    // create path and map variables
    String path = "/alist/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Update a list
  Future<Alist> updateListByUuid(String uuid, Alist alist) async {
    Response response = await updateListByUuidWithHttpInfo(uuid, alist);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Alist') as Alist;
    } else {
      return null;
    }
  }

}
