# mindwell_api.api.NotificationsApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**notificationsGet**](NotificationsApi.md#notificationsget) | **GET** /notifications | 
[**notificationsIdGet**](NotificationsApi.md#notificationsidget) | **GET** /notifications/{id} | 
[**notificationsReadPut**](NotificationsApi.md#notificationsreadput) | **PUT** /notifications/read | 


# **notificationsGet**
> MwNotificationList notificationsGet(limit, after, before, unread)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getNotificationsApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 
final bool unread = true; // bool | 

try {
    final response = api.notificationsGet(limit, after, before, unread);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->notificationsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 
 **unread** | **bool**|  | [optional] [default to false]

### Return type

[**MwNotificationList**](MwNotificationList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationsIdGet**
> MwNotification notificationsIdGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getNotificationsApi();
final int id = 789; // int | 

try {
    final response = api.notificationsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->notificationsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwNotification**](MwNotification.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationsReadPut**
> MwNotificationsReadPut200Response notificationsReadPut(time)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getNotificationsApi();
final num time = 8.14; // num | 

try {
    final response = api.notificationsReadPut(time);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->notificationsReadPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **time** | **num**|  | [optional] [default to 0.0]

### Return type

[**MwNotificationsReadPut200Response**](MwNotificationsReadPut200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

