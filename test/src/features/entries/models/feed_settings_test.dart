import 'package:flutter_test/flutter_test.dart';
import 'package:mindwell/src/features/entries/models/feed_settings.dart';

void main() {
  group('FeedSettings', () {
    test('should create with default values', () {
      const settings = FeedSettings();

      expect(settings.entriesPerPage, 20);
      expect(settings.displayFormat, DisplayFormat.short);
      expect(settings.sortOrder, SortOrder.newest);
      expect(settings.imagesOnly, false);
      expect(settings.favoritesOnly, false);
      expect(settings.followedOnly, false);
      expect(settings.autoRefresh, true);
      expect(settings.autoRefreshInterval, 30);
    });

    test('should create with custom values', () {
      const settings = FeedSettings(
        entriesPerPage: 50,
        displayFormat: DisplayFormat.full,
        sortOrder: SortOrder.best,
        imagesOnly: true,
        favoritesOnly: true,
        followedOnly: true,
        autoRefresh: false,
        autoRefreshInterval: 60,
      );

      expect(settings.entriesPerPage, 50);
      expect(settings.displayFormat, DisplayFormat.full);
      expect(settings.sortOrder, SortOrder.best);
      expect(settings.imagesOnly, true);
      expect(settings.favoritesOnly, true);
      expect(settings.followedOnly, true);
      expect(settings.autoRefresh, false);
      expect(settings.autoRefreshInterval, 60);
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
      expect(updated.imagesOnly, false); // unchanged
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
}
