# openapi.api.SpacedRepetitionApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addSpacedRepetitionEntry**](SpacedRepetitionApi.md#addSpacedRepetitionEntry) | **POST** /spaced-repetition/ | 
[**deleteSpacedRepetitionEntry**](SpacedRepetitionApi.md#deleteSpacedRepetitionEntry) | **DELETE** /spaced-repetition/{uuid} | 
[**getNextSpacedRepetitionEntry**](SpacedRepetitionApi.md#getNextSpacedRepetitionEntry) | **GET** /spaced-repetition/next | 
[**getSpacedRepetitionEntries**](SpacedRepetitionApi.md#getSpacedRepetitionEntries) | **GET** /spaced-repetition/all | 
[**updateSpacedRepetitionEntry**](SpacedRepetitionApi.md#updateSpacedRepetitionEntry) | **POST** /spaced-repetition/viewed | 


# **addSpacedRepetitionEntry**
> Object addSpacedRepetitionEntry(body)



Add entry for spaced based learning

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

var api_instance = SpacedRepetitionApi();
var body = Object(); // Object | Entry to add for spaced based learning

try { 
    var result = api_instance.addSpacedRepetitionEntry(body);
    print(result);
} catch (e) {
    print("Exception when calling SpacedRepetitionApi->addSpacedRepetitionEntry: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **Object**| Entry to add for spaced based learning | 

### Return type

[**Object**](Object.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSpacedRepetitionEntry**
> deleteSpacedRepetitionEntry(uuid)



Deletes a single entry based on the UUID

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

var api_instance = SpacedRepetitionApi();
var uuid = uuid_example; // String | UUID of entry

try { 
    api_instance.deleteSpacedRepetitionEntry(uuid);
} catch (e) {
    print("Exception when calling SpacedRepetitionApi->deleteSpacedRepetitionEntry: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**| UUID of entry | [default to null]

### Return type

void (empty response body)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNextSpacedRepetitionEntry**
> Object getNextSpacedRepetitionEntry()



Get next entry for spaced based learning

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

var api_instance = SpacedRepetitionApi();

try { 
    var result = api_instance.getNextSpacedRepetitionEntry();
    print(result);
} catch (e) {
    print("Exception when calling SpacedRepetitionApi->getNextSpacedRepetitionEntry: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSpacedRepetitionEntries**
> List<Object> getSpacedRepetitionEntries()



Get all entries for spaced repetition learning

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

var api_instance = SpacedRepetitionApi();

try { 
    var result = api_instance.getSpacedRepetitionEntries();
    print(result);
} catch (e) {
    print("Exception when calling SpacedRepetitionApi->getSpacedRepetitionEntries: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Object>**](Object.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSpacedRepetitionEntry**
> Object updateSpacedRepetitionEntry(spacedRepetitionEntryViewed)



Update spaced entry with feedback from the user

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

var api_instance = SpacedRepetitionApi();
var spacedRepetitionEntryViewed = SpacedRepetitionEntryViewed(); // SpacedRepetitionEntryViewed | Tell the system if we should move forward or backwards with the learning

try { 
    var result = api_instance.updateSpacedRepetitionEntry(spacedRepetitionEntryViewed);
    print(result);
} catch (e) {
    print("Exception when calling SpacedRepetitionApi->updateSpacedRepetitionEntry: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **spacedRepetitionEntryViewed** | [**SpacedRepetitionEntryViewed**](SpacedRepetitionEntryViewed.md)| Tell the system if we should move forward or backwards with the learning | 

### Return type

[**Object**](Object.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

