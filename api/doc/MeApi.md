# mindwell_api.api.MeApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**meAvatarPut**](MeApi.md#meavatarput) | **PUT** /me/avatar | 
[**meBadgesGet**](MeApi.md#mebadgesget) | **GET** /me/badges | 
[**meCalendarGet**](MeApi.md#mecalendarget) | **GET** /me/calendar | 
[**meCommentsGet**](MeApi.md#mecommentsget) | **GET** /me/comments | 
[**meCoverPut**](MeApi.md#mecoverput) | **PUT** /me/cover | 
[**meFavoritesGet**](MeApi.md#mefavoritesget) | **GET** /me/favorites | 
[**meFollowersGet**](MeApi.md#mefollowersget) | **GET** /me/followers | 
[**meFollowingsGet**](MeApi.md#mefollowingsget) | **GET** /me/followings | 
[**meGet**](MeApi.md#meget) | **GET** /me | 
[**meHiddenGet**](MeApi.md#mehiddenget) | **GET** /me/hidden | 
[**meIgnoredGet**](MeApi.md#meignoredget) | **GET** /me/ignored | 
[**meImagesGet**](MeApi.md#meimagesget) | **GET** /me/images | 
[**meInvitedGet**](MeApi.md#meinvitedget) | **GET** /me/invited | 
[**meOnlinePut**](MeApi.md#meonlineput) | **PUT** /me/online | 
[**mePut**](MeApi.md#meput) | **PUT** /me | 
[**meRequestedGet**](MeApi.md#merequestedget) | **GET** /me/requested | 
[**meTagsGet**](MeApi.md#metagsget) | **GET** /me/tags | 
[**meTlogGet**](MeApi.md#metlogget) | **GET** /me/tlog | 
[**meTlogPost**](MeApi.md#metlogpost) | **POST** /me/tlog | 


# **meAvatarPut**
> meAvatarPut(file)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.meAvatarPut(file);
} catch on DioException (e) {
    print('Exception when calling MeApi->meAvatarPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meBadgesGet**
> MwBadgeList meBadgesGet(limit)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 

try {
    final response = api.meBadgesGet(limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meBadgesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 1000]

### Return type

[**MwBadgeList**](MwBadgeList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meCalendarGet**
> MwCalendar meCalendarGet(start, end, limit)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int start = 789; // int | 
final int end = 789; // int | 
final int limit = 56; // int | 

try {
    final response = api.meCalendarGet(start, end, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meCalendarGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **start** | **int**|  | [optional] [default to 0]
 **end** | **int**|  | [optional] [default to 0]
 **limit** | **int**|  | [optional] [default to 1000]

### Return type

[**MwCalendar**](MwCalendar.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meCommentsGet**
> MwCommentList meCommentsGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meCommentsGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meCommentsGet: $e\n');
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

# **meCoverPut**
> meCoverPut(file)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.meCoverPut(file);
} catch on DioException (e) {
    print('Exception when calling MeApi->meCoverPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meFavoritesGet**
> MwFeed meFavoritesGet(limit, after, before, query)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.meFavoritesGet(limit, after, before, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meFavoritesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meFollowersGet**
> MwFriendList meFollowersGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meFollowersGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meFollowersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meFollowingsGet**
> MwFriendList meFollowingsGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meFollowingsGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meFollowingsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meGet**
> MwAuthProfile meGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();

try {
    final response = api.meGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAuthProfile**](MwAuthProfile.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meHiddenGet**
> MwFriendList meHiddenGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meHiddenGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meHiddenGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meIgnoredGet**
> MwFriendList meIgnoredGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meIgnoredGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meIgnoredGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meImagesGet**
> MwImageList meImagesGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meImagesGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meImagesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwImageList**](MwImageList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meInvitedGet**
> MwFriendList meInvitedGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meInvitedGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meInvitedGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meOnlinePut**
> MwMeOnlinePut200Response meOnlinePut()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();

try {
    final response = api.meOnlinePut();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meOnlinePut: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwMeOnlinePut200Response**](MwMeOnlinePut200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **mePut**
> MwProfile mePut(showName, privacy, chatPrivacy, gender, isDaylog, title, birthday, country, city, showInTops)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final String showName = showName_example; // String | 
final String privacy = privacy_example; // String | 
final String chatPrivacy = chatPrivacy_example; // String | 
final String gender = gender_example; // String | 
final bool isDaylog = true; // bool | 
final String title = title_example; // String | 
final String birthday = birthday_example; // String | 
final String country = country_example; // String | 
final String city = city_example; // String | 
final bool showInTops = true; // bool | 

try {
    final response = api.mePut(showName, privacy, chatPrivacy, gender, isDaylog, title, birthday, country, city, showInTops);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->mePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **showName** | **String**|  | 
 **privacy** | **String**|  | 
 **chatPrivacy** | **String**|  | 
 **gender** | **String**|  | [optional] [default to 'not set']
 **isDaylog** | **bool**|  | [optional] [default to false]
 **title** | **String**|  | [optional] 
 **birthday** | **String**|  | [optional] 
 **country** | **String**|  | [optional] 
 **city** | **String**|  | [optional] 
 **showInTops** | **bool**|  | [optional] [default to false]

### Return type

[**MwProfile**](MwProfile.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meRequestedGet**
> MwFriendList meRequestedGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.meRequestedGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meRequestedGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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

# **meTagsGet**
> MwTagList meTagsGet(limit, query)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String query = query_example; // String | 

try {
    final response = api.meTagsGet(limit, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meTagsGet: $e\n');
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

# **meTlogGet**
> MwFeed meTlogGet(limit, after, before, tag, sort, query)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final String tag = tag_example; // String | 
final String sort = sort_example; // String | 
final String query = query_example; // String | 

try {
    final response = api.meTlogGet(limit, after, before, tag, sort, query);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meTlogGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 
 **tag** | **String**|  | [optional] 
 **sort** | **String**|  | [optional] [default to 'new']
 **query** | **String**|  | [optional] 

### Return type

[**MwFeed**](MwFeed.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **meTlogPost**
> MwEntry meTlogPost(content, privacy, title, images, tags, visibleFor, isCommentable, isVotable, inLive, isShared, isDraft)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getMeApi();
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
final bool isDraft = true; // bool | 

try {
    final response = api.meTlogPost(content, privacy, title, images, tags, visibleFor, isCommentable, isVotable, inLive, isShared, isDraft);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->meTlogPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
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
 **isDraft** | **bool**|  | [optional] [default to false]

### Return type

[**MwEntry**](MwEntry.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

