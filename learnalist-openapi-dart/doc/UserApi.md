# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://learnalist.net/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteUser**](UserApi.md#deleteUser) | **DELETE** /user/{uuid} | 
[**loginWithIdpIdToken**](UserApi.md#loginWithIdpIdToken) | **POST** /user/login/idp | 
[**loginWithUsernameAndPassword**](UserApi.md#loginWithUsernameAndPassword) | **POST** /user/login | 
[**patchUserInfo**](UserApi.md#patchUserInfo) | **PATCH** /user/info/{uuid} | 
[**registerUserWithUsernameAndPassword**](UserApi.md#registerUserWithUsernameAndPassword) | **POST** /user/register | 


# **deleteUser**
> HttpResponseMessage deleteUser(uuid)



Deletes a user and there lists

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

var api_instance = UserApi();
var uuid = uuid_example; // String | UUID of entry

try { 
    var result = api_instance.deleteUser(uuid);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->deleteUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**| UUID of entry | [default to null]

### Return type

[**HttpResponseMessage**](HttpResponseMessage.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loginWithIdpIdToken**
> HttpUserLoginResponse loginWithIdpIdToken(httpUserLoginIDPInput)



Login with idToken, mostly to support mobile devices.

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var httpUserLoginIDPInput = HttpUserLoginIDPInput(); // HttpUserLoginIDPInput | Based on the idp, we will verify your id_token and log you in.

try { 
    var result = api_instance.loginWithIdpIdToken(httpUserLoginIDPInput);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->loginWithIdpIdToken: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **httpUserLoginIDPInput** | [**HttpUserLoginIDPInput**](HttpUserLoginIDPInput.md)| Based on the idp, we will verify your id_token and log you in. | 

### Return type

[**HttpUserLoginResponse**](HttpUserLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loginWithUsernameAndPassword**
> HttpUserLoginResponse loginWithUsernameAndPassword(httpUserLoginRequest)



Login with username and password. The token can be used in future api requests via bearerAuth

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var httpUserLoginRequest = HttpUserLoginRequest(); // HttpUserLoginRequest | Username and password

try { 
    var result = api_instance.loginWithUsernameAndPassword(httpUserLoginRequest);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->loginWithUsernameAndPassword: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **httpUserLoginRequest** | [**HttpUserLoginRequest**](HttpUserLoginRequest.md)| Username and password | 

### Return type

[**HttpUserLoginResponse**](HttpUserLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchUserInfo**
> patchUserInfo(uuid, httpUserInfoInput)



Single or many updates to the users information

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

var api_instance = UserApi();
var uuid = uuid_example; // String | UUID of user to modify
var httpUserInfoInput = HttpUserInfoInput(); // HttpUserInfoInput | Allowed attributes to update

try { 
    api_instance.patchUserInfo(uuid, httpUserInfoInput);
} catch (e) {
    print("Exception when calling UserApi->patchUserInfo: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**| UUID of user to modify | [default to null]
 **httpUserInfoInput** | [**HttpUserInfoInput**](HttpUserInfoInput.md)| Allowed attributes to update | 

### Return type

void (empty response body)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerUserWithUsernameAndPassword**
> HttpUserRegisterResponse registerUserWithUsernameAndPassword(httpUserRegisterInput)



Register a new user with username and password

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

var api_instance = UserApi();
var httpUserRegisterInput = HttpUserRegisterInput(); // HttpUserRegisterInput | Username and password

try { 
    var result = api_instance.registerUserWithUsernameAndPassword(httpUserRegisterInput);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->registerUserWithUsernameAndPassword: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **httpUserRegisterInput** | [**HttpUserRegisterInput**](HttpUserRegisterInput.md)| Username and password | 

### Return type

[**HttpUserRegisterResponse**](HttpUserRegisterResponse.md)

### Authorization

[basicAuth](../README.md#basicAuth), [bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

