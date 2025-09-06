# mindwell_api.api.ChatsApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**chatsGet**](ChatsApi.md#chatsget) | **GET** /chats | 
[**chatsNameGet**](ChatsApi.md#chatsnameget) | **GET** /chats/{name} | 
[**chatsNameMessagesGet**](ChatsApi.md#chatsnamemessagesget) | **GET** /chats/{name}/messages | 
[**chatsNameMessagesPost**](ChatsApi.md#chatsnamemessagespost) | **POST** /chats/{name}/messages | 
[**chatsNameReadPut**](ChatsApi.md#chatsnamereadput) | **PUT** /chats/{name}/read | 
[**messagesIdComplainPost**](ChatsApi.md#messagesidcomplainpost) | **POST** /messages/{id}/complain | 
[**messagesIdDelete**](ChatsApi.md#messagesiddelete) | **DELETE** /messages/{id} | 
[**messagesIdGet**](ChatsApi.md#messagesidget) | **GET** /messages/{id} | 
[**messagesIdPut**](ChatsApi.md#messagesidput) | **PUT** /messages/{id} | 


# **chatsGet**
> MwChatList chatsGet(limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.chatsGet(limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->chatsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 30]
 **after** | **String**|  | [optional] 
 **before** | **String**|  | [optional] 

### Return type

[**MwChatList**](MwChatList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **chatsNameGet**
> MwChat chatsNameGet(name)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final String name = name_example; // String | 

try {
    final response = api.chatsNameGet(name);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->chatsNameGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 

### Return type

[**MwChat**](MwChat.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **chatsNameMessagesGet**
> MwMessageList chatsNameMessagesGet(name, limit, after, before)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final String name = name_example; // String | 
final int limit = 56; // int | 
final String after = after_example; // String | 
final String before = before_example; // String | 

try {
    final response = api.chatsNameMessagesGet(name, limit, after, before);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->chatsNameMessagesGet: $e\n');
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

[**MwMessageList**](MwMessageList.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **chatsNameMessagesPost**
> MwMessage chatsNameMessagesPost(name, content, uid)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final String name = name_example; // String | 
final String content = content_example; // String | 
final num uid = 8.14; // num | unique message id

try {
    final response = api.chatsNameMessagesPost(name, content, uid);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->chatsNameMessagesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **content** | **String**|  | 
 **uid** | **num**| unique message id | 

### Return type

[**MwMessage**](MwMessage.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **chatsNameReadPut**
> MwNotificationsReadPut200Response chatsNameReadPut(name, message)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final String name = name_example; // String | 
final int message = 789; // int | 

try {
    final response = api.chatsNameReadPut(name, message);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->chatsNameReadPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 
 **message** | **int**|  | 

### Return type

[**MwNotificationsReadPut200Response**](MwNotificationsReadPut200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messagesIdComplainPost**
> messagesIdComplainPost(id, content)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    api.messagesIdComplainPost(id, content);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->messagesIdComplainPost: $e\n');
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

# **messagesIdDelete**
> messagesIdDelete(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final int id = 789; // int | 

try {
    api.messagesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->messagesIdDelete: $e\n');
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

# **messagesIdGet**
> MwMessage messagesIdGet(id)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final int id = 789; // int | 

try {
    final response = api.messagesIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->messagesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**MwMessage**](MwMessage.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messagesIdPut**
> MwMessage messagesIdPut(id, content)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getChatsApi();
final int id = 789; // int | 
final String content = content_example; // String | 

try {
    final response = api.messagesIdPut(id, content);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ChatsApi->messagesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **content** | **String**|  | 

### Return type

[**MwMessage**](MwMessage.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

