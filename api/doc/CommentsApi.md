# mindwell_api.api.CommentsApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**commentsGet**](CommentsApi.md#commentsget) | **GET** /comments | 
[**commentsIdComplainPost**](CommentsApi.md#commentsidcomplainpost) | **POST** /comments/{id}/complain | 
[**commentsIdDelete**](CommentsApi.md#commentsiddelete) | **DELETE** /comments/{id} | 
[**commentsIdGet**](CommentsApi.md#commentsidget) | **GET** /comments/{id} | 
[**commentsIdPut**](CommentsApi.md#commentsidput) | **PUT** /comments/{id} | 
[**entriesIdCommentatorGet**](CommentsApi.md#entriesidcommentatorget) | **GET** /entries/{id}/commentator | 
[**entriesIdCommentsGet**](CommentsApi.md#entriesidcommentsget) | **GET** /entries/{id}/comments | 
[**entriesIdCommentsPost**](CommentsApi.md#entriesidcommentspost) | **POST** /entries/{id}/comments | 


# **commentsGet**
> MwCommentList commentsGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.commentsGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->commentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwCommentList**](MwCommentList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **commentsIdComplainPost**
> commentsIdComplainPost(id, content)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    api.commentsIdComplainPost(id, content);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->commentsIdComplainPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **content** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **commentsIdDelete**
> commentsIdDelete(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 

try {
    api.commentsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->commentsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **commentsIdGet**
> MwComment commentsIdGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 

try {
    final response = api.commentsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->commentsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwComment**](MwComment.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **commentsIdPut**
> MwComment commentsIdPut(id, content)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    final response = api.commentsIdPut(id, content);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->commentsIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **content** | **String**|  | 

### Return type

[**MwComment**](MwComment.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdCommentatorGet**
> MwUser entriesIdCommentatorGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdCommentatorGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->entriesIdCommentatorGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwUser**](MwUser.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdCommentsGet**
> MwCommentList entriesIdCommentsGet(id, limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.entriesIdCommentsGet(id, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->entriesIdCommentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwCommentList**](MwCommentList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdCommentsPost**
> MwComment entriesIdCommentsPost(id, content)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getCommentsApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    final response = api.entriesIdCommentsPost(id, content);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->entriesIdCommentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **content** | **String**|  | 

### Return type

[**MwComment**](MwComment.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

