import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:mindwell/src/core/services/token_storage_service.dart';
import 'package:mindwell/src/core/api/api_provider.dart';

/// Mock class for TokenStorageService to enable testing.
class MockTokenStorageService extends Mock implements TokenStorageService {}

void main() {
  group('AuthInterceptor', () {
    late MockTokenStorageService mockTokenStorageService;
    late AuthInterceptor authInterceptor;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      mockTokenStorageService = MockTokenStorageService();
      authInterceptor = AuthInterceptor(tokenStorageService: mockTokenStorageService);
      
      // Create a Dio instance with the interceptor for testing
      dio = Dio(BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
      ));
      dio.interceptors.add(authInterceptor);
      
      // Set up mock adapter
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });

    group('onRequest - Token Injection', () {
      test('should inject user access token when available', () async {
        // Arrange
        const accessToken = 'user_access_token_123';
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => accessToken);

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        final response = await dio.get('/test');

        // Assert
        verify(() => mockTokenStorageService.getAccessToken()).called(1);
        expect(response.statusCode, 200);
      });

      test('should inject app token when user token is not available', () async {
        // Arrange
        const appToken = 'app_token_123';
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        when(() => mockTokenStorageService.getAppToken())
            .thenAnswer((_) async => appToken);

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        final response = await dio.get('/test');

        // Assert
        verify(() => mockTokenStorageService.getAccessToken()).called(1);
        verify(() => mockTokenStorageService.getAppToken()).called(1);
        expect(response.statusCode, 200);
      });

      test('should continue without Authorization header when no tokens are available', () async {
        // Arrange
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        when(() => mockTokenStorageService.getAppToken())
            .thenAnswer((_) async => null);

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        final response = await dio.get('/test');

        // Assert
        verify(() => mockTokenStorageService.getAccessToken()).called(1);
        verify(() => mockTokenStorageService.getAppToken()).called(1);
        expect(response.statusCode, 200);
      });

      test('should handle token storage errors gracefully', () async {
        // Arrange
        when(() => mockTokenStorageService.getAccessToken())
            .thenThrow(Exception('Storage error'));

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        final response = await dio.get('/test');

        // Assert
        verify(() => mockTokenStorageService.getAccessToken()).called(1);
        // Should not call getAppToken if getAccessToken throws
        verifyNever(() => mockTokenStorageService.getAppToken());
        expect(response.statusCode, 200);
      });

      test('should handle app token storage errors gracefully', () async {
        // Arrange
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        when(() => mockTokenStorageService.getAppToken())
            .thenThrow(Exception('Storage error'));

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        final response = await dio.get('/test');

        // Assert
        verify(() => mockTokenStorageService.getAccessToken()).called(1);
        verify(() => mockTokenStorageService.getAppToken()).called(1);
        expect(response.statusCode, 200);
      });
    });

    group('onRequest - Request Options Modification', () {
      test('should modify request options with user token', () async {
        // Arrange
        const accessToken = 'user_access_token_123';
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => accessToken);

        // Create a custom interceptor to capture the request options
        late RequestOptions capturedOptions;
        dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            handler.next(options);
          },
        ));

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        await dio.get('/test');

        // Assert
        expect(capturedOptions.headers['Authorization'], 'Bearer $accessToken');
      });

      test('should modify request options with app token when user token is not available', () async {
        // Arrange
        const appToken = 'app_token_123';
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        when(() => mockTokenStorageService.getAppToken())
            .thenAnswer((_) async => appToken);

        // Create a custom interceptor to capture the request options
        late RequestOptions capturedOptions;
        dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            handler.next(options);
          },
        ));

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        await dio.get('/test');

        // Assert
        expect(capturedOptions.headers['Authorization'], 'Bearer $appToken');
      });

      test('should not modify request options when no tokens are available', () async {
        // Arrange
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        when(() => mockTokenStorageService.getAppToken())
            .thenAnswer((_) async => null);

        // Create a custom interceptor to capture the request options
        late RequestOptions capturedOptions;
        dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedOptions = options;
            handler.next(options);
          },
        ));

        // Mock the HTTP response
        dioAdapter.onGet('/test', (server) => server.reply(200, {'success': true}));

        // Act
        await dio.get('/test');

        // Assert
        expect(capturedOptions.headers['Authorization'], isNull);
      });
    });

    group('onError - Error Handling', () {
      test('should pass through errors without modification', () async {
        // Arrange
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        when(() => mockTokenStorageService.getAppToken())
            .thenAnswer((_) async => null);

        // Mock the HTTP response to return 404
        dioAdapter.onGet('/nonexistent', (server) => server.reply(404, {'error': 'Not found'}));

        // Act & Assert
        expect(
          () => dio.get('/nonexistent'),
          throwsA(isA<DioException>()),
        );
      });

      test('should pass through 401 errors without modification', () async {
        // Arrange
        const accessToken = 'invalid_token';
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => accessToken);

        // Mock the HTTP response to return 401
        dioAdapter.onGet('/protected', (server) => server.reply(401, {'error': 'Unauthorized'}));

        // Act & Assert
        expect(
          () => dio.get('/protected'),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('Integration Tests', () {
      test('should work with multiple requests using different tokens', () async {
        // Arrange
        const userToken = 'user_token_123';
        const appToken = 'app_token_123';
        
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => userToken);
        when(() => mockTokenStorageService.getAppToken())
            .thenAnswer((_) async => appToken);

        // Create a custom interceptor to capture request options
        final capturedRequests = <RequestOptions>[];
        dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedRequests.add(options);
            handler.next(options);
          },
        ));

        // Mock the HTTP responses
        dioAdapter.onGet('/user-endpoint', (server) => server.reply(200, {'success': true}));
        dioAdapter.onGet('/public-endpoint', (server) => server.reply(200, {'success': true}));

        // Act
        await dio.get('/user-endpoint');
        
        // Change to app token scenario
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => null);
        await dio.get('/public-endpoint');

        // Assert
        expect(capturedRequests.length, 2);
        expect(capturedRequests[0].headers['Authorization'], 'Bearer $userToken');
        expect(capturedRequests[1].headers['Authorization'], 'Bearer $appToken');
      });

      test('should handle rapid successive requests', () async {
        // Arrange
        const accessToken = 'user_token_123';
        when(() => mockTokenStorageService.getAccessToken())
            .thenAnswer((_) async => accessToken);

        // Create a custom interceptor to capture request options
        final capturedRequests = <RequestOptions>[];
        dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) {
            capturedRequests.add(options);
            handler.next(options);
          },
        ));

        // Mock the HTTP responses
        dioAdapter.onGet('/endpoint1', (server) => server.reply(200, {'success': true}));
        dioAdapter.onGet('/endpoint2', (server) => server.reply(200, {'success': true}));
        dioAdapter.onGet('/endpoint3', (server) => server.reply(200, {'success': true}));

        // Act
        await Future.wait([
          dio.get('/endpoint1'),
          dio.get('/endpoint2'),
          dio.get('/endpoint3'),
        ]);

        // Assert
        expect(capturedRequests.length, 3);
        for (final request in capturedRequests) {
          expect(request.headers['Authorization'], 'Bearer $accessToken');
        }
      });
    });
  });
}
