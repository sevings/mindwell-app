import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';

void main() {
  group('FeedSettings', () {
    test('should create with default values', () {
      const settings = FeedSettings();

      expect(settings.entriesPerPage, 20);
      expect(settings.displayFormat, DisplayFormat.short);
      expect(settings.sortOrder, SortOrder.newest);
      expect(settings.includeTlogs, true);
      expect(settings.includeThemes, true);
    });

    test('should create with custom values', () {
      const settings = FeedSettings(
        entriesPerPage: 50,
        displayFormat: DisplayFormat.full,
        sortOrder: SortOrder.best,
        includeTlogs: false,
        includeThemes: true,
      );

      expect(settings.entriesPerPage, 50);
      expect(settings.displayFormat, DisplayFormat.full);
      expect(settings.sortOrder, SortOrder.best);
      expect(settings.includeTlogs, false);
      expect(settings.includeThemes, true);
    });

    test('should support copyWith', () {
      const original = FeedSettings();
      final updated = original.copyWith(
        entriesPerPage: 30,
        displayFormat: DisplayFormat.full,
      );

      expect(updated.entriesPerPage, 30);
      expect(updated.displayFormat, DisplayFormat.full);
      expect(updated.sortOrder, SortOrder.newest); // unchanged
      expect(updated.includeTlogs, true); // unchanged
      expect(updated.includeThemes, true); // unchanged
    });

    test('should be immutable', () {
      const settings1 = FeedSettings(entriesPerPage: 10);
      const settings2 = FeedSettings(entriesPerPage: 10);

      expect(settings1, equals(settings2));
      expect(settings1.hashCode, equals(settings2.hashCode));
    });

    test('should have defaultSettings constant', () {
      const defaultSettings = FeedSettings.defaultSettings;
      const manualDefault = FeedSettings();

      expect(defaultSettings, equals(manualDefault));
    });

    test('should validate source configuration', () {
      const validSettings = FeedSettings(includeTlogs: true, includeThemes: false);
      const invalidSettings = FeedSettings(includeTlogs: false, includeThemes: false);

      expect(validSettings.isValidSourceConfiguration, isTrue);
      expect(invalidSettings.isValidSourceConfiguration, isFalse);
    });

    test('should prevent disabling both sources with copyWithValidated', () {
      const original = FeedSettings(includeTlogs: true, includeThemes: true);
      
      // Try to disable both sources
      final result = original.copyWithValidated(includeTlogs: false, includeThemes: false);
      
      // Should keep at least one source enabled
      expect(result.isValidSourceConfiguration, isTrue);
      expect(result.includeTlogs || result.includeThemes, isTrue);
    });

    test('should allow disabling one source if the other is enabled', () {
      const original = FeedSettings(includeTlogs: true, includeThemes: true);
      
      // Disable only tlogs
      final result = original.copyWithValidated(includeTlogs: false);
      
      expect(result.includeTlogs, isFalse);
      expect(result.includeThemes, isTrue);
      expect(result.isValidSourceConfiguration, isTrue);
    });
  });

  group('DisplayFormat', () {
    test('should have correct enum values', () {
      expect(DisplayFormat.values, containsAll([
        DisplayFormat.short,
        DisplayFormat.full,
      ]));
    });
  });

  group('SortOrder', () {
    test('should have correct enum values', () {
      expect(SortOrder.values, containsAll([
        SortOrder.newest,
        SortOrder.oldest,
        SortOrder.best,
      ]));
    });
  });

  group('FeedSource', () {
    test('should have correct enum values', () {
      expect(FeedSource.values, containsAll([
        FeedSource.tlogs,
        FeedSource.themes,
      ]));
    });
  });
}
