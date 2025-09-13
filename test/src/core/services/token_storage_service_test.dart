import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mindwell/src/core/services/token_storage_service.dart';

/// Mock class for FlutterSecureStorage to enable testing.
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('TokenStorageService', () {
    late MockFlutterSecureStorage mockStorage;
    late TokenStorageService tokenStorageService;

    setUp(() {
      mockStorage = MockFlutterSecureStorage();
      tokenStorageService = TokenStorageService(storage: mockStorage);
    });

    group('saveTokens', () {
      test('should save both access and refresh tokens', () async {
        // Arrange
        const accessToken = 'test_access_token';
        const refreshToken = 'test_refresh_token';

        when(() => mockStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenAnswer((_) async {});

        // Act
        await tokenStorageService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

        // Assert
        verify(() => mockStorage.write(
              key: 'access_token',
              value: accessToken,
            )).called(1);
        verify(() => mockStorage.write(
              key: 'refresh_token',
              value: refreshToken,
            )).called(1);
      });

      test('should handle storage write errors gracefully', () async {
        // Arrange
        const accessToken = 'test_access_token';
        const refreshToken = 'test_refresh_token';

        when(() => mockStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            )).thenThrow(Exception('Storage write failed'));

        // Act & Assert
        expect(
          () => tokenStorageService.saveTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
          ),
          throwsException,
        );
      });
    });

    group('getAccessToken', () {
      test('should return access token when it exists', () async {
        // Arrange
        const expectedToken = 'test_access_token';
        when(() => mockStorage.read(key: 'access_token'))
            .thenAnswer((_) async => expectedToken);

        // Act
        final result = await tokenStorageService.getAccessToken();

        // Assert
        expect(result, equals(expectedToken));
        verify(() => mockStorage.read(key: 'access_token')).called(1);
      });

      test('should return null when access token does not exist', () async {
        // Arrange
        when(() => mockStorage.read(key: 'access_token'))
            .thenAnswer((_) async => null);

        // Act
        final result = await tokenStorageService.getAccessToken();

        // Assert
        expect(result, isNull);
        verify(() => mockStorage.read(key: 'access_token')).called(1);
      });

      test('should handle storage read errors gracefully', () async {
        // Arrange
        when(() => mockStorage.read(key: 'access_token'))
            .thenThrow(Exception('Storage read failed'));

        // Act & Assert
        expect(
          () => tokenStorageService.getAccessToken(),
          throwsException,
        );
      });
    });

    group('getRefreshToken', () {
      test('should return refresh token when it exists', () async {
        // Arrange
        const expectedToken = 'test_refresh_token';
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenAnswer((_) async => expectedToken);

        // Act
        final result = await tokenStorageService.getRefreshToken();

        // Assert
        expect(result, equals(expectedToken));
        verify(() => mockStorage.read(key: 'refresh_token')).called(1);
      });

      test('should return null when refresh token does not exist', () async {
        // Arrange
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenAnswer((_) async => null);

        // Act
        final result = await tokenStorageService.getRefreshToken();

        // Assert
        expect(result, isNull);
        verify(() => mockStorage.read(key: 'refresh_token')).called(1);
      });

      test('should handle storage read errors gracefully', () async {
        // Arrange
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenThrow(Exception('Storage read failed'));

        // Act & Assert
        expect(
          () => tokenStorageService.getRefreshToken(),
          throwsException,
        );
      });
    });

    group('clearTokens', () {
      test('should remove both access and refresh tokens', () async {
        // Arrange
        when(() => mockStorage.delete(key: any(named: 'key')))
            .thenAnswer((_) async {});

        // Act
        await tokenStorageService.clearTokens();

        // Assert
        verify(() => mockStorage.delete(key: 'access_token')).called(1);
        verify(() => mockStorage.delete(key: 'refresh_token')).called(1);
      });

      test('should handle storage delete errors gracefully', () async {
        // Arrange
        when(() => mockStorage.delete(key: any(named: 'key')))
            .thenThrow(Exception('Storage delete failed'));

        // Act & Assert
        expect(
          () => tokenStorageService.clearTokens(),
          throwsException,
        );
      });
    });

    group('hasTokens', () {
      test('should return true when both tokens exist', () async {
        // Arrange
        when(() => mockStorage.read(key: 'access_token'))
            .thenAnswer((_) async => 'access_token');
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenAnswer((_) async => 'refresh_token');

        // Act
        final result = await tokenStorageService.hasTokens();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when access token is missing', () async {
        // Arrange
        when(() => mockStorage.read(key: 'access_token'))
            .thenAnswer((_) async => null);
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenAnswer((_) async => 'refresh_token');

        // Act
        final result = await tokenStorageService.hasTokens();

        // Assert
        expect(result, isFalse);
      });

      test('should return false when refresh token is missing', () async {
        // Arrange
        when(() => mockStorage.read(key: 'access_token'))
            .thenAnswer((_) async => 'access_token');
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenAnswer((_) async => null);

        // Act
        final result = await tokenStorageService.hasTokens();

        // Assert
        expect(result, isFalse);
      });

      test('should return false when both tokens are missing', () async {
        // Arrange
        when(() => mockStorage.read(key: 'access_token'))
            .thenAnswer((_) async => null);
        when(() => mockStorage.read(key: 'refresh_token'))
            .thenAnswer((_) async => null);

        // Act
        final result = await tokenStorageService.hasTokens();

        // Assert
        expect(result, isFalse);
      });
    });
  });
}
