# mindwell_api.api.Oauth2Api

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**oauth2AllowPost**](Oauth2Api.md#oauth2allowpost) | **POST** /oauth2/allow | only for internal usage
[**oauth2AppsIdGet**](Oauth2Api.md#oauth2appsidget) | **GET** /oauth2/apps/{id} | 
[**oauth2DenyGet**](Oauth2Api.md#oauth2denyget) | **GET** /oauth2/deny | only for internal usage
[**oauth2TokenPost**](Oauth2Api.md#oauth2tokenpost) | **POST** /oauth2/token | 


# **oauth2AllowPost**
> MwOauth2AllowPost200Response oauth2AllowPost(responseType, clientId, redirectUri, scope, state, codeChallenge, codeChallengeMethod)

only for internal usage

### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getOauth2Api();
final String responseType = responseType_example; // String | 
final int clientId = 56; // int | 
final String redirectUri = redirectUri_example; // String | 
final BuiltList<String> scope = ; // BuiltList<String> | 
final String state = state_example; // String | 
final String codeChallenge = codeChallenge_example; // String | 
final String codeChallengeMethod = codeChallengeMethod_example; // String | 

try {
    final response = api.oauth2AllowPost(responseType, clientId, redirectUri, scope, state, codeChallenge, codeChallengeMethod);
    print(response);
} catch on DioException (e) {
    print('Exception when calling Oauth2Api->oauth2AllowPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **responseType** | **String**|  | 
 **clientId** | **int**|  | 
 **redirectUri** | **String**|  | 
 **scope** | [**BuiltList&lt;String&gt;**](String.md)|  | 
 **state** | **String**|  | [optional] 
 **codeChallenge** | **String**|  | [optional] 
 **codeChallengeMethod** | **String**|  | [optional] 

### Return type

[**MwOauth2AllowPost200Response**](MwOauth2AllowPost200Response.md)

### Authorization

[OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **oauth2AppsIdGet**
> MwApp oauth2AppsIdGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getOauth2Api();
final int id = 789; // int | 

try {
    final response = api.oauth2AppsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling Oauth2Api->oauth2AppsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwApp**](MwApp.md)

### Authorization

[OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **oauth2DenyGet**
> oauth2DenyGet(clientId, redirectUri)

only for internal usage

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getOauth2Api();
final int clientId = 56; // int | 
final String redirectUri = redirectUri_example; // String | 

try {
    api.oauth2DenyGet(clientId, redirectUri);
} catch on DioException (e) {
    print('Exception when calling Oauth2Api->oauth2DenyGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **clientId** | **int**|  | 
 **redirectUri** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **oauth2TokenPost**
> MwOAuth2Token oauth2TokenPost(grantType, clientId, clientSecret, code, redirectUri, codeVerifier, refreshToken, username, password)



### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getOauth2Api();
final String grantType = grantType_example; // String | 
final int clientId = 56; // int | 
final String clientSecret = clientSecret_example; // String | 
final String code = code_example; // String | 
final String redirectUri = redirectUri_example; // String | 
final String codeVerifier = codeVerifier_example; // String | 
final String refreshToken = refreshToken_example; // String | 
final String username = username_example; // String | 
final String password = password_example; // String | 

try {
    final response = api.oauth2TokenPost(grantType, clientId, clientSecret, code, redirectUri, codeVerifier, refreshToken, username, password);
    print(response);
} catch on DioException (e) {
    print('Exception when calling Oauth2Api->oauth2TokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **grantType** | **String**|  | 
 **clientId** | **int**|  | 
 **clientSecret** | **String**|  | [optional] 
 **code** | **String**|  | [optional] 
 **redirectUri** | **String**|  | [optional] 
 **codeVerifier** | **String**|  | [optional] 
 **refreshToken** | **String**|  | [optional] 
 **username** | **String**|  | [optional] 
 **password** | **String**|  | [optional] 

### Return type

[**MwOAuth2Token**](MwOAuth2Token.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

