# mindwell_api.api.ImagesApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**imagesFindGet**](ImagesApi.md#imagesfindget) | **GET** /images/find | 
[**imagesIdDelete**](ImagesApi.md#imagesiddelete) | **DELETE** /images/{id} | 
[**imagesIdGet**](ImagesApi.md#imagesidget) | **GET** /images/{id} | 
[**imagesPost**](ImagesApi.md#imagespost) | **POST** /images | 


# **imagesFindGet**
> MwImage imagesFindGet(link)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2App
//defaultApiClient.getAuthentication<OAuth>('OAuth2App').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getImagesApi();
final String link = link_example; // String | 

try {
    final response = api.imagesFindGet(link);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ImagesApi->imagesFindGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **link** | **String**|  | 

### Return type

[**MwImage**](MwImage.md)

### Authorization

[OAuth2App](../README.md#OAuth2App), [OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **imagesIdDelete**
> imagesIdDelete(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getImagesApi();
final int id = 789; // int | 

try {
    api.imagesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ImagesApi->imagesIdDelete: $e\n');
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

# **imagesIdGet**
> MwImage imagesIdGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getImagesApi();
final int id = 789; // int | 

try {
    final response = api.imagesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ImagesApi->imagesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwImage**](MwImage.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **imagesPost**
> MwImage imagesPost(file)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getImagesApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.imagesPost(file);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ImagesApi->imagesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | 

### Return type

[**MwImage**](MwImage.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

