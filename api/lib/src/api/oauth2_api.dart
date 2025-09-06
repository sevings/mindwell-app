//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:built_collection/built_collection.dart';
import 'package:mindwell_api/src/api_util.dart';
import 'package:mindwell_api/src/model/mw_app.dart';
import 'package:mindwell_api/src/model/mw_o_auth2_token.dart';
import 'package:mindwell_api/src/model/mw_oauth2_allow_post200_response.dart';

class Oauth2Api {

  final Dio _dio;

  final Serializers _serializers;

  const Oauth2Api(this._dio, this._serializers);

  /// only for internal usage
  /// 
  ///
  /// Parameters:
  /// * [responseType] 
  /// * [clientId] 
  /// * [redirectUri] 
  /// * [scope] 
  /// * [state] 
  /// * [codeChallenge] 
  /// * [codeChallengeMethod] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [MwOauth2AllowPost200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<MwOauth2AllowPost200Response>> oauth2AllowPost({ 
    required String responseType,
    required int clientId,
    required String redirectUri,
    required BuiltList<String> scope,
    String? state,
    String? codeChallenge,
    String? codeChallengeMethod,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/oauth2/allow';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'oauth2',
            'name': 'OAuth2Password',
          },
        ],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = FormData.fromMap(<String, dynamic>{
        r'response_type': encodeFormParameter(_serializers, responseType, const FullType(String)),
        r'client_id': encodeFormParameter(_serializers, clientId, const FullType(int)),
        r'redirect_uri': encodeFormParameter(_serializers, redirectUri, const FullType(String)),
        r'scope': encodeFormParameter(_serializers, scope, const FullType(BuiltList, [FullType(String)])),
        if (state != null) r'state': encodeFormParameter(_serializers, state, const FullType(String)),
        if (codeChallenge != null) r'code_challenge': encodeFormParameter(_serializers, codeChallenge, const FullType(String)),
        if (codeChallengeMethod != null) r'code_challenge_method': encodeFormParameter(_serializers, codeChallengeMethod, const FullType(String)),
      });

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    MwOauth2AllowPost200Response? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(MwOauth2AllowPost200Response),
      ) as MwOauth2AllowPost200Response;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<MwOauth2AllowPost200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// oauth2AppsIdGet
  /// 
  ///
  /// Parameters:
  /// * [id] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [MwApp] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<MwApp>> oauth2AppsIdGet({ 
    required int id,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/oauth2/apps/{id}'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(int)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'oauth2',
            'name': 'OAuth2Password',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    MwApp? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(MwApp),
      ) as MwApp;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<MwApp>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// only for internal usage
  /// 
  ///
  /// Parameters:
  /// * [clientId] 
  /// * [redirectUri] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> oauth2DenyGet({ 
    required int clientId,
    required String redirectUri,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/oauth2/deny';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'client_id': encodeQueryParameter(_serializers, clientId, const FullType(int)),
      r'redirect_uri': encodeQueryParameter(_serializers, redirectUri, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// oauth2TokenPost
  /// 
  ///
  /// Parameters:
  /// * [grantType] 
  /// * [clientId] 
  /// * [clientSecret] 
  /// * [code] 
  /// * [redirectUri] 
  /// * [codeVerifier] 
  /// * [refreshToken] 
  /// * [username] 
  /// * [password] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [MwOAuth2Token] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<MwOAuth2Token>> oauth2TokenPost({ 
    required String grantType,
    required int clientId,
    String? clientSecret,
    String? code,
    String? redirectUri,
    String? codeVerifier,
    String? refreshToken,
    String? username,
    String? password,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/oauth2/token';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      contentType: 'multipart/form-data',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      _bodyData = FormData.fromMap(<String, dynamic>{
        r'grant_type': encodeFormParameter(_serializers, grantType, const FullType(String)),
        r'client_id': encodeFormParameter(_serializers, clientId, const FullType(int)),
        if (clientSecret != null) r'client_secret': encodeFormParameter(_serializers, clientSecret, const FullType(String)),
        if (code != null) r'code': encodeFormParameter(_serializers, code, const FullType(String)),
        if (redirectUri != null) r'redirect_uri': encodeFormParameter(_serializers, redirectUri, const FullType(String)),
        if (codeVerifier != null) r'code_verifier': encodeFormParameter(_serializers, codeVerifier, const FullType(String)),
        if (refreshToken != null) r'refresh_token': encodeFormParameter(_serializers, refreshToken, const FullType(String)),
        if (username != null) r'username': encodeFormParameter(_serializers, username, const FullType(String)),
        if (password != null) r'password': encodeFormParameter(_serializers, password, const FullType(String)),
      });

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    MwOAuth2Token? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(MwOAuth2Token),
      ) as MwOAuth2Token;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<MwOAuth2Token>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}