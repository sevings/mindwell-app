//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:mindwell_api/src/serializers.dart';
import 'package:mindwell_api/src/auth/api_key_auth.dart';
import 'package:mindwell_api/src/auth/basic_auth.dart';
import 'package:mindwell_api/src/auth/bearer_auth.dart';
import 'package:mindwell_api/src/auth/oauth.dart';
import 'package:mindwell_api/src/api/account_api.dart';
import 'package:mindwell_api/src/api/adm_api.dart';
import 'package:mindwell_api/src/api/chats_api.dart';
import 'package:mindwell_api/src/api/comments_api.dart';
import 'package:mindwell_api/src/api/design_api.dart';
import 'package:mindwell_api/src/api/entries_api.dart';
import 'package:mindwell_api/src/api/favorites_api.dart';
import 'package:mindwell_api/src/api/images_api.dart';
import 'package:mindwell_api/src/api/me_api.dart';
import 'package:mindwell_api/src/api/notifications_api.dart';
import 'package:mindwell_api/src/api/oauth2_api.dart';
import 'package:mindwell_api/src/api/relations_api.dart';
import 'package:mindwell_api/src/api/themes_api.dart';
import 'package:mindwell_api/src/api/users_api.dart';
import 'package:mindwell_api/src/api/votes_api.dart';
import 'package:mindwell_api/src/api/watchings_api.dart';
import 'package:mindwell_api/src/api/wishes_api.dart';

class MindwellApi {
  static const String basePath = r'/api/v1';

  final Dio dio;
  final Serializers serializers;

  MindwellApi({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AccountApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AccountApi getAccountApi() {
    return AccountApi(dio, serializers);
  }

  /// Get AdmApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdmApi getAdmApi() {
    return AdmApi(dio, serializers);
  }

  /// Get ChatsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ChatsApi getChatsApi() {
    return ChatsApi(dio, serializers);
  }

  /// Get CommentsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  CommentsApi getCommentsApi() {
    return CommentsApi(dio, serializers);
  }

  /// Get DesignApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  DesignApi getDesignApi() {
    return DesignApi(dio, serializers);
  }

  /// Get EntriesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  EntriesApi getEntriesApi() {
    return EntriesApi(dio, serializers);
  }

  /// Get FavoritesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FavoritesApi getFavoritesApi() {
    return FavoritesApi(dio, serializers);
  }

  /// Get ImagesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ImagesApi getImagesApi() {
    return ImagesApi(dio, serializers);
  }

  /// Get MeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MeApi getMeApi() {
    return MeApi(dio, serializers);
  }

  /// Get NotificationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationsApi getNotificationsApi() {
    return NotificationsApi(dio, serializers);
  }

  /// Get Oauth2Api instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  Oauth2Api getOauth2Api() {
    return Oauth2Api(dio, serializers);
  }

  /// Get RelationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RelationsApi getRelationsApi() {
    return RelationsApi(dio, serializers);
  }

  /// Get ThemesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ThemesApi getThemesApi() {
    return ThemesApi(dio, serializers);
  }

  /// Get UsersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UsersApi getUsersApi() {
    return UsersApi(dio, serializers);
  }

  /// Get VotesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  VotesApi getVotesApi() {
    return VotesApi(dio, serializers);
  }

  /// Get WatchingsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WatchingsApi getWatchingsApi() {
    return WatchingsApi(dio, serializers);
  }

  /// Get WishesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WishesApi getWishesApi() {
    return WishesApi(dio, serializers);
  }
}
