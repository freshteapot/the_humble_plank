# openapi.api.RemindApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteRemindDailySettingsByAppIdentifier**](RemindApi.md#deleteRemindDailySettingsByAppIdentifier) | **DELETE** /remind/daily/{app_identifier} | 
[**getRemindDailySettingsByAppIdentifier**](RemindApi.md#getRemindDailySettingsByAppIdentifier) | **GET** /remind/daily/{app_identifier} | 
[**setRemindDailySetting**](RemindApi.md#setRemindDailySetting) | **PUT** /remind/daily/ | 


# **deleteRemindDailySettingsByAppIdentifier**
> HttpResponseMessage deleteRemindDailySettingsByAppIdentifier(appIdentifier)



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

var api_instance = RemindApi();
var appIdentifier = appIdentifier_example; // String | Via app_identifier which settings to remove

try { 
    var result = api_instance.deleteRemindDailySettingsByAppIdentifier(appIdentifier);
    print(result);
} catch (e) {
    print("Exception when calling RemindApi->deleteRemindDailySettingsByAppIdentifier: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appIdentifier** | **String**| Via app_identifier which settings to remove | [default to null]

### Return type

[**HttpResponseMessage**](HttpResponseMessage.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRemindDailySettingsByAppIdentifier**
> RemindDailySettings getRemindDailySettingsByAppIdentifier(appIdentifier)



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

var api_instance = RemindApi();
var appIdentifier = appIdentifier_example; // String | Via app_identifier which settings to remove

try { 
    var result = api_instance.getRemindDailySettingsByAppIdentifier(appIdentifier);
    print(result);
} catch (e) {
    print("Exception when calling RemindApi->getRemindDailySettingsByAppIdentifier: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appIdentifier** | **String**| Via app_identifier which settings to remove | [default to null]

### Return type

[**RemindDailySettings**](RemindDailySettings.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setRemindDailySetting**
> RemindDailySettings setRemindDailySetting(remindDailySettings)



Set remind settings for app_identifier

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

var api_instance = RemindApi();
var remindDailySettings = RemindDailySettings(); // RemindDailySettings | Remind settings

try { 
    var result = api_instance.setRemindDailySetting(remindDailySettings);
    print(result);
} catch (e) {
    print("Exception when calling RemindApi->setRemindDailySetting: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **remindDailySettings** | [**RemindDailySettings**](RemindDailySettings.md)| Remind settings | 

### Return type

[**RemindDailySettings**](RemindDailySettings.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

