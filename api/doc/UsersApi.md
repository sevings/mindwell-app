# mindwell.api.UsersApi

## Load the API package
```dart
import 'package:mindwell/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**usersGet**](UsersApi.md#usersget) | **GET** /users | 
[**usersNameCalendarGet**](UsersApi.md#usersnamecalendarget) | **GET** /users/{name}/calendar | 
[**usersNameCommentsGet**](UsersApi.md#usersnamecommentsget) | **GET** /users/{name}/comments | 
[**usersNameComplainPost**](UsersApi.md#usersnamecomplainpost) | **POST** /users/{name}/complain | 
[**usersNameFavoritesGet**](UsersApi.md#usersnamefavoritesget) | **GET** /users/{name}/favorites | 
[**usersNameFollowersGet**](UsersApi.md#usersnamefollowersget) | **GET** /users/{name}/followers | 
[**usersNameFollowingsGet**](UsersApi.md#usersnamefollowingsget) | **GET** /users/{name}/followings | 
[**usersNameGet**](UsersApi.md#usersnameget) | **GET** /users/{name} | 
[**usersNameImagesGet**](UsersApi.md#usersnameimagesget) | **GET** /users/{name}/images | 
[**usersNameInvitedGet**](UsersApi.md#usersnameinvitedget) | **GET** /users/{name}/invited | 
[**usersNameTagsGet**](UsersApi.md#usersnametagsget) | **GET** /users/{name}/tags | 
[**usersNameTlogGet**](UsersApi.md#usersnametlogget) | **GET** /users/{name}/tlog | 


# **usersGet**
> MwUsersGet200Response usersGet(top, query)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String top = top_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.usersGet(top, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **top** | **String**|  | [optional] [default to 'new']
 **query** | **String**|  | [optional] 

### Return type

[**MwUsersGet200Response**](MwUsersGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersNameCalendarGet**
> MwCalendar usersNameCalendarGet(name, start, end, limit)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int start = 789; // int | 
final int end = 789; // int | 
final int limit = 56; // int | 

try {
    final response = api.usersNameCalendarGet(name, start, end, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameCalendarGet: $e\n');
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

# **usersNameCommentsGet**
> MwCommentList usersNameCommentsGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.usersNameCommentsGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameCommentsGet: $e\n');
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

# **usersNameComplainPost**
> usersNameComplainPost(name, content)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final String content = content_example; // String | 

try {
    api.usersNameComplainPost(name, content);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameComplainPost: $e\n');
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

# **usersNameFavoritesGet**
> MwFeed usersNameFavoritesGet(name, limit, after, before, query)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.usersNameFavoritesGet(name, limit, after, before, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameFavoritesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 
 **query** | **String**|  | [optional] 

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersNameFollowersGet**
> MwFriendList usersNameFollowersGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.usersNameFollowersGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameFollowersGet: $e\n');
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

# **usersNameFollowingsGet**
> MwFriendList usersNameFollowingsGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.usersNameFollowingsGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameFollowingsGet: $e\n');
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

# **usersNameGet**
> MwProfile usersNameGet(name)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 

try {
    final response = api.usersNameGet(name);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameGet: $e\n');
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

# **usersNameImagesGet**
> MwImageList usersNameImagesGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.usersNameImagesGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameImagesGet: $e\n');
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

# **usersNameInvitedGet**
> MwFriendList usersNameInvitedGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.usersNameInvitedGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameInvitedGet: $e\n');
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

# **usersNameTagsGet**
> MwTagList usersNameTagsGet(name, limit, query)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String query = query_example; // String | 

try {
    final response = api.usersNameTagsGet(name, limit, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameTagsGet: $e\n');
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

# **usersNameTlogGet**
> MwFeed usersNameTlogGet(name, limit, after, before, tag, sort, query)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getUsersApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String tag = tag_example; // String | 
final String sort = sort_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.usersNameTlogGet(name, limit, after, before, tag, sort, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UsersApi->usersNameTlogGet: $e\n');
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

