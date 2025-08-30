# mindwell.api.EntriesApi

## Load the API package
```dart
import 'package:mindwell/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**entriesBestGet**](EntriesApi.md#entriesbestget) | **GET** /entries/best | 
[**entriesFriendsGet**](EntriesApi.md#entriesfriendsget) | **GET** /entries/friends | 
[**entriesIdAdjacentGet**](EntriesApi.md#entriesidadjacentget) | **GET** /entries/{id}/adjacent | 
[**entriesIdComplainPost**](EntriesApi.md#entriesidcomplainpost) | **POST** /entries/{id}/complain | 
[**entriesIdDelete**](EntriesApi.md#entriesiddelete) | **DELETE** /entries/{id} | 
[**entriesIdGet**](EntriesApi.md#entriesidget) | **GET** /entries/{id} | 
[**entriesIdPut**](EntriesApi.md#entriesidput) | **PUT** /entries/{id} | 
[**entriesLiveGet**](EntriesApi.md#entriesliveget) | **GET** /entries/live | 
[**entriesRandomGet**](EntriesApi.md#entriesrandomget) | **GET** /entries/random | 
[**entriesTagsGet**](EntriesApi.md#entriestagsget) | **GET** /entries/tags | 
[**entriesWatchingGet**](EntriesApi.md#entrieswatchingget) | **GET** /entries/watching | 


# **entriesBestGet**
> MwFeed entriesBestGet(limit, tag, query, source_, category)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int limit = 56; // int | 
final String tag = tag_example; // String | 
final String query = query_example; // String | 
final String source_ = source__example; // String | 
final String category = category_example; // String | 

try {
    final response = api.entriesBestGet(limit, tag, query, source_, category);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesBestGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **tag** | **String**|  | [optional] 
 **query** | **String**|  | [optional] 
 **source_** | **String**|  | [optional] [default to 'all']
 **category** | **String**|  | [optional] [default to 'month']

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesFriendsGet**
> MwFeed entriesFriendsGet(limit, after, before, tag, query)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String tag = tag_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.entriesFriendsGet(limit, after, before, tag, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesFriendsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 
 **tag** | **String**|  | [optional] 
 **query** | **String**|  | [optional] 

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdAdjacentGet**
> MwAdjacentEntries entriesIdAdjacentGet(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdAdjacentGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesIdAdjacentGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwAdjacentEntries**](MwAdjacentEntries.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdComplainPost**
> entriesIdComplainPost(id, content)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    api.entriesIdComplainPost(id, content);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesIdComplainPost: $e\n');
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

# **entriesIdDelete**
> entriesIdDelete(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int id = 789; // int | 

try {
    api.entriesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesIdDelete: $e\n');
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

# **entriesIdGet**
> MwEntry entriesIdGet(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwEntry**](MwEntry.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdPut**
> MwEntry entriesIdPut(id, content, privacy, title, images, tags, visibleFor, isCommentable, isVotable, inLive, isShared, anonymousComments)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int id = 789; // int | 
final String content = content_example; // String | 
final String privacy = privacy_example; // String | 
final String title = title_example; // String | 
final BuiltSet<int> images = ; // BuiltSet<int> | 
final BuiltSet<String> tags = ; // BuiltSet<String> | 
final BuiltList<int> visibleFor = ; // BuiltList<int> | 
final bool isCommentable = true; // bool | 
final bool isVotable = true; // bool | 
final bool inLive = true; // bool | 
final bool isShared = true; // bool | 
final bool anonymousComments = true; // bool | 

try {
    final response = api.entriesIdPut(id, content, privacy, title, images, tags, visibleFor, isCommentable, isVotable, inLive, isShared, anonymousComments);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **content** | **String**|  | 
 **privacy** | **String**|  | 
 **title** | **String**|  | [optional] 
 **images** | [**BuiltSet&lt;int&gt;**](int.md)|  | [optional] 
 **tags** | [**BuiltSet&lt;String&gt;**](String.md)|  | [optional] 
 **visibleFor** | [**BuiltList&lt;int&gt;**](int.md)|  | [optional] 
 **isCommentable** | **bool**|  | [optional] [default to true]
 **isVotable** | **bool**|  | [optional] [default to false]
 **inLive** | **bool**|  | [optional] [default to false]
 **isShared** | **bool**|  | [optional] [default to false]
 **anonymousComments** | **bool**|  | [optional] [default to false]

### Return type

[**MwEntry**](MwEntry.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesLiveGet**
> MwFeed entriesLiveGet(limit, after, before, tag, query, source_, section)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String tag = tag_example; // String | 
final String query = query_example; // String | 
final String source_ = source__example; // String | 
final String section = section_example; // String | 

try {
    final response = api.entriesLiveGet(limit, after, before, tag, query, source_, section);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesLiveGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 
 **tag** | **String**|  | [optional] 
 **query** | **String**|  | [optional] 
 **source_** | **String**|  | [optional] [default to 'all']
 **section** | **String**|  | [optional] [default to 'entries']

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesRandomGet**
> MwEntry entriesRandomGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();

try {
    final response = api.entriesRandomGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesRandomGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwEntry**](MwEntry.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesTagsGet**
> MwTagList entriesTagsGet(limit, query)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int limit = 56; // int | 
final String query = query_example; // String | 

try {
    final response = api.entriesTagsGet(limit, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesTagsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **query** | **String**|  | [optional] 

### Return type

[**MwTagList**](MwTagList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesWatchingGet**
> MwFeed entriesWatchingGet(limit, after, before)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getEntriesApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.entriesWatchingGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling EntriesApi->entriesWatchingGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

