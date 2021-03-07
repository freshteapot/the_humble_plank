part of openapi.api;



class RemindApi {
  final ApiClient apiClient;

  RemindApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// 
  Future<Response> deleteRemindDailySettingsByAppIdentifierWithHttpInfo(String appIdentifier) async {
    Object postBody;

    // verify required params are set
    if(appIdentifier == null) {
     throw ApiException(400, "Missing required param: appIdentifier");
    }

    // create path and map variables
    String path = "/remind/daily/{app_identifier}".replaceAll("{format}","json").replaceAll("{" + "app_identifier" + "}", appIdentifier.toString());

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
  /// 
  Future<HttpResponseMessage> deleteRemindDailySettingsByAppIdentifier(String appIdentifier) async {
    Response response = await deleteRemindDailySettingsByAppIdentifierWithHttpInfo(appIdentifier);
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
  /// 
  Future<Response> getRemindDailySettingsByAppIdentifierWithHttpInfo(String appIdentifier) async {
    Object postBody;

    // verify required params are set
    if(appIdentifier == null) {
     throw ApiException(400, "Missing required param: appIdentifier");
    }

    // create path and map variables
    String path = "/remind/daily/{app_identifier}".replaceAll("{format}","json").replaceAll("{" + "app_identifier" + "}", appIdentifier.toString());

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
  Future<RemindDailySettings> getRemindDailySettingsByAppIdentifier(String appIdentifier) async {
    Response response = await getRemindDailySettingsByAppIdentifierWithHttpInfo(appIdentifier);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'RemindDailySettings') as RemindDailySettings;
    } else {
      return null;
    }
  }

  ///  with HTTP info returned
  ///
  /// Set remind settings for app_identifier
  Future<Response> setRemindDailySettingWithHttpInfo(RemindDailySettings remindDailySettings) async {
    Object postBody = remindDailySettings;

    // verify required params are set
    if(remindDailySettings == null) {
     throw ApiException(400, "Missing required param: remindDailySettings");
    }

    // create path and map variables
    String path = "/remind/daily/".replaceAll("{format}","json");

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
  /// Set remind settings for app_identifier
  Future<RemindDailySettings> setRemindDailySetting(RemindDailySettings remindDailySettings) async {
    Response response = await setRemindDailySettingWithHttpInfo(remindDailySettings);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'RemindDailySettings') as RemindDailySettings;
    } else {
      return null;
    }
  }

}
