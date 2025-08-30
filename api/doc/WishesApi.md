# mindwell.api.WishesApi

## Load the API package
```dart
import 'package:mindwell/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**wishesIdComplainPost**](WishesApi.md#wishesidcomplainpost) | **POST** /wishes/{id}/complain | 
[**wishesIdDelete**](WishesApi.md#wishesiddelete) | **DELETE** /wishes/{id} | 
[**wishesIdGet**](WishesApi.md#wishesidget) | **GET** /wishes/{id} | 
[**wishesIdPut**](WishesApi.md#wishesidput) | **PUT** /wishes/{id} | 
[**wishesIdThankPost**](WishesApi.md#wishesidthankpost) | **POST** /wishes/{id}/thank | 


# **wishesIdComplainPost**
> wishesIdComplainPost(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getWishesApi();
final int id = 789; // int | 

try {
    api.wishesIdComplainPost(id);
} catch on DioException (e) {
    print('Exception when calling WishesApi->wishesIdComplainPost: $e\n');
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

# **wishesIdDelete**
> wishesIdDelete(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getWishesApi();
final int id = 789; // int | 

try {
    api.wishesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling WishesApi->wishesIdDelete: $e\n');
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

# **wishesIdGet**
> MwWish wishesIdGet(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getWishesApi();
final int id = 789; // int | 

try {
    final response = api.wishesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WishesApi->wishesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwWish**](MwWish.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **wishesIdPut**
> wishesIdPut(id, content)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getWishesApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    api.wishesIdPut(id, content);
} catch on DioException (e) {
    print('Exception when calling WishesApi->wishesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **content** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **wishesIdThankPost**
> wishesIdThankPost(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getWishesApi();
final int id = 789; // int | 

try {
    api.wishesIdThankPost(id);
} catch on DioException (e) {
    print('Exception when calling WishesApi->wishesIdThankPost: $e\n');
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

