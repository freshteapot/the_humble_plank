# openapi.api.DefaultApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getServerVersion**](DefaultApi.md#getServerVersion) | **GET** /version | 


# **getServerVersion**
> Version getServerVersion()



Get information about the server, linked to the git repo

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = DefaultApi();

try { 
    var result = api_instance.getServerVersion();
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->getServerVersion: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Version**](Version.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

