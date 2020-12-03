# openapi.api.MobileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**registerDevice**](MobileApi.md#registerDevice) | **POST** /mobile/register-device | 


# **registerDevice**
> HttpResponseMessage registerDevice(httpMobileRegisterInput)



Register the user and the token, to be able to send push notifications

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

var api_instance = MobileApi();
var httpMobileRegisterInput = HttpMobileRegisterInput(); // HttpMobileRegisterInput | Device information

try { 
    var result = api_instance.registerDevice(httpMobileRegisterInput);
    print(result);
} catch (e) {
    print("Exception when calling MobileApi->registerDevice: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **httpMobileRegisterInput** | [**HttpMobileRegisterInput**](HttpMobileRegisterInput.md)| Device information | 

### Return type

[**HttpResponseMessage**](HttpResponseMessage.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

