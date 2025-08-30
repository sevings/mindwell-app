# mindwell.api.FavoritesApi

## Load the API package
```dart
import 'package:mindwell/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**entriesIdFavoriteDelete**](FavoritesApi.md#entriesidfavoritedelete) | **DELETE** /entries/{id}/favorite | 
[**entriesIdFavoriteGet**](FavoritesApi.md#entriesidfavoriteget) | **GET** /entries/{id}/favorite | 
[**entriesIdFavoritePut**](FavoritesApi.md#entriesidfavoriteput) | **PUT** /entries/{id}/favorite | 


# **entriesIdFavoriteDelete**
> MwFavoriteStatus entriesIdFavoriteDelete(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getFavoritesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdFavoriteDelete(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FavoritesApi->entriesIdFavoriteDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwFavoriteStatus**](MwFavoriteStatus.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdFavoriteGet**
> MwFavoriteStatus entriesIdFavoriteGet(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getFavoritesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdFavoriteGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FavoritesApi->entriesIdFavoriteGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwFavoriteStatus**](MwFavoriteStatus.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **entriesIdFavoritePut**
> MwFavoriteStatus entriesIdFavoritePut(id)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getFavoritesApi();
final int id = 789; // int | 

try {
    final response = api.entriesIdFavoritePut(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FavoritesApi->entriesIdFavoritePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwFavoriteStatus**](MwFavoriteStatus.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

