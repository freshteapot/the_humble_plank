# openapi.api.AppSettingsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**setRemindV1**](AppSettingsApi.md#setRemindV1) | **PUT** /app-settings/remind_v1 | 


# **setRemindV1**
> AppSettingsRemindV1 setRemindV1(appSettingsRemindV1)



Enable or disable push notifications for spaced repetition in remindV1

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP basic authorization: basicAuth
//defaultApiClient.getAuthentication<HttpBasicAuth>('basicAuth').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('basicAuth').password = 'YOUR_PASSWORD';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

var api_instance = AppSettingsApi();
var appSettingsRemindV1 = AppSettingsRemindV1(); // AppSettingsRemindV1 | Settings

try { 
    var result = api_instance.setRemindV1(appSettingsRemindV1);
    print(result);
} catch (e) {
    print("Exception when calling AppSettingsApi->setRemindV1: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appSettingsRemindV1** | [**AppSettingsRemindV1**](AppSettingsRemindV1.md)| Settings | 

### Return type

[**AppSettingsRemindV1**](AppSettingsRemindV1.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

