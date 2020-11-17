part of openapi.api;



class AssetApi {
  final ApiClient apiClient;

  AssetApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Upload asset and link it to the user logged in
  Future<Response> addUserAssetWithHttpInfo(MultipartFile file, { String sharedWith }) async {
    Object postBody;

    // verify required params are set
    if(file == null) {
     throw ApiException(400, "Missing required param: file");
    }

    // create path and map variables
    String path = "/assets/upload".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["multipart/form-data"];

    String nullableContentType = contentTypes.isNotEmpty ? contentTypes[0] : null;
    List<String> authNames = ["basicAuth", "bearerAuth"];

    if(nullableContentType != null && nullableContentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (sharedWith != null) {
        hasFields = true;
        mp.fields['shared_with'] = parameterToString(sharedWith);
      }
      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }
      if(hasFields)
        postBody = mp;
    }
    else {
      if (sharedWith != null)
        formParams['shared_with'] = parameterToString(sharedWith);
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
  /// Upload asset and link it to the user logged in
  Future<HttpAssetUploadResponse> addUserAsset(MultipartFile file, { String sharedWith }) async {
    Response response = await addUserAssetWithHttpInfo(file,  sharedWith: sharedWith );
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpAssetUploadResponse') as HttpAssetUploadResponse;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Deletes a single asset based on the UUID
  Future deleteAssetWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/assets/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// Deletes a single asset based on the UUID
  Future deleteAsset(String uuid) async {
    Response response = await deleteAssetWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// 
  Future getAssetWithHttpInfo(String uuid) async {
    Object postBody;

    // verify required params are set
    if(uuid == null) {
     throw ApiException(400, "Missing required param: uuid");
    }

    // create path and map variables
    String path = "/assets/{uuid}".replaceAll("{format}","json").replaceAll("{" + "uuid" + "}", uuid.toString());

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
  /// 
  Future getAsset(String uuid) async {
    Response response = await getAssetWithHttpInfo(uuid);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  ///  with HTTP info returned
  ///
  /// Set asset for public or private access
  Future<Response> shareAssetWithHttpInfo(HttpAssetShareRequestBody httpAssetShareRequestBody) async {
    Object postBody = httpAssetShareRequestBody;

    // verify required params are set
    if(httpAssetShareRequestBody == null) {
     throw ApiException(400, "Missing required param: httpAssetShareRequestBody");
    }

    // create path and map variables
    String path = "/assets/share".replaceAll("{format}","json");

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
  /// Set asset for public or private access
  Future<HttpResponseMessage> shareAsset(HttpAssetShareRequestBody httpAssetShareRequestBody) async {
    Response response = await shareAssetWithHttpInfo(httpAssetShareRequestBody);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'HttpResponseMessage') as HttpResponseMessage;
    } else {
      return null;
    }
  }

}
