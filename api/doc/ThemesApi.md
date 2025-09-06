# mindwell_api.api.ThemesApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**themesGet**](ThemesApi.md#themesget) | **GET** /themes | 
[**themesNameAvatarPut**](ThemesApi.md#themesnameavatarput) | **PUT** /themes/{name}/avatar | 
[**themesNameCalendarGet**](ThemesApi.md#themesnamecalendarget) | **GET** /themes/{name}/calendar | 
[**themesNameCommentsGet**](ThemesApi.md#themesnamecommentsget) | **GET** /themes/{name}/comments | 
[**themesNameComplainPost**](ThemesApi.md#themesnamecomplainpost) | **POST** /themes/{name}/complain | 
[**themesNameCoverPut**](ThemesApi.md#themesnamecoverput) | **PUT** /themes/{name}/cover | 
[**themesNameFollowersGet**](ThemesApi.md#themesnamefollowersget) | **GET** /themes/{name}/followers | 
[**themesNameGet**](ThemesApi.md#themesnameget) | **GET** /themes/{name} | 
[**themesNameImagesGet**](ThemesApi.md#themesnameimagesget) | **GET** /themes/{name}/images | 
[**themesNamePut**](ThemesApi.md#themesnameput) | **PUT** /themes/{name} | 
[**themesNameTagsGet**](ThemesApi.md#themesnametagsget) | **GET** /themes/{name}/tags | 
[**themesNameTlogGet**](ThemesApi.md#themesnametlogget) | **GET** /themes/{name}/tlog | 
[**themesNameTlogPost**](ThemesApi.md#themesnametlogpost) | **POST** /themes/{name}/tlog | 
[**themesPost**](ThemesApi.md#themespost) | **POST** /themes | 


# **themesGet**
> MwThemesGet200Response themesGet(top, query)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String top = top_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.themesGet(top, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **top** | **String**|  | [optional] [default to 'new']
 **query** | **String**|  | [optional] 

### Return type

[**MwThemesGet200Response**](MwThemesGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameAvatarPut**
> themesNameAvatarPut(name, file)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.themesNameAvatarPut(name, file);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameAvatarPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **file** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameCalendarGet**
> MwCalendar themesNameCalendarGet(name, start, end, limit)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final int start = 789; // int | 
final int end = 789; // int | 
final int limit = 56; // int | 

try {
    final response = api.themesNameCalendarGet(name, start, end, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameCalendarGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **start** | **int**|  | [optional] [default to 0]
 **end** | **int**|  | [optional] [default to 0]
 **limit** | **int**|  | [optional] [default to 1000]

### Return type

[**MwCalendar**](MwCalendar.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameCommentsGet**
> MwCommentList themesNameCommentsGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.themesNameCommentsGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameCommentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
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

# **themesNameComplainPost**
> themesNameComplainPost(name, content)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final String content = content_example; // String | 

try {
    api.themesNameComplainPost(name, content);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameComplainPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **content** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameCoverPut**
> themesNameCoverPut(name, file)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.themesNameCoverPut(name, file);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameCoverPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **file** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameFollowersGet**
> MwFriendList themesNameFollowersGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.themesNameFollowersGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameFollowersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwFriendList**](MwFriendList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameGet**
> MwProfile themesNameGet(name)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 

try {
    final response = api.themesNameGet(name);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 

### Return type

[**MwProfile**](MwProfile.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameImagesGet**
> MwImageList themesNameImagesGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.themesNameImagesGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameImagesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwImageList**](MwImageList.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNamePut**
> MwProfile themesNamePut(name, showName, privacy, isDaylog, title, showInTops)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final String showName = showName_example; // String | 
final String privacy = privacy_example; // String | 
final bool isDaylog = true; // bool | 
final String title = title_example; // String | 
final bool showInTops = true; // bool | 

try {
    final response = api.themesNamePut(name, showName, privacy, isDaylog, title, showInTops);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNamePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **showName** | **String**|  | 
 **privacy** | **String**|  | 
 **isDaylog** | **bool**|  | [optional] [default to false]
 **title** | **String**|  | [optional] 
 **showInTops** | **bool**|  | [optional] [default to false]

### Return type

[**MwProfile**](MwProfile.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameTagsGet**
> MwTagList themesNameTagsGet(name, limit, query)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String query = query_example; // String | 

try {
    final response = api.themesNameTagsGet(name, limit, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameTagsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 30]
 **query** | **String**|  | [optional] 

### Return type

[**MwTagList**](MwTagList.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameTlogGet**
> MwFeed themesNameTlogGet(name, limit, after, before, tag, sort, query)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String tag = tag_example; // String | 
final String sort = sort_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.themesNameTlogGet(name, limit, after, before, tag, sort, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameTlogGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 
 **tag** | **String**|  | [optional] 
 **sort** | **String**|  | [optional] [default to 'new']
 **query** | **String**|  | [optional] 

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesNameTlogPost**
> MwEntry themesNameTlogPost(name, content, privacy, title, images, tags, isCommentable, isVotable, inLive, isShared, isDraft, isAnonymous)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final String content = content_example; // String | 
final String privacy = privacy_example; // String | 
final String title = title_example; // String | 
final BuiltSet<int> images = ; // BuiltSet<int> | 
final BuiltSet<String> tags = ; // BuiltSet<String> | 
final bool isCommentable = true; // bool | 
final bool isVotable = true; // bool | 
final bool inLive = true; // bool | 
final bool isShared = true; // bool | 
final bool isDraft = true; // bool | 
final bool isAnonymous = true; // bool | 

try {
    final response = api.themesNameTlogPost(name, content, privacy, title, images, tags, isCommentable, isVotable, inLive, isShared, isDraft, isAnonymous);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesNameTlogPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **content** | **String**|  | 
 **privacy** | **String**|  | 
 **title** | **String**|  | [optional] 
 **images** | [**BuiltSet&lt;int&gt;**](int.md)|  | [optional] 
 **tags** | [**BuiltSet&lt;String&gt;**](String.md)|  | [optional] 
 **isCommentable** | **bool**|  | [optional] [default to true]
 **isVotable** | **bool**|  | [optional] [default to false]
 **inLive** | **bool**|  | [optional] [default to false]
 **isShared** | **bool**|  | [optional] [default to false]
 **isDraft** | **bool**|  | [optional] [default to false]
 **isAnonymous** | **bool**|  | [optional] [default to false]

### Return type

[**MwEntry**](MwEntry.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **themesPost**
> MwProfile themesPost(name, showName)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getThemesApi();
final String name = name_example; // String | 
final String showName = showName_example; // String | 

try {
    final response = api.themesPost(name, showName);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ThemesApi->themesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **showName** | **String**|  | 

### Return type

[**MwProfile**](MwProfile.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

