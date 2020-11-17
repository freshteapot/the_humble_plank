# openapi.api.AListApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addList**](AListApi.md#addList) | **POST** /alist | 
[**deleteListByUuid**](AListApi.md#deleteListByUuid) | **DELETE** /alist/{uuid} | 
[**getListByUuid**](AListApi.md#getListByUuid) | **GET** /alist/{uuid} | 
[**getListsByMe**](AListApi.md#getListsByMe) | **GET** /alist/by/me | 
[**updateListByUuid**](AListApi.md#updateListByUuid) | **PUT** /alist/{uuid} | 


# **addList**
> Alist addList(alistInput)



add a new list

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

var api_instance = AListApi();
var alistInput = AlistInput(); // AlistInput | A list object

try { 
    var result = api_instance.addList(alistInput);
    print(result);
} catch (e) {
    print("Exception when calling AListApi->addList: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **alistInput** | [**AlistInput**](AlistInput.md)| A list object | 

### Return type

[**Alist**](Alist.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteListByUuid**
> HttpResponseMessage deleteListByUuid(uuid)



Delete a list

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

var api_instance = AListApi();
var uuid = uuid_example; // String | UUID of list

try { 
    var result = api_instance.deleteListByUuid(uuid);
    print(result);
} catch (e) {
    print("Exception when calling AListApi->deleteListByUuid: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**| UUID of list | [default to null]

### Return type

[**HttpResponseMessage**](HttpResponseMessage.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getListByUuid**
> Alist getListByUuid(uuid)



Get a list

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

var api_instance = AListApi();
var uuid = uuid_example; // String | UUID of list

try { 
    var result = api_instance.getListByUuid(uuid);
    print(result);
} catch (e) {
    print("Exception when calling AListApi->getListByUuid: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**| UUID of list | [default to null]

### Return type

[**Alist**](Alist.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getListsByMe**
> List<Alist> getListsByMe(labels, listType)



Get lists by me

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

var api_instance = AListApi();
var labels = labels_example; // String | Filter your lists by one or many labels. \"seperated by ,\".
var listType = listType_example; // String | Filter your lists by type v1, v2 etc

try { 
    var result = api_instance.getListsByMe(labels, listType);
    print(result);
} catch (e) {
    print("Exception when calling AListApi->getListsByMe: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **labels** | **String**| Filter your lists by one or many labels. \&quot;seperated by ,\&quot;. | [optional] [default to null]
 **listType** | **String**| Filter your lists by type v1, v2 etc | [optional] [default to null]

### Return type

[**List<Alist>**](Alist.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateListByUuid**
> Alist updateListByUuid(uuid, alist)



Update a list

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

var api_instance = AListApi();
var uuid = uuid_example; // String | UUID of list
var alist = Alist(); // Alist | List to update

try { 
    var result = api_instance.updateListByUuid(uuid, alist);
    print(result);
} catch (e) {
    print("Exception when calling AListApi->updateListByUuid: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**| UUID of list | [default to null]
 **alist** | [**Alist**](Alist.md)| List to update | 

### Return type

[**Alist**](Alist.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

