# mindwell_api.api.AccountApi

## Load the API package
```dart
import 'package:mindwell_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountEmailEmailGet**](AccountApi.md#accountemailemailget) | **GET** /account/email/{email} | check if email is used
[**accountEmailPost**](AccountApi.md#accountemailpost) | **POST** /account/email | set new email
[**accountInvitesGet**](AccountApi.md#accountinvitesget) | **GET** /account/invites | 
[**accountNameNameGet**](AccountApi.md#accountnamenameget) | **GET** /account/name/{name} | check if name is used
[**accountPasswordPost**](AccountApi.md#accountpasswordpost) | **POST** /account/password | change new password
[**accountRecoverPasswordPost**](AccountApi.md#accountrecoverpasswordpost) | **POST** /account/recover/password | reset password
[**accountRecoverPost**](AccountApi.md#accountrecoverpost) | **POST** /account/recover | request reset password email
[**accountRegisterPost**](AccountApi.md#accountregisterpost) | **POST** /account/register | register new account
[**accountSettingsEmailGet**](AccountApi.md#accountsettingsemailget) | **GET** /account/settings/email | 
[**accountSettingsEmailPut**](AccountApi.md#accountsettingsemailput) | **PUT** /account/settings/email | 
[**accountSettingsOnsiteGet**](AccountApi.md#accountsettingsonsiteget) | **GET** /account/settings/onsite | 
[**accountSettingsOnsitePut**](AccountApi.md#accountsettingsonsiteput) | **PUT** /account/settings/onsite | 
[**accountSettingsTelegramGet**](AccountApi.md#accountsettingstelegramget) | **GET** /account/settings/telegram | 
[**accountSettingsTelegramPut**](AccountApi.md#accountsettingstelegramput) | **PUT** /account/settings/telegram | 
[**accountSubscribeTelegramDelete**](AccountApi.md#accountsubscribetelegramdelete) | **DELETE** /account/subscribe/telegram | 
[**accountSubscribeTelegramGet**](AccountApi.md#accountsubscribetelegramget) | **GET** /account/subscribe/telegram | 
[**accountSubscribeTokenGet**](AccountApi.md#accountsubscribetokenget) | **GET** /account/subscribe/token | 
[**accountVerificationEmailGet**](AccountApi.md#accountverificationemailget) | **GET** /account/verification/{email} | verify account email
[**accountVerificationPost**](AccountApi.md#accountverificationpost) | **POST** /account/verification | request verification email


# **accountEmailEmailGet**
> MwAccountEmailEmailGet200Response accountEmailEmailGet(email)

check if email is used

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getAccountApi();
final String email = email_example; // String | 

try {
    final response = api.accountEmailEmailGet(email);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountEmailEmailGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 

### Return type

[**MwAccountEmailEmailGet200Response**](MwAccountEmailEmailGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountEmailPost**
> accountEmailPost(email, password)

set new email

### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();
final String email = email_example; // String | 
final String password = password_example; // String | 

try {
    api.accountEmailPost(email, password);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountEmailPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **password** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountInvitesGet**
> MwAccountInvitesGet200Response accountInvitesGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    final response = api.accountInvitesGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountInvitesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAccountInvitesGet200Response**](MwAccountInvitesGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountNameNameGet**
> MwAccountNameNameGet200Response accountNameNameGet(name)

check if name is used

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getAccountApi();
final String name = name_example; // String | 

try {
    final response = api.accountNameNameGet(name);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountNameNameGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 

### Return type

[**MwAccountNameNameGet200Response**](MwAccountNameNameGet200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountPasswordPost**
> accountPasswordPost(oldPassword, newPassword)

change new password

### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();
final String oldPassword = oldPassword_example; // String | 
final String newPassword = newPassword_example; // String | 

try {
    api.accountPasswordPost(oldPassword, newPassword);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountPasswordPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **oldPassword** | **String**|  | 
 **newPassword** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountRecoverPasswordPost**
> accountRecoverPasswordPost(email, password, date, code)

reset password

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getAccountApi();
final String email = email_example; // String | 
final String password = password_example; // String | 
final int date = 789; // int | 
final String code = code_example; // String | 

try {
    api.accountRecoverPasswordPost(email, password, date, code);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountRecoverPasswordPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **password** | **String**|  | 
 **date** | **int**|  | 
 **code** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountRecoverPost**
> accountRecoverPost(email)

request reset password email

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getAccountApi();
final String email = email_example; // String | 

try {
    api.accountRecoverPost(email);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountRecoverPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountRegisterPost**
> MwAuthProfile accountRegisterPost(email, password, name, birthday, gender, country, city)

register new account

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getAccountApi();
final String email = email_example; // String | 
final String password = password_example; // String | 
final String name = name_example; // String | 
final String birthday = birthday_example; // String | 
final String gender = gender_example; // String | 
final String country = country_example; // String | 
final String city = city_example; // String | 

try {
    final response = api.accountRegisterPost(email, password, name, birthday, gender, country, city);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **password** | **String**|  | 
 **name** | **String**|  | 
 **birthday** | **String**|  | [optional] 
 **gender** | **String**|  | [optional] [default to 'not set']
 **country** | **String**|  | [optional] 
 **city** | **String**|  | [optional] 

### Return type

[**MwAuthProfile**](MwAuthProfile.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSettingsEmailGet**
> MwAccountSettingsEmailGet200Response accountSettingsEmailGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    final response = api.accountSettingsEmailGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSettingsEmailGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAccountSettingsEmailGet200Response**](MwAccountSettingsEmailGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSettingsEmailPut**
> accountSettingsEmailPut(comments, followers, invites, movedEntries, badges)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();
final bool comments = true; // bool | 
final bool followers = true; // bool | 
final bool invites = true; // bool | 
final bool movedEntries = true; // bool | 
final bool badges = true; // bool | 

try {
    api.accountSettingsEmailPut(comments, followers, invites, movedEntries, badges);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSettingsEmailPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **comments** | **bool**|  | [optional] [default to false]
 **followers** | **bool**|  | [optional] [default to false]
 **invites** | **bool**|  | [optional] [default to false]
 **movedEntries** | **bool**|  | [optional] [default to false]
 **badges** | **bool**|  | [optional] [default to false]

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSettingsOnsiteGet**
> MwAccountSettingsOnsiteGet200Response accountSettingsOnsiteGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    final response = api.accountSettingsOnsiteGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSettingsOnsiteGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAccountSettingsOnsiteGet200Response**](MwAccountSettingsOnsiteGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSettingsOnsitePut**
> accountSettingsOnsitePut(wishes)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();
final bool wishes = true; // bool | 

try {
    api.accountSettingsOnsitePut(wishes);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSettingsOnsitePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **wishes** | **bool**|  | [optional] [default to false]

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSettingsTelegramGet**
> MwAccountSettingsTelegramGet200Response accountSettingsTelegramGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    final response = api.accountSettingsTelegramGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSettingsTelegramGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAccountSettingsTelegramGet200Response**](MwAccountSettingsTelegramGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSettingsTelegramPut**
> accountSettingsTelegramPut(comments, followers, invites, messages, movedEntries, badges)



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();
final bool comments = true; // bool | 
final bool followers = true; // bool | 
final bool invites = true; // bool | 
final bool messages = true; // bool | 
final bool movedEntries = true; // bool | 
final bool badges = true; // bool | 

try {
    api.accountSettingsTelegramPut(comments, followers, invites, messages, movedEntries, badges);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSettingsTelegramPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **comments** | **bool**|  | [optional] [default to false]
 **followers** | **bool**|  | [optional] [default to false]
 **invites** | **bool**|  | [optional] [default to false]
 **messages** | **bool**|  | [optional] [default to false]
 **movedEntries** | **bool**|  | [optional] [default to false]
 **badges** | **bool**|  | [optional] [default to false]

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: multipart/form-data, application/x-www-form-urlencoded
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSubscribeTelegramDelete**
> accountSubscribeTelegramDelete()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    api.accountSubscribeTelegramDelete();
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSubscribeTelegramDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSubscribeTelegramGet**
> MwAccountSubscribeTokenGet200Response accountSubscribeTelegramGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    final response = api.accountSubscribeTelegramGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSubscribeTelegramGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAccountSubscribeTokenGet200Response**](MwAccountSubscribeTokenGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountSubscribeTokenGet**
> MwAccountSubscribeTokenGet200Response accountSubscribeTokenGet()



### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Code
//defaultApiClient.getAuthentication<OAuth>('OAuth2Code').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    final response = api.accountSubscribeTokenGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountSubscribeTokenGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MwAccountSubscribeTokenGet200Response**](MwAccountSubscribeTokenGet200Response.md)

### Authorization

[OAuth2Code](../README.md#OAuth2Code), [OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountVerificationEmailGet**
> accountVerificationEmailGet(email, code)

verify account email

### Example
```dart
import 'package:mindwell_api/api.dart';

final api = MindwellApi().getAccountApi();
final String email = email_example; // String | 
final String code = code_example; // String | 

try {
    api.accountVerificationEmailGet(email, code);
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountVerificationEmailGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 
 **code** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountVerificationPost**
> accountVerificationPost()

request verification email

### Example
```dart
import 'package:mindwell_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2Password
//defaultApiClient.getAuthentication<OAuth>('OAuth2Password').accessToken = 'YOUR_ACCESS_TOKEN';

final api = MindwellApi().getAccountApi();

try {
    api.accountVerificationPost();
} catch on DioException (e) {
    print('Exception when calling AccountApi->accountVerificationPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2Password](../README.md#OAuth2Password)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

