part of openapi.api;



class AppSettingsApi {
  final ApiClient apiClient;

  AppSettingsApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  /// Enable or disable push notifications for spaced repetition in remindV1
  Future<Response> setRemindV1WithHttpInfo(AppSettingsRemindV1 appSettingsRemindV1) async {
    Object postBody = appSettingsRemindV1;

    // verify required params are set
    if(appSettingsRemindV1 == null) {
     throw ApiException(400, "Missing required param: appSettingsRemindV1");
    }

    // create path and map variables
    String path = "/app-settings/remind_v1".replaceAll("{format}","json");

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
  /// Enable or disable push notifications for spaced repetition in remindV1
  Future<AppSettingsRemindV1> setRemindV1(AppSettingsRemindV1 appSettingsRemindV1) async {
    Response response = await setRemindV1WithHttpInfo(appSettingsRemindV1);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'AppSettingsRemindV1') as AppSettingsRemindV1;
    } else {
      return null;
    }
  }

}
