# mindwell_api.api.VotesApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**commentsIdVoteDelete**](VotesApi.md#commentsidvotedelete) | **DELETE** /comments/{id}/vote | 
[**commentsIdVoteGet**](VotesApi.md#commentsidvoteget) | **GET** /comments/{id}/vote | 
[**commentsIdVotePut**](VotesApi.md#commentsidvoteput) | **PUT** /comments/{id}/vote | 
[**entriesIdVoteDelete**](VotesApi.md#entriesidvotedelete) | **DELETE** /entries/{id}/vote | 
[**entriesIdVoteGet**](VotesApi.md#entriesidvoteget) | **GET** /entries/{id}/vote | 
[**entriesIdVotePut**](VotesApi.md#entriesidvoteput) | **PUT** /entries/{id}/vote | 


# **commentsIdVoteDelete**
> MwRating commentsIdVoteDelete(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getVotesApi();
final int id = 789; // int | 

try {
    final response = api.commentsIdVoteDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling VotesApi->commentsIdVoteDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwRating**](MwRating.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **commentsIdVoteGet**
> MwRating commentsIdVoteGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getVotesApi();
final int id = 789; // int | 

try {
    final response = api.commentsIdVoteGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling VotesApi->commentsIdVoteGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwRating**](MwRating.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **commentsIdVotePut**
> MwRating commentsIdVotePut(id, positive)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getVotesApi();
final int id = 789; // int | 
final bool positive = true; // bool | 

try {
    final response = api.commentsIdVotePut(id, positive);
    print(response);
} catch on DioException (e) {
    print('Exception when calling VotesApi->commentsIdVotePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **positive** | **bool**|  | [optional] [default to true]

### Return type

[**MwRating**](MwRating.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdVoteDelete**
> MwRating entriesIdVoteDelete(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getVotesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdVoteDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling VotesApi->entriesIdVoteDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwRating**](MwRating.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdVoteGet**
> MwRating entriesIdVoteGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getVotesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdVoteGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling VotesApi->entriesIdVoteGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwRating**](MwRating.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdVotePut**
> MwRating entriesIdVotePut(id, positive)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getVotesApi();
final int id = 789; // int | 
final bool positive = true; // bool | 

try {
    final response = api.entriesIdVotePut(id, positive);
    print(response);
} catch on DioException (e) {
    print('Exception when calling VotesApi->entriesIdVotePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **positive** | **bool**|  | [optional] [default to true]

### Return type

[**MwRating**](MwRating.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

