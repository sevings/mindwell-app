# mindwell.api.AdmApi

## Load the API package
```dart
import 'package:mindwell/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**admGrandfatherGet**](AdmApi.md#admgrandfatherget) | **GET** /adm/grandfather | 
[**admGrandfatherStatusGet**](AdmApi.md#admgrandfatherstatusget) | **GET** /adm/grandfather/status | 
[**admGrandfatherStatusPost**](AdmApi.md#admgrandfatherstatuspost) | **POST** /adm/grandfather/status | 
[**admGrandsonGet**](AdmApi.md#admgrandsonget) | **GET** /adm/grandson | 
[**admGrandsonPost**](AdmApi.md#admgrandsonpost) | **POST** /adm/grandson | 
[**admGrandsonStatusGet**](AdmApi.md#admgrandsonstatusget) | **GET** /adm/grandson/status | 
[**admGrandsonStatusPost**](AdmApi.md#admgrandsonstatuspost) | **POST** /adm/grandson/status | 
[**admStatGet**](AdmApi.md#admstatget) | **GET** /adm/stat | 


# **admGrandfatherGet**
> MwAdmGrandfatherGet200Response admGrandfatherGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();

try {
    final response = api.admGrandfatherGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandfatherGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAdmGrandfatherGet200Response**](MwAdmGrandfatherGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admGrandfatherStatusGet**
> MwAdmGrandsonStatusGet200Response admGrandfatherStatusGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();

try {
    final response = api.admGrandfatherStatusGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandfatherStatusGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAdmGrandsonStatusGet200Response**](MwAdmGrandsonStatusGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admGrandfatherStatusPost**
> admGrandfatherStatusPost(sent, tracking, comment)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();
final bool sent = true; // bool | 
final String tracking = tracking_example; // String | 
final String comment = comment_example; // String | 

try {
    api.admGrandfatherStatusPost(sent, tracking, comment);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandfatherStatusPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sent** | **bool**|  | [optional] [default to false]
 **tracking** | **String**|  | [optional] 
 **comment** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admGrandsonGet**
> MwAdmGrandsonGet200Response admGrandsonGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();

try {
    final response = api.admGrandsonGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandsonGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAdmGrandsonGet200Response**](MwAdmGrandsonGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admGrandsonPost**
> admGrandsonPost(postcode, country, address, name, phone, comment, anonymous)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();
final String postcode = postcode_example; // String | 
final String country = country_example; // String | 
final String address = address_example; // String | 
final String name = name_example; // String | 
final String phone = phone_example; // String | 
final String comment = comment_example; // String | 
final bool anonymous = true; // bool | 

try {
    api.admGrandsonPost(postcode, country, address, name, phone, comment, anonymous);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandsonPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **postcode** | **String**|  | 
 **country** | **String**|  | 
 **address** | **String**|  | 
 **name** | **String**|  | 
 **phone** | **String**|  | [optional] 
 **comment** | **String**|  | [optional] 
 **anonymous** | **bool**|  | [optional] [default to false]

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admGrandsonStatusGet**
> MwAdmGrandsonStatusGet200Response admGrandsonStatusGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();

try {
    final response = api.admGrandsonStatusGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandsonStatusGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAdmGrandsonStatusGet200Response**](MwAdmGrandsonStatusGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admGrandsonStatusPost**
> admGrandsonStatusPost(received)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();
final bool received = true; // bool | 

try {
    api.admGrandsonStatusPost(received);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admGrandsonStatusPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **received** | **bool**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **admStatGet**
> MwAdmStatGet200Response admStatGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getAdmApi();

try {
    final response = api.admStatGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AdmApi->admStatGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAdmStatGet200Response**](MwAdmStatGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

