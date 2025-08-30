# mindwell.api.DesignApi

## Load the API package
```dart
import 'package:mindwell/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**designFontsGet**](DesignApi.md#designfontsget) | **GET** /design/fonts | 
[**designGet**](DesignApi.md#designget) | **GET** /design | 
[**designPut**](DesignApi.md#designput) | **PUT** /design | 


# **designFontsGet**
> MwDesignFontsGet200Response designFontsGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getDesignApi();

try {
    final response = api.designFontsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DesignApi->designFontsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwDesignFontsGet200Response**](MwDesignFontsGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **designGet**
> MwDesign designGet()



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getDesignApi();

try {
    final response = api.designGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DesignApi->designGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwDesign**](MwDesign.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **designPut**
> MwDesign designPut(textAlignment, css, backgroundColor, textColor, fontFamily, fontSize)



### Example
```dart
import 'package:mindwell/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = Mindwell().getDesignApi();
final String textAlignment = textAlignment_example; // String | 
final String css = css_example; // String | 
final String backgroundColor = backgroundColor_example; // String | 
final String textColor = textColor_example; // String | 
final String fontFamily = fontFamily_example; // String | 
final int fontSize = 56; // int | 

try {
    final response = api.designPut(textAlignment, css, backgroundColor, textColor, fontFamily, fontSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DesignApi->designPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **textAlignment** | **String**|  | 
 **css** | **String**|  | [optional] 
 **backgroundColor** | **String**|  | [optional] [default to '#ffffff']
 **textColor** | **String**|  | [optional] [default to '#000000']
 **fontFamily** | **String**|  | [optional] 
 **fontSize** | **int**|  | [optional] 

### Return type

[**MwDesign**](MwDesign.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

